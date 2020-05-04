Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC522C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9713A20661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBTEMgDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9713A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVY20-0007J5-NO
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVY0p-0005Av-81; Mon, 04 May 2020 06:07:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVY0o-0002jx-BR; Mon, 04 May 2020 06:07:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id x18so20225026wrq.2;
 Mon, 04 May 2020 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3T0kMXUkml3SPOC+ozrWaQIIxf6I2/xjXP4RZGOc7C0=;
 b=LBTEMgDf21d8EYLLYw4CGG8/pL52gzKDRRi3VpCUJkbuls2ghqJPmeqte7XWNL48LH
 yjrNEpeDOF2wVYy7hldkagWzQZyJ4GoaA5Xw3rfxXfAT9JUt9c8cNu9LNmG3XRrExNfM
 fc8NKqKVYT4RuesNvayTEZbl5oTDlvJIiUlfhnMiNe0OXJr50hTT6BDfBeRubK/qchuw
 V3Mv+fiB8qlXR3PVSs+GjbRyZ51EksoO3hlE8DqHlBz9/TDKBdGBqpvfvMFTF5BejsdB
 3pNHSONBxGghtv3FJuU6wXa+q2LpRPbagT1YWxHvcfEJyDFnzPDeLEK6EnH4dwSG3kcv
 U8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3T0kMXUkml3SPOC+ozrWaQIIxf6I2/xjXP4RZGOc7C0=;
 b=qAOgTzS8wp/+7GFDDAN62m9DQllBobFpRk/hFpSNr5OTG32tLFHepFxHtucrkAbTTQ
 rVtukBLRLMzX8f9d+GwGDQxlRqOuDAOjACtx7hKIBh2F+ESZG7JO6SS7cy9dHpCxgbOI
 l78fsCDG4lDs+vquhc0fiW3boIDTue1Wa+qlw3Rhg/HpnzeeO+S7ffbMQbmr+ShQ9zGf
 xLSQUFuv05arQ0ievrDg3BGaeyWDPZIKRDY2Bvz7h5xqjkZ3Q0JmwH9J06CyJu8wugw/
 4qL3ZyTUWJmRYtAh8CV7YT9M/YG4X7YlIvKzw77JkXvILjxTjMekKvPmkqJZH8emhIHC
 dsXA==
X-Gm-Message-State: AGi0PubcZ9wkFY1ZvjF/N+UkklL0hFtBKFUrElPlMfvKgkCz91osvAua
 CtI+rgxe8zzQXAIXhap8i6D6/h+5v8Q=
X-Google-Smtp-Source: APiQypJBR0VsXTUOks5yliB8aAc5q8D6l3Gg5z/mv3Da0c8XMYX7HdFCNrgqVwjEZd9i5aQQrfLYZw==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr17727689wrr.131.1588586862825; 
 Mon, 04 May 2020 03:07:42 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k9sm18517778wrd.17.2020.05.04.03.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 03:07:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] various: Remove unnecessary OBJECT() cast
Date: Mon,  4 May 2020 12:07:34 +0200
Message-Id: <20200504100735.10269-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504100735.10269-1-f4bug@amsat.org>
References: <20200504100735.10269-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The OBJECT() macro is defined as:

  #define OBJECT(obj) ((Object *)(obj))

which expands to:

  ((Object *)object_dynamic_cast_assert((Object *)(obj), (name),
                                        __FILE__, __LINE__, __func__))

This assertion can only fail when @obj points to something other
than its stated type, i.e. when we're in undefined behavior country.

Remove the unnecessary OBJECT() casts when we already know the
pointer is of Object type.

