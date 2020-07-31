Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E570C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320182245C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320182245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SMP-00006y-GD
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1k1SL4-0007jS-Ag
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:32:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:49108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1k1SL1-0002zo-4a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:32:33 -0400
IronPort-SDR: CeDaG02qD+b4u/J+1a/1MXhkL5b4yDEmS0oZbKvRUC+/HQI/YHa+MjD4BP90J+Gf+d6VsfImEq
 r5Z9ymHgA+3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150954729"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="150954729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2020 03:32:27 -0700
IronPort-SDR: GgXPiKl498NCKXq/aVUxHdDCJzMn/p40HuF89Wv+NoVrwGsZvXv+cV/qHiAEijrM9ZlqYx+7ob
 0H0w7Xbx4Gmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="274477961"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2020 03:32:27 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jul 2020 03:32:27 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jul 2020 18:32:24 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 31 Jul 2020 18:32:24 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
Thread-Topic: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
Thread-Index: AQHWZvhcyNtoE14Q+k2AsNDcZxskCakhfatw
Date: Fri, 31 Jul 2020 10:32:24 +0000
Message-ID: <75db1541718344588f08647465e02067@intel.com>
References: <20200731070604.0c981f41@luklap>
In-Reply-To: <20200731070604.0c981f41@luklap>
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
Received-SPF: pass client-ip=192.55.52.115; envelope-from=chen.zhang@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 06:32:27
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Friday, July 31, 2020 1:06 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Jason Wang
> <jasowang@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH] colo-compare: Remove superfluous NULL-pointer checks
> for s->iothread
>=20
> s->iothread is checked for NULL on object creation in
> s->colo_compare_complete,
> so it's guaranteed not to be NULL.
> This resolves a false alert from Coverity (CID 1429969).
>=20

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> cc15f23dea..2c20de1537 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
>          qemu_chr_fe_deinit(&s->chr_notify_dev, false);
>      }
>=20
> -    if (s->iothread) {
> -        colo_compare_timer_del(s);
> -    }
> +    colo_compare_timer_del(s);
>=20
>      qemu_bh_delete(s->event_bh);
>=20
> @@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
>          g_hash_table_destroy(s->connection_track_table);
>      }
>=20
> -    if (s->iothread) {
> -        object_unref(OBJECT(s->iothread));
> -    }
> +    object_unref(OBJECT(s->iothread));
>=20
>      g_free(s->pri_indev);
>      g_free(s->sec_indev);
> --
> 2.20.1

