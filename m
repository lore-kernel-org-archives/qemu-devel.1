Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B080B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgPsds+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B080B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueyB-0002aU-AR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrD-0004lT-Ri
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucr9-00030x-90
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucr9-0002zq-1v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id s144so1922761wme.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WAC8gUQTFh0ug1Q505u277fTx8OwLP9Zp685B+gt4rY=;
 b=CgPsds+1skCAHgaK68VhK45AlbFWBdXc5TMGbVh6lTYVnbJAJxB+D93wyx15WgFl8O
 cSUos1WP/Z9p4xLtygTmO6rae6X9lsQIU8zgf8hxmkUiZm+H3pUsO3islz1EUU3MJoHs
 kQn92zEc0k+ZqPwEzmV1M2DI74g1dPVYov/4z0v6cI1XGQlZkjuSCdu4kD001keaAIRT
 yLSwvtp4XFkSp4izmwytT21qPv+X5tQrPeE+i1bArISoPlRGf+QVi7mqRihDvfCXfeEC
 pCa0r1oLboKEzcVmj3kSM/Sx7I4XdMSXhOeinkd3cvsybPJMfzyGCMEY11Q1BaBKAHqO
 BwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WAC8gUQTFh0ug1Q505u277fTx8OwLP9Zp685B+gt4rY=;
 b=HrtKakiBwLzmSNpsuArTKU1MuFHCDOW3ssC1rdIIli83H1mbDKHhDcmFSRbMabYUph
 Kh6xWtt1kEqeatgOR+6fYlH2CsmSk42j0oTbKiFGWBDx5qDHTbn+wudVh7xtzJiINPzO
 FaoJSNI1/L4gl7NZDC541PBNTDdLxyRTGJrVno4BtTD4KbwK3GgIG4NejBLvCeqpISax
 HGgLav6NzChHd7qEXG/D7rX4bLLhwBXc2Gyo4BmM1HB+Mds31FWK2xK+22oGrdlmXG+f
 qHu28j2BseflMgd2YD4myK9vYUEPfYQfaJ9Hs/a0qw2uKp9Gn40e4TU9scROqph0N+wf
 1/gQ==
X-Gm-Message-State: APjAAAUoZbOzmjQebc8siv/jPF04zJQ0g6oJhxoSW0ebFT7tF3BS7HV/
 4yfP4r5wCcPSrcNKLGkGIcqRqzzI
X-Google-Smtp-Source: APXvYqwzLAdTcRPHCxHg7IR9l0UnkU7ZamqfUxrC3SCtfoiMRdpM2l8MCLukd4oWB1RXcdMD9tTxbQ==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr4343339wmj.130.1579787349173; 
 Thu, 23 Jan 2020 05:49:09 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/59] pvpanic: implement crashloaded event handling
Date: Thu, 23 Jan 2020 14:48:07 +0100
Message-Id: <1579787342-27146-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Handle bit 1 write, then post event to monitor.

Suggested by Paolo, declear a new event, using GUEST_PANICKED could
cause upper layers to react by shutting down or rebooting the guest.

In advance for extention, add GuestPanicInformation in event message.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200114023102.612548-3-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/specs/pvpanic.txt    | 16 ++++++++--------
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 24 ++++++++++++++++++++++--
 vl.c                      | 12 ++++++++++++
 5 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index bdea68a..a90fbca 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -19,9 +19,10 @@ Software should set only bits both itself and the device recognize.
 
 Bit Definition
 --------------
-bit 0: setting it indicates a guest panic has happened.
-bit 1: named crashloaded. setting it indicates a guest panic and run
-       kexec to handle error by guest itself.
+bit 0: a guest panic has happened and should be processed by the host
+bit 1: a guest panic has happened and will be handled by the guest;
+       the host should record it or report it, but should not affect
+       the execution of the guest.
 
 ACPI Interface
 --------------
@@ -30,13 +31,12 @@ pvpanic device is defined with ACPI ID "QEMU0001". Custom methods:
 
 RDPT:       To determine whether guest panic notification is supported.
 Arguments:  None
-Return:     Returns a byte, bit 0 set to indicate guest panic
-            notification is supported. Other bits are reserved and
-            should be ignored.
+Return:     Returns a byte, with the same semantics as the I/O port
+            interface.
 
 WRPT:       To send a guest panic event
-Arguments:  Arg0 is a byte, with bit 0 set to indicate guest panic has
-            happened. Other bits are reserved and should be cleared.
+Arguments:  Arg0 is a byte to be written, with the same semantics as
+            the I/O interface.
 Return:     None
 
 The ACPI device will automatically refer to the right port in case it
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index d65ac86..4ebda78 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,11 +21,13 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 
-/* The bit of supported pv event */
+/* The bit of supported pv event, TODO: include uapi header and remove this */
 #define PVPANIC_F_PANICKED      0
+#define PVPANIC_F_CRASHLOADED   1
 
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
+#define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
 
 #define ISA_PVPANIC_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
@@ -34,7 +36,7 @@ static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~PVPANIC_PANICKED && !logged) {
+    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASHLOADED) && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
@@ -43,6 +45,11 @@ static void handle_event(int event)
         qemu_system_guest_panicked(NULL);
         return;
     }
+
+    if (event & PVPANIC_CRASHLOADED) {
+        qemu_system_guest_crashloaded(NULL);
+        return;
+    }
 }
 
 #include "hw/isa/isa.h"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0b41555..f760094 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -63,6 +63,7 @@ ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_crashloaded(GuestPanicInformation *info);
 
 #endif
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index d7477cd..b83a436 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -357,16 +357,36 @@
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
 ##
+# @GUEST_CRASHLOADED:
+#
+# Emitted when guest OS crash loaded is detected
+#
+# @action: action that has been taken, currently always "run"
+#
+# @info: information about a panic
+#
+# Since: 5.0
+#
+# Example:
+#
+# <- { "event": "GUEST_CRASHLOADED",
+#      "data": { "action": "run" } }
+#
+##
+{ 'event': 'GUEST_CRASHLOADED',
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
+
+##
 # @GuestPanicAction:
 #
 # An enumeration of the actions taken when guest OS panic is detected
 #
 # @pause: system pauses
 #
-# Since: 2.1 (poweroff since 2.8)
+# Since: 2.1 (poweroff since 2.8, run since 5.0)
 ##
 { 'enum': 'GuestPanicAction',
-  'data': [ 'pause', 'poweroff' ] }
+  'data': [ 'pause', 'poweroff', 'run' ] }
 
 ##
 # @GuestPanicInformationType:
diff --git a/vl.c b/vl.c
index 71d3e7e..9f5f477 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,6 +1468,18 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 }
 
+void qemu_system_guest_crashloaded(GuestPanicInformation *info)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+
+    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN,
+                                   !!info, info);
+
+    if (info) {
+        qapi_free_GuestPanicInformation(info);
+    }
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
-- 
1.8.3.1



