Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4132E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4132E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jki0q-0007QL-Hp
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 01:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jki0H-0006yw-V1; Mon, 15 Jun 2020 01:49:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:23157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jki0F-0005FY-EC; Mon, 15 Jun 2020 01:49:53 -0400
IronPort-SDR: Lon/Qx6K280LoTLpquXM1WZhD969bd8Mm7peBL6KItlUQp7yDfrprp+3uWl23gySvycpyFmMFW
 CNcxCvIB35UA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 22:49:46 -0700
IronPort-SDR: dmcfz1mZsXNTPefAopYM3verYlYevgc1nB5RIBmQhNzHya+IIsWfqZkw9PZOgHUzJqEvNe4UjA
 iu+tAk1ZBAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; d="scan'208";a="420249100"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga004.jf.intel.com with ESMTP; 14 Jun 2020 22:49:46 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 22:49:45 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 15 Jun 2020 13:49:43 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 15 Jun 2020 13:49:43 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Like Xu <like.xu@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/2] migration/colo/net: fix typo in the COLO Proxy module
Thread-Topic: [PATCH 2/2] migration/colo/net: fix typo in the COLO Proxy module
Thread-Index: AQHWQihBve3pwZ2T20ysG5Vw22gV5ajZGA5Q
Date: Mon, 15 Jun 2020 05:49:43 +0000
Message-ID: <35f6da2075854e79b2cc8d8cc9ecfc62@intel.com>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
 <20200614084510.7917-2-like.xu@linux.intel.com>
In-Reply-To: <20200614084510.7917-2-like.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=chen.zhang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:49:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Like Xu <like.xu@linux.intel.com>
> Sent: Sunday, June 14, 2020 4:45 PM
> To: qemu-devel@nongnu.org
> Cc: Like Xu <like.xu@linux.intel.com>; Zhang, Chen <chen.zhang@intel.com>=
;
> Li Zhijian <lizhijian@cn.fujitsu.com>
> Subject: [PATCH 2/2] migration/colo/net: fix typo in the COLO Proxy modul=
e
>=20
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>


Looks good to me.
By the way, add CC qemu-trivial@nongnu.org
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  docs/colo-proxy.txt | 4 ++--
>  net/colo-compare.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt index
> fa1cef0278..0bbd6f720a 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -21,7 +21,7 @@ and filter-rewriter compose the COLO-proxy.
>  =3D=3D Architecture =3D=3D
>=20
>  COLO-Proxy is based on qemu netfilter and it's a plugin for qemu netfilt=
er -
> (except colo-compare). It keep Secondary VM connect normally to
> +(except colo-compare). It keeps Secondary VM connect normally to
>  client and compare packets sent by PVM with sent by SVM.
>  If the packet difference, notify COLO-frame to do checkpoint and send  a=
ll
> primary packet has queued. Otherwise just send the queued primary @@ -
> 94,7 +94,7 @@ Redirect Server Filter --> COLO-Compare  COLO-compare
> receive primary guest packet then  waiting secondary redirect packet to
> compare it.
>  If packet same,send queued primary packet and clear -queued secondary
> packet, Otherwise send primary packet
> +queued secondary packet, otherwise send primary packet
>  and do checkpoint.
>=20
>  COLO-Compare --> Another Redirector Filter diff --git a/net/colo-compare=
.c
> b/net/colo-compare.c index c07e7c1c09..3efc61c777 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -658,7 +658,7 @@ static void colo_compare_packet(CompareState *s,
> Connection *conn,
>              g_queue_remove(&conn->secondary_list, result->data);
>          } else {
>              /*
> -             * If one packet arrive late, the secondary_list or
> +             * If one packet arrives late, the secondary_list or
>               * primary_list will be empty, so we can't compare it
>               * until next comparison. If the packets in the list are
>               * timeout, it will trigger a checkpoint request.
> @@ -1296,7 +1296,7 @@ static void colo_compare_finalize(Object *obj)
>          }
>      }
>=20
> -    /* Release all unhandled packets after compare thead exited */
> +    /* Release all unhandled packets after compare thread exited */
>      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>=20
>      g_queue_clear(&s->conn_list);
> --
> 2.21.3


