Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D50C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD6720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQnNshFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD6720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06B8-0004os-Ky
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j06AO-0003Tg-2M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j06AM-000646-QQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:07:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j06AM-00063a-NI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581091658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oD1NuLLoLNSEhus9xc2ZfXtMyC4FjTGa+wT7BCvANM=;
 b=YQnNshFby5rOC5JBrioo3MUzrRuJ1bdZSpbVbaZjTkPcXgMyNgb5FtBi8EgkkUuA2pi6Mt
 7WsWrgMYeLP8h81PoKMFurLfbsUmmdNx8TQILmDySSDKx0RGmj2AB8Xphzum99MH5qL+nT
 FtXw9p5VgAQQsnyJ6n+F+VMvclqecJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-wXzcXzB9MMCYzszM0I3Fmg-1; Fri, 07 Feb 2020 11:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44303800D6C;
 Fri,  7 Feb 2020 16:07:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D1F60BEC;
 Fri,  7 Feb 2020 16:07:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7847711386A7; Fri,  7 Feb 2020 17:07:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Cover qapi/block{-core}.json in 'Block
 layer core' section
References: <20200207103012.27049-1-philmd@redhat.com>
 <20200207103012.27049-3-philmd@redhat.com>
 <87blqaqyxi.fsf@dusky.pond.sub.org>
 <20200207142146.GF6031@linux.fritz.box>
Date: Fri, 07 Feb 2020 17:07:13 +0100
In-Reply-To: <20200207142146.GF6031@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 7 Feb 2020 15:21:46 +0100")
Message-ID: <87blqapej2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wXzcXzB9MMCYzszM0I3Fmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.02.2020 um 15:01 hat Markus Armbruster geschrieben:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>> > List this file in the proper section, so maintainers get
>> > notified when it is modified.
>> >
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > ---
>> > Cc: Kevin Wolf <kwolf@redhat.com>
>> > Cc: Max Reitz <mreitz@redhat.com>
>> > Cc: qemu-block@nongnu.org
>> > ---
>> >  MAINTAINERS | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 903831e0a4..e269e9092c 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -1842,6 +1842,8 @@ S: Supported
>>    Block layer core
>>    M: Kevin Wolf <kwolf@redhat.com>
>>    M: Max Reitz <mreitz@redhat.com>
>>    L: qemu-block@nongnu.org
>>    S: Supported
>> >  F: block*
>> >  F: block/
>> >  F: hw/block/
>> > +F: qapi/block.json
>> > +F: qapi/block-core.json
>> >  F: include/block/
>> >  F: qemu-img*
>> >  F: docs/interop/qemu-img.rst
>>=20
>> This is in addition to
>>=20
>>     Block QAPI, monitor, command line
>>     M: Markus Armbruster <armbru@redhat.com>
>>     S: Supported
>>     F: blockdev.c
>>     F: block/qapi.c
>>     F: qapi/block*.json
>>     F: qapi/transaction.json
>>     T: git https://repo.or.cz/qemu/armbru.git block-next
>>=20
>> I'm not sure this section makes much sense anymore.
>
> This is probably for you to decide.
>
> Though the block-next branch from the T: line doesn't even exist any
> more...

I have the questionable habit to delete my -next branches when they're
empty.

>> Should qapi/transaction.json also be added to "Block layer core"?  Or
>> should it go into John's section "Block Jobs"?
>
> I think at the moment it only supports actions that are more related to
> block jobs, so moving it there would make sense to me.

Alright, what about this:

diff --git a/MAINTAINERS b/MAINTAINERS
index e72b5e5f69..43e821c901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1842,6 +1842,8 @@ F: block*
 F: block/
 F: hw/block/
 F: include/block/
+F: qapi/block.json
+F: qapi/block-core.json
 F: qemu-img*
 F: docs/interop/qemu-img.rst
 F: qemu-io*
@@ -1887,16 +1889,8 @@ F: block/commit.c
 F: block/stream.c
 F: block/mirror.c
 F: qapi/job.json
-T: git https://github.com/jnsnow/qemu.git jobs
-
-Block QAPI, monitor, command line
-M: Markus Armbruster <armbru@redhat.com>
-S: Supported
-F: blockdev.c
-F: block/qapi.c
-F: qapi/block*.json
 F: qapi/transaction.json
-T: git https://repo.or.cz/qemu/armbru.git block-next
+T: git https://github.com/jnsnow/qemu.git jobs
=20
 Dirty Bitmaps
 M: John Snow <jsnow@redhat.com>


