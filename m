Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED4C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210D320637
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e497DHoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210D320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZXw-0003S0-C0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlT-0002Fw-A1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlS-00028k-3q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlR-00025X-Tb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id m3so2666883wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cS1cp5F+bNd5b1TER3ctjZ7T+bdVSmnYgn9LJfYa/Ls=;
 b=e497DHocHVmWezv7QgGNi+Ug/xUX5MsS7yauoKzsxroDRP+ZvKipw4QBFyqx0kK1Vi
 ctWLxNYsd1dViDUgeBgaQJNitlqfqHJmmwXe9u23PAHsrj0DuEUSqbMTdwyGilIX/w+t
 ckF8xEI3t4/Z8DqAxeDrUIduwj8DJ+tu5avONJQTBAMrDgEbpD9lTMUMsHBWs/W1CO4I
 T/3J398QcX4B/uOJyAbgmQCJGBWfrB+ykAQjvTzDSzFhHUjfxW7zSTy/rSGUjtcf99NH
 vik7tvhDVns4tlaD0LhMJqrINhi2ktMrT6msdTwir3edS+D1zc1wf+EQtCI8Cf8/04TL
 5DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cS1cp5F+bNd5b1TER3ctjZ7T+bdVSmnYgn9LJfYa/Ls=;
 b=FLq3WCbOFgfxFyxLkWpXcWy+1Mta9d502Dbs0FidNEy4ACzeFMoH/y5t67Od5GL4n7
 DJs5+PWZ2oTR9GSJ9S4Vk5zqnE5ZEwh9kjkXq8SkcNmIHAdkQH4TlOZ6JzFnHMrGNAjY
 wOUQcFetta3JGZL3GjfItKptaziEHP6pfn3x3hpO3uCM6hfXBIJpXOuRmDeTFbpwpGEX
 RU1+4r8nlWGEeV/nUEYpEihrdZGGXdDm1PMMYnf3s8Y6AfD2M+3sbrK25ePhp8XZkYzF
 KDtWoxTdHApp8NuuUANBCOym6NbHcV/Su55Lwk4AMTNzpmevrtyq/xYW1lBoyJXPapZN
 mOUg==
X-Gm-Message-State: APjAAAUpojgR7pKIaedfpC1kBHpLpebIL39BETabFbIiVIJjtrXTPFlB
 5Kh/8hldIUeQTBf3QgEo/L5JpAme
X-Google-Smtp-Source: APXvYqyZUV8F1D6pOpeLMrTo+gy8UjlBT8nqIV5uEv3C8Pd2NPqAsVD3HYErwobTw52IgOYUn8QIIw==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr4961318wmm.143.1582631556773; 
 Tue, 25 Feb 2020 03:52:36 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 098/136] Avoid cpu_physical_memory_rw() with a constant
 is_write argument
Date: Tue, 25 Feb 2020 12:50:28 +0100
Message-Id: <1582631466-13880-98-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/xen/xen_pt_graphics.c               |  2 +-
 scripts/coccinelle/exec_rw_const.cocci | 12 ++++++++++++
 target/i386/hax-all.c                  |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index b11e4e0..a3bc7e3 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -222,7 +222,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
     }
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_rw(0xc0000, bios, bios_size, true);
+    cpu_physical_memory_write(0xc0000, bios, bios_size);
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 35ab79e..1a20296 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -62,6 +62,18 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
+// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
+@@
+expression E1, E2, E3;
+@@
+(
+- cpu_physical_memory_rw(E1, E2, E3, false)
++ cpu_physical_memory_read(E1, E2, E3)
+|
+- cpu_physical_memory_rw(E1, E2, E3, true)
++ cpu_physical_memory_write(E1, E2, E3)
+)
+
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 38936d7..f9c83ff 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft)
          *  hft->direction == 2: gpa ==> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, &value, hft->size, false);
-        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, true);
+        cpu_physical_memory_read(hft->gpa, &value, hft->size);
+        cpu_physical_memory_write(hft->gpa2, &value, hft->size);
     }
 
     return 0;
-- 
1.8.3.1



