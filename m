Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFDC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70782076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70782076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWM4-0004St-0a
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRWL3-0003kL-8s
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRWL2-0002dT-JM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:32:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:54982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRWL2-0002dF-0x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:32:00 -0400
IronPort-SDR: 3CoRTV5wm2bQbP9kgZchOQpvzYUsGjYwStUsLTEydqZ2h934vFmmnBd6zqrzjV4AKWC971NU3v
 FAu/rO09Svlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 00:31:57 -0700
IronPort-SDR: LQhTALs2N6Rk6UW56h8RD10Xa97bL+Qb6AAXSDdH954K6Yq4lvYMbGK/RKStm1GHbHKbRYd9Uz
 VHcV5cQoP46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="291099544"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2020 00:31:56 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 00:31:29 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 15:31:27 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 23 Apr 2020 15:31:27 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Index: AQHWD7P+xm/8Bq9SCE2KY4WVvkZ5vqiCyuwQ
Date: Thu, 23 Apr 2020 07:31:27 +0000
Message-ID: <716ca2bcd9e64c37a79509c468e18485@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
In-Reply-To: <20200411033824.19389-1-chen.zhang@intel.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:31:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

Please review this series when you free.

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen <chen.zhang@intel.com>
> Sent: Saturday, April 11, 2020 11:38 AM
> To: Jason Wang <jasowang@redhat.com>; qemu-dev <qemu-
> devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen
> <chen.zhang@intel.com>
> Subject: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to
> users and clean up
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> This series make a way to config COLO "max_queue_size" parameters
> according to user's scenarios and environments and do some clean up for
> descriptions.
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


