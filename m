Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB742C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40BB206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40BB206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYlH-0006OW-TH
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgS-000756-BA
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgR-0007eo-80
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mj8a5-1j4ctz366X-00fFGl; Sat, 06 Jun 2020 15:16:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/19] stubs/Makefile: Reduce the user-mode object list
Date: Sat,  6 Jun 2020 15:16:00 +0200
Message-Id: <20200606131607.1250819-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hmgqyD69i52pURRa8xNImRDVVBuhd7lG9woVIeaaiIQqDFNJ6zC
 o+a11w2E++oZB9atYkuLFhq5mU8k53aTQOpaNHGFC6mT2rMFSfgyG1+nC94dkGD8MiNRCPW
 sjo28eIOTZACwAgLPP/MXqXku871aKTqvWSKlqZpzgv4RDaX1NGdhYiyoa72SqoxuRLuCjx
 eT5HpfXWwMyfSRLE+imrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jbT4tsYpI/0=:GlKDOmhgrQxi1VZKmpMrxV
 jvRA2faz3C5wzPYrSkhJzsSjCKxc3d87kTV29h5cz6lOdccFleaDanpbrc/gXddpXfWUAHINC
 rgBYYgMp9+uloCMUXq31rGpQow2Bv+FxbyqAVE00pWJ5HzyeNZ0hyMNBArPYkkioikPtZVhfM
 zHZwz/7g+UZZQIoscuMSNC+Q7ExaO5uvSqw1s6dQJK9iS0RYxouy6PQ6n3d2k7PEiKEuv74gR
 s1795sw2lwOejUqh7ikFz2sww8B8qAOtSkHwNLC5kcpm/wVXlwt7SnnqWBu5R0gY0kWUTn2xK
 sUO866ykB8gAXDBJwNAGRt6Ha6dgccnSQeCpLqS6iVhcQUeJjkNsuq65kLWv+uj8uMa07tvlS
 wrkaWz4twH3l5ymalbb0JOLseib9I9RBRYXO6hTF9rT1n57ffGfavbbiy0J9W90H3/blB6efb
 dnZl5/Yq1mPXgg2dl15j2p0zPcy9zaraSUSpGJZfmDsdOe5urytdflBn/ZAHyNBM/jMQZHeyn
 5DTCZ5D/4qom7V3xFFFrOclPIh6wBR/StIGUtOoprq0ROd8JyCuwmNN6CZ1GfpeLXi3Z/xMGh
 KVB8yPxGeCzdYjElH4YrH/xnXPo9OmuXhTw62i01FNBbkC46/UocBMYqiR3oNsWs/KWP6w800
 A13RE+5QafpLAXxe86aTBBSer9kuuBfN8YkvYyDb8Wv6aZHCH6RSdPAQP1D45mEgEQU28yg12
 jqVKjgKwUTYKSr2gTxKt9RNYthDFqvEdTgvlFVbxL7Y1AyylXgl3OQESSrHWnz2xmRwum/faX
 JbJAkjo4q0lIb89iOFCFPU82t1cWnHFbBYpGK3H6UtOZ0Dh2TZZIKi+p689oWf0+B50MGmm
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These stubs are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 stubs/Makefile.objs | 50 ++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 6a9e3135e8f9..f54125de317d 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,47 +1,55 @@
-stub-obj-y += arch_type.o
-stub-obj-y += bdrv-next-monitor-owned.o
 stub-obj-y += blk-commit-all.o
-stub-obj-y += blockdev-close-all-bdrv-states.o
-stub-obj-y += clock-warp.o
 stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
 stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
 stub-obj-y += gdbstub.o
-stub-obj-y += get-vm-name.o
-stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
-stub-obj-y += machine-init-done.o
-stub-obj-y += migr-blocker.o
-stub-obj-y += change-state-handler.o
-stub-obj-y += monitor.o
 stub-obj-y += monitor-core.o
 stub-obj-y += notify-event.o
+stub-obj-y += qmp_memory_device.o
 stub-obj-y += qtest.o
+stub-obj-y += ramfb.o
 stub-obj-y += replay.o
-stub-obj-y += replay-user.o
 stub-obj-y += runstate-check.o
+stub-obj-$(CONFIG_SOFTMMU) += semihost.o
 stub-obj-y += set-fd-handler.o
+stub-obj-y += vmgenid.o
 stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
-stub-obj-y += uuid.o
-stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-y += win32-kbd-hook.o
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+stub-obj-y += arch_type.o
+stub-obj-y += bdrv-next-monitor-owned.o
+stub-obj-y += blockdev-close-all-bdrv-states.o
+stub-obj-y += change-state-handler.o
+stub-obj-y += clock-warp.o
 stub-obj-y += fd-register.o
-stub-obj-y += qmp_memory_device.o
-stub-obj-y += target-monitor-defs.o
+stub-obj-y += fw_cfg.o
+stub-obj-y += get-vm-name.o
+stub-obj-y += iothread.o
+stub-obj-y += machine-init-done.o
+stub-obj-y += migr-blocker.o
+stub-obj-y += monitor.o
+stub-obj-y += pci-host-piix.o
+stub-obj-y += ram-block.o
+stub-obj-y += replay-user.o
 stub-obj-y += target-get-monitor-def.o
-stub-obj-y += vmgenid.o
+stub-obj-y += target-monitor-defs.o
+stub-obj-y += uuid.o
+stub-obj-y += vm-stop.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
-stub-obj-y += pci-host-piix.o
-stub-obj-y += ram-block.o
-stub-obj-y += ramfb.o
-stub-obj-y += fw_cfg.o
-stub-obj-$(CONFIG_SOFTMMU) += semihost.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
-- 
2.26.2


