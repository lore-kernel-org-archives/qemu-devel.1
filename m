Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5897F205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5897F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxAh-0007HJ-Ft
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx2-0007Dl-Mo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtZ-0003iK-DR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtZ-0003hb-4N; Thu, 19 Sep 2019 09:54:53 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Md6AP-1han871umB-00aCra; Thu, 19 Sep 2019 15:54:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:38 +0200
Message-Id: <20190919135443.15164-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SMeMu5RPOQoX5EG7ToWuGiXxNEBcKDlPdbYxiLnwkVN3lFN1LSn
 uXF7kLKM+XF86gBvQf3vs4DFsXwtg8XAJcOljG4E/bustw2tMSccVi5naAowVYf4GxCCFVb
 bGMkV3qlsXsEFs3S8XfL/qepbcGQCXXHhb8/9m15M+WzRm82fTqz5G7yC5hUGoJ+zjvJTHj
 y/8yShNLHqIVN8Wx3DlVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7LdlLPoGuBE=:Nz1hGprNHVO7pM05+Q61uZ
 T96JpsjGypEUo58Sjj17YSY8Vg5GXZqAZRjyovN2LH9DHFsu1dnIRGSjUggJ6YHGCRwTMb4JB
 hmQrEpFf9LqH9T2Hp/tvn+yeJwUM+1uBQuJX45QsIqBpA608z4JZJqDnzQ6yUI73aZnzKD2F1
 eXfXJUmewIAqylRq9COD8m+NJepXW0y3vRn4fHDMGK/tgXzRjtvbqI10bKwq28/5TvQXs7DHX
 ywiVe7qaynAeOo4eNcGizpt5w5RyvM2kF18w8kTGIw3qIxCH9U6XQb8IAouKJV/k2GK0H2jtj
 T7eGkeE2fNyWEGYYBL7d7dlm7HZqjIoJFdt71fXUEMG+ovFS3Iu+Ctuw3wvw0Ewxt11pkfM4o
 /zlbiK0gr+rHooSpXVyJdFAuDaVm2EF+KFKkBdXxlr//WOxFmsmWLYOMH4rGXiXTWN8bPysQa
 PtL9nqiCIZCBeVP9UOHeBjMFiP5Ojq8BDVcWd2nyNt6Hm5deWgFs+4GDnky7O8U3XQKddNwqT
 mq2ky745Zhc9MtBxtR6JH2hDt5NH7HZqf2Hf+bVMel9kXXrFeq3ZtiJj71f2zibXELhuVPHDU
 HwBCtZApeGhPuEz9h8qIUIe8OQtDJMmCpow/YbwzuOqjxj5HxBoHFENtHHqkmPFBHarmr/1DY
 6QTHuIjdQT69VXzLikW01etmH7EasoDJ8hrMwzOtUhVSmFsCHUe3y1sRYuoDnTD8FA/7cAQOG
 qrBFQoCK+FgCm7sBmtDjGoI631yYRuTwPtcK+VxqW1Ec0J3yge3WDQ591q8bzR1moeDIHuFVa
 Vll6hFlzb1ykya4fRkqgZAylZ8DQfrwtHVF/jsIU9KbzkaBioWw31yK6SuzF5RL4whHMnwoT/
 hVW/8gDxikELBN/XJGjw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 3/8] Replace '-machine accel=xyz' with '-accel
 xyz'
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We've got a separate option to configure the accelerator nowadays, which
is shorter to type and the preferred way of specifying an accelerator.
Use it in the source and examples to show that it is the favored option.
(However, do not touch the places yet which also specify other machine
options or multiple accelerators - these are currently still better
handled with one single "-machine" statement instead)

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190904052739.22123-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 python/qemu/qtest.py                | 2 +-
 qemu-deprecated.texi                | 3 +--
 qemu-options.hx                     | 2 +-
 tests/libqtest.c                    | 2 +-
 tests/migration/guestperf/engine.py | 2 +-
 tests/qemu-iotests/172              | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index eebcc233ed5c..3f1d2cb32543 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -96,7 +96,7 @@ class QEMUQtestMachine(QEMUMachine):
     def _base_args(self):
         args = super(QEMUQtestMachine, self)._base_args()
         args.extend(['-qtest', 'unix:path=' + self._qtest_path,
-                     '-machine', 'accel=qtest'])
+                     '-accel', 'qtest'])
         return args
 
     def _pre_launch(self):
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9d74a1cfc017..01245e0b1c4b 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -26,8 +26,7 @@ The @option{enforce-config-section} parameter is replaced by the
 
 @subsection -no-kvm (since 1.3.0)
 
-The ``-no-kvm'' argument is now a synonym for setting
-``-machine accel=tcg''.
+The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
 
 @subsection -usbdevice (since 2.10.0)
 
diff --git a/qemu-options.hx b/qemu-options.hx
index bbfd936d29ec..80c16fa317e5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4156,7 +4156,7 @@ STEXI
 Enable FIPS 140-2 compliance mode.
 ETEXI
 
-HXCOMM Deprecated by -machine accel=tcg property
+HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a7556462d65..38e4f5b5871e 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -241,7 +241,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
                               "-qtest-log %s "
                               "-chardev socket,path=%s,id=char0 "
                               "-mon chardev=char0,mode=control "
-                              "-machine accel=qtest "
+                              "-accel qtest "
                               "-display none "
                               "%s", qemu_binary, socket_path,
                               getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index f13dbea8000d..1dd04ce33b72 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -287,7 +287,7 @@ class Engine(object):
             cmdline = "'" + cmdline + "'"
 
         argv = [
-            "-machine", "accel=kvm",
+            "-accel", "kvm",
             "-cpu", "host",
             "-kernel", self._kernel,
             "-initrd", self._initrd,
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index ba7dad905751..d67997e5f62b 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -55,7 +55,7 @@ do_run_qemu()
             done
         fi
         echo quit
-    ) | $QEMU -machine accel=qtest -nographic -monitor stdio -serial none "$@"
+    ) | $QEMU -accel qtest -nographic -monitor stdio -serial none "$@"
     echo
 }
 
-- 
2.21.0


