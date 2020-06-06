Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17EE206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17EE206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYkR-00041O-0m
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgR-00073k-P8
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgQ-0007ed-IG
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTR6K-1jXlao0imS-00ThkI; Sat, 06 Jun 2020 15:16:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/19] util/Makefile: Reduce the user-mode object list
Date: Sat,  6 Jun 2020 15:15:59 +0200
Message-Id: <20200606131607.1250819-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V/aHWdl8UrH1CJeMgwlpTbN0wkVZ+UCwr3JP6jfUPF5McYYjZLa
 ZkS/Of53EfF45tIMdSgqJDrzgu6AIaO50vSzXMMq5eTTObuMb8EL4ARK8YEKZkNSn1aWxgS
 hv/tz0IBsimmYdUFw4yCVCorcit7Uvd3OevSMDJHIcYdaOkcjtglPab2omQdx2HWuKRTui9
 R5AZrmGn7YZ/BEDG5iw7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3qAw+i81rw=:nXcFhrLgti038HofC0CRSv
 lJrGW8fSzNzDJvIbLWPLOFtjrdNByxK1R6Ty4nfiEnAR8KMzFS9fk1Hu/v6g//iriuafkQNHk
 30LBVd5c9RvPFLwrA0BfcYQpN7pt29K+t267hCZ0Whwf1nGHO3Yn1UHXHRxPG8Mm9chZEcY9f
 3r7DMVlgKGhebK0y7fKk8/gLkf2M6Y9kRLqNx0G3ZeNHO5o5/KmYeWvMbU/NUA78AioftiaYc
 RzP/OKcP7UJ7nnWRxy4oCVNJKv4Ezb5CeakTD+/Btaz7i+ojW1qy/PYf33ErCYLL29a0MAmNF
 iKYNExKizpCb3UOwBfntqQwcGFyf6c3KnJH/u5RUs6CXYJX/hVFtnnaXvbV6a0+L5ND+JaW0t
 i5sT+zkEU6UUt0lcXT9QCD+3WQ1aTeUP+VypyCiHPKJtpcG7qxUgXhXGrwBlM+J4g2zkRLho0
 KI+oM9PKxogTM/ECVUd6u8uVmTa4XjkCchnKwKmthrGgzBUv+HUwdHJUOBVBbmV+x5KdZpMPQ
 t/i2QPOw3PbHCBLjTxxO/nwZ/E/Nt/JPAZND7krWPH1KaYW4UBHhr5aEHCi+6+X34W8BzEBnj
 6XGb2rTKITq6wNuwOQp2jP1ShRrNmogYehm6/lzt8/lT0/LWa841RJImSdjq4JGb5QUmz652q
 Emxdn5LMyysdBAtJ3iz8q8Oq2xQOf5j5yVi/767ef76MjsrCwM1X4sGCoSweqGM1O9mBpG7tN
 g8NiF6HPLNtlgQokfx9R+YBfWSsWRzVEl2m+BPke6tSQw3dqAtv2LtKExj4vgex6VjS0xvTCF
 lj/coY2MpesTWbkp3TvqPzlIm3vMUhGbEOO1ZwHb8zdjxrlTGlpSfDGcUBGc3BRAl+qzvQy
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
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

These objects are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/Makefile.objs | 59 +++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index fe339c2636ba..cc5e37177afd 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,8 +1,4 @@
 util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-y += bufferiszero.o
-util-obj-y += lockcnt.o
-util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y += main-loop.o
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += fdmon-poll.o
@@ -21,31 +17,20 @@ util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
 util-obj-y += host-utils.o
-util-obj-y += bitmap.o bitops.o hbitmap.o
+util-obj-y += bitmap.o bitops.o
 util-obj-y += fifo8.o
-util-obj-y += nvdimm-utils.o
 util-obj-y += cacheinfo.o
 util-obj-y += error.o qemu-error.o
 util-obj-y += qemu-print.o
 util-obj-y += id.o
-util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
+util-obj-y += qemu-config.o notify.o
 util-obj-y += qemu-option.o qemu-progress.o
 util-obj-y += keyval.o
-util-obj-y += hexdump.o
 util-obj-y += crc32c.o
 util-obj-y += uuid.o
-util-obj-y += throttle.o
 util-obj-y += getauxval.o
-util-obj-y += readline.o
 util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
-util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
-util-obj-y += qemu-coroutine-sleep.o
-util-obj-y += qemu-co-shared-resource.o
-util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
-util-obj-y += buffer.o
-util-obj-y += timed-average.o
-util-obj-y += base64.o
 util-obj-y += log.o
 util-obj-y += pagesize.o
 util-obj-y += qdist.o
@@ -54,13 +39,45 @@ util-obj-y += qsp.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
-util-obj-y += iova-tree.o
-util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
-util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
-util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_POSIX) += drm.o
 util-obj-y += guest-random.o
 util-obj-$(CONFIG_GIO) += dbus.o
 dbus.o-cflags = $(GIO_CFLAGS)
 dbus.o-libs = $(GIO_LIBS)
 util-obj-$(CONFIG_USER_ONLY) += selfmap.o
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+util-obj-y += aio-wait.o
+util-obj-y += aiocb.o
+util-obj-y += async.o
+util-obj-y += base64.o
+util-obj-y += buffer.o
+util-obj-y += bufferiszero.o
+util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
+util-obj-y += hexdump.o
+util-obj-y += lockcnt.o
+util-obj-y += iov.o
+util-obj-y += iova-tree.o
+util-obj-y += hbitmap.o
+util-obj-y += main-loop.o
+util-obj-y += nvdimm-utils.o
+util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+util-obj-y += qemu-coroutine-sleep.o
+util-obj-y += qemu-co-shared-resource.o
+util-obj-y += qemu-sockets.o
+util-obj-y += qemu-timer.o
+util-obj-y += thread-pool.o
+util-obj-y += throttle.o
+util-obj-y += timed-average.o
+util-obj-y += uri.o
+
+util-obj-$(CONFIG_LINUX) += vfio-helpers.o
+util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
+util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
+util-obj-$(CONFIG_BLOCK) += readline.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
-- 
2.26.2


