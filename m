Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5276A21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5276A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsHt-0007Jc-0h
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvs-0005D8-Ip
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvo-0000Ke-Kd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvk-0000Ix-QE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C947D8665A;
 Thu, 19 Sep 2019 08:36:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0A825D6C8;
 Thu, 19 Sep 2019 08:36:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 883631FCC0; Thu, 19 Sep 2019 10:36:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:26 +0200
Message-Id: <20190919083629.29998-24-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 08:36:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 23/26] usb-audio: support more than two channels
 of audio
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

This commit adds support for 5.1 and 7.1 audio playback.  This commit
adds a new property to usb-audio:

* multi=3Don|off
  Whether to enable the 5.1 and 7.1 audio support.  When off (default)
  it continues to emulate the old stereo-only device.  When on, it
  emulates a slightly different audio device that supports 5.1 and 7.1
  audio.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 17a517c599bf8e906f41430b97bbe07ebe7eeef5.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-audio.c | 419 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 366 insertions(+), 53 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 74c99b1f1204..e42bdfbdc101 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -37,11 +37,15 @@
 #include "desc.h"
 #include "audio/audio.h"
=20
+static void usb_audio_reinit(USBDevice *dev, unsigned channels);
+
 #define USBAUDIO_VENDOR_NUM     0x46f4 /* CRC16() of "QEMU" */
 #define USBAUDIO_PRODUCT_NUM    0x0002
=20
 #define DEV_CONFIG_VALUE        1 /* The one and only */
=20
+#define USBAUDIO_MAX_CHANNELS(s) (s->multi ? 8 : 2)
+
 /* Descriptor subtypes for AC interfaces */
 #define DST_AC_HEADER           1
 #define DST_AC_INPUT_TERMINAL   2
@@ -80,6 +84,27 @@ static const USBDescStrings usb_audio_stringtable =3D =
{
     [STRING_REAL_STREAM]        =3D "Audio Output - 48 kHz Stereo",
 };
=20
+/*
+ * A USB audio device supports an arbitrary number of alternate
+ * interface settings for each interface.  Each corresponds to a block
+ * diagram of parameterized blocks.  This can thus refer to things like
+ * number of channels, data rates, or in fact completely different
+ * block diagrams.  Alternative setting 0 is always the null block diagr=
am,
+ * which is used by a disabled device.
+ */
+enum usb_audio_altset {
+    ALTSET_OFF    =3D 0x00,         /* No endpoint */
+    ALTSET_STEREO =3D 0x01,         /* Single endpoint */
+    ALTSET_51     =3D 0x02,
+    ALTSET_71     =3D 0x03,
+};
+
+static unsigned altset_channels[] =3D {
+    [ALTSET_STEREO] =3D 2,
+    [ALTSET_51]     =3D 6,
+    [ALTSET_71]     =3D 8,
+};
+
 #define U16(x) ((x) & 0xff), (((x) >> 8) & 0xff)
 #define U24(x) U16(x), (((x) >> 16) & 0xff)
 #define U32(x) U24(x), (((x) >> 24) & 0xff)
@@ -87,7 +112,8 @@ static const USBDescStrings usb_audio_stringtable =3D =
{
 /*
  * A Basic Audio Device uses these specific values
  */
-#define USBAUDIO_PACKET_SIZE     192
+#define USBAUDIO_PACKET_SIZE_BASE 96
+#define USBAUDIO_PACKET_SIZE(channels) (USBAUDIO_PACKET_SIZE_BASE * chan=
nels)
 #define USBAUDIO_SAMPLE_RATE     48000
 #define USBAUDIO_PACKET_INTERVAL 1
