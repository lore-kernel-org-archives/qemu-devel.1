Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3765020771
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2XV-0001NE-HX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jv2Vc-0007Yd-16
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:44:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:22549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jv2Va-0006HW-G2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:44:55 -0400
IronPort-SDR: B52PYn5EC7VDRNVCIuFryVUb73+yUtJD+9yy+/ifZaXmuiuCvDjvYvSLQce6gW1AYULXck3i6G
 EDsYWKWfHrSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128255226"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; d="scan'208";a="128255226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 10:44:43 -0700
IronPort-SDR: 5kHW9S5hH1wdF2yLeOyytcYmx2bx3pRHOKhWwrHdcOVVjskJ6TjnlclejT1chDlNMIrCbUJR26
 OpCcyCCpOXgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; d="scan'208";a="317450493"
Received: from lxy-dell.sh.intel.com ([10.239.159.21])
 by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2020 10:44:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH 2/2] i386/cpu: Don't add unavailable_features to
 env->user_features
Date: Tue, 14 Jul 2020 01:44:36 +0800
Message-Id: <20200713174436.41070-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200713174436.41070-1-xiaoyao.li@intel.com>
References: <20200713174436.41070-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 13:44:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Features unavailable due to absent of their dependent features should
not be added to env->user_features. env->user_features only contains the
feature explicity specified with -feature/+feature by user.

Fixes: 99e24dbdaa68 ("target/i386: introduce generic feature dependency mechanism")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9812d5747f35..fb1de1bd6165 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6370,7 +6370,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
                                       unavailable_features & env->user_features[d->to.index],
                                       "This feature depends on other features that were not requested");
 
-            env->user_features[d->to.index] |= unavailable_features;
             env->features[d->to.index] &= ~unavailable_features;
         }
     }
-- 
2.18.4


