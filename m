Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9601EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FB720758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcJu-00068U-1O
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kDcJN-0005hs-OC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:37:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:22216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kDcJK-0005vL-SZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:37:05 -0400
IronPort-SDR: 6z+7OqwLpoa+byUHA9g3myHmU0UpCDW1PJnpSBf8ipTnWmU0xGtbvMB+rI3Kasa4ya/fVNU8Tc
 bHWHB3KqFbLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158481773"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="158481773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 16:36:58 -0700
IronPort-SDR: whTXQrqsTbKkh8K4O4U1nWB0Q2iwCxzMxQzsG7vEV2qKgmUUFCYXWVBJJJZyUncgEAw6fJMTgF
 lDc3j7smqUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="502310740"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2020 16:36:58 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Sep 2020 16:36:57 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:36:55 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 3 Sep 2020 07:36:55 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 40/63] filter-rewriter: Rename FILTER_COLO_REWRITER to
 FILTER_REWRITER
Thread-Topic: [PATCH 40/63] filter-rewriter: Rename FILTER_COLO_REWRITER to
 FILTER_REWRITER
Thread-Index: AQHWgXq6WSTWUoPwpUauYCbXij1H/KlV+TCQ
Date: Wed, 2 Sep 2020 23:36:55 +0000
Message-ID: <e33d7a390b1e4782bcf11392e9598a87@intel.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-41-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-41-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:36:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Thursday, September 3, 2020 6:43 AM
> To: qemu-devel@nongnu.org
> Cc: berrange@redhat.com; Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>
> Subject: [PATCH 40/63] filter-rewriter: Rename FILTER_COLO_REWRITER to
> FILTER_REWRITER
>=20
> Make the type checking macro name consistent with the TYPE_* constant.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  net/filter-rewriter.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c index
> 113e293207..44f6021dd8 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -25,7 +25,7 @@
>=20
>  #define TYPE_FILTER_REWRITER "filter-rewriter"
>  typedef struct RewriterState RewriterState; -
> DECLARE_INSTANCE_CHECKER(RewriterState, FILTER_COLO_REWRITER,
> +DECLARE_INSTANCE_CHECKER(RewriterState, FILTER_REWRITER,
>                           TYPE_FILTER_REWRITER)
>=20
>  #define FAILOVER_MODE_ON  true
> @@ -47,7 +47,7 @@ static void filter_rewriter_failover_mode(RewriterState
> *s)
>=20
>  static void filter_rewriter_flush(NetFilterState *nf)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> +    RewriterState *s =3D FILTER_REWRITER(nf);
>=20
>      if (!qemu_net_queue_flush(s->incoming_queue)) {
>          /* Unable to empty the queue, purge remaining packets */ @@ -252=
,7
> +252,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
>                                           int iovcnt,
>                                           NetPacketSent *sent_cb)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> +    RewriterState *s =3D FILTER_REWRITER(nf);
>      Connection *conn;
>      ConnectionKey key;
>      Packet *pkt;
> @@ -350,7 +350,7 @@ static gboolean offset_is_nonzero(gpointer key,
> static void colo_rewriter_handle_event(NetFilterState *nf, int event,
>                                         Error **errp)  {
> -    RewriterState *rs =3D FILTER_COLO_REWRITER(nf);
> +    RewriterState *rs =3D FILTER_REWRITER(nf);
>=20
>      switch (event) {
>      case COLO_EVENT_CHECKPOINT:
> @@ -370,7 +370,7 @@ static void
> colo_rewriter_handle_event(NetFilterState *nf, int event,
>=20
>  static void colo_rewriter_cleanup(NetFilterState *nf)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> +    RewriterState *s =3D FILTER_REWRITER(nf);
>=20
>      /* flush packets */
>      if (s->incoming_queue) {
> @@ -381,7 +381,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
>=20
>  static void colo_rewriter_setup(NetFilterState *nf, Error **errp)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> +    RewriterState *s =3D FILTER_REWRITER(nf);
>=20
>      s->connection_track_table =3D
> g_hash_table_new_full(connection_key_hash,
>                                                        connection_key_equ=
al, @@ -392,7 +392,7 @@
> static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
>=20
>  static bool filter_rewriter_get_vnet_hdr(Object *obj, Error **errp)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +    RewriterState *s =3D FILTER_REWRITER(obj);
>=20
>      return s->vnet_hdr;
>  }
> @@ -401,14 +401,14 @@ static void filter_rewriter_set_vnet_hdr(Object
> *obj,
>                                           bool value,
>                                           Error **errp)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +    RewriterState *s =3D FILTER_REWRITER(obj);
>=20
>      s->vnet_hdr =3D value;
>  }
>=20
>  static void filter_rewriter_init(Object *obj)  {
> -    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +    RewriterState *s =3D FILTER_REWRITER(obj);
>=20
>      s->vnet_hdr =3D false;
>      s->failover_mode =3D FAILOVER_MODE_OFF;
> --
> 2.26.2


