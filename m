Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BCFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 01:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A074D20775
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 01:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A074D20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jke3w-0002x6-TH
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 21:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jke3N-0002WZ-VO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 21:36:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2468 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jke3M-00050j-16
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 21:36:49 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 34464BBCA69F139A32E2;
 Mon, 15 Jun 2020 09:36:35 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 15 Jun 2020 09:36:34 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 15 Jun 2020 09:36:34 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Mon, 15 Jun 2020 09:36:34 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Like Xu <like.xu@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Topic: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Index: AQHWQihESQ1QHSyBjUOMZYAPEejPW6jY5YMw
Date: Mon, 15 Jun 2020 01:36:34 +0000
Message-ID: <17a0016f32fb471fa57e4f0c21ecb19d@huawei.com>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
In-Reply-To: <20200614084510.7917-1-like.xu@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 21:36:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Like,

Please check this patch, It seems that you didn't use git format-patch comm=
and to generate this patch,
It is in wrong format.

Thanks,
Hailiang

> -----Original Message-----
> From: Like Xu [mailto:like.xu@linux.intel.com]
> Sent: Sunday, June 14, 2020 4:45 PM
> To: qemu-devel@nongnu.org
> Cc: Like Xu <like.xu@linux.intel.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>
> Subject: [PATCH 1/2] migration/colo: fix typo in the COLO Framework
> module
>=20
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  docs/COLO-FT.txt | 8 ++++----
>  migration/colo.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> c8e1740935..fdc0207cff 100644
> --- a/docs/COLO-FT.txt
> +++ b/docs/COLO-FT.txt
> @@ -10,7 +10,7 @@ See the COPYING file in the top-level directory.
>  This document gives an overview of COLO's design and how to use it.
>=20
>  =3D=3D Background =3D=3D
> -Virtual machine (VM) replication is a well known technique for providing
> +Virtual machine (VM) replication is a well-known technique for
> +providing
>  application-agnostic software-implemented hardware fault tolerance,  als=
o
> known as "non-stop service".
>=20
> @@ -103,7 +103,7 @@ Primary side.
>=20
>  COLO Proxy:
>  Delivers packets to Primary and Secondary, and then compare the response=
s
> from -both side. Then decide whether to start a checkpoint according to
> some rules.
> +both sides. Then decide whether to start a checkpoint according to some
> rules.
>  Please refer to docs/colo-proxy.txt for more information.
>=20
>  Note:
> @@ -146,12 +146,12 @@ in test procedure.
>=20
>  =3D=3D Test procedure =3D=3D
>  Note: Here we are running both instances on the same host for testing,
> -change the IP Addresses if you want to run it on two hosts. Initally
> +change the IP Addresses if you want to run it on two hosts. Initially
>  127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
>=20
>  =3D=3D Startup qemu =3D=3D
>  1. Primary:
> -Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hos=
ts.
> +Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all ho=
sts.
>  You don't need to change any IP's here, because 0.0.0.0 listens on any
> interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
> instance.
> diff --git a/migration/colo.c b/migration/colo.c index
> ea7d1e9d4e..80788d46b5 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -632,7 +632,7 @@ out:
>      /*
>       * It is safe to unregister notifier after failover finished.
>       * Besides, colo_delay_timer and colo_checkpoint_sem can't be
> -     * released befor unregister notifier, or there will be use-after-fr=
ee
> +     * released before unregister notifier, or there will be
> + use-after-free
>       * error.
>       */
>      colo_compare_unregister_notifier(&packets_compare_notifier);
> --
> 2.21.3


