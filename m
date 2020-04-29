Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EEFC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4E220757
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StXCYN2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4E220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTqcL-0000gs-1H
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 13:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTqb3-0007iV-F8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTqb1-0006W2-Vw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTqb1-0006Vt-HA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588181646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxAP/LNGiYydTAPzfXtdlvxumXCuWt+cWNbyrmXhHLo=;
 b=StXCYN2Y5ev2nkj2a3Ynz5D5ry5O62gTXhmDYejqK4R8Zxppu4+kX1X04MrGfpfi8mmQ55
 o03uHVuzq8H9hiqnCZjFp1tToXyLeBDLIJ0LBQhlKBpE8T5Cwh2zmF6IxPaokejf2Zsu5N
 ae7/hL9hzPKUYRjOqAfMWGy5Rsls13s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-1RH8fJG4O4ypb59oREYnyw-1; Wed, 29 Apr 2020 13:34:02 -0400
X-MC-Unique: 1RH8fJG4O4ypb59oREYnyw-1
Received: by mail-wr1-f69.google.com with SMTP id f4so2111837wrp.14
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 10:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vhCyETNVbbeyL8EYgMdNpRAmmdv9w4aBkUbVWAp5DvA=;
 b=F211P/S7nDUwnDkZMleQJCKGnlMdAMIiTfSzej12Tz/gNfyMd++fxZ0Rc++5V/KTyS
 NBIyNkFuGr2+12bZO/+Iv5b2nxIV8fb+OqqeLGiAjWiHexCBXEY1aPDouRTDsakQG60z
 9q8mx6xg2V/56r8fYWeBP9s4xcsETzyxM93e7LghdWXFL6dQgQoraZncBhxmE/aleVT6
 hB25Gmvzog2EZBRLrIYIRYAfLSl14HX9xKS3DF3RasZzlRPA4q+BJEBFI6TTRrB/6+8k
 1mzCDhJeMivlyiGCD+Iz5OuRXXKa81YYUacrTSlZNVl1WLGffoA7JFRXaBf16qACShw3
 zyxw==
X-Gm-Message-State: AGi0PuY0rtYI6mpezNU2S3nr1qM1N0J/d/3H27FC+sxX8aOwhb4AFZrl
 2LG8S4UZgIrIuw7K/S2kyzMiqateo3CLVnyuFvGdRtvc1/Igh+bTp8M+me6R/zq0K0YUKvVZ/iY
 diM7D44y4MPtqz2g=
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr39852555wru.258.1588181639935; 
 Wed, 29 Apr 2020 10:33:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfkMHv02XasdpmbQ6eXVcPtNMCYcMaVhvSQwwdZwLjPX3HbyYaAScXusEM3JGwOYhFun7SQw==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr39852523wru.258.1588181639495; 
 Wed, 29 Apr 2020 10:33:59 -0700 (PDT)
Received: from x1w.redhat.com (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id o3sm31629429wru.68.2020.04.29.10.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 10:33:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 1/1] hw/audio: Make 'soundhw' command line option a QOM
 interface
Date: Wed, 29 Apr 2020 19:33:52 +0200
Message-Id: <20200429173352.29442-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429173352.29442-1-philmd@redhat.com>
References: <20200429173352.29442-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 13:34:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Introduce the SOUNDHW_CMDLINE_INTERFACE QOM type to replace the
deprecated register_soundhw() API.

The conversion of devices calling isa_register_soundhw() /
pci_register_soundhw() is easy:
- Add SOUNDHW_CMDLINE_INTERFACE to InterfaceInfo[],
- Set cmdline_name to the soundhw name, the first argument
  of register_soundhw()to cmdline_name,
- Remove register_soundhw() call.

soundhw.c is rewritten:
- Register the new interface type,
- Use GLib APIs
- Remove register_soundhw() functions.

