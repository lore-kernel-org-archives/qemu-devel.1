Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B56C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EB924679
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZziK3BtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ8G-0001Sj-VV
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irJ7c-0000lC-Om
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irJ7Z-0001Ly-3f
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:08:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irJ7Y-0001Lm-WA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=YsPOKO5VuHtfyeuY7VrvEY52mOoDlHbuoXh29lYX0Y8=;
 b=ZziK3BtE8CESuLVAFblcI/veW4WNeuF5X/kcxmeooHg+W7EshOG1qUwv5Y2tXSYNi1tfxf
 quXHuzzP6iqG5x2WIRB+EWT2tkiza6knoClP0ThC1zKbRGXGysN89ycfu8xymkzU7UO7ql
 aRtdgAMQXS3Qq0UqatqBa+D/XdpCHb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-F-M_FDMiPqawW_D4SpaH8A-1; Tue, 14 Jan 2020 05:08:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06CE21007302;
 Tue, 14 Jan 2020 10:08:22 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A6B5C1B0;
 Tue, 14 Jan 2020 10:08:18 +0000 (UTC)
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
References: <20200109095116.18201-1-thuth@redhat.com>
 <5883bc34-926e-70e3-6402-32dfb5d92ab2@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e1ae4e63-626c-cc6d-5117-4b4fbd1ad436@redhat.com>
Date: Tue, 14 Jan 2020 11:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5883bc34-926e-70e3-6402-32dfb5d92ab2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: F-M_FDMiPqawW_D4SpaH8A-1
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/01/2020 23.36, John Snow wrote:
>=20
>=20
> On 1/9/20 4:51 AM, Thomas Huth wrote:
>> Python 2 support has been removed, so we should now also remove
>> the announcement text for the deprecation.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
>> ---
>>  qemu-deprecated.texi | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 7033e531de..8b23e98474 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to s=
kip image creation.
>>  Silently ignored options can be confusing, so this combination of
>>  options will be made an error in future versions.
>> =20
>> -@section Build system
>> -
>> -@subsection Python 2 support (since 4.1.0)
>> -
>> -In the future, QEMU will require Python 3 to be available at
>> -build time.  Support for Python 2 in scripts shipped with QEMU
>> -is deprecated.
>> -
>>  @section Backwards compatibility
>> =20
>>  @subsection Runnability guarantee of CPU models (since 4.1.0)
>>
>=20
> Genuine question, I'm sorry:
>=20
> Is it worth documenting things we recently removed?

Basically yes. In case of Python 2, it's not a QEMU feature that we
remove here, but a build requirement, and we tell the users that we need
at least Python 3.5 when they run "configure", so I'm not sure whether
that needs to be explicitely mentioned again the docs beside our ChangeLog?

> Right now, we don't
> really have these docs hosted in a searchable way online in a
> per-version format. Once the notice is gone, it's gone from the mirror.
>=20
> I removed some bitmap functionality not too long ago and I created a
> "Recently Removed" section as a bit of a troubleshooting guide should it
> be needed.
>=20
> - Do we want this section?
> - Should I remove it?
> - Can we add historical docs to the website to see previous deprecated
> docs in a searchable manner?

I also once started a page in the Wiki here:

 https://wiki.qemu.org/Features/RemovedFeatures

... but apparently, it did not get enough attention yet, otherwise you
would have noticed it before introducing the new chapter into the
qemu-doc ...

We definitely need one spot where we can document removed features. I
don't mind which way we do it, either the qemu-doc or the wiki, but we
should unify on one of the two. I guess the qemu-doc is the better place
since we are tracking the deprecated features there already and one more
or less just has to move the text to the other chapter when things get
finally removed?

 Thomas


