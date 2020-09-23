Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D04DC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41042371F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41042371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKtsh-0008Mq-08
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 21:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKts7-0007vv-6G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:47:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:48658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKts4-00078r-Ff
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:47:02 -0400
IronPort-SDR: wEcX52wx6R6a/Cpq+16hKy+yPw8n7X1ajj4AcZacuBfY3UkVbGGRW74shFOM/UMa37NFqk5i9S
 OgdKmmiR0zJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224904738"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="224904738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 18:46:57 -0700
IronPort-SDR: PR34qOzyvFDbbJWQV5tqqgMEAPa8UwWd0xvrnlGTNQX8KehlAzlf8YP4+lE8hdmAXD+eYxkiP1
 1FxvWQA8bbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="511446447"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2020 18:46:57 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 18:46:56 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 09:46:54 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 09:46:54 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH 3/3] colo-compare: check mark in mutual exclusion
Thread-Topic: [PATCH 3/3] colo-compare: check mark in mutual exclusion
Thread-Index: AQHWkMaNWC8vtCWU7kaxMIpzD9ac/Kl1dNKA
Date: Wed, 23 Sep 2020 01:46:54 +0000
Message-ID: <a9a96714fd844d0baecef33d93577da8@intel.com>
References: <20200922095525.4081603-1-lizhijian@cn.fujitsu.com>
 <20200922095525.4081603-4-lizhijian@cn.fujitsu.com>
In-Reply-To: <20200922095525.4081603-4-lizhijian@cn.fujitsu.com>
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
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:46:57
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> Sent: Tuesday, September 22, 2020 5:55 PM
> To: Zhang, Chen <chen.zhang@intel.com>; jasowang@redhat.com
> Cc: qemu-devel@nongnu.org; Li Zhijian <lizhijian@cn.fujitsu.com>
> Subject: [PATCH 3/3] colo-compare: check mark in mutual exclusion
>=20
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>
By the way, we have other optimization here, will be sent in the future.

Thanks
Zhang Chen

> ---
>  net/colo-compare.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 039b515611..19633fc684 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -481,13 +481,11 @@ sec:
>              colo_release_primary_pkt(s, ppkt);
>              g_queue_push_head(&conn->secondary_list, spkt);
>              goto pri;
> -        }
> -        if (mark =3D=3D COLO_COMPARE_FREE_SECONDARY) {
> +        } else if (mark =3D=3D COLO_COMPARE_FREE_SECONDARY) {
>              conn->compare_seq =3D spkt->seq_end;
>              packet_destroy(spkt, NULL);
>              goto sec;
> -        }
> -        if (mark =3D=3D (COLO_COMPARE_FREE_PRIMARY |
> COLO_COMPARE_FREE_SECONDARY)) {
> +        } else if (mark =3D=3D (COLO_COMPARE_FREE_PRIMARY |
> + COLO_COMPARE_FREE_SECONDARY)) {
>              conn->compare_seq =3D ppkt->seq_end;
>              colo_release_primary_pkt(s, ppkt);
>              packet_destroy(spkt, NULL);
> --
> 2.28.0
>=20
>=20


