Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761DC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86012371F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86012371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKtq3-00064y-Uw
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 21:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtnK-0003rX-4O
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:42:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:24885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtnH-0006dg-Eh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:42:05 -0400
IronPort-SDR: drhcYLJJs7D4trXbsUnsuS/kGettZo6nyUmN0TNgC1n9pEvqu/v+K4H9R7KmknCaOhH9KV//dN
 i6AWX8/GJMEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="160835876"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="160835876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 18:41:56 -0700
IronPort-SDR: xdIOesBqsUPPqGisYl2mUcuwKbLBqD81WGlFqup3aVYFlvAqaLsYG/mvfeiKKKfthE/qYVQ62K
 gBONeWOStGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="382515142"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga001.jf.intel.com with ESMTP; 22 Sep 2020 18:41:55 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 18:41:54 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 09:41:52 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 09:41:52 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH 1/3] colo-compare: return -1 if no packet is queued
Thread-Topic: [PATCH 1/3] colo-compare: return -1 if no packet is queued
Thread-Index: AQHWkMaM/VdgRrmbx02bMbjfHxwoLal1cpbA
Date: Wed, 23 Sep 2020 01:41:52 +0000
Message-ID: <e1841d5119ff4d82ad01586d08ea45ec@intel.com>
References: <20200922095525.4081603-1-lizhijian@cn.fujitsu.com>
 <20200922095525.4081603-2-lizhijian@cn.fujitsu.com>
In-Reply-To: <20200922095525.4081603-2-lizhijian@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:41:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> Sent: Tuesday, September 22, 2020 5:55 PM
> To: Zhang, Chen <chen.zhang@intel.com>; jasowang@redhat.com
> Cc: qemu-devel@nongnu.org; Li Zhijian <lizhijian@cn.fujitsu.com>
> Subject: [PATCH 1/3] colo-compare: return -1 if no packet is queued
>=20
> Return 0 will trigger a packet comparison
>=20

Yes, we need active trigger a checkpoint to flush all the queued packets he=
re.
Otherwise, we should drop all the packet after this time still next checkpo=
int.
So, I think original logic is a better choice.

Thanks
Zhang Chen

> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 3a45d64175..039b515611 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -289,6 +289,7 @@ static int packet_enqueue(CompareState *s, int
> mode, Connection **con)
>              "queue size too big, drop packet");
>          packet_destroy(pkt, NULL);
>          pkt =3D NULL;
> +        return -1;
>      }
>=20
>      *con =3D conn;
> --
> 2.28.0
>=20
>=20