As the conversion is hardly splitable, it is unfortunately
written as a single patch.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
pcspk and hda-intel are problematic, so the conversion is not
finished there, code is marked /* XXX */.
---
 include/hw/audio/soundhw.h |  20 +++-
 hw/audio/ac97.c            |  10 +-
 hw/audio/adlib.c           |  13 ++-
 hw/audio/cs4231a.c         |  13 ++-
 hw/audio/es1370.c          |  10 +-
 hw/audio/gus.c             |  13 ++-
 hw/audio/intel-hda.c       |  13 ++-
 hw/audio/pcspk.c           |  14 ++-
 hw/audio/sb16.c            |  13 ++-
 hw/audio/soundhw.c         | 203 ++++++++++++++++++++-----------------
 10 files changed, 178 insertions(+), 144 deletions(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index c8eef82418..4d65412493 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -1,13 +1,23 @@
 #ifndef HW_SOUNDHW_H
 #define HW_SOUNDHW_H
=20
-void isa_register_soundhw(const char *name, const char *descr,
-                          int (*init_isa)(ISABus *bus));
-
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus));
+#include "qom/object.h"
=20
 void soundhw_init(void);
 void select_soundhw(const char *optarg);
=20
+#define SOUNDHW_CMDLINE_INTERFACE "soundhw-deprecated"
+
+#define SOUNDHW_CMDLINE_CLASS(class) \
+    OBJECT_CLASS_CHECK(SoundHwCmdlineClass, (class), SOUNDHW_CMDLINE_INTER=
FACE)
+
+typedef struct SoundHwCmdlineClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+    /*< public >*/
+
+    const char *cmdline_name;
+    bool option_used;
+} SoundHwCmdlineClass;
+
 #endif
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1ec87feec0..5599f97f39 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1395,12 +1395,6 @@ static void ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
=20
-static int ac97_init (PCIBus *bus)
-{
-    pci_create_simple(bus, -1, TYPE_AC97);
-    return 0;
-}
-
 static Property ac97_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_END_OF_LIST (),
@@ -1410,6 +1404,7 @@ static void ac97_class_init (ObjectClass *klass, void=
 *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     k->realize =3D ac97_realize;
     k->exit =3D ac97_exit;
@@ -1422,6 +1417,7 @@ static void ac97_class_init (ObjectClass *klass, void=
 *data)
     dc->vmsd =3D &vmstate_ac97;
     device_class_set_props(dc, ac97_properties);
     dc->reset =3D ac97_on_reset;
+    sk->cmdline_name =3D "ac97";
 }
=20
 static const TypeInfo ac97_info =3D {
@@ -1431,6 +1427,7 @@ static const TypeInfo ac97_info =3D {
     .class_init    =3D ac97_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { SOUNDHW_CMDLINE_INTERFACE },
         { },
     },
 };
@@ -1438,7 +1435,6 @@ static const TypeInfo ac97_info =3D {
 static void ac97_register_types (void)
 {
     type_register_static (&ac97_info);
-    pci_register_soundhw("ac97", "Intel 82801AA AC97 Audio", ac97_init);
 }
=20
 type_init (ac97_register_types)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index d6c1fb0586..a2b298c264 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -308,11 +308,13 @@ static Property adlib_properties[] =3D {
 static void adlib_class_initfn (ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     dc->realize =3D adlib_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc =3D ADLIB_DESC;
     device_class_set_props(dc, adlib_properties);
+    sk->cmdline_name =3D "adlib";
 }
=20
 static const TypeInfo adlib_info =3D {
@@ -320,18 +322,15 @@ static const TypeInfo adlib_info =3D {
     .parent        =3D TYPE_ISA_DEVICE,
     .instance_size =3D sizeof (AdlibState),
     .class_init    =3D adlib_class_initfn,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
-static int Adlib_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_ADLIB);
-    return 0;
-}
-
 static void adlib_register_types (void)
 {
     type_register_static (&adlib_info);
-    isa_register_soundhw("adlib", ADLIB_DESC, Adlib_init);
 }
=20
 type_init (adlib_register_types)
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index ffdbb58d6a..bdbb792777 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -683,12 +683,6 @@ static void cs4231a_realizefn (DeviceState *dev, Error=
 **errp)
     AUD_register_card ("cs4231a", &s->card);
 }
=20
-static int cs4231a_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_CS4231A);
-    return 0;
-}
-
 static Property cs4231a_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(CSState, card),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
