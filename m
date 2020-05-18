Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21742207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21742207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jac6Q-0000yw-Ci
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jac5m-0000Tv-WF
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:29:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:6475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jac5l-0003mN-6w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:29:50 -0400
IronPort-SDR: NPaMooME//mdlHKA7YQE08JMrl11PhHHtz8Bidxluep/XSodcPHJ7cJ8bSByRp05R8oE5IflWi
 JQ6KmgKJYUDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 02:29:29 -0700
IronPort-SDR: K6d0xpmrpjmYgFl+/0Zynj6mYyxUGPBxaRy2Vc5eSiwfyinRWNxjrjHHuS3zHuHVA+2eL8vnbh
 +uK5y1YB6bxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; d="scan'208";a="308052563"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by FMSMGA003.fm.intel.com with ESMTP; 18 May 2020 02:29:28 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 02:29:28 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 May 2020 17:29:26 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 18 May 2020 17:29:26 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 0/6] colo-compare bugfixes
Thread-Topic: [PATCH v5 0/6] colo-compare bugfixes
Thread-Index: AQHWKqmhJecHpEJ2oUCI7IioaAPjnaitmBxw
Date: Mon, 18 May 2020 09:29:26 +0000
Message-ID: <c0a25bae521f42529976f1fb9f71a5c1@intel.com>
References: <cover.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 05:29:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Friday, May 15, 2020 7:11 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH v5 0/6] colo-compare bugfixes
>=20
> Hello Everyone,
> Here are fixes for bugs that I found in my tests.
>=20

I will queue this series after test in my side.

Thanks
Zhang Chen

> Regards,
> Lukas Straub
>=20
> Version changes:
> v5:
>  -initialize and use notify_sendco only if notify_dev is set
>=20
> v4:
>  -fix potential deadlock with notify_remote_frame  -avoid malloc and
> memcpy in many cases
>=20
> v3:
>  -fix checkpatch.pl error
>=20
> v2:
>  -better wording
>  -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock=
 in
> compare_chr_send"
>  -add more bugfixes
>=20
>=20
> Lukas Straub (6):
>   net/colo-compare.c: Create event_bh with the right AioContext
>   chardev/char.c: Use qemu_co_sleep_ns if in coroutine
>   net/colo-compare.c: Fix deadlock in compare_chr_send
>   net/colo-compare.c: Only hexdump packets if tracing is enabled
>   net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
>   net/colo-compare.c: Correct ordering in complete and finalize
>=20
>  chardev/char.c     |   7 +-
>  net/colo-compare.c | 254 ++++++++++++++++++++++++++++++++++-------
> ----
>  net/colo-compare.h |   1 +
>  net/colo.c         |   7 ++
>  net/colo.h         |   1 +
>  softmmu/vl.c       |   2 +
>  6 files changed, 209 insertions(+), 63 deletions(-)
>=20
> --
> 2.20.1

