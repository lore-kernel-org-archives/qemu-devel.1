Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A581C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C877B214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOMCBjRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C877B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rT4-0003rd-VR
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8rRQ-0002ip-Ap
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8rRP-0006oh-4B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:13:28 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8rRP-0006oU-0C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:13:27 -0500
Received: by mail-qk1-x744.google.com with SMTP id p62so1051849qkb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tVH7ua6nWnbcHDgoFSIHFCuc2MlGrp9bq3Bqf0UePNM=;
 b=FOMCBjRZgVTXLy9LobIkiJTbnnBK4Eq2uXdxid5mUk7wuwPttLScoIr7jJUR7Hg80R
 cxkrGPtaneG2wF3aeCeBYwigKsoBpcHV3Xn3mzdQ/ZtwgHQ1GextqXZ4oEWSLm2c328G
 BYVDsJFPqwYuAYaR+t/VMdUr6c4jIg1B1C03oKpfGf7U9UR9gFSq6mYRwmHxZ/dqO24Q
 hyw1VtwnHO+SnKFU80SltpU2RlKHJNcCYECHlbqkLc3csZd8uZodrpnjCbBvIochCygc
 rn2EVgB1qe0IZZ/DBN3V2N77cXRvJl7iicLawQYjiHL0Fwz35Oh8pn4awtQvYdCrojCb
 u1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tVH7ua6nWnbcHDgoFSIHFCuc2MlGrp9bq3Bqf0UePNM=;
 b=ZKuuJHWiE64sCAK3SIDUJL/e0vdqpIZwRlTheiAKz+4uc7S3NF+yemds6wwVGfOaFn
 MvRffvvFQLA6wag70Yy0aMg2raw0SpUXW0TdjOSkyuC/p9egvPr1nTQNc9Ih9nLER46l
 Djal31ezmuzXKGm0Z/Kd92CaatGvMc+PDdZZW8YVVX1iYrME1P/DtVUk320QUBcV6OE/
 WMgfhMLRgRtUchZ7AVPiioqpab5+naeKQgKkboGY4GAXnp2+wgr7PwIXSiMDfOh9tyUO
 dQnVxL2PIaC8e/XLQ5oPlVzxKLq7rvQlahg1Ym/1kOC2B8wn5iOEy7+lglkCkUl/cAnX
 dAhA==
X-Gm-Message-State: ANhLgQ2Tv72Wj4KazIhR6PnRqpf6C5F4L/k32nArTlY/u8+2k2cRp4y7
 G92MNRAzqVb813SHgzhWT+2l73tX
X-Google-Smtp-Source: ADFU+vvxB46CnE4PhM/7pNmfNu5xtfBRbNfq2HLH2a5Nx1tU0xLhINPeKwnBKOZQqZbzoqiPejivxA==
X-Received: by 2002:a37:de0d:: with SMTP id h13mr966922qkj.332.1583180005360; 
 Mon, 02 Mar 2020 12:13:25 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7cb:1f67:aa55:feb:954c:c891])
 by smtp.gmail.com with ESMTPSA id
 w48sm11421565qtc.40.2020.03.02.12.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 12:13:24 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] i386: Fix GCC warning with snprintf when HAX is enabled
Date: Mon,  2 Mar 2020 17:13:20 -0300
Message-Id: <20200302201320.6465-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
snprintf(). Replacing old snprintf() by g_strdup_printf() fixes the
problem with boundary checks of vm_id and vcpu_id and finally the
warnings produced by GCC.

For more details, one example of warning:
  CC      i386-softmmu/target/i386/hax-posix.o
qemu/target/i386/hax-posix.c: In function ‘hax_host_open_vm’:
qemu/target/i386/hax-posix.c:124:56: error: ‘%02d’ directive output may be
truncated writing between 2 and 11 bytes into a region of size 3
[-Werror=format-truncation=]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                                        ^~~~
qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range
[-2147483648, 64]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                         ^~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:867,
                 from qemu/include/qemu/osdep.h:99,
                 from qemu/target/i386/hax-posix.c:14:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output
between 17 and 26 bytes into a destination of size 17
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
v1-v2: Add assert() as Richard Henderson suggested.
v2-v3: Fix code syntax alignment with vm_id and snprintf() function.
v3-v4: Replacing snprintf() by g_strdup_printf() from linux and windows.
---
---
 target/i386/hax-posix.c   | 33 ++-------------------------------
 target/i386/hax-windows.c | 33 ++-------------------------------
 2 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..3bad89f133 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -108,41 +108,12 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
 
 static char *hax_vm_devfs_string(int vm_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
-        return NULL;
-    }
-
-#define HAX_VM_DEVFS "/dev/hax_vm/vmxx"
-    name = g_strdup(HAX_VM_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
 }
 
 static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id);
-        return NULL;
-    }
-
-#define HAX_VCPU_DEVFS "/dev/hax_vmxx/vcpuxx"
-    name = g_strdup(HAX_VCPU_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
 }
 
 int hax_host_create_vm(struct hax_state *hax, int *vmid)
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 5729ad9b48..0ba488c468 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -185,41 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
 
 static char *hax_vm_devfs_string(int vm_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
-        return NULL;
-    }
-
-#define HAX_VM_DEVFS "\\\\.\\hax_vmxx"
-    name = g_strdup(HAX_VM_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VM_DEVFS, "\\\\.\\hax_vm%02d", vm_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
 }
 
 static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id);
-        return NULL;
-    }
-
-#define HAX_VCPU_DEVFS "\\\\.\\hax_vmxx_vcpuxx"
-    name = g_strdup(HAX_VCPU_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "\\\\.\\hax_vm%02d_vcpu%02d",
-             vm_id, vcpu_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
 }
 
 int hax_host_create_vm(struct hax_state *hax, int *vmid)
-- 
2.24.1


