Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD045C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748BD20673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjbRjquZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748BD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJkA9-0006uu-Ks
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0Q-0005Xd-A6
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0P-0003Lh-49
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0O-0003KX-UO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so17198619wrm.12
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9lJbQYocXSR3LzW21RYjme2hTgIUpvB0ikUNj0SmxGA=;
 b=DjbRjquZ0ds8nxZcqtmlxMqFs1xiWcRKq3mgn2DrkKUy7rpoR/Noka6PjcoJlygBdi
 +G1frdLT158/qpHMJgay/lz0J7oXDY8lFQ8cCbOXF2y7cX3kLObpKIbko9DbGTYUeqZc
 sbI+IOdSvXZDchMwNKBx9/fB62rSoX+yn6EbgarzrDElgA7/bgv2BRyXs1VC2x8R4ywc
 na/23Vi9/gdT0OaXF/iNZkD7HEykrP1YeDyUFyoyAoWWP4orDR/O0Sw+EjQEGz6ofLfX
 uQ0tVchsMhrrgBuDt0IGmNqSa7sflfL3C/TnSOHLLZZl5oMA1gu1r0HMaB5Hp3yKfhP/
 G7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9lJbQYocXSR3LzW21RYjme2hTgIUpvB0ikUNj0SmxGA=;
 b=BpD7ytFO7+YUg45Oey4+Yku+GJGWvU6tpBn9IQ6zk9VeXLIa8KV3ZcmOLhY6486W3b
 gzIjklMGDj5k9RvsXKsaQNwKYAsrJNKFUW3Rjz8hwXB4apyq8J78eQCXC7HuagajJR6p
 PEqClyPvtYml1rl1FplGwpXKFEPVl79PGV7FzXbEkJlkqo9OhPGal0SlxonhDj45YMUB
 Rpw1HbBFjXTjnx9ASs3xQIEe0uSjse1y8ucDm56xJ8zzJtaP7sPAf0pF1Z+UqsdPbReP
 fFUsV43iYSVhUI9dwPXdTDyw1xdWBsJefMXlOotDobPSa3QVnSWm+8bRrbHTuho6H17F
 81wQ==
X-Gm-Message-State: APjAAAVSZCsJXq338KaPA7lFelIMkdBctLfBirlMvnKGDNS1Rn1cUK75
 clrgV8P7ta09iRR8yxj613A8Qy5b
X-Google-Smtp-Source: APXvYqyOz0CBXAYZT/dPe+20V5grppwrurzAKFd+NVGj1yQf4iCbgOCtK49HxRomohE+eN+zwaPhHg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr22015510wrv.52.1570996695891; 
 Sun, 13 Oct 2019 12:58:15 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:15 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/10] paaudio: fix channel order for usb-audio 5.1 and 7.1
 streams
Date: Sun, 13 Oct 2019 21:58:07 +0200
Message-Id: <2900e462d27bd73277ae083d037c32b1b4451ee2.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index d195b1caa8..6ff0d17537 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -338,17 +338,59 @@ static pa_stream *qpa_simple_new (
         pa_stream_direction_t dir,
         const char *dev,
         const pa_sample_spec *ss,
-        const pa_channel_map *map,
         const pa_buffer_attr *attr,
         int *rerror)
 {
     int r;
-    pa_stream *stream;
+    pa_stream *stream = NULL;
     pa_stream_flags_t flags;
+    pa_channel_map map;
 
     pa_threaded_mainloop_lock(c->mainloop);
 
-    stream = pa_stream_new(c->context, name, ss, map);
+    pa_channel_map_init(&map);
+    map.channels = ss->channels;
+
+    /*
+     * TODO: This currently expects the only frontend supporting more than 2
+     * channels is the usb-audio.  We will need some means to set channel
+     * order when a new frontend gains multi-channel support.
+     */
+    switch (ss->channels) {
+    case 1:
+        map.map[0] = PA_CHANNEL_POSITION_MONO;
+        break;
+
+    case 2:
+        map.map[0] = PA_CHANNEL_POSITION_LEFT;
+        map.map[1] = PA_CHANNEL_POSITION_RIGHT;
+        break;
+
+    case 6:
+        map.map[0] = PA_CHANNEL_POSITION_FRONT_LEFT;
+        map.map[1] = PA_CHANNEL_POSITION_FRONT_RIGHT;
+        map.map[2] = PA_CHANNEL_POSITION_CENTER;
+        map.map[3] = PA_CHANNEL_POSITION_LFE;
+        map.map[4] = PA_CHANNEL_POSITION_REAR_LEFT;
+        map.map[5] = PA_CHANNEL_POSITION_REAR_RIGHT;
+        break;
+
+    case 8:
+        map.map[0] = PA_CHANNEL_POSITION_FRONT_LEFT;
+        map.map[1] = PA_CHANNEL_POSITION_FRONT_RIGHT;
+        map.map[2] = PA_CHANNEL_POSITION_CENTER;
+        map.map[3] = PA_CHANNEL_POSITION_LFE;
+        map.map[4] = PA_CHANNEL_POSITION_REAR_LEFT;
+        map.map[5] = PA_CHANNEL_POSITION_REAR_RIGHT;
+        map.map[6] = PA_CHANNEL_POSITION_SIDE_LEFT;
+        map.map[7] = PA_CHANNEL_POSITION_SIDE_RIGHT;
+
+    default:
+        dolog("Internal error: unsupported channel count %d\n", ss->channels);
+        goto fail;
+    }
+
+    stream = pa_stream_new(c->context, name, ss, &map);
     if (!stream) {
         goto fail;
     }
@@ -421,7 +463,6 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
         &ba,                    /* buffering attributes */
         &error
         );
@@ -470,7 +511,6 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
         &ba,                    /* buffering attributes */
         &error
         );
-- 
2.23.0


