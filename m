Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514102063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514102063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAro-00050l-Fb
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0008EY-AG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoe-0006iN-15
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBDzc-1joItq02H8-00Cgsz; Fri, 05 Jun 2020 13:47:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] stubs/Makefile: Reduce the user-mode object list
Date: Fri,  5 Jun 2020 13:46:53 +0200
Message-Id: <20200605114700.1052050-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o6yxUzAJ+EbUPUl5mF2vB1ArVVZM207EPI0BqVf5XnDMEkm9I4C
 qvSDy/HlxrFqUbybUOQ+I+GegQqmGfWb7AsrXxoW9eq8YHVYhKNiMeAA/UHI0I1g/aaUMIo
 KTCJJW25sBXA+/Hj7PTcOIVRkWbchRool2Nj785WYQDNBt2oLqbrfHdoFLx7nlc1o0dx2W4
 sTUJthEluVDfzF+95HUWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wPCU3FBInFE=:s2Qz8gE8GHwzhdjvbr1xge
 4ZR8kzfY30DbI0Xs6f/khNUBgkacxu/eRimsLgH/HYw4uqQaYyg53bV04ZLoq6EDykdruHGdi
 bmQ2hfquLRw0+QuKHPpnaTKXs8GzpJ/21x9thTAJ99p7Tj+7CZjccZrQnvAzNy4YwnmdBCqvt
 FEyIvNsuIy3WSZrElARpChQwbEqfK0qe2PoTBa5/G2zFbD4tdm9NACEu1uSgYw/VsDK7YZe5e
 +5duwGEr2WjsdOfSM3fk50qzTiV8X7y+qGcoA4BfRmPn+9kOJ9SY2joYnk1Et81z4XG7Yk+gQ
 OoM0MDZa3txG7uRWi4gI/49ZBAWcBcqx/NVHxTMuKl6QmzFO4YfKnoNuWLYI9H8wh39Gxyd9M
 wGka8AgURKykeioPmMT/nOszNAXmywdbCFEemDcLyVOZv09GkfRZD373hixOY1WvOIDHmKINr
 uWdae7b8NL87TD/QoKl0nY0efOU6wEXkuu5HZf1m5K2LsEiIne1vEFU32b3mkgtssChkcgp3K
 4oi0huHncpiewVHzOJHOqGuCGRK60O5DgRjODgYl3uUOZagrqZBmh9hQB05WEV0wmiUzviP9v
 aP3pTOilNmtzbnIGEbURh+WnzLOoycJhXiFrzo58mKlYmkvHEmZzrkjRX1eWZYeZXB83afB89
 QGo9grGzXJweCU8hlQXmIpWUkLaz5D1SI09vZ/ZY507pTHR5mmWTUACD5jniciz89hl8qyl+C
 dGxNYuNRlTq/rqYBkCgsbw1ePRJ7pfFVEi7rjcnaofqacLMsHFMQNP52s9c7KtqzkY+nI9T9Y
 Mg/GM+9LQPIVmc5VbM8CLtFG598YMhIQkJzfQhMlI4A64RuaIeRtqlTNZRM0heK1/rrujAL
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:04
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