=20
@@ -121,7 +147,7 @@ static const USBDescIface desc_iface[] =3D {
                     0x01,                       /*  u8  bTerminalID */
                     U16(0x0101),                /* u16  wTerminalType */
                     0x00,                       /*  u8  bAssocTerminal *=
/
-                    0x02,                       /* u16  bNrChannels */
+                    0x02,                       /*  u8  bNrChannels */
                     U16(0x0003),                /* u16  wChannelConfig *=
/
                     0x00,                       /*  u8  iChannelNames */
                     STRING_INPUT_TERMINAL,      /*  u8  iTerminal */
@@ -156,14 +182,14 @@ static const USBDescIface desc_iface[] =3D {
         },
     },{
         .bInterfaceNumber              =3D 1,
-        .bAlternateSetting             =3D 0,
+        .bAlternateSetting             =3D ALTSET_OFF,
         .bNumEndpoints                 =3D 0,
         .bInterfaceClass               =3D USB_CLASS_AUDIO,
         .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
         .iInterface                    =3D STRING_NULL_STREAM,
     },{
         .bInterfaceNumber              =3D 1,
-        .bAlternateSetting             =3D 1,
+        .bAlternateSetting             =3D ALTSET_STEREO,
         .bNumEndpoints                 =3D 1,
         .bInterfaceClass               =3D USB_CLASS_AUDIO,
         .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
@@ -199,7 +225,7 @@ static const USBDescIface desc_iface[] =3D {
             {
                 .bEndpointAddress      =3D USB_DIR_OUT | 0x01,
                 .bmAttributes          =3D 0x0d,
-                .wMaxPacketSize        =3D USBAUDIO_PACKET_SIZE,
+                .wMaxPacketSize        =3D USBAUDIO_PACKET_SIZE(2),
                 .bInterval             =3D 1,
                 .is_audio              =3D 1,
                 /* Stereo Headphone Class-specific
@@ -247,17 +273,274 @@ static const USBDesc desc_audio =3D {
     .str  =3D usb_audio_stringtable,
 };
=20
-/*
- * A USB audio device supports an arbitrary number of alternate
- * interface settings for each interface.  Each corresponds to a block
- * diagram of parameterized blocks.  This can thus refer to things like
- * number of channels, data rates, or in fact completely different
- * block diagrams.  Alternative setting 0 is always the null block diagr=
am,
- * which is used by a disabled device.
- */
-enum usb_audio_altset {
-    ALTSET_OFF  =3D 0x00,         /* No endpoint */
-    ALTSET_ON   =3D 0x01,         /* Single endpoint */
+/* multi channel compatible desc */
+
+static const USBDescIface desc_iface_multi[] =3D {
+    {
+        .bInterfaceNumber              =3D 0,
+        .bNumEndpoints                 =3D 0,
+        .bInterfaceClass               =3D USB_CLASS_AUDIO,
+        .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_CONTROL,
+        .bInterfaceProtocol            =3D 0x04,
+        .iInterface                    =3D STRING_USBAUDIO_CONTROL,
+        .ndesc                         =3D 4,
+        .descs =3D (USBDescOther[]) {
+            {
+                /* Headphone Class-Specific AC Interface Header Descript=
or */
+                .data =3D (uint8_t[]) {
+                    0x09,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AC_HEADER,              /*  u8  bDescriptorSubty=
pe */
+                    U16(0x0100),                /* u16  bcdADC */
+                    U16(0x38),                  /* u16  wTotalLength */
+                    0x01,                       /*  u8  bInCollection */
+                    0x01,                       /*  u8  baInterfaceNr */
+                }
+            },{
+                /* Generic Stereo Input Terminal ID1 Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x0c,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AC_INPUT_TERMINAL,      /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bTerminalID */
+                    U16(0x0101),                /* u16  wTerminalType */
+                    0x00,                       /*  u8  bAssocTerminal *=
/
+                    0x08,                       /*  u8  bNrChannels */
+                    U16(0x063f),                /* u16  wChannelConfig *=
/
+                    0x00,                       /*  u8  iChannelNames */
+                    STRING_INPUT_TERMINAL,      /*  u8  iTerminal */
+                }
+            },{
+                /* Generic Stereo Feature Unit ID2 Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x19,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AC_FEATURE_UNIT,        /*  u8  bDescriptorSubty=
pe */
+                    0x02,                       /*  u8  bUnitID */
+                    0x01,                       /*  u8  bSourceID */
+                    0x02,                       /*  u8  bControlSize */
+                    U16(0x0001),                /* u16  bmaControls(0) *=
/
+                    U16(0x0002),                /* u16  bmaControls(1) *=
/
+                    U16(0x0002),                /* u16  bmaControls(2) *=
/
+                    U16(0x0002),                /* u16  bmaControls(3) *=
/
+                    U16(0x0002),                /* u16  bmaControls(4) *=
/
+                    U16(0x0002),                /* u16  bmaControls(5) *=
/
+                    U16(0x0002),                /* u16  bmaControls(6) *=
/
+                    U16(0x0002),                /* u16  bmaControls(7) *=
/
+                    U16(0x0002),                /* u16  bmaControls(8) *=
/
+                    STRING_FEATURE_UNIT,        /*  u8  iFeature */
+                }
+            },{
+                /* Headphone Ouptut Terminal ID3 Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x09,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AC_OUTPUT_TERMINAL,     /*  u8  bDescriptorSubty=
pe */
+                    0x03,                       /*  u8  bUnitID */
+                    U16(0x0301),                /* u16  wTerminalType (S=
PK) */
+                    0x00,                       /*  u8  bAssocTerminal *=
/
+                    0x02,                       /*  u8  bSourceID */
+                    STRING_OUTPUT_TERMINAL,     /*  u8  iTerminal */
+                }
+            }
+        },
+    },{
+        .bInterfaceNumber              =3D 1,
+        .bAlternateSetting             =3D ALTSET_OFF,
+        .bNumEndpoints                 =3D 0,
+        .bInterfaceClass               =3D USB_CLASS_AUDIO,
+        .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    =3D STRING_NULL_STREAM,
+    },{
+        .bInterfaceNumber              =3D 1,
+        .bAlternateSetting             =3D ALTSET_STEREO,
+        .bNumEndpoints                 =3D 1,
+        .bInterfaceClass               =3D USB_CLASS_AUDIO,
+        .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    =3D STRING_REAL_STREAM,
+        .ndesc                         =3D 2,
+        .descs =3D (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descrip=
tor */
+                .data =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bFormatType */
+                    0x02,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution *=
/
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps =3D (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      =3D USB_DIR_OUT | 0x01,
+                .bmAttributes          =3D 0x0d,
+                .wMaxPacketSize        =3D USBAUDIO_PACKET_SIZE(2),
+                .bInterval             =3D 1,
+                .is_audio              =3D 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType =
*/
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits =
*/
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    },{
+        .bInterfaceNumber              =3D 1,
+        .bAlternateSetting             =3D ALTSET_51,
+        .bNumEndpoints                 =3D 1,
+        .bInterfaceClass               =3D USB_CLASS_AUDIO,
+        .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    =3D STRING_REAL_STREAM,
+        .ndesc                         =3D 2,
+        .descs =3D (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descrip=
tor */
+                .data =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bFormatType */
+                    0x06,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution *=
/
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps =3D (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      =3D USB_DIR_OUT | 0x01,
+                .bmAttributes          =3D 0x0d,
+                .wMaxPacketSize        =3D USBAUDIO_PACKET_SIZE(6),
+                .bInterval             =3D 1,
+                .is_audio              =3D 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType =
*/
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits =
*/
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    },{
+        .bInterfaceNumber              =3D 1,
+        .bAlternateSetting             =3D ALTSET_71,
+        .bNumEndpoints                 =3D 1,
+        .bInterfaceClass               =3D USB_CLASS_AUDIO,
+        .bInterfaceSubClass            =3D USB_SUBCLASS_AUDIO_STREAMING,
+        .iInterface                    =3D STRING_REAL_STREAM,
+        .ndesc                         =3D 2,
+        .descs =3D (USBDescOther[]) {
+            {
+                /* Headphone Class-specific AS General Interface Descrip=
tor */
+                .data =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bTerminalLink */
+                    0x00,                       /*  u8  bDelay */
+                    0x01, 0x00,                 /* u16  wFormatTag */
+                }
+            },{
+                /* Headphone Type I Format Type Descriptor */
+                .data =3D (uint8_t[]) {
+                    0x0b,                       /*  u8  bLength */
+                    USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType =
*/
+                    DST_AS_FORMAT_TYPE,         /*  u8  bDescriptorSubty=
pe */
+                    0x01,                       /*  u8  bFormatType */
+                    0x08,                       /*  u8  bNrChannels */
+                    0x02,                       /*  u8  bSubFrameSize */
+                    0x10,                       /*  u8  bBitResolution *=
/
+                    0x01,                       /*  u8  bSamFreqType */
+                    U24(USBAUDIO_SAMPLE_RATE),  /* u24  tSamFreq */
+                }
+            }
+        },
+        .eps =3D (USBDescEndpoint[]) {
+            {
+                .bEndpointAddress      =3D USB_DIR_OUT | 0x01,
+                .bmAttributes          =3D 0x0d,
+                .wMaxPacketSize        =3D USBAUDIO_PACKET_SIZE(8),
+                .bInterval             =3D 1,
+                .is_audio              =3D 1,
+                /* Stereo Headphone Class-specific
+                   AS Audio Data Endpoint Descriptor */
+                .extra =3D (uint8_t[]) {
+                    0x07,                       /*  u8  bLength */
+                    USB_DT_CS_ENDPOINT,         /*  u8  bDescriptorType =
*/
+                    DST_EP_GENERAL,             /*  u8  bDescriptorSubty=
pe */
+                    0x00,                       /*  u8  bmAttributes */
+                    0x00,                       /*  u8  bLockDelayUnits =
*/
+                    U16(0x0000),                /* u16  wLockDelay */
+                },
+            },
+        }
+    }
+};
+
+static const USBDescDevice desc_device_multi =3D {
+    .bcdUSB                        =3D 0x0100,
+    .bMaxPacketSize0               =3D 64,
+    .bNumConfigurations            =3D 1,
+    .confs =3D (USBDescConfig[]) {
+        {
+            .bNumInterfaces        =3D 2,
+            .bConfigurationValue   =3D DEV_CONFIG_VALUE,
+            .iConfiguration        =3D STRING_CONFIG,
+            .bmAttributes          =3D USB_CFG_ATT_ONE | USB_CFG_ATT_SEL=
FPOWER,
+            .bMaxPower             =3D 0x32,
+            .nif =3D ARRAY_SIZE(desc_iface_multi),
+            .ifs =3D desc_iface_multi,
+        }
+    },
+};
+
+static const USBDesc desc_audio_multi =3D {
+    .id =3D {
+        .idVendor          =3D USBAUDIO_VENDOR_NUM,
+        .idProduct         =3D USBAUDIO_PRODUCT_NUM,
+        .bcdDevice         =3D 0,
+        .iManufacturer     =3D STRING_MANUFACTURER,
+        .iProduct          =3D STRING_PRODUCT,
+        .iSerialNumber     =3D STRING_SERIALNUMBER,
+    },
+    .full =3D &desc_device_multi,
+    .str  =3D usb_audio_stringtable,
 };
=20
 /*
@@ -300,10 +583,11 @@ struct streambuf {
     uint32_t cons;
 };
=20
-static void streambuf_init(struct streambuf *buf, uint32_t size)
+static void streambuf_init(struct streambuf *buf, uint32_t size,
+                           uint32_t channels)
 {
     g_free(buf->data);
-    buf->size =3D size - (size % USBAUDIO_PACKET_SIZE);
+    buf->size =3D size - (size % USBAUDIO_PACKET_SIZE(channels));
     buf->data =3D g_malloc(buf->size);
     buf->prod =3D 0;
     buf->cons =3D 0;
@@ -315,21 +599,21 @@ static void streambuf_fini(struct streambuf *buf)
     buf->data =3D NULL;
 }
=20
-static int streambuf_put(struct streambuf *buf, USBPacket *p)
+static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t c=
hannels)
 {
     uint32_t free =3D buf->size - (buf->prod - buf->cons);
=20
-    if (free < USBAUDIO_PACKET_SIZE) {
+    if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
     }
-    if (p->iov.size !=3D USBAUDIO_PACKET_SIZE) {
+    if (p->iov.size !=3D USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
     }
=20
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
-                    USBAUDIO_PACKET_SIZE);
-    buf->prod +=3D USBAUDIO_PACKET_SIZE;
-    return USBAUDIO_PACKET_SIZE;
+                    USBAUDIO_PACKET_SIZE(channels));
+    buf->prod +=3D USBAUDIO_PACKET_SIZE(channels);
+    return USBAUDIO_PACKET_SIZE(channels);
 }
=20
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
=20
     /* properties */
     uint32_t debug;
-    uint32_t buffer;
+    uint32_t buffer_user, buffer;
+    bool multi;
 } USBAudioState;
=20
 #define TYPE_USB_AUDIO "usb-audio"
@@ -397,10 +682,15 @@ static int usb_audio_set_output_altset(USBAudioStat=
e *s, int altset)
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
+        if (s->out.channels !=3D altset_channels[altset]) {
+            usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
+        }
+        streambuf_init(&s->out.buf, s->buffer, s->out.channels);
         AUD_set_active_out(s->out.voice, true);
         break;
     default:
@@ -431,33 +721,33 @@ static int usb_audio_get_control(USBAudioState *s, =
uint8_t attrib,
=20
     switch (aid) {
     case ATTRIB_ID(MUTE_CONTROL, CR_GET_CUR, 0x0200):
-        data[0] =3D s->out.mute;
+        data[0] =3D s->out.vol.mute;
         ret =3D 1;
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_CUR, 0x0200):
-        if (cn < 2) {
-            uint16_t vol =3D (s->out.vol[cn] * 0x8800 + 127) / 255 + 0x8=
000;
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
+            uint16_t vol =3D (s->out.vol.vol[cn] * 0x8800 + 127) / 255 +=
 0x8000;
             data[0] =3D vol;
             data[1] =3D vol >> 8;
             ret =3D 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_MIN, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] =3D 0x01;
             data[1] =3D 0x80;
             ret =3D 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_MAX, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] =3D 0x00;
             data[1] =3D 0x08;
             ret =3D 2;
         }
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_GET_RES, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             data[0] =3D 0x88;
             data[1] =3D 0x00;
             ret =3D 2;
@@ -479,16 +769,17 @@ static int usb_audio_set_control(USBAudioState *s, =
uint8_t attrib,
=20
     switch (aid) {
     case ATTRIB_ID(MUTE_CONTROL, CR_SET_CUR, 0x0200):
-        s->out.mute =3D data[0] & 1;
+        s->out.vol.mute =3D data[0] & 1;
         set_vol =3D true;
         ret =3D 0;
         break;
     case ATTRIB_ID(VOLUME_CONTROL, CR_SET_CUR, 0x0200):
-        if (cn < 2) {
+        if (cn < USBAUDIO_MAX_CHANNELS(s)) {
             uint16_t vol =3D data[0] + (data[1] << 8);
=20
             if (s->debug) {
-                fprintf(stderr, "usb-audio: vol %04x\n", (uint16_t)vol);
+                fprintf(stderr, "usb-audio: cn %d vol %04x\n", cn,
+                        (uint16_t)vol);
             }
=20
             vol -=3D 0x8000;
@@ -497,7 +788,7 @@ static int usb_audio_set_control(USBAudioState *s, ui=
nt8_t attrib,
                 vol =3D 255;
             }
=20
-            s->out.vol[cn] =3D vol;
+            s->out.vol.vol[cn] =3D vol;
             set_vol =3D true;
             ret =3D 0;
         }
@@ -506,11 +797,14 @@ static int usb_audio_set_control(USBAudioState *s, =
uint8_t attrib,
=20
     if (set_vol) {
         if (s->debug) {
-            fprintf(stderr, "usb-audio: mute %d, lvol %3d, rvol %3d\n",
-                    s->out.mute, s->out.vol[0], s->out.vol[1]);
+            int i;
+            fprintf(stderr, "usb-audio: mute %d", s->out.vol.mute);
+            for (i =3D 0; i < USBAUDIO_MAX_CHANNELS(s); ++i) {
+                fprintf(stderr, ", vol[%d] %3d", i, s->out.vol.vol[i]);
+            }
+            fprintf(stderr, "\n");
         }
-        AUD_set_volume_out(s->out.voice, s->out.mute,
-                           s->out.vol[0], s->out.vol[1]);
+        audio_set_volume_out(s->out.voice, &s->out.vol);
     }
=20
     return ret;
@@ -603,7 +897,7 @@ static void usb_audio_handle_dataout(USBAudioState *s=
, USBPacket *p)
         return;
     }
=20
-    streambuf_put(&s->out.buf, p);
+    streambuf_put(&s->out.buf, p, s->out.channels);
     if (p->actual_length < p->iov.size && s->debug > 1) {
         fprintf(stderr, "usb-audio: output overrun (%zd bytes)\n",
                 p->iov.size - p->actual_length);
@@ -645,6 +939,9 @@ static void usb_audio_unrealize(USBDevice *dev, Error=
 **errp)
 static void usb_audio_realize(USBDevice *dev, Error **errp)
 {
     USBAudioState *s =3D USB_AUDIO(dev);
+    int i;
+
+    dev->usb_desc =3D s->multi ? &desc_audio_multi : &desc_audio;
=20
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
@@ -652,18 +949,35 @@ static void usb_audio_realize(USBDevice *dev, Error=
 **errp)
     AUD_register_card(TYPE_USB_AUDIO, &s->card);
=20
     s->out.altset        =3D ALTSET_OFF;
-    s->out.mute          =3D false;
-    s->out.vol[0]        =3D 240; /* 0 dB */
-    s->out.vol[1]        =3D 240; /* 0 dB */
+    s->out.vol.mute      =3D false;
+    for (i =3D 0; i < USBAUDIO_MAX_CHANNELS(s); ++i) {
+        s->out.vol.vol[i] =3D 240; /* 0 dB */
+    }
+
+    usb_audio_reinit(dev, 2);
+}
+
+static void usb_audio_reinit(USBDevice *dev, unsigned channels)
+{
+    USBAudioState *s =3D USB_AUDIO(dev);
+
+    s->out.channels      =3D channels;
+    if (!s->buffer_user) {
+        s->buffer =3D 32 * USBAUDIO_PACKET_SIZE(s->out.channels);
+    } else {
+        s->buffer =3D s->buffer_user;
+    }
+
+    s->out.vol.channels  =3D s->out.channels;
     s->out.as.freq       =3D USBAUDIO_SAMPLE_RATE;
-    s->out.as.nchannels  =3D 2;
+    s->out.as.nchannels  =3D s->out.channels;
     s->out.as.fmt        =3D AUDIO_FORMAT_S16;
     s->out.as.endianness =3D 0;
-    streambuf_init(&s->out.buf, s->buffer);
+    streambuf_init(&s->out.buf, s->buffer, s->out.channels);
=20
     s->out.voice =3D AUD_open_out(&s->card, s->out.voice, TYPE_USB_AUDIO=
,
                                 s, output_callback, &s->out.as);
-    AUD_set_volume_out(s->out.voice, s->out.mute, s->out.vol[0], s->out.=
vol[1]);
+    audio_set_volume_out(s->out.voice, &s->out.vol);
     AUD_set_active_out(s->out.voice, 0);
 }
=20
@@ -675,8 +989,8 @@ static const VMStateDescription vmstate_usb_audio =3D=
 {
 static Property usb_audio_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
-    DEFINE_PROP_UINT32("buffer", USBAudioState, buffer,
-                       32 * USBAUDIO_PACKET_SIZE),
+    DEFINE_PROP_UINT32("buffer", USBAudioState, buffer_user, 0),
+    DEFINE_PROP_BOOL("multi", USBAudioState, multi, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -689,7 +1003,6 @@ static void usb_audio_class_init(ObjectClass *klass,=
 void *data)
     dc->props         =3D usb_audio_properties;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     k->product_desc   =3D "QEMU USB Audio Interface";
-    k->usb_desc       =3D &desc_audio;
     k->realize        =3D usb_audio_realize;
     k->handle_reset   =3D usb_audio_handle_reset;
     k->handle_control =3D usb_audio_handle_control;
--=20
2.18.1


