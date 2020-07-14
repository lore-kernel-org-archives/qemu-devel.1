Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC89C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9582721897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9582721897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGVG-00013e-U1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jvGU2-0007l7-Iw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:43774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jvGTy-0002ZC-Vb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:14 -0400
IronPort-SDR: F5g3zufniiGl1AYM9C5oD63acYChJz6RhzKYdb/hGoWgUZRjhBXrIkp5wWpbWxD86+Hx1MJF58
 FEJHuDrqXMJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128407127"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="128407127"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 01:40:06 -0700
IronPort-SDR: rHLjcCP7Q/Ob4MEnkXCWIyAUye8afuY9P58Hir6c6agwMG2i6sx6FcM2vmr476GUO15lCvGOaO
 DPDUkRrKy/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="299464766"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 01:40:04 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v6 0/3] modify CPU model info
Date: Tue, 14 Jul 2020 16:41:45 +0800
Message-Id: <20200714084148.26690-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=chenyi.qiang@intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 04:40:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To apply this patchset, a bug related to env->user_features need to be
fixed first. The patch is available at
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04399.html

Changes in v6:
	-integrate all the missing features(patch 1/4, 3/4, 4/4 in
	 previous version) into the same version of CPU model

Changes in v5:
	- exclude Icelake-Client CPU model deprecation API from this series.
	  Robert is working on it available at https://patchwork.kernel.org/patch/11599155/

Changes in v4:
	- remove the Icelake-Client CPU model

Changes in v3:
	- change the missing features of Icelake-Server from v3 to v4

Changes in v2:
	- add missing features as a new version of CPU model
	- add the support of FSRM
	- add New CPUID of FSRM and RDPID in Icelake-Server CPU model

Chenyi Qiang (3):
  target/i386: add fast short REP MOV support
  target/i386: fix model number and add missing features for
    Icelake-Server CPU model
  target/i386: add the missing vmx features for Skylake-Server and
    Cascadelake-Server CPU models

 target/i386/cpu.c | 30 +++++++++++++++++++++++++++++-
 target/i386/cpu.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.17.1


