Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B18C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0B7221E3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0B7221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHYDQ-0005e7-Sv
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 16:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kHYCa-0004nI-KE
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:02:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:33330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kHYCY-0003Ek-ND
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:02:20 -0400
IronPort-SDR: mRIGnGimyPyLnqmgDfDG+bzemtJps6u8IQjF9svJ2F/slmuKX+W/A9cX98eeVIcWxlzZuqnOzU
 g5OraRtnhk2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="139013244"
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; d="scan'208";a="139013244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 13:02:16 -0700
IronPort-SDR: 1HaPnkHzYuAl6Wr8a2UhOPcE6RadAMmkQIHbZch4yO2YKAE05cMQ2hyvWRBkqpytOYpDob66Xl
 z2ty6n6lAOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; d="scan'208";a="482075174"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga005.jf.intel.com with ESMTP; 13 Sep 2020 13:02:16 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 13 Sep 2020 13:02:15 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 04:02:13 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 14 Sep 2020 04:02:13 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversion
Thread-Topic: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversion
Thread-Index: AQHWiES5QtR8SEPuYEuZPvdyOc5w2Klm9+2w
Date: Sun, 13 Sep 2020 20:02:13 +0000
Message-ID: <3c5d8cfd966a415c896c0d8e814e4ab9@intel.com>
References: <20200911190508.1316487-1-dereksu@qnap.com>
 <20200911190508.1316487-2-dereksu@qnap.com>
In-Reply-To: <20200911190508.1316487-2-dereksu@qnap.com>
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
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 16:02:16
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
> Subject: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversion
>=20
> Fix data type conversion of compare_timeout. The incorrect conversion
> results in a random compare_timeout value and unexpected stalls in packet
> comparison.
>=20

This bug already found on our internal test too. Just waiting to send.
Good catch! But this patch not fixed the root cause.
Change the compare_timeout from uint32_t to uint64_t is better.
I will send a patch for this and tag reported by you.

Thanks
Zhang Chen


> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  net/colo-compare.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 2c20de1537..c4de86ef34 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -619,11 +619,12 @@ static int colo_packet_compare_other(Packet *spkt,
> Packet *ppkt)
>                                         ppkt->size - offset);  }
>=20
> -static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
> +static int colo_old_packet_check_one(Packet *pkt, void *user_data)
>  {
>      int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    uint32_t check_time =3D *(uint32_t *)user_data;
>=20
> -    if ((now - pkt->creation_ms) > (*check_time)) {
> +    if ((now - pkt->creation_ms) > check_time) {
>          trace_colo_old_packet_check_found(pkt->creation_ms);
>          return 0;
>      } else {
> --
> 2.25.1


