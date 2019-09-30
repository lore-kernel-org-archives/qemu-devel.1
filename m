Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD2C35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3755B224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkfgoKqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3755B224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2g8-00010d-Cs
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hb-0003wi-BA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2HZ-0002U2-RS
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iF2HZ-0002R9-I5
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id f22so836428wmc.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=DkfgoKqK7dUSBf8DHGmdEG6tdSreHj+ZunbCOOpgDN9BUFiobccFSYyI36qNmUcSLu
 m6akWDsS1jbA0dwrYYLn69g7Rw7RSsbAKRwDALO9fRkCB3ZYbcym/1QQZeDb+wyRWm6W
 V53k3VtDIzleCogzQrjWQh1cZB6h/2a8Bgvu+8B1UHsY7ksRgl/SdydZsyitcjx5YcNs
 asctDADf1nAI9r+eMSHlg2RDNtXVjUGrdHPhcNIv7Twjq+OMhNQTC3rHS1E4ieRy0kOI
 MMTKZBoKSRM7+Wd8BeNBPMqZFPP0PrxHIuMIffMhjHGtinivuGy1pjIopXsAje8vE0cn
 hg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=eJ8FoWpSZFXkG3kmYpPpeDN0/t1Q095HVkXV8xFMH9jg/prVO2vZdBriQHktzNc4jX
 JEuOmP2JWN0h8PIb4uWJ207kVxGHCUmaOmDdIcLbwz3PmQvjTltsuIPgEUayw5VUqxQx
 Kdchukm43FBCS+OY/6zgNb2efVQVRKukYN5osBz1F4nKT0XyyM9t79G+9dfbMRKgplqt
 j93NSSMLfym2/kZqaZUnRaE8bTDuAfmcky//tt4Q8hQXeTMXQebq8qb0RXmlFdNpj+k7
 SYVCIQSngmZEhH5Nx9E/6YeLIsgnQGDqNYGgarAhOF+IktMob4CAjq5ERorhh3QxLB1E
 5ikQ==
X-Gm-Message-State: APjAAAXO+QFEQN6ZHwE18iNiWm+YAGI6ckgVMyq7JB1rLskzKpr78kWx
 J7bKkGWxfUvCWic6mknk1ez/bJsA
X-Google-Smtp-Source: APXvYqyxlEvHNoSfuwsTkH3DHCQ3xw9bC9RnaPTjICSkZtA1cJC4jFY8PdzIMuhRWjjQjkR76YqPHQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr786150wmi.142.1569875312365; 
 Mon, 30 Sep 2019 13:28:32 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.gmail.com with ESMTPSA id o9sm34402911wrh.46.2019.09.30.13.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:28:31 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/10] paaudio: get/put_buffer functions
Date: Mon, 30 Sep 2019 22:28:56 +0200
Message-Id: <de01501f2623b8eac9c810eab3205cad0f9e1c52.1569874641.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
References: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This lets us avoid some buffer copying when using mixeng.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index ed31f863f7..6ccdf31415 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -98,6 +98,59 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
         }                                                               \
     } while (0)
 
+static void *qpa_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    PAVoiceIn *p = (PAVoiceIn *) hw;
+    PAConnection *c = p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    if (!p->read_length) {
+        r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
+        CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
+                           "pa_stream_peek failed\n");
+    }
+
+    *size = MIN(p->read_length, *size);
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return (void *) p->read_data;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size = 0;
+    return NULL;
+}
+
+static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    PAVoiceIn *p = (PAVoiceIn *) hw;
+    PAConnection *c = p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    assert(buf == p->read_data && size <= p->read_length);
+
+    p->read_data += size;
+    p->read_length -= size;
+
+    if (size && !p->read_length) {
+        r = pa_stream_drop(p->stream);
+        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed\n");
+    }
+
+unlock:
+    pa_threaded_mainloop_unlock(c->mainloop);
+}
+
 static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
 {
     PAVoiceIn *p = (PAVoiceIn *) hw;
@@ -136,6 +189,32 @@ unlock_and_fail:
     return 0;
 }
 
+static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    PAVoiceOut *p = (PAVoiceOut *) hw;
+    PAConnection *c = p->g->conn;
+    void *ret;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    *size = -1;
+    r = pa_stream_begin_write(p->stream, &ret, size);
+    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail,
+                       "pa_stream_begin_write failed\n");
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return ret;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size = 0;
+    return NULL;
+}
+
 static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
 {
     PAVoiceOut *p = (PAVoiceOut *) hw;
@@ -698,11 +777,15 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
+    .get_buffer_out = qpa_get_buffer_out,
+    .put_buffer_out = qpa_write, /* pa handles it */
     .volume_out = qpa_volume_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .read     = qpa_read,
+    .get_buffer_in = qpa_get_buffer_in,
+    .put_buffer_in = qpa_put_buffer_in,
     .volume_in = qpa_volume_in
 };
 
-- 
2.23.0


