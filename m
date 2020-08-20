Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDCC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEF020658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEF020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8k6K-0002Ew-TO
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <punit1.agrawal@toshiba.co.jp>)
 id 1k8cbx-0000yF-4s; Thu, 20 Aug 2020 00:55:37 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:54104
 helo=mo-csw.securemx.jp)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <punit1.agrawal@toshiba.co.jp>)
 id 1k8cbr-0005Dr-U7; Thu, 20 Aug 2020 00:55:35 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07K4tJmI031419;
 Thu, 20 Aug 2020 13:55:20 +0900
X-Iguazu-Qid: 2wGrV5ExkTeoSQFQd4
X-Iguazu-QSIG: v=2; s=0; t=1597899319; q=2wGrV5ExkTeoSQFQd4;
 m=ZSBeRo0cUaHW2d51aGDT4R82sr7LdQDDf9LhBu8iUOA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1111) id 07K4tIJC021865;
 Thu, 20 Aug 2020 13:55:19 +0900
Received: from enc03.toshiba.co.jp ([106.186.93.13])
 by imx12.toshiba.co.jp  with ESMTP id 07K4tIEa013070;
 Thu, 20 Aug 2020 13:55:18 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc03.toshiba.co.jp  with ESMTP id 07K4tI1N010320;
 Thu, 20 Aug 2020 13:55:18 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: peter.maydell@linaro.org
Subject: [PATCH] hw/arm/virt: Default to architecture appropriate CPU
Date: Thu, 20 Aug 2020 13:55:07 +0900
X-TSB-HOP: ON
Message-Id: <20200820045507.614288-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=210.130.202.158;
 envelope-from=punit1.agrawal@toshiba.co.jp; helo=mo-csw.securemx.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 00:55:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2020 08:54:49 -0400
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
Cc: qemu-arm@nongnu.org, Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default_cpu_type for the Virt machine is set to "cortex-a15" for
both the arm (qemu-system-arm) and aarch64 (qemu-system-aarch64)
targets.

As a result, starting the aarch64 target with "-machine virt" defaults
to booting with a Arm v7 cpu which is counter to
expectation. Debugging the issue is further hampered by lack of any
output from a supplied arm64 firmware as it is now running on the
wrong CPU type.

Fix this by defaulting to the "max" capability CPU for the target
architecture. After the patch both the arm and aarch64 qemu default to
the equivalent of passing "-cpu max".

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
Hi Peter,

I spent inordinately long time scratching my head trying to figure out
why my arm64 VM wasn't booting in TCG mode.

Please consider merging if you don't see any issues with the patch.

Thanks,
Punit

 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ecfee362a1..7c5cbdba87 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2424,7 +2424,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
-- 
2.28.0


