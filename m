Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ADEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1132074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1132074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDgv-0008Dm-4D
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kEDft-0007h3-2V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:30:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:18030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kEDfp-000569-UA
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:30:48 -0400
IronPort-SDR: ZIkzqkOnFWWtBvf1R+EM+PfCvMsxy6em3VYLwGbOFawLGdkXQV0Pm18Z1XNwVca3bVG5nEumAf
 +LQ8QxRbVgSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="242580431"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="242580431"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 08:30:38 -0700
IronPort-SDR: bBqpVpIQTYNuZj/YBoHaHEDlOKpXGayXf7zUfM4sOAG1XrRmxod61NTFNImmOaQL1pAdl53rGv
 WNU3dQXPT0Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="405867876"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 08:30:38 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 08:30:38 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Sep 2020 23:30:21 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 4 Sep 2020 23:30:21 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Pan Nengyuan <pannengyuan@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] net/filter-rewriter: destroy g_hash_table in
 colo_rewriter_cleanup
Thread-Topic: [PATCH] net/filter-rewriter: destroy g_hash_table in
 colo_rewriter_cleanup
Thread-Index: AQHWgoxAN7Z5W4Oo6kad3S1TmqXujalYmseg
Date: Fri, 4 Sep 2020 15:30:21 +0000
Message-ID: <cbc8bf62c2d14f78ad21020d50597740@intel.com>
References: <20200904134908.1396-1-pannengyuan@huawei.com>
In-Reply-To: <20200904134908.1396-1-pannengyuan@huawei.com>
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
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:30:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Pan Nengyuan <pannengyuan@huawei.com>
> Sent: Friday, September 4, 2020 9:49 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; jasowang@redhat.com;
> zhang.zhanghailiang@huawei.com; kuhn.chenqun@huawei.com; Pan
> Nengyuan <pannengyuan@huawei.com>
> Subject: [PATCH] net/filter-rewriter: destroy g_hash_table in
> colo_rewriter_cleanup
>=20
> s->connection_track_table forgot to destroy in colo_rewriter_cleanup. Fix=
 it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Oh, Thanks Euler Robot~~
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  net/filter-rewriter.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c index
> 1aaad101b6..9ff366d44f 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -376,6 +376,8 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
>          filter_rewriter_flush(nf);
>          g_free(s->incoming_queue);
>      }
> +
> +    g_hash_table_destroy(s->connection_track_table);
>  }
>=20
>  static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
> --
> 2.18.2


