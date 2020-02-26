Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E792467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqZJCkc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E792467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tPh-0000wd-0q
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6tP3-0000QC-Re
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6tP2-0003vO-OW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:54:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6tP2-0003um-KX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582710892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xp3xeOqaNDoIa9NTtOqILdHbwFkwRlALmAsN/itNMrk=;
 b=IqZJCkc8KB+7qNPP8sKQ1N4XncjQkrAYs98OOLu/jzCzWXL4JbM/MWVHhdFZKNmrKMiyOz
 mY+LDWNsSneD4/Ry7DH0MAdZrOe9C99APDChFmVpwMruC754erlQ9gCdn703M9xRB/YATJ
 tiWMhtyek6WBTMrEk5q3Ymm/NDtXqPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-FHEosH-SM6y5q0jGG00A3g-1; Wed, 26 Feb 2020 04:54:50 -0500
X-MC-Unique: FHEosH-SM6y5q0jGG00A3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70C1DBA3;
 Wed, 26 Feb 2020 09:54:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872345C13D;
 Wed, 26 Feb 2020 09:54:46 +0000 (UTC)
Date: Wed, 26 Feb 2020 10:54:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Message-ID: <20200226095444.GB6096@linux.fritz.box>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200226084647.20636-3-kuhn.chenqun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.02.2020 um 09:46 hat kuhn.chenqun@huawei.com geschrieben:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Clang static code analyzer show warning:
>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>         flags &=3D ~BDRV_O_RDWR;
>         ^        ~~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Hmm, I'm not so sure about this one because if we remove the line, flags
will be inconsistent with bs->open_flags. It feels like setting a trap
for anyone who wants to add code using flags in the future.

Kevin

> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  block/iscsi.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 682abd8e09..ed88479ede 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1917,7 +1917,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          if (ret < 0) {
>              goto out;
>          }
> -        flags &=3D ~BDRV_O_RDWR;
>      }
> =20
>      iscsi_readcapacity_sync(iscsilun, &local_err);
> --=20
> 2.23.0
>=20
>=20


