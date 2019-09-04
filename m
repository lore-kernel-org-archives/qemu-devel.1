Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1C12339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1C12339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5NqM-0008UP-OA
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 01:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5Npa-0007xV-W4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5NpZ-0006pR-Qv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i5NpZ-0006ow-Ho; Wed, 04 Sep 2019 01:27:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8925418B3D87;
 Wed,  4 Sep 2019 05:27:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-69.ams2.redhat.com [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C5885D6C8;
 Wed,  4 Sep 2019 05:27:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 07:27:39 +0200
Message-Id: <20190904052739.22123-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 04 Sep 2019 05:27:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Replace '-machine accel=xyz' with '-accel xyz'
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've got a separate option to configure the accelerator nowadays, which
is shorter to type and the preferred way of specifying an accelerator.
Use it in the source and examples to show that it is the favored option.
(However, do not touch the places yet which also specify other machine
options or multiple accelerators - these are currently still better
handled with one single "-machine" statement instead)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 python/qemu/qtest.py                | 2 +-
 qemu-deprecated.texi                | 3 +--
 qemu-options.hx                     | 2 +-
 tests/libqtest.c                    | 2 +-
 tests/migration/guestperf/engine.py | 2 +-
 tests/qemu-iotests/172              | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index eebcc233ed..3f1d2cb325 100644
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
index 00a4b6f350..0982e41698 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -26,8 +26,7 @@ The @option{enforce-config-section} parameter is replaced by the
 
 @subsection -no-kvm (since 1.3.0)
 
-The ``-no-kvm'' argument is now a synonym for setting
-``-machine accel=tcg''.
+The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
 
 @subsection -usbdevice (since 2.10.0)
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 09e6439646..e0bba2abd1 100644
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
index 2713b86cf7..67e39c59e7 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -238,7 +238,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
                               "-qtest-log %s "
                               "-chardev socket,path=%s,id=char0 "
                               "-mon chardev=char0,mode=control "
-                              "-machine accel=qtest "
+                              "-accel qtest "
                               "-display none "
                               "%s", qemu_binary, socket_path,
                               getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index f13dbea800..1dd04ce33b 100644
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
index ba7dad9057..d67997e5f6 100755
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
2.18.1


