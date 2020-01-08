Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B38C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F102072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsHDMF5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F102072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAtq-0004ns-Ic
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWp-0004TZ-5N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWn-0004dE-VR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWn-0004ch-OM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so2325038wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lI/UiO0FLtiZA09SZKe3jYpK18b21lSc4c4LR3K/VDs=;
 b=TsHDMF5vCHzvDgzxwEFl1FN1p9Pmbx3hHVrAzPLJZyivAg6AEG3NlQ6XH+pPl1S2py
 IrAJA5J3k1gEdBaJfhUE2QaZr0u2pbSEpy2nV76J21LpooLuiR08t1CdQyPvzpH//753
 Wx/1ZVpZBiCPbnqkXmlpvz5zQGPizKAsnH/OMpAWmE+rJAZE3tNaUbX0cEWnUcHscuCI
 MGdB4URatFXPYQDKJCBet2ZHh3VwEwaKWrvOBwQi+3m4dZbR+6JJvP9QMfav6WgEDAPb
 a2mJhBzL0ssjg+pEpxcHSHH6m2kyjd158dDzC56jrVNmG0/BW+lv1uyaHPokgsY0ByM9
 CThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lI/UiO0FLtiZA09SZKe3jYpK18b21lSc4c4LR3K/VDs=;
 b=Qg1Nb6NtLbPiRJF6YscxpfCAtZuH9/6XY+rAdhmD+o1h5KMfbTDxc0AjOTx8lLKY0m
 GznBmHc6CPIb6ceUmDwrYTuL4id05u6FJkaVvYiKRrFDSPdh5xvS+n8Y1z/iYvPav/Ph
 vHLtjPpJGE7Kg4V8tkQCrT9lzwkaZFuOCc5PepjOTpHNjy1eW9mvhXa867uA16FBwrHy
 OwRVV+4pSLonjAb1ZIw0yG1fmUlHVgMYCrVwC5vtNwZDn1yWOjHOJ0pEQWXpHQ4VlPtL
 sXITjEysmEHV1QhKkS/+aD/uu6DZUCUwK/VsZouGxs91qbAtERl6o++TYIU/JFRt0Mux
 4bLQ==
X-Gm-Message-State: APjAAAX1/uavVuybHLs4o9a2ne4B9XK5nqWOhrpBWbdlJWzx5AxfxoDH
 kA3lFcvTRyC/g6g++aa9tVpgYK+C
X-Google-Smtp-Source: APXvYqy+ghnelaFLwIt3+Em/6UBY35s+XLG+PaoIN8YJf9VfsfIm63foF9cPfXNu8A15xsvuHohdwg==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr3503888wmc.64.1578486816630; 
 Wed, 08 Jan 2020 04:33:36 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] chardev: use QEMUChrEvent instead of int
Date: Wed,  8 Jan 2020 13:32:54 +0100
Message-Id: <1578486775-52247-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This uses the QEMUChrEvent enum everywhere except in IOEventHandler.
The IOEventHandler change needs to happen at once for all front ends and
is done with Coccinelle in the next patch.

(Extracted from a patch by Philippe Mathieu-Daudé).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-mux.c         | 6 +++---
 chardev/char.c             | 4 ++--
 include/chardev/char-mux.h | 2 +-
 include/chardev/char.h     | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 200c62a..2675ae0 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -117,7 +117,7 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
+static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -126,7 +126,7 @@ static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
     }
 }
 
-static void mux_chr_be_event(Chardev *chr, int event)
+static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
@@ -232,7 +232,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
         }
 }
 
-void mux_chr_send_all_event(Chardev *chr, int event)
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
     int i;
diff --git a/chardev/char.c b/chardev/char.c
index 739da11..4f598f8 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -48,7 +48,7 @@ static Object *get_chardevs_root(void)
     return container_get(object_get_root(), "/chardevs");
 }
 
-static void chr_be_event(Chardev *s, int event)
+static void chr_be_event(Chardev *s, QEMUChrEvent event)
 {
     CharBackend *be = s->be;
 
@@ -59,7 +59,7 @@ static void chr_be_event(Chardev *s, int event)
     be->chr_event(be->opaque, event);
 }
 
-void qemu_chr_be_event(Chardev *s, int event)
+void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
 {
     /* Keep track if the char device is open */
     switch (event) {
diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 572cefd..417fe32 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -56,6 +56,6 @@ typedef struct MuxChardev {
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 
 void mux_set_focus(Chardev *chr, int focus);
-void mux_chr_send_all_event(Chardev *chr, int event);
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
 #endif /* CHAR_MUX_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 087b202..00589a6 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -210,7 +210,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
  *
  * Send an event from the back end to the front end.
  */
-void qemu_chr_be_event(Chardev *s, int event);
+void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
 
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
@@ -273,7 +273,7 @@ typedef struct ChardevClass {
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
-    void (*chr_be_event)(Chardev *s, int event);
+    void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
     /* Return 0 if succeeded, 1 if failed */
     int (*chr_machine_done)(Chardev *chr);
 } ChardevClass;
-- 
1.8.3.1



