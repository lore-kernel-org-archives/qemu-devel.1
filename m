Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA5C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCBA206C1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFjtWgdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCBA206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJz1-0001FW-UF
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw7-0002Pv-RL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw3-00049X-Az
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw3-00040Q-1r
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so82047421wrf.11
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PksipMVzAiiMTAlABLCmlNruZKZ2bg95M8Q+Ha0hlqQ=;
 b=sFjtWgdnNg98Urrin4BYTtOENReVLX3VsN5naYziLh/Y6A2sUcga5FB5Qne4gUEibg
 AqF3hiXfblFUjCnNgypJ813/jk6hovuu6TDYYKw4MflCBbY2GQeoM2ttRhXhuqwaZBUi
 KQoay9RoB+VSx7y0yhIv8rdd95gQhCxTO0Esx90wM06+S9yFn4IKi/MWhxHBij9nQa6i
 bdN6P6bRl5rDUqKC8p2sirfuf2JpwMFgm2bA1H9MAESuzhhui5tglIJ8b44gsO6VEjeJ
 CD4lbnAHX1K/60T5OT4tSsj03VVSBQJGdWos6Wb13Nmh+zwuF0LExL2Yb9Xervcl2dTO
 uXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PksipMVzAiiMTAlABLCmlNruZKZ2bg95M8Q+Ha0hlqQ=;
 b=npDINRtlnBLhQTdLP2l80BFgQFjz67IQmurDWni05Z3+h614wKQQoTZmIxnEWZbIfq
 sBsGMGNaLk4/XZvqnROnsIRoQpxpbgQY5Ialzk6+9l2o0F3s/zZ7kqeYey+SKIey/OvP
 o5C0LLuWHDAkyhJzx8gUpl6QxEQFsEA3SP6K66R6iCKYVOa3ooVF/g7mWZ8ZemvTZhDY
 HdFTliYSBUI9/tipF146Y5co4oI445Uaup/tm/HzK5Gxp4ykKMo2bYrJpUwkUOFSIFDG
 uHMl6PlWoBnhdm+UYs0R5rhxiM/xygHNelyXbx+Xdr6qoJA42F4BUyaH9uVLhEUh1sww
 lPKg==
X-Gm-Message-State: APjAAAX7oTjyo8WSqzJf4u88U5dZyX8P1szYr51eAT53G5AMCJotR1g9
 2EDgO08Zqaev/3Pl9pA/T4HIJrPRuYc=
X-Google-Smtp-Source: APXvYqxT8hCtITiFtyszZ5HCoHc4+cRVmDKjO6caNxyRzQudCUVcaob9/82Qly2A/fry744F9s10vQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr5201889wrv.347.1564938273955; 
 Sun, 04 Aug 2019 10:04:33 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:33 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:18 +0200
Message-Id: <faa22ae99df3a4de8c83effe90ed986460df7b34.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 06/14] audio: audiodev= parameters no longer
 optional when -audiodev present
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

This means you should probably stop using -soundhw (as it doesn't allow
you to specify any options) and add the device manually with -device.
The exception is pcspk, it's currently not possible to manually add it.
To use it with audiodev, use something like this:

    -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v1:
    
    * Split off paaudio changes to a different commit.

 audio/audio.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 4baa37caac..d131958194 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -101,6 +101,8 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
+static bool legacy_config = true;
+
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
 #error No its not
 #else
@@ -1392,7 +1394,7 @@ static AudiodevListEntry *audiodev_find(
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, const char *name)
 {
     static bool atexit_registered;
     size_t i;
@@ -1406,12 +1408,13 @@ static AudioState *audio_init(Audiodev *dev)
 
     if (dev) {
         /* -audiodev option */
+        legacy_config = false;
         drvname = AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
-        /*
-         * todo: check for -audiodev once we have normal audiodev selection
-         * support
-         */
+        if (!legacy_config) {
+            dolog("You must specify an audiodev= for the device %s\n", name);
+            exit(1);
+        }
         return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
@@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *head)
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
-        card->state = audio_init(NULL);
+        card->state = audio_init(NULL, name);
     }
 
     card->name = g_strdup (name);
@@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        /* todo: remove when we have normal audiodev selection support */
-        s = audio_init(NULL);
+        if (!legacy_config) {
+            dolog("You must specify audiodev when trying to capture\n");
+            return NULL;
+        }
+        s = audio_init(NULL, NULL);
     }
 
     if (audio_validate_settings (as)) {
@@ -1776,7 +1782,7 @@ void audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        audio_init(e->dev);
+        audio_init(e->dev, NULL);
     }
 }
 
-- 
2.22.0


