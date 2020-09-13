Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6482C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC1C221E3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC1C221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHYE3-0006po-Km
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 16:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kHYCW-0004jL-Qu
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:02:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:10352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kHYCU-0003DE-5l
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:02:16 -0400
IronPort-SDR: ELd4sNJM8Sod35MKWD+rxkqbruDlnikTEUpf4gyXK+Ir6ndsSKahds3iK63KvPzI82HlrJGFtD
 3qD6FaAndOrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="159935876"
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; d="scan'208";a="159935876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 13:02:08 -0700
IronPort-SDR: z3GIX3wV/5s7SqzrcO6vr+xHLMmStqr8fYClJ+XwYQ1LqcpFycYLoRsyaj15oiQM2iVuJoy7jA
 +157mmbf6GXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; d="scan'208";a="482075148"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 13 Sep 2020 13:02:08 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 13 Sep 2020 13:02:07 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 04:02:05 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 14 Sep 2020 04:02:05 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 2/2] colo-compare: Record packet creation time by
 QEMU_CLOCK_REALTIME
Thread-Topic: [PATCH v1 2/2] colo-compare: Record packet creation time by
 QEMU_CLOCK_REALTIME
Thread-Index: AQHWiETF87zrE2R0cEag8anmIvFjdqlm/1sQ
Date: Sun, 13 Sep 2020 20:02:05 +0000
Message-ID: <817fd011098a4fc6a6790c17414a71a8@intel.com>
References: <20200911190508.1316487-1-dereksu@qnap.com>
 <20200911190508.1316487-3-dereksu@qnap.com>
In-Reply-To: <20200911190508.1316487-3-dereksu@qnap.com>
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
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 16:02:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Derek Su <dereksu@qnap.com>
> Sent: Saturday, September 12, 2020 3:05 AM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; Derek Su <dereksu@qnap.com>
> Subject: [PATCH v1 2/2] colo-compare: Record packet creation time by
> QEMU_CLOCK_REALTIME
>=20
> Record packet creation time by QEMU_CLOCK_REALTIME instead of
> QEMU_CLOCK_HOST. The time difference between `now` and packet
> `creation_ms` has the possibility of an unexpected negative value and res=
ults
> in wrong comparison after changing the host clock.
>=20

Hi Derek,

I think this issue caused by other code in this file use the qemu_clock_get=
_ms(QEMU_CLOCK_VIRTUAL);
I will change all code to QEMU_CLOCK_HOST to fix it with the patch 1/2.=20

Thanks
Zhang Chen

> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  net/colo-compare.c | 2 +-
>  net/colo.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> c4de86ef34..29d7f986e3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -621,7 +621,7 @@ static int colo_packet_compare_other(Packet *spkt,
> Packet *ppkt)
>=20
>  static int colo_old_packet_check_one(Packet *pkt, void *user_data)  {
> -    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      uint32_t check_time =3D *(uint32_t *)user_data;
>=20
>      if ((now - pkt->creation_ms) > check_time) { diff --git a/net/colo.c
> b/net/colo.c index a6c66d829a..0441910169 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -164,7 +164,7 @@ Packet *packet_new(const void *data, int size, int
> vnet_hdr_len)
>=20
>      pkt->data =3D g_memdup(data, size);
>      pkt->size =3D size;
> -    pkt->creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    pkt->creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      pkt->vnet_hdr_len =3D vnet_hdr_len;
>      pkt->tcp_seq =3D 0;
>      pkt->tcp_ack =3D 0;
> --
> 2.25.1


