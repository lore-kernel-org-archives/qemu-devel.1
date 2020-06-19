Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C40C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53620771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmBU2-0007WY-TY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 03:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jmBT2-0005iW-3c
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:29:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:38786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jmBSz-0002VC-95
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:29:39 -0400
IronPort-SDR: AJFyLXGv8F/u1raXeGzRxTJnwzcPBcXqqS/t4FJY6pTZ1S1L/kQvzz6Mhr5YdvGquGZ2D/bckt
 6fhS0eCAD/9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="140406120"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="140406120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 00:29:31 -0700
IronPort-SDR: 9AzniRkJef71FuAWvRL/YkQBjpLkngNQH0dCmjaEV5uYCq3ugapa5YiWl4KiMDyo+0paCohOEO
 J0g8pp8xK5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="292040590"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga002.jf.intel.com with ESMTP; 19 Jun 2020 00:29:29 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v5 0/4] modify CPU model info
Date: Fri, 19 Jun 2020 15:31:10 +0800
Message-Id: <20200619073114.24303-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=chenyi.qiang@intel.com; helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:29:31
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the missing VMX features in Skylake-Server, Cascadelake-Server and
Icelake-Server CPU models. In Icelake-Server CPU model, it lacks sha_ni,
avx512ifma, rdpid and fsrm. The model number of Icelake-Server also needs
to be fixed.

Changes in v5:
	- exclude Icelake-Client CPU model deprecation API from this series.
	  Robert is working on this available at https://patchwork.kernel.org/patch/11599155/

Changes in v4:
	- remove the Icelake-Client CPU model

Changes in v3:
	- change the missing features of Icelake-Server from v3 to v4

Changes in v2:
	- add missing features as a new version of CPU model
	- add the support of FSRM
	- add New CPUID of FSRM and RDPID in Icelake-Server CPU model

Chenyi Qiang (4):
  target/i386: add missing vmx features for several CPU models
  target/i386: add fast short REP MOV support
  target/i386: add the missing features for Icelake-Server CPU model
  target/i386: modify Icelake-Server CPU model number

 target/i386/cpu.c | 20 +++++++++++++++++---
 target/i386/cpu.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.17.1


