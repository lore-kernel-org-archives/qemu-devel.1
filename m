Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39612C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20FC224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMjlQWy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20FC224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2gq-0001iN-Tb
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hj-00045v-MR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hf-0002bf-2p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iF2He-0002aE-Ff
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so874228wme.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xbpHh712sivYhk5HmhmXHkxPur7dIJpK6QrNTW7BR0=;
 b=JMjlQWy5Fzx/GB25cjxm3NR+6d1k7n0X3GoLbuTuuBv+jfUkad2klU3a7yFqaFxLyr
 So/eb5BR39ScaghzTKSHtWpWXuy+B/cJQDIzyuDlRhoqUdH8RAxEKJ0AiRZLjPyxOO8y
 6JvhoiVeCpRsc0LfTeo/KI1JWl42xoSntCiLDk82y34LtXqnycQVmeZ5+WGIaqBClRCm
 tqcsHSsY7NAaUTtf1Z+qT3N46Gjynw2GSTrCqsIsRGfYkDl93gPBTdKWzL5c9NlkMgW7
 QmFkj1E0LA8uspYa7YzI5QgSZNd95WoeF35PTT7t1X2gYdbWdaNLFImshctEal6fHIMT
 0fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1xbpHh712sivYhk5HmhmXHkxPur7dIJpK6QrNTW7BR0=;
 b=BhPOSiZJycZQjL5l+7ZXIYdHkzgnHy/+YlqqotTJpQTtsUlrVn93zknzjTICMYbd0L
 /GrcAJu8wOUe6HSBkq3t7QlIF9x7i0bj90jZ4J/Sr8jeT5+gTpSGZOjzWQMbOs3iEA44
 Et2FYLnMQJqaERfXNSjyHqdadkuAlMzOrsksKmnPXwR/H427+CdgdTS05FeTL+rLNQSA
 iD+01sDLJaNn53qnAt38mwPJWxSPQYQeg9ZtaU29Nl1ciXpTqJQjOaTRQgMSVp88Dl4c
 pSQA2J60XrxTYtcqfkbQj2k7+A8p8JsBwItQdj+yjGf3gav9WtCYwWMgSF6fvQUv8As8
 GUag==
X-Gm-Message-State: APjAAAU000Xa52ALOF+kBON6SVZorKkF++HcPXNQHmMWb/2rTnc1Ovvt
 zQQTFI6LXM4wUQLto7pew+km8y6z
X-Google-Smtp-Source: APXvYqz5G9irYbvl/F1PlA6jXuo0Ds0U3op28MMYcU23m5TW7VjyXRaWVcyXw4KHo5VPAiDBWFvIIA==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr691836wma.122.1569875316896; 
 Mon, 30 Sep 2019 13:28:36 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.gmail.com with ESMTPSA id o9sm34402911wrh.46.2019.09.30.13.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:28:36 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/10] usb-audio: support more than two channels of audio
Date: Mon, 30 Sep 2019 22:29:01 +0200
Message-Id: <94d771da13a06784eda88a956f21e80c9ab4ea50.1569874641.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
References: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

This commit adds support for 5.1 and 7.1 audio playback.  This commit
adds a new property to usb-audio:

* multi=on|off
  Whether to enable the 5.1 and 7.1 audio support.  When off (default)
  it continues to emulate the old stereo-only device.  When on, it
  emulates a slightly different audio device that supports 5.1 and 7.1
  audio.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    According to the spec the channel order is front left, front right,
    center, lfe, surround left, surround right for 5.1 sound.  But alsa uses
    front left, front right, surround left, surround right, center, lfe.
    This means if you simply use an alsa device as -audiodev, the surround
    and center/lfe channels will be swapped.  There is not much to do sort
    of writing a mini mixeng or something like that, but you can easily add
    a new device to /etc/asound.conf that swaps the channels:
    
    pcm.swap {
        type route
        slave.pcm "default" # or whatever
        slave.channels 6
    
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.4 1
        ttable.3.5 1
        ttable.4.2 1
        ttable.5.3 1
    }
    
    and use -audiodev alsa,id=foo,out.mixing-engine=off,alsa-out.dev=swap,...
    
    (due to how usb and usb-audio works, you'll probably need
    alsa-out.try-poll=off and some playing with threshold)
    
    Pulseaudio allows us to specify channel order, and we default to a
    compatible order so it should work correctly without extra setup.

 hw/usb/dev-audio.c | 419 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 366 insertions(+), 53 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 74c99b1f12..e42bdfbdc1 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -37,11 +37,15 @@
 #include "desc.h"
 #include "audio/audio.h"
 
