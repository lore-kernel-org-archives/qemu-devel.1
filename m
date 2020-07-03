Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE32C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B1C2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B1C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI7t-0001Zn-U7
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jrI7C-0000GX-GS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:36:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:60536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jrI79-0004m9-4I
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:36:13 -0400
IronPort-SDR: RFpDIWwfa7jHvHGdV7CbXzTPO1jHHTd1eD1+I3veXcScR+2oHx9dyL1sP8Rn+i+mbne80pKc4h
 S3Q6CfDwFCjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144644711"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; d="scan'208";a="144644711"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2020 02:27:51 -0700
IronPort-SDR: xE9yh13K0bKsngCqM06AuzhWmuYmV2zPOSuKm7i5lxM5b3jHqyMqB2ZKcmgfQCGDq3M5PZ824k
 p++JgOKXmanA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; d="scan'208";a="278386416"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga003.jf.intel.com with ESMTP; 03 Jul 2020 02:27:51 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 3 Jul 2020 02:27:50 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 3 Jul 2020 17:27:48 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 3 Jul 2020 17:27:48 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to
 users and clean up
Thread-Topic: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to
 users and clean up
Thread-Index: AQHWScdKlRnAwnxk2E6+4tCs8rrEA6j1pKeA
Date: Fri, 3 Jul 2020 09:27:48 +0000
Message-ID: <15d75b295b7b482db3ef2428aee87a6d@intel.com>
References: <20200624012042.29355-1-chen.zhang@intel.com>
In-Reply-To: <20200624012042.29355-1-chen.zhang@intel.com>
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
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:27:51
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

Maybe missed this updated series?

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen <chen.zhang@intel.com>
> Sent: Wednesday, June 24, 2020 9:21 AM
> To: Jason Wang <jasowang@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>; qemu-dev <qemu-
> devel@nongnu.org>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to
> users and clean up
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> This series make a way to config COLO "max_queue_size" parameters
> according to user's scenarios and environments and do some clean up for
> descriptions.
>=20
> V2:
>  - Rebase on upstream code.
>=20
> Zhang Chen (2):
>   net/colo-compare.c: Expose compare "max_queue_size" to users
>   qemu-options.hx: Clean up and fix typo for colo-compare
>=20
>  net/colo-compare.c | 43
> ++++++++++++++++++++++++++++++++++++++++++-
>  qemu-options.hx    | 33 +++++++++++++++++----------------
>  2 files changed, 59 insertions(+), 17 deletions(-)
>=20
> --
> 2.17.1


