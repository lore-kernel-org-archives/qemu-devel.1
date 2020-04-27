Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF3E206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/HxSKgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF3E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3li-00052q-4O
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT3kZ-0003SI-4Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT3kY-0004Pn-LI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <changbin.du@gmail.com>)
 id 1jT3kY-0004Pb-8z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id p8so8675982pgi.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yntwoKjwQcRE9wIsHn1qcGJYKZYmp0BzBHc7v26DwEw=;
 b=U/HxSKgqfWGvhOBO6lykg2tYmXekyKzJOpJ68FBiccbUOaYffN2zajdqOU0VOs4DHU
 xdhI2b8DZ36dGLEe2UczE8CmkxDZErT+XEyYZpR+1O941ai59Z838vo1uW1zL4bmfVdv
 MvJn3KZ9DJoJVe0fbFoHY/dOqAMwOJoRjI3beKFu1BkOpeaaSehb3chqc3XdSOu5ENkw
 2+cn4XWMwO6vRaV8sC2WYlDsia5aHF03VMtoJwNL3VOGay0iQMvj0eOoKTarAvBcmeAw
 0nRM2qm7CVA+D0dyhDKC0hxsErRauKXeqV7pC4aNF0idGgt5nf9wBH+AA9qDnd4F0x9h
 4mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yntwoKjwQcRE9wIsHn1qcGJYKZYmp0BzBHc7v26DwEw=;
 b=udSHgWQvD78lyDdBWvXWA/k6q7D9ssbIlp5v3ZMr9if3xQJSoPq4fRcUvbbQI8hSTJ
 +X2Gk7An9s1Q/PhgSbC5+RXcJa+0A0oPxv6MSVDBPELem+tMkOqNpsd7ik6oUHEAxMYJ
 BSh04zHLAG1gdL72ZTYvD9Q7cb9zo9e3YnuIYVPcV87GXGCnqn2N7CAiemUFvR98B7gL
 dZSH3kNo/GwpixJzB3lTPZ184KlpD+iQiEji1w2TcsDEFX5b/++lCn+6A3S36XCcPCR1
 ZkDjxAquvFk5JxfMi/Bmh5hwoOVu8Lh8QRrccpM3Z2A8CiYHbvjAY6jAI/3IuIvphMW8
 UY/w==
X-Gm-Message-State: AGi0PuY63SqhAeKOA1VoxO0ge3vaAHW+7dd5GWsFo4beNqmVZxCUDYaG
 dbmG5VlLXo/GXXkmdlNDUgA=
X-Google-Smtp-Source: APiQypKpDhJbMU7kp2Q5YNdADSSpQaOGfhG9X10yPwQy9VXknpqGAkZ/y33MPI6gmHTilRqL8v+K3g==
X-Received: by 2002:a63:4d18:: with SMTP id a24mr21881864pgb.97.1587993880889; 
 Mon, 27 Apr 2020 06:24:40 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id q6sm8378475pfh.193.2020.04.27.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 06:24:40 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] ui/sdl2: fix segment fault caused by null pointer
 dereference
Date: Mon, 27 Apr 2020 21:24:12 +0800
Message-Id: <20200427132412.17909-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=changbin.du@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
ssh forwarding even the window has been crated already. I am not sure
whether this is a bug of SDL, but we'd better check it carefully.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: fix typo.
---
 ui/sdl2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3c9424eb42..61c7956da3 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -332,6 +332,10 @@ static void handle_keydown(SDL_Event *ev)
     int gui_key_modifier_pressed = get_mod_state();
     int gui_keysym = 0;
 
+    if (!scon) {
+        return;
+    }
+
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
@@ -412,6 +416,10 @@ static void handle_keyup(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!scon) {
+        return;
+    }
+
     scon->ignore_hotkeys = false;
     sdl2_process_key(scon, &ev->key);
 }
@@ -421,6 +429,10 @@ static void handle_textinput(SDL_Event *ev)
     struct sdl2_console *scon = get_scon_from_window(ev->text.windowID);
     QemuConsole *con = scon ? scon->dcl.con : NULL;
 
+    if (!con) {
+        return;
+    }
+
     if (qemu_console_is_graphic(con)) {
         return;
     }
-- 
2.25.1