@@ -700,6 +694,7 @@ static Property cs4231a_properties[] =3D {
 static void cs4231a_class_initfn (ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     dc->realize =3D cs4231a_realizefn;
     dc->reset =3D cs4231a_reset;
@@ -707,6 +702,7 @@ static void cs4231a_class_initfn (ObjectClass *klass, v=
oid *data)
     dc->desc =3D "Crystal Semiconductor CS4231A";
     dc->vmsd =3D &vmstate_cs4231a;
     device_class_set_props(dc, cs4231a_properties);
+    sk->cmdline_name =3D "cs4231a";
 }
=20
 static const TypeInfo cs4231a_info =3D {
@@ -715,12 +711,15 @@ static const TypeInfo cs4231a_info =3D {
     .instance_size =3D sizeof (CSState),
     .instance_init =3D cs4231a_initfn,
     .class_init    =3D cs4231a_class_initfn,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
 static void cs4231a_register_types (void)
 {
     type_register_static (&cs4231a_info);
-    isa_register_soundhw("cs4231a", "CS4231A", cs4231a_init);
 }
=20
 type_init (cs4231a_register_types)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 89c4dabcd4..e162fe6e95 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -881,12 +881,6 @@ static void es1370_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
=20
-static int es1370_init (PCIBus *bus)
-{
-    pci_create_simple (bus, -1, TYPE_ES1370);
-    return 0;
-}
-
 static Property es1370_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
     DEFINE_PROP_END_OF_LIST(),
@@ -896,6 +890,7 @@ static void es1370_class_init (ObjectClass *klass, void=
 *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     k->realize =3D es1370_realize;
     k->exit =3D es1370_exit;
@@ -909,6 +904,7 @@ static void es1370_class_init (ObjectClass *klass, void=
 *data)
     dc->vmsd =3D &vmstate_es1370;
     dc->reset =3D es1370_on_reset;
     device_class_set_props(dc, es1370_properties);
+    sk->cmdline_name =3D "es1370";
 }
=20
 static const TypeInfo es1370_info =3D {
@@ -918,6 +914,7 @@ static const TypeInfo es1370_info =3D {
     .class_init    =3D es1370_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { SOUNDHW_CMDLINE_INTERFACE },
         { },
     },
 };
@@ -925,7 +922,6 @@ static const TypeInfo es1370_info =3D {
 static void es1370_register_types (void)
 {
     type_register_static (&es1370_info);
-    pci_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370", es1370_init)=
;
 }
=20
 type_init (es1370_register_types)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index eb4a803fb5..6ecf7f9a0a 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -292,12 +292,6 @@ static void gus_realizefn (DeviceState *dev, Error **e=
rrp)
     AUD_set_active_out (s->voice, 1);
 }
=20
-static int GUS_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_GUS);
-    return 0;
-}
-
 static Property gus_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(GUSState, card),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
@@ -310,12 +304,14 @@ static Property gus_properties[] =3D {
 static void gus_class_initfn (ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     dc->realize =3D gus_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc =3D "Gravis Ultrasound GF1";
     dc->vmsd =3D &vmstate_gus;
     device_class_set_props(dc, gus_properties);
+    sk->cmdline_name =3D "gus";
 }
=20
 static const TypeInfo gus_info =3D {
@@ -323,12 +319,15 @@ static const TypeInfo gus_info =3D {
     .parent        =3D TYPE_ISA_DEVICE,
     .instance_size =3D sizeof (GUSState),
     .class_init    =3D gus_class_initfn,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
 static void gus_register_types (void)
 {
     type_register_static (&gus_info);
-    isa_register_soundhw("gus", "Gravis Ultrasound GF1", GUS_init);
 }
=20
 type_init (gus_register_types)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index e8d18b7c58..77b4091433 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1281,11 +1281,15 @@ static const TypeInfo intel_hda_info_ich9 =3D {
 static void hda_codec_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k =3D DEVICE_CLASS(klass);
+    SoundHwCmdlineClass *shc =3D SOUNDHW_CMDLINE_CLASS(klass);
+
     k->realize =3D hda_codec_dev_realize;
     k->unrealize =3D hda_codec_dev_unrealize;
     set_bit(DEVICE_CATEGORY_SOUND, k->categories);
     k->bus_type =3D TYPE_HDA_BUS;
     device_class_set_props(k, hda_props);
+    k->desc =3D "Intel HD Audio";
+    shc->cmdline_name =3D "hda";
 }
=20
 static const TypeInfo hda_codec_device_type_info =3D {
@@ -1295,6 +1299,10 @@ static const TypeInfo hda_codec_device_type_info =3D=
 {
     .abstract =3D true,
     .class_size =3D sizeof(HDACodecDeviceClass),
     .class_init =3D hda_codec_device_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
 /*
@@ -1321,7 +1329,10 @@ static void intel_hda_register_types(void)
     type_register_static(&intel_hda_info_ich6);
     type_register_static(&intel_hda_info_ich9);
     type_register_static(&hda_codec_device_type_info);
-    pci_register_soundhw("hda", "Intel HD Audio", intel_hda_and_codec_init=
);
+
+    if (0) {
+        intel_hda_and_codec_init(NULL); /* XXX */
+    }
 }
=20
 type_init(intel_hda_register_types)
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 29dc00bf8d..f9aafea115 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -112,7 +112,7 @@ static void pcspk_callback(void *opaque, int free)
     }
 }
=20
-static int pcspk_audio_init(ISABus *bus)
+static int pcspk_audio_init(BusState *bus)
 {
     PCSpkState *s =3D pcspk_state;
     struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
@@ -218,14 +218,21 @@ static Property pcspk_properties[] =3D {
 static void pcspk_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     dc->realize =3D pcspk_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+    dc->desc =3D "PC speaker";
     dc->vmsd =3D &vmstate_spk;
     device_class_set_props(dc, pcspk_properties);
     /* Reason: realize sets global pcspk_state */
     /* Reason: pit object link */
     dc->user_creatable =3D false;
+    sk->cmdline_name =3D "pcspk";
+
+    if (0) {
+        pcspk_audio_init(NULL); /* XXX */
+    }
 }
=20
 static const TypeInfo pcspk_info =3D {
@@ -234,11 +241,14 @@ static const TypeInfo pcspk_info =3D {
     .instance_size  =3D sizeof(PCSpkState),
     .instance_init  =3D pcspk_initfn,
     .class_init     =3D pcspk_class_initfn,
+    .interfaces =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
-    isa_register_soundhw("pcspk", "PC speaker", pcspk_audio_init);
 }
 type_init(pcspk_register)
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index df6f755a37..e562338ad7 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1415,12 +1415,6 @@ static void sb16_realizefn (DeviceState *dev, Error =
**errp)
     AUD_register_card ("sb16", &s->card);
 }
=20
-static int SB16_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_SB16);
-    return 0;
-}
-
 static Property sb16_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
@@ -1434,12 +1428,14 @@ static Property sb16_properties[] =3D {
 static void sb16_class_initfn (ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS (klass);
+    SoundHwCmdlineClass *sk =3D SOUNDHW_CMDLINE_CLASS(klass);
=20
     dc->realize =3D sb16_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc =3D "Creative Sound Blaster 16";
     dc->vmsd =3D &vmstate_sb16;
     device_class_set_props(dc, sb16_properties);
+    sk->cmdline_name =3D "sb16";
 }
=20
 static const TypeInfo sb16_info =3D {
@@ -1448,12 +1444,15 @@ static const TypeInfo sb16_info =3D {
     .instance_size =3D sizeof (SB16State),
     .instance_init =3D sb16_initfn,
     .class_init    =3D sb16_class_initfn,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { SOUNDHW_CMDLINE_INTERFACE },
+        { },
+    },
 };
=20
 static void sb16_register_types (void)
 {
     type_register_static (&sb16_info);
-    isa_register_soundhw("sb16", "Creative Sound Blaster 16", SB16_init);
 }
=20
 type_init (sb16_register_types)
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index c750473c8f..1b495fddfb 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -31,125 +31,140 @@
=20
 struct soundhw {
     const char *name;
-    const char *descr;
-    int enabled;
-    int isa;
-    union {
-        int (*init_isa) (ISABus *bus);
-        int (*init_pci) (PCIBus *bus);
-    } init;
+    bool is_found;
 };
=20
-static struct soundhw soundhw[9];
-static int soundhw_count;
-
-void isa_register_soundhw(const char *name, const char *descr,
-                          int (*init_isa)(ISABus *bus))
+static gint soundhw_list_compare(gconstpointer a, gconstpointer b)
 {
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name =3D name;
-    soundhw[soundhw_count].descr =3D descr;
-    soundhw[soundhw_count].isa =3D 1;
-    soundhw[soundhw_count].init.init_isa =3D init_isa;
-    soundhw_count++;
+    SoundHwCmdlineClass *sc_a =3D SOUNDHW_CMDLINE_CLASS(a);
+    SoundHwCmdlineClass *sc_b =3D SOUNDHW_CMDLINE_CLASS(b);
+
+    return strcmp(sc_a->cmdline_name, sc_b->cmdline_name);
 }
=20
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus))
+static void soundhw_list_entry(gpointer data, gpointer user_data)
 {
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name =3D name;
-    soundhw[soundhw_count].descr =3D descr;
-    soundhw[soundhw_count].isa =3D 0;
-    soundhw[soundhw_count].init.init_pci =3D init_pci;
-    soundhw_count++;
+    SoundHwCmdlineClass *sc =3D SOUNDHW_CMDLINE_CLASS(data);
+    DeviceClass *dc =3D DEVICE_CLASS(data);
+
+    printf("%-11s %s\n", sc->cmdline_name, dc->desc);
+}
+
+static void soundhw_check_enable_entry(gpointer data, gpointer user_data)
+{
+    SoundHwCmdlineClass *sc =3D SOUNDHW_CMDLINE_CLASS(data);
+    struct soundhw *d =3D user_data;
+
+    if (g_str_equal(d->name, "all") || g_str_equal(d->name, sc->cmdline_na=
me)) {
+        sc->option_used =3D d->is_found =3D true;
+    }
+}
+
+static void soundhw_list(GSList *list)
+{
+    if (!list) {
+        printf("Machine has no user-selectable audio hardware "
+                "(it may or may not have always-present audio hardware).\n=
");
+        return;
+    }
+    list =3D g_slist_sort(list, soundhw_list_compare);
+    printf("Valid sound card names (comma separated):\n");
+    g_slist_foreach(list, soundhw_list_entry, NULL);
+    printf("\n-soundhw all will enable all of the above\n");
 }
=20
 void select_soundhw(const char *optarg)
 {
-    struct soundhw *c;
+    struct soundhw data;
+    GSList *list;
+
+    list =3D object_class_get_list(SOUNDHW_CMDLINE_INTERFACE, false);
=20
     if (is_help_option(optarg)) {
-    show_valid_cards:
-
-        if (soundhw_count) {
-             printf("Valid sound card names (comma separated):\n");
-             for (c =3D soundhw; c->name; ++c) {
-                 printf ("%-11s %s\n", c->name, c->descr);
-             }
-             printf("\n-soundhw all will enable all of the above\n");
-        } else {
-             printf("Machine has no user-selectable audio hardware "
-                    "(it may or may not have always-present audio hardware=
).\n");
-        }
-        exit(!is_help_option(optarg));
+        soundhw_list(list);
+        exit(0);
     }
-    else {
-        size_t l;
-        const char *p;
-        char *e;
-        int bad_card =3D 0;
=20
-        if (!strcmp(optarg, "all")) {
-            for (c =3D soundhw; c->name; ++c) {
-                c->enabled =3D 1;
+    if (strchr(optarg, ',')) {
+        char **parts =3D g_strsplit(optarg, ",", 0);
+        char **tmp;
+
+        for (tmp =3D parts; tmp && *tmp; tmp++) {
+            data =3D (struct soundhw){ .name =3D *tmp };
+            g_slist_foreach(list, soundhw_check_enable_entry, &data);
+            if (!data.is_found) {
+                goto invalid_name;
             }
-            return;
         }
-
-        p =3D optarg;
-        while (*p) {
-            e =3D strchr(p, ',');
-            l =3D !e ? strlen(p) : (size_t) (e - p);
-
-            for (c =3D soundhw; c->name; ++c) {
-                if (!strncmp(c->name, p, l) && !c->name[l]) {
-                    c->enabled =3D 1;
-                    break;
-                }
-            }
-
-            if (!c->name) {
-                if (l > 80) {
-                    error_report("Unknown sound card name (too big to show=
)");
-                }
-                else {
-                    error_report("Unknown sound card name `%.*s'",
-                                 (int) l, p);
-                }
-                bad_card =3D 1;
-            }
-            p +=3D l + (e !=3D NULL);
+        g_strfreev(parts);
+    } else {
+        data =3D (struct soundhw){ .name =3D optarg };
+        g_slist_foreach(list, soundhw_check_enable_entry, &data);
+        if (!data.is_found) {
+            goto invalid_name;
         }
+    }
+    g_slist_free(list);
+    return;
=20
-        if (bad_card) {
-            goto show_valid_cards;
+invalid_name:
+    error_report("Unknown sound card name `%s'", data.name);
+    soundhw_list(list);
+    exit(1);
+}
+
+static void soundhw_create_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc =3D data;
+    SoundHwCmdlineClass *sc =3D SOUNDHW_CMDLINE_CLASS(oc);
+    const char *typename =3D object_class_get_name(oc);
+    BusState *bus;
+
+    if (!sc->option_used) {
+        return;
+    }
+
+    warn_report("'-soundhw %s' is deprecated, please use '-device %s' inst=
ead",
+                sc->cmdline_name, typename);
+
+    if (object_class_dynamic_cast(oc, TYPE_ISA_DEVICE)) {
+        bus =3D (BusState *)object_resolve_path_type("", TYPE_ISA_BUS, NUL=
L);
+        if (!bus) {
+            error_report("ISA bus not available for %s", sc->cmdline_name)=
;
+            exit(1);
         }
+        isa_create_simple(ISA_BUS(bus), typename);
+    }
+    if (object_class_dynamic_cast(oc, TYPE_PCI_DEVICE)) {
+        bus =3D (BusState *)object_resolve_path_type("", TYPE_PCI_BUS, NUL=
L);
+        if (!bus) {
+            error_report("PCI bus not available for %s", sc->cmdline_name)=
;
+            exit(1);
+        }
+        pci_create_simple(PCI_BUS(bus), -1, typename);
     }
 }
=20
 void soundhw_init(void)
 {
-    struct soundhw *c;
-    ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA_B=
US, NULL);
-    PCIBus *pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI_B=
US, NULL);
+    GSList *list;
=20
-    for (c =3D soundhw; c->name; ++c) {
-        if (c->enabled) {
-            if (c->isa) {
-                if (!isa_bus) {
-                    error_report("ISA bus not available for %s", c->name);
-                    exit(1);
-                }
-                c->init.init_isa(isa_bus);
-            } else {
-                if (!pci_bus) {
-                    error_report("PCI bus not available for %s", c->name);
-                    exit(1);
-                }
-                c->init.init_pci(pci_bus);
-            }
-        }
+    list =3D object_class_get_list(SOUNDHW_CMDLINE_INTERFACE, false);
+    if (list) {
+        g_slist_foreach(list, soundhw_create_entry, NULL);
+        g_slist_free(list);
     }
 }
=20
+static const TypeInfo soundhw_interface_info =3D {
+    .name       =3D SOUNDHW_CMDLINE_INTERFACE,
+    .parent     =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(SoundHwCmdlineClass),
+};
+
+static void soundhw_register_types(void)
+{
+    type_register_static(&soundhw_interface_info);
+}
+
+type_init(soundhw_register_types)
--=20
2.21.1


