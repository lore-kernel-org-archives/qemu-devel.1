Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCF2214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCF2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzozV-0002gB-Fk
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wentong.wu@intel.com>) id 1hzoyt-0002Ft-OA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wentong.wu@intel.com>) id 1hzoyr-0004vX-JS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:14:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:41086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wentong.wu@intel.com>)
 id 1hzoyr-0004u6-BC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:14:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Aug 2019 14:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; d="scan'208";a="168874444"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga007.jf.intel.com with ESMTP; 19 Aug 2019 14:14:17 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 14:14:17 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 14:14:16 -0700
Received: from shsmsx106.ccr.corp.intel.com ([169.254.10.204]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.62]) with mapi id 14.03.0439.000;
 Tue, 20 Aug 2019 05:14:14 +0800
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] qemu icount mode timer accuracy
Thread-Index: AdVW0w0x3pGolKnBRryEYnlxHNbd9Q==
Date: Mon, 19 Aug 2019 21:14:13 +0000
Message-ID: <DD3E3CED-CFFE-4821-8487-EE481307475E@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C966E6105EAD5D468FB718268D2639BD@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel]  qemu icount mode timer accuracy
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Could anyone please give some comments? Thanks in advance!



Hi,

Recently I'm working to enable Qemu icount mode with TCG, with source code =
review I found that Qemu can give deterministic execution for guest code ti=
meout. But for exact time point for guest OS, I have a question:

For armv7m_systick.c example, guest OS will use systick_read which will cal=
l "t =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL); " to calculate his exact ti=
me point, and qemu_clock_get_ns will use qemu_icount. But from qemu_tcg_rr_=
cpu_thread_fn { prepare_icount_for_run(cpu); r =3D tcg_cpu_exec(cpu); proce=
ss_icount_data(cpu);}, we know qemu just update qemu_icount value after tcg=
_cpu_exec, so for each tcg_cpu_exec execution there is the same qemu_icount=
 value, and then guest code will get the same time point for that one tcg e=
xecution. Can someone confirm that?=

