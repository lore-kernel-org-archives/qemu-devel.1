Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E84BC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DDC20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUD1eVoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DDC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkkF-0003C6-2r
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwkjd-0002gc-SY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwkjc-0006HQ-Pc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:38:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwkjc-0006HG-M8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580294292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mtaauwAc0HhOVmkKft0gVgYWNQqGiC5BAH6rk7KsD4=;
 b=PUD1eVoyQrgd0ofGktbU2p5EH5cVeeUyYytfjGzroF8ZS2qYR0oe26Gf7+Ejg9bZB36t1I
 UnqcnQH3EEoa4+2Axtg1lQwSh5+thAZhy4qhddg+6FtIyj5s42U4X6uDHuxsfGEJkPaa32
 LYMzeBeXQ1A7n+bXaGpuCHGXKsNSqBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-V4vfM1YxP-exZKNIPF58wg-1; Wed, 29 Jan 2020 05:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D774B107ACC7;
 Wed, 29 Jan 2020 10:38:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2157838A;
 Wed, 29 Jan 2020 10:38:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D2001138404; Wed, 29 Jan 2020 11:38:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 12/13] add 'error' prefix to vreport
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-13-mlevitsk@redhat.com>
 <cc410f54aeb01a517b74283a497e7ce861c92dab.camel@redhat.com>
Date: Wed, 29 Jan 2020 11:38:04 +0100
In-Reply-To: <cc410f54aeb01a517b74283a497e7ce861c92dab.camel@redhat.com>
 (Maxim Levitsky's message of "Tue, 28 Jan 2020 21:30:52 +0200")
Message-ID: <87o8um5z03.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: V4vfM1YxP-exZKNIPF58wg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Mon, 2020-01-27 at 12:36 +0200, Maxim Levitsky wrote:
>> This changes most of qemu's error messages,
>> but it feels like the right thing to do.
>>=20
>> This is WIP patch, since I updated most of iotests but not all of them,
>> and will be updated if this patch is accepeted in the review.
>> Also few error message already have 'error' prefix, which should be remo=
ved.
>>=20
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>
> Since Peter Krempa pointed out that libvirt doesn't need the error prefix=
es any more
> (this wasn't the case when I developed this sadly) I guess I'll drop that=
 patch,
> although to me it looks just better to have errors cleanly prefixed to be=
 honest.

The "libvirt needs this" justification is gone.  But perhaps we want it
anyway.  It's hardly an "HMP monitor handlers cleanups", though.
Suggest to split it off this series, so it can't hold it back.  Posting
it separately should also give it a better chance to be noticed.


