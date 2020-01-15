Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6811C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804F82081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQla9cbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804F82081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlpd-0000Wb-Gw
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irlA8-0000zT-1s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irlA4-0002El-CB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:04:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irlA4-0002EO-84
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579104291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcx9IPo7holjwR4NqEbYJcH5NenTdICAbnNTWaUIBzU=;
 b=iQla9cbeIBLHwiHduqp5zgd3olxuNuTfRawNQ2F2qh6tvpfMXFVAcPLJEZo7zNrlbDp4AC
 EefWXk+60i8FQEJRamMKP/iJoq4g6pXt9aUSj1XheRYEKbNWcW/XwsGrZ2q0AU9gPWMJgk
 Yxv1VHFp5RYvAq+tnPWKZsR/AWo9zYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-xGvDyxlgP4iZa3eZrTfVVA-1; Wed, 15 Jan 2020 11:04:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEC1192442D;
 Wed, 15 Jan 2020 16:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 463C95D9C9;
 Wed, 15 Jan 2020 16:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC0A71138600; Wed, 15 Jan 2020 17:04:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
References: <20200109095116.18201-1-thuth@redhat.com>
 <5883bc34-926e-70e3-6402-32dfb5d92ab2@redhat.com>
 <e1ae4e63-626c-cc6d-5117-4b4fbd1ad436@redhat.com>
 <20200114102031.GE4071034@redhat.com>
Date: Wed, 15 Jan 2020 17:04:44 +0100
In-Reply-To: <20200114102031.GE4071034@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Tue, 14 Jan 2020 10:20:31 +0000")
Message-ID: <874kww7lk3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xGvDyxlgP4iZa3eZrTfVVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jan 14, 2020 at 11:08:16AM +0100, Thomas Huth wrote:
>> On 13/01/2020 23.36, John Snow wrote:
>> > Right now, we don't
>> > really have these docs hosted in a searchable way online in a
>> > per-version format. Once the notice is gone, it's gone from the mirror=
.
>> >=20
>> > I removed some bitmap functionality not too long ago and I created a
>> > "Recently Removed" section as a bit of a troubleshooting guide should =
it
>> > be needed.
>> >=20
>> > - Do we want this section?
>> > - Should I remove it?
>> > - Can we add historical docs to the website to see previous deprecated
>> > docs in a searchable manner?
>>=20
>> I also once started a page in the Wiki here:
>>=20
>>  https://wiki.qemu.org/Features/RemovedFeatures
>>=20
>> ... but apparently, it did not get enough attention yet, otherwise you
>> would have noticed it before introducing the new chapter into the
>> qemu-doc ...
>>=20
>> We definitely need one spot where we can document removed features. I
>> don't mind which way we do it, either the qemu-doc or the wiki, but we
>> should unify on one of the two. I guess the qemu-doc is the better place
>> since we are tracking the deprecated features there already and one more
>> or less just has to move the text to the other chapter when things get
>> finally removed?
>
> Yeah, I've said in the past that we should not be deleting deprecations
> from the docs entirely.
>
> If you look at GTK docs for example, you'll see they keep a record of
> all incompatible or noteworth changes between release:
>
>   https://developer.gnome.org/gtk3/stable/gtk-migrating-3-x-to-y.html
>
> IMHO, we should follow this and have an appendix of removed features,
> with sub-sections per QEMU release listing each removed feature. Thus
> deprecation docs just get moved to this appendix at the right time.

This is exactly the "Recently Removed" appendix John added in commit
3264ffced3d.

Now we need a sucker^Wvolunteer to restore all the stuff we dropped from
appendix "Deprecated features" to this appendix.  John, you were
incautious enough to signal you care; what about you?


