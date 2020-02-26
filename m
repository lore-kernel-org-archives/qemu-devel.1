Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D31C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E89820714
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0tjG6Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E89820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6u3r-0000dH-FP
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6u38-0000Ar-FX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6u36-00025K-7r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:36:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6u36-00021v-3M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582713374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODLEvxrJOLvP0jliU5YyCcs7Etg2vs0tTEaqV0F4UJk=;
 b=f0tjG6BqadUUH9s+5BKxXiL0COVGvY4LyME6LAtYXZhb4T9Jh02tY7cnFGdBDKNsIxB5Sp
 iAupN/NUagGCvAiFGfV4ehbvernWbhhZRekyqZd5MZbwRwYh+eckGCt0jwmdGp6kywbAm5
 s5MC2VcUfeEPKQVsC96oZY6Oa4chv8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-jtTEHQgoOwa87HA6dTQocw-1; Wed, 26 Feb 2020 05:36:13 -0500
X-MC-Unique: jtTEHQgoOwa87HA6dTQocw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27BE2F60;
 Wed, 26 Feb 2020 10:36:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08ACA60BE2;
 Wed, 26 Feb 2020 10:36:09 +0000 (UTC)
Date: Wed, 26 Feb 2020 11:36:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 01/13] block/stream: Remove redundant statement in
 stream_run()
Message-ID: <20200226103608.GC6096@linux.fritz.box>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-2-kuhn.chenqun@huawei.com>
 <20200226095102.GA6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B662BBF@dggemm531-mbx.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B662BBF@dggemm531-mbx.china.huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.02.2020 um 11:21 hat Chenqun (kuhn) geschrieben:
>=20
>=20
> >-----Original Message-----
> >From: Kevin Wolf [mailto:kwolf@redhat.com]
> >Sent: Wednesday, February 26, 2020 5:51 PM
> >To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>
> >Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> >peter.maydell@linaro.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>=
;
> >Euler Robot <euler.robot@huawei.com>; John Snow <jsnow@redhat.com>;
> >Max Reitz <mreitz@redhat.com>
> >Subject: Re: [PATCH v2 01/13] block/stream: Remove redundant statement i=
n
> >stream_run()
> >
> >Am 26.02.2020 um 09:46 hat kuhn.chenqun@huawei.com geschrieben:
> >> From: Chen Qun <kuhn.chenqun@huawei.com>
> >>
> >> Clang static code analyzer show warning:
> >>   block/stream.c:186:9: warning: Value stored to 'ret' is never read
> >>         ret =3D 0;
> >>         ^     ~
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >
> >Let's mention that this is unnecessary since commit 1d809098aa9.
> >
> >Since the same commit, the initialisation 'int ret =3D 0;' is unnecessar=
y because
> >we never read ret before overwriting the initial value. We could clean t=
his up
> >in the same patch.
>=20
> Yes, we can clean it and move 'ret'  declaration to the for() statement.
>=20
> Modify just Like this=EF=BC=9A
> [...]

Godd point, makes sense to me. Please keep my R-b if you make this
change.

Kevin

> @@ -114,7 +114,6 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
>      int64_t offset =3D 0;
>      uint64_t delay_ns =3D 0;
>      int error =3D 0;
> -    int ret =3D 0;
>      int64_t n =3D 0; /* bytes */
>=20
>      if (bs =3D=3D s->bottom) {
> @@ -139,6 +138,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
>=20
>      for ( ; offset < len; offset +=3D n) {
>          bool copy;
> +        int ret;
>=20
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
> @@ -183,7 +183,6 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
>                  break;
>              }
>          }
> -        ret =3D 0;
>=20
>          /* Publish progress */
>          job_progress_update(&s->common.job, n);
>=20
> >
> >With or without the changes:
> >
> >Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>=20


