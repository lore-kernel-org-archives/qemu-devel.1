Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9023C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942EC2469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He25rWxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942EC2469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dJJ-00016h-Kh
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j7dId-0000Ra-G7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j7dIc-0004NE-4J
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:55:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j7dIc-0004Md-0C
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582887317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvnElAPP5HAL5nqrU6/6YvEE4v3u0M9bgUvkSNi/DuI=;
 b=He25rWxQcpus7lEiMy7g63To0s8Pv8L+lKdLtJWt+hxTuD4+lF4l/W+v3ULlnoV2JXgEJx
 oStsyw1JexQV7FDrgnzxMItLv1uXzylMxVDff1zrJqEQzIhFJfqM+22LfQdO+2YA0/Cwsz
 xhak0391rOSjOsPo3Lkji9udtYZJqoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-9IByQCJrN8-EUjU8dSaPqg-1; Fri, 28 Feb 2020 05:55:15 -0500
X-MC-Unique: 9IByQCJrN8-EUjU8dSaPqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8DCDBA3;
 Fri, 28 Feb 2020 10:55:14 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4110819C7F;
 Fri, 28 Feb 2020 10:55:11 +0000 (UTC)
Date: Fri, 28 Feb 2020 11:55:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Message-ID: <20200228105509.GB5274@linux.fritz.box>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
 <20200226095444.GB6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
 <20200227103054.GB7493@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B664140@dggemm531-mbx.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B664140@dggemm531-mbx.china.huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.02.2020 um 08:30 hat Chenqun (kuhn) geschrieben:
> >-----Original Message-----
> >From: Kevin Wolf [mailto:kwolf@redhat.com]
> >Sent: Thursday, February 27, 2020 6:31 PM
> >To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>
> >Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> >peter.maydell@linaro.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>=
;
> >Euler Robot <euler.robot@huawei.com>; Ronnie Sahlberg
> ><ronniesahlberg@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter
> >Lieven <pl@kamp.de>; Max Reitz <mreitz@redhat.com>
> >Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
> >iscsi_open()
> >
> >Am 27.02.2020 um 02:49 hat Chenqun (kuhn) geschrieben:
> >> >-----Original Message-----
> >> >From: Kevin Wolf [mailto:kwolf@redhat.com]
> >> >Sent: Wednesday, February 26, 2020 5:55 PM
> >> >To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>
> >> >Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> >> >peter.maydell@linaro.org; Zhanghailiang
> >> ><zhang.zhanghailiang@huawei.com>; Euler Robot
> >> ><euler.robot@huawei.com>; Ronnie Sahlberg
> ><ronniesahlberg@gmail.com>;
> >> >Paolo Bonzini <pbonzini@redhat.com>; Peter Lieven <pl@kamp.de>; Max
> >> >Reitz <mreitz@redhat.com>
> >> >Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement
> >> >in
> >> >iscsi_open()
> >> >
> >> >Am 26.02.2020 um 09:46 hat kuhn.chenqun@huawei.com geschrieben:
> >> >> From: Chen Qun <kuhn.chenqun@huawei.com>
> >> >>
> >> >> Clang static code analyzer show warning:
> >> >>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never r=
ead
> >> >>         flags &=3D ~BDRV_O_RDWR;
> >> >>         ^        ~~~~~~~~~~~~
> >> >>
> >> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >> >
> >> >Hmm, I'm not so sure about this one because if we remove the line,
> >> >flags will be inconsistent with bs->open_flags. It feels like setting
> >> >a trap for anyone who wants to add code using flags in the future.
> >> Hi Kevin,
> >> I find it exists since 8f3bf50d34037266.   :  )
> >
> >Yes, it has existed from the start with auto-read-only.
> >
> >> It's not a big deal,  just upset clang static code analyzer.
> >> As you said, it could be a trap for the future.
> >
> >What's interesting is that we do have one user of the flags later in the=
 function,
> >but it uses bs->open_flags instead:
> >
> >    ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
> >
> >Maybe this should be using flags? (The value of the bits we're intereste=
d in is
> >the same, but when flags is passed as a parameter, I would expect it to =
be
> >used.)
> >
> Hi Kevin,
> I have a question: are 'flags' exactly the same as 'bs-> open_flags'?=20
> In the function bdrv_open_common() at block.c file,  the existence of sta=
tement( open_flags =3D bdrv_open_flags(bs, bs->open_flags); ) makes them a =
little different.
> Will this place affect them inconsistently ?

Not exactly the same, that's why I said "value of the bits we're
interested in is the same". bdrv_open_flags() basically just filters out
things that are handled by the generic block layer and none of the block
driver's business.

To be precise, iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which
is the same in both.

> Is it safer if we assign bs-> open_flags to flags?

This would add back the flags that we consciously filtered out before,
so I would say no.

Kevin

> Modify just like=EF=BC=9A
> @@ -1917,7 +1917,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          if (ret < 0) {
>              goto out;
>          }
> -        flags &=3D ~BDRV_O_RDWR;
> +        flags =3D bs->open_flags;
>      }
>=20
>      iscsi_readcapacity_sync(iscsilun, &local_err);
> @@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          iscsilun->cluster_size =3D iscsilun->bl.opt_unmap_gran *
>              iscsilun->block_size;
>          if (iscsilun->lbprz) {
> -            ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
> +            ret =3D iscsi_allocmap_init(iscsilun, flags);
>          }
>      }
>=20
> Thanks.
>=20
>=20
>=20


