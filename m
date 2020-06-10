Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B638BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE5E2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE5E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu4o-0006UQ-SK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jitnN-0004WU-41
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:01:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:9480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jitnK-0000Yp-UW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:01:04 -0400
IronPort-SDR: YUj66mOEGrrYzFe7QQ+rBv8JAlA7fv/8CGH+Zk2O5VOJMizTLfAjBYktMR7wGMnGlDR1lAtSoO
 GTjiU3YYiliQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 23:00:47 -0700
IronPort-SDR: F2gCgY154jUWxELRPtDB4pnju62GVT4+daumVj34IbpjNRU+SZ3FEMkR/SY/iZ/9hNoKcZ0xHc
 LBqpA/xGY0Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; d="scan'208";a="259194911"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 23:00:47 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 23:00:47 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jun 2020 14:00:44 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 10 Jun 2020 14:00:44 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Topic: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Index: AQHWPQXUSKAMWxVp4EWHfvIjGmZAKajRXpJw
Date: Wed, 10 Jun 2020 06:00:44 +0000
Message-ID: <d1b031b8c9f241d4af843392d8091a18@intel.com>
References: <20200607194611.24763-1-chen.zhang@intel.com>
In-Reply-To: <20200607194611.24763-1-chen.zhang@intel.com>
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
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 02:00:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave,

Any comments for this series?

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen <chen.zhang@intel.com>
> Sent: Monday, June 8, 2020 3:46 AM
> To: Dr . David Alan Gilbert <dgilbert@redhat.com>; qemu-dev <qemu-
> devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> This series optimize some code of COLO, please review.
>=20
> Zhang Chen (3):
>   migration/colo: Optimize COLO boot code path
>   migration/colo: Update checkpoint time lately
>   migration/migration.c: Remove MIGRATION_STATUS_ACTIVE in
>     migration_iteration_finish
>=20
>  migration/colo.c      |  7 ++-----
>  migration/migration.c | 12 +++++-------
>  2 files changed, 7 insertions(+), 12 deletions(-)
>=20
> --
> 2.17.1


