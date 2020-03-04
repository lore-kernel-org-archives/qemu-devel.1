Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABFCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAFE20866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAFE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Oz6-0003Hz-Ca
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j9Own-0001mP-Pm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j9Owl-0003my-W6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:00:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:50085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j9Owl-0003fP-ML
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:00:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 23:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; d="scan'208";a="287269287"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2020 23:59:59 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Mar 2020 23:59:59 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Mar 2020 15:59:56 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 4 Mar 2020 15:59:56 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
Thread-Index: AQHV6o0xaOdrdOl2ek2ZIaAYq4O+2qg4ID0g
Date: Wed, 4 Mar 2020 07:59:56 +0000
Message-ID: <16d27cc5e749412ebfff71cdb0de1e34@intel.com>
References: <20200223205805.26412-1-chen.zhang@intel.com>
In-Reply-To: <20200223205805.26412-1-chen.zhang@intel.com>
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
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: Daniel Cho <danielcho@qnap.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Please give me some comments, this patch need by users(QNAP...).

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen <chen.zhang@intel.com>
> Sent: Monday, February 24, 2020 4:58 AM
> To: Jason Wang <jasowang@redhat.com>; qemu-dev <qemu-
> devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Dr . David Alan Gilbert
> <dgilbert@redhat.com>; Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> <chen.zhang@intel.com>
> Subject: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Make a way to config COLO parameter detailed according to user cases and
> environment.
>=20
> Zhang Chen (2):
>   net/colo-compare.c: Expose "compare_timeout" to user
>   net/colo-compare.c: Expose "expired_scan_cycle" to user
>=20
>  net/colo-compare.c | 95
> +++++++++++++++++++++++++++++++++++++++++++---
>  qemu-options.hx    |  6 ++-
>  2 files changed, 94 insertions(+), 7 deletions(-)
>=20
> --
> 2.17.1