Patch created mechanically using spatch with this script:

  @@
  typedef Object;
  Object *o;
  @@
  -   OBJECT(o)
  +   o

Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Acked-by: John Snow <jsnow@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Reword (Markus)
---
 hw/core/bus.c                       | 2 +-
 hw/ide/ahci-allwinner.c             | 2 +-
 hw/ipmi/smbus_ipmi.c                | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c | 8 ++++----
 hw/s390x/sclp.c                     | 2 +-
 monitor/misc.c                      | 3 +--
 qom/object.c                        | 4 ++--
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 3dc0a825f0..4ea5870de8 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -25,7 +25,7 @@
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
 {
-    object_property_set_link(OBJECT(bus), OBJECT(handler),
+    object_property_set_link(OBJECT(bus), handler,
                              QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
 }
 
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index bb8393d2b6..8536b9eb5a 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -90,7 +90,7 @@ static void allwinner_ahci_init(Object *obj)
     SysbusAHCIState *s = SYSBUS_AHCI(obj);
     AllwinnerAHCIState *a = ALLWINNER_AHCI(obj);
 
-    memory_region_init_io(&a->mmio, OBJECT(obj), &allwinner_ahci_mem_ops, a,
+    memory_region_init_io(&a->mmio, obj, &allwinner_ahci_mem_ops, a,
                           "allwinner-ahci", ALLWINNER_AHCI_MMIO_SIZE);
     memory_region_add_subregion(&s->ahci.mem, ALLWINNER_AHCI_MMIO_OFF,
                                 &a->mmio);
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index 2a9470d9df..f1a0148755 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -329,7 +329,7 @@ static void smbus_ipmi_init(Object *obj)
 {
     SMBusIPMIDevice *sid = SMBUS_IPMI(obj);
 
-    ipmi_bmc_find_and_link(OBJECT(obj), (Object **) &sid->bmc);
+    ipmi_bmc_find_and_link(obj, (Object **) &sid->bmc);
 }
 
 static void smbus_ipmi_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 0a2640c40b..52dcea9abd 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -150,9 +150,9 @@ petalogix_ml605_init(MachineState *machine)
     qdev_set_nic_properties(eth0, &nd_table[0]);
     qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
     qdev_prop_set_uint32(eth0, "txmem", 0x1000);
-    object_property_set_link(OBJECT(eth0), OBJECT(ds),
+    object_property_set_link(OBJECT(eth0), ds,
                              "axistream-connected", &error_abort);
-    object_property_set_link(OBJECT(eth0), OBJECT(cs),
+    object_property_set_link(OBJECT(eth0), cs,
                              "axistream-control-connected", &error_abort);
     qdev_init_nofail(eth0);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
@@ -163,9 +163,9 @@ petalogix_ml605_init(MachineState *machine)
     cs = object_property_get_link(OBJECT(eth0),
                                   "axistream-control-connected-target", NULL);
     qdev_prop_set_uint32(dma, "freqhz", 100 * 1000000);
-    object_property_set_link(OBJECT(dma), OBJECT(ds),
+    object_property_set_link(OBJECT(dma), ds,
                              "axistream-connected", &error_abort);
-    object_property_set_link(OBJECT(dma), OBJECT(cs),
+    object_property_set_link(OBJECT(dma), cs,
                              "axistream-control-connected", &error_abort);
     qdev_init_nofail(dma);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index ede056b3ef..4132286db7 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -322,7 +322,7 @@ void s390_sclp_init(void)
 
     object_property_add_child(qdev_get_machine(), TYPE_SCLP, new,
                               NULL);
-    object_unref(OBJECT(new));
+    object_unref(new);
     qdev_init_nofail(DEVICE(new));
 }
 
diff --git a/monitor/misc.c b/monitor/misc.c
index 6c45fa490f..57af5fa5a4 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1839,8 +1839,7 @@ void object_add_completion(ReadLineState *rs, int nb_args, const char *str)
 static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
 {
     GSList **list = opaque;
-    DeviceState *dev = (DeviceState *)object_dynamic_cast(OBJECT(obj),
-                                                          TYPE_DEVICE);
+    DeviceState *dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
 
     if (dev == NULL) {
         return 0;
diff --git a/qom/object.c b/qom/object.c
index be700e831f..07c1443d0e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -762,7 +762,7 @@ Object *object_new_with_propv(const char *typename,
         }
     }
 
-    object_unref(OBJECT(obj));
+    object_unref(obj);
     return obj;
 
  error:
@@ -1687,7 +1687,7 @@ void object_property_add_child(Object *obj, const char *name,
         return;
     }
 
-    type = g_strdup_printf("child<%s>", object_get_typename(OBJECT(child)));
+    type = g_strdup_printf("child<%s>", object_get_typename(child));
 
     op = object_property_add(obj, name, type, object_get_child_property, NULL,
                              object_finalize_child_property, child, &local_err);
-- 
2.21.3