+static void usb_audio_reinit(USBDevice *dev, unsigned channels);
+
 #define USBAUDIO_VENDOR_NUM     0x46f4 /* CRC16() of "QEMU" */
 #define USBAUDIO_PRODUCT_NUM    0x0002
 
 #define DEV_CONFIG_VALUE        1 /* The one and only */
 
+#define USBAUDIO_MAX_CHANNELS(s) (s->multi ? 8 : 2)
+
 /* Descriptor subtypes for AC interfaces */
 #define DST_AC_HEADER           1
 #define DST_AC_INPUT_TERMINAL   2
@@ -80,6 +84,27 @@ static const USBDescStrings usb_audio_stringtable = {
     [STRING_REAL_STREAM]        = "Audio Output - 48 kHz Stereo",
 };
 
+/*
+ * A USB audio device supports an arbitrary number of alternate
+ * interface settings for each interface.  Each corresponds to a block
+ * diagram of parameterized blocks.  This can thus refer to things like
+ * number of channels, data rates, or in fact completely different
+ * block diagrams.  Alternative setting 0 is always the null block diagram,
+ * which is used by a disabled device.
+ */
+enum usb_audio_altset {
+    ALTSET_OFF    = 0x00,         /* No endpoint */
+    ALTSET_STEREO = 0x01,         /* Single endpoint */
+    ALTSET_51     = 0x02,
+    ALTSET_71     = 0x03,
+};
+
+static unsigned altset_channels[] = {
+    [ALTSET_STEREO] = 2,
+    [ALTSET_51]     = 6,
+    [ALTSET_71]     = 8,
+};
+
 #define U16(x) ((x) & 0xff), (((x) >> 8) & 0xff)
 #define U24(x) U16(x), (((x) >> 16) & 0xff)
 #define U32(x) U24(x), (((x) >> 24) & 0xff)
@@ -87,7 +112,8 @@ static const USBDescStrings usb_audio_stringtable = {
 /*
  * A Basic Audio Device uses these specific values
  */
-#define USBAUDIO_PACKET_SIZE     192
+#define USBAUDIO_PACKET_SIZE_BASE 96
+#define USBAUDIO_PACKET_SIZE(channels) (USBAUDIO_PACKET_SIZE_BASE * channels)
 #define USBAUDIO_SAMPLE_RATE     48000
 #define USBAUDIO_PACKET_INTERVAL 1
 
@@ -121,7 +147,7 @@ static const USBDescIface desc_iface[] = {
                     0x01,                       /*  u8  bTerminalID */
                     U16(0x0101),                /* u16  wTerminalType */
                     0x00,                       /*  u8  bAssocTerminal */
-                    0x02,                       /* u16  bNrChannels */
+                    0x02,                       /*  u8  bNrChannels */
                     U16(0x0003),                /* u16  wChannelConfig */
                     0x00,                       /*  u8  iChannelNames */
                     STRING_INPUT_TERMINAL,      /*  u8  iTerminal */
@@ -156,14 +182,14 @@ static const USBDescIface desc_iface[] = {
         },
     },{
         .bInterfaceNumber              = 1,
-        .bAlternateSetting             = 0,
+        .bAlternateSetting             = ALTSET_OFF,
         .bNumEndpoints                 = 0,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
         .iInterface                    = STRING_NULL_STREAM,
     },{
         .bInterfaceNumber              = 1,
-        .bAlternateSetting             = 1,
+        .bAlternateSetting             = ALTSET_STEREO,
         .bNumEndpoints                 = 1,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
@@ -199,7 +225,7 @@ static const USBDescIface desc_iface[] = {
             {
                 .bEndpointAddress      = USB_DIR_OUT | 0x01,
                 .bmAttributes          = 0x0d,
-                .wMaxPacketSize        = USBAUDIO_PACKET_SIZE,
+                .wMaxPacketSize        = USBAUDIO_PACKET_SIZE(2),
                 .bInterval             = 1,
                 .is_audio              = 1,
                 /* Stereo Headphone Class-specific
@@ -247,17 +273,274 @@ static const USBDesc desc_audio = {
     .str  = usb_audio_stringtable,
 };
 
-/*
- * A USB audio device supports an arbitrary number of alternate
- * interface settings for each interface.  Each corresponds to a block
- * diagram of parameterized blocks.  This can thus refer to things like
- * number of channels, data rates, or in fact completely different
- * block diagrams.  Alternative setting 0 is always the null block diagram,
- * which is used by a disabled device.
- */
-enum usb_audio_altset {
-    ALTSET_OFF  = 0x00,         /* No endpoint */
-    ALTSET_ON   = 0x01,         /* Single endpoint */
+/* multi channel compatible desc */
+
+static const USBDescIface desc_iface_multi[] = {
+    {
+        .bInterfaceNumber              = 0,
+        .bNumEndpoints                 = 0,
+        .bInterfaceClass               = USB_CLASS_AUDIO,
+        .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
+        .bInterfaceProtocol            = 0x04,
+        .iInterface                    = STRING_USBAUDIO_CONTROL,
+        .ndesc                         = 4,
+        .descs = (USBDescOther[]) {
+            {
+                /* Headphone Class-Specific AC Interface Header Descriptor */
+                .data = (uint8_t[]) {
+                    0x09,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AC_HEADER,              /*  u8  bDescriptorSubtype */
+                    U16(0x0100),                /* u16  bcdADC */
+                    U16(0x38),                  /* u16  wTotalLength */
+                    0x01,                       /*  u8  bInCollection */
+                    0x01,                       /*  u8  baInterfaceNr */
+                }
+            },{
+                /* Generic Stereo Input Terminal ID1 Descriptor */
+                .data = (uint8_t[]) {
+                    0x0c,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AC_INPUT_TERMINAL,      /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bTerminalID */
+                    U16(0x0101),                /* u16  wTerminalType */
+                    0x00,                       /*  u8  bAssocTerminal */
+                    0x08,                       /*  u8  bNrChannels */
+                    U16(0x063f),                /* u16  wChannelConfig */
+                    0x00,                       /*  u8  iChannelNames */
+                    STRING_INPUT_TERMINAL,      /*  u8  iTerminal */
+                }
+            },{
+                /* Generic Stereo Feature Unit ID2 Descriptor */
+                .data = (uint8_t[]) {
+                    0x19,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AC_FEATURE_UNIT,        /*  u8  bDescriptorSubtype */
+                    0x02,                       /*  u8  bUnitID */
+                    0x01,                       /*  u8  bSourceID */
+                    0x02,                       /*  u8  bControlSize */
+                    U16(0x0001),                /* u16  bmaControls(0) */
+                    U16(0x0002),                /* u16  bmaControls(1) */
+                    U16(0x0002),                /* u16  bmaControls(2) */
+                    U16(0x0002),                /* u16  bmaControls(3) */
+                    U16(0x0002),                /* u16  bmaControls(4) */
+                    U16(0x0002),                /* u16  bmaControls(5) */
+                    U16(0x0002),                /* u16  bmaControls(6) */
+                    U16(0x0002),                /* u16  bmaControls(7) */
+                    U16(0x0002),                /* u16  bmaControls(8) */
+                    STRING_FEATURE_UNIT,        /*  u8  iFeature */
+                }
+            },{
+                /* Headphone Ouptut Terminal ID3 Descriptor */
+                .data = (uint8_t[]) {
+                    0x09,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AC_OUTPUT_TERMINAL,     /*  u8  bDescriptorSubtype */
+                    0x03,                       /*  u8  bUnitID */
+                    U16(0x0301),                /* u16  wTerminalType (SPK) */
+                    0x00,                       /*  u8  bAssocTerminal */
+                    0x02,                       /*  u8  bSourceID */
+                    STRING_OUTPUT_TERMINAL,     /*  u8  iTerminal */
+                }
+            }
+        },
+    },{
+        .bInterfaceNumber              = 1,
+        .bAlternateSetting             = ALTSET_OFF,
+        .bNumEndpoints                 = 0,
+        .bInterfaceClass               = USB_CLASS_AUDIO,
+        .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    = STRING_NULL_STREAM,
+    },{
+        .bInterfaceNumber              = 1,
+        .bAlternateSetting             = ALTSET_STEREO,
+        .bNumEndpoints                 = 1,
+        .bInterfaceClass               = USB_CLASS_AUDIO,
+        .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    = STRING_REAL_STREAM,
+        .ndesc                         = 2,
+        .descs = (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descriptor */
+                .data = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data = (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bFormatType */
+                    0x02,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution */
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps = (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      = USB_DIR_OUT | 0x01,
+                .bmAttributes          = 0x0d,
+                .wMaxPacketSize        = USBAUDIO_PACKET_SIZE(2),
+                .bInterval             = 1,
+                .is_audio              = 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType */
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits */
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    },{
+        .bInterfaceNumber              = 1,
+        .bAlternateSetting             = ALTSET_51,
+        .bNumEndpoints                 = 1,
+        .bInterfaceClass               = USB_CLASS_AUDIO,
+        .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    = STRING_REAL_STREAM,
+        .ndesc                         = 2,
+        .descs = (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descriptor */
+                .data = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data = (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bFormatType */
+                    0x06,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution */
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps = (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      = USB_DIR_OUT | 0x01,
+                .bmAttributes          = 0x0d,
+                .wMaxPacketSize        = USBAUDIO_PACKET_SIZE(6),
+                .bInterval             = 1,
+                .is_audio              = 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType */
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits */
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    },{
+        .bInterfaceNumber              = 1,
+        .bAlternateSetting             = ALTSET_71,
+        .bNumEndpoints                 = 1,
+        .bInterfaceClass               = USB_CLASS_AUDIO,
+        .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    = STRING_REAL_STREAM,
+        .ndesc                         = 2,
+        .descs = (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descriptor */
+                .data = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data = (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubtype */
+                    0x01,                       /*  u8  bFormatType */
+                    0x08,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution */
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps = (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      = USB_DIR_OUT | 0x01,
+                .bmAttributes          = 0x0d,
+                .wMaxPacketSize        = USBAUDIO_PACKET_SIZE(8),
+                .bInterval             = 1,
+                .is_audio              = 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra = (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType */
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubtype */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits */
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    }
+};
+
+static const USBDescDevice desc_device_multi = {
+    .bcdUSB                        = 0x0100,
+    .bMaxPacketSize0               = 64,
+    .bNumConfigurations            = 1,
+    .confs = (USBDescConfig[]) {
+        {
+            .bNumInterfaces        = 2,
+            .bConfigurationValue   = DEV_CONFIG_VALUE,
+            .iConfiguration        = STRING_CONFIG,
+            .bmAttributes          = USB_CFG_ATT_ONE | USB_CFG_ATT_SELFPOWER,
+            .bMaxPower             = 0x32,
+            .nif = ARRAY_SIZE(desc_iface_multi),
+            .ifs = desc_iface_multi,
+        }
+    },
+};
+
+static const USBDesc desc_audio_multi = {
+    .id = {
+        .idVendor          = USBAUDIO_VENDOR_NUM,
+        .idProduct         = USBAUDIO_PRODUCT_NUM,
+        .bcdDevice         = 0,
+        .iManufacturer     = STRING_MANUFACTURER,
+        .iProduct          = STRING_PRODUCT,
+        .iSerialNumber     = STRING_SERIALNUMBER,
+    },
+    .full = &desc_device_multi,
+    .str  = usb_audio_stringtable,
 };
 
 /*
@@ -300,10 +583,11 @@ struct streambuf {
     uint32_t cons;
 };
 
-static void streambuf_init(struct streambuf *buf, uint32_t size)
+static void streambuf_init(struct streambuf *buf, uint32_t size,
+                           uint32_t channels)
 {
     g_free(buf->data);
-    buf->size = size - (size % USBAUDIO_PACKET_SIZE);
+    buf->size = size - (size % USBAUDIO_PACKET_SIZE(channels));
     buf->data = g_malloc(buf->size);
     buf->prod = 0;
     buf->cons = 0;
@@ -315,21 +599,21 @@ static void streambuf_fini(struct streambuf *buf)
     buf->data = NULL;
 }
 
-static int streambuf_put(struct streambuf *buf, USBPacket *p)
+static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 {
     uint32_t free = buf->size - (buf->prod - buf->cons);
 
-    if (free < USBAUDIO_PACKET_SIZE) {
+    if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
     }
-    if (p->iov.size != USBAUDIO_PACKET_SIZE) {
+    if (p->iov.size != USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
     }
 
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
-                    USBAUDIO_PACKET_SIZE);
-    buf->prod += USBAUDIO_PACKET_SIZE;
-    return USBAUDIO_PACKET_SIZE;
+                    USBAUDIO_PACKET_SIZE(channels));
+    buf->prod += USBAUDIO_PACKET_SIZE(channels);
+    return USBAUDIO_PACKET_SIZE(channels);
 }
 
 static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
@@ -357,14 +641,15 @@ typedef struct USBAudioState {
         enum usb_audio_altset altset;
         struct audsettings as;
         SWVoiceOut *voice;
-        bool mute;
-        uint8_t vol[2];
+        Volume vol;
         struct streambuf buf;
+        uint32_t channels;
     } out;
 
     /* properties */
     uint32_t debug;
-    uint32_t buffer;
+    uint32_t buffer_user, buffer;
+    bool multi;
 } USBAudioState;
 
 #define TYPE_USB_AUDIO "usb-audio"
@@ -397,10 +682,15 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
 {
     switch (altset) {
     case ALTSET_OFF:
-        streambuf_init(&s->out.buf, s->buffer);
         AUD_set_active_out(s->out.voice, false);
         break;
-    case ALTSET_ON:
+    case ALTSET_STEREO:
+    case ALTSET_51:
+    case ALTSET_71:
+        if (s->out.channels != altset_channels[altset]) {
+            usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
+        }
+        streambuf_init(&s->out.buf, s->buffer, s->out.channels);
         AUD_set_active_out(s->out.voice, true);
         break;
     default:
@@ -431,33 +721,33 @@ static int usb_audio_get_control(USBAudioState *s, uint8_t attrib,
 
     switch (aid) {
     case ATTRIB_ID(MUTE_CONTROL, CR_GET_CUR, 0x0200):
-        data[0] = s->out.mute;
+        data[0] = s->out.vol.mute;
         ret = 1;
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_CUR, 0x0200):
-        if (cn < 2) {
-            uint16_t vol = (s->out.vol[cn] * 0x8800 + 127) / 255 + 0x8000;
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
+            uint16_t vol = (s->out.vol.vol[cn] * 0x8800 + 127) / 255 + 0x8000;
             data[0] = vol;
             data[1] = vol >> 8;
             ret = 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_MIN, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] = 0x01;
             data[1] = 0x80;
             ret = 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_MAX, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] = 0x00;
             data[1] = 0x08;
             ret = 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_RES, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] = 0x88;
             data[1] = 0x00;
             ret = 2;
@@ -479,16 +769,17 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
 
     switch (aid) {
     case ATTRIB_ID(MUTE_CONTROL, CR_SET_CUR, 0x0200):
-        s->out.mute = data[0] & 1;
+        s->out.vol.mute = data[0] & 1;
         set_vol = true;
         ret = 0;
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_SET_CUR, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             uint16_t vol = data[0] + (data[1] << 8);
 
             if (s->debug) {
-                fprintf(stderr, "usb-audio: vol %04x\n", (uint16_t)vol);
+                fprintf(stderr, "usb-audio: cn %d vol %04x\n", cn,
+                        (uint16_t)vol);
             }
 
             vol -= 0x8000;
@@ -497,7 +788,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
                 vol = 255;
             }
 
-            s->out.vol[cn] = vol;
+            s->out.vol.vol[cn] = vol;
             set_vol = true;
             ret = 0;
         }
@@ -506,11 +797,14 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
 
     if (set_vol) {
         if (s->debug) {
-            fprintf(stderr, "usb-audio: mute %d, lvol %3d, rvol %3d\n",
-                    s->out.mute, s->out.vol[0], s->out.vol[1]);
+            int i;
+            fprintf(stderr, "usb-audio: mute %d", s->out.vol.mute);
+            for (i = 0; i < USBAUDIO_MAX_CHANNELS(s); ++i) {
+                fprintf(stderr, ", vol[%d] %3d", i, s->out.vol.vol[i]);
+            }
+            fprintf(stderr, "\n");
         }
-        AUD_set_volume_out(s->out.voice, s->out.mute,
-                           s->out.vol[0], s->out.vol[1]);
+        audio_set_volume_out(s->out.voice, &s->out.vol);
     }
 
     return ret;
@@ -603,7 +897,7 @@ static void usb_audio_handle_dataout(USBAudioState *s, USBPacket *p)
         return;
     }
 
-    streambuf_put(&s->out.buf, p);
+    streambuf_put(&s->out.buf, p, s->out.channels);
     if (p->actual_length < p->iov.size && s->debug > 1) {
         fprintf(stderr, "usb-audio: output overrun (%zd bytes)\n",
                 p->iov.size - p->actual_length);
@@ -645,6 +939,9 @@ static void usb_audio_unrealize(USBDevice *dev, Error **errp)
 static void usb_audio_realize(USBDevice *dev, Error **errp)
 {
     USBAudioState *s = USB_AUDIO(dev);
+    int i;
+
+    dev->usb_desc = s->multi ? &desc_audio_multi : &desc_audio;
 
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
@@ -652,18 +949,35 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     AUD_register_card(TYPE_USB_AUDIO, &s->card);
 
     s->out.altset        = ALTSET_OFF;
-    s->out.mute          = false;
-    s->out.vol[0]        = 240; /* 0 dB */
-    s->out.vol[1]        = 240; /* 0 dB */
+    s->out.vol.mute      = false;
+    for (i = 0; i < USBAUDIO_MAX_CHANNELS(s); ++i) {
+        s->out.vol.vol[i] = 240; /* 0 dB */
+    }
+
+    usb_audio_reinit(dev, 2);
+}
+
+static void usb_audio_reinit(USBDevice *dev, unsigned channels)
+{
+    USBAudioState *s = USB_AUDIO(dev);
+
+    s->out.channels      = channels;
+    if (!s->buffer_user) {
+        s->buffer = 32 * USBAUDIO_PACKET_SIZE(s->out.channels);
+    } else {
+        s->buffer = s->buffer_user;
+    }
+
+    s->out.vol.channels  = s->out.channels;
     s->out.as.freq       = USBAUDIO_SAMPLE_RATE;
-    s->out.as.nchannels  = 2;
+    s->out.as.nchannels  = s->out.channels;
     s->out.as.fmt        = AUDIO_FORMAT_S16;
     s->out.as.endianness = 0;
-    streambuf_init(&s->out.buf, s->buffer);
+    streambuf_init(&s->out.buf, s->buffer, s->out.channels);
 
     s->out.voice = AUD_open_out(&s->card, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
-    AUD_set_volume_out(s->out.voice, s->out.mute, s->out.vol[0], s->out.vol[1]);
+    audio_set_volume_out(s->out.voice, &s->out.vol);
     AUD_set_active_out(s->out.voice, 0);
 }
 
@@ -675,8 +989,8 @@ static const VMStateDescription vmstate_usb_audio = {
 static Property usb_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
-    DEFINE_PROP_UINT32("buffer", USBAudioState, buffer,
-                       32 * USBAUDIO_PACKET_SIZE),
+    DEFINE_PROP_UINT32("buffer", USBAudioState, buffer_user, 0),
+    DEFINE_PROP_BOOL("multi", USBAudioState, multi, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -689,7 +1003,6 @@ static void usb_audio_class_init(ObjectClass *klass, void *data)
     dc->props         = usb_audio_properties;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     k->product_desc   = "QEMU USB Audio Interface";
-    k->usb_desc       = &desc_audio;
     k->realize        = usb_audio_realize;
     k->handle_reset   = usb_audio_handle_reset;
     k->handle_control = usb_audio_handle_control;
-- 
2.23.0


