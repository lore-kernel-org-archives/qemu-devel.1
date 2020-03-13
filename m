Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1017AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4B7206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTzECvmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4B7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpWx-0007U9-T4
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKc-0001Tz-V3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKY-0006to-TJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKY-0006sA-Ly
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4SQwCbFWUy50P8l7BxwLWnJYW4DO5O+iz10fDkk3+M=;
 b=MTzECvmonHpeqDvbzk1I4N57Mwk843j78sddsb4mwH68hKQ4MRQywBAs3eS2gBxZV1uNoT
 G5EoNzLT8OC0KxfvpSoA3+5wBAlnH2tlIWAPZUEUekhkWN+cA4w/dy1sPYZ1OHeoQqbLEB
 LilhE1sWKCP53PhZxXHQTA5gOe3mpGk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-2dBxM7HkOR-GIrWjGa1rjw-1; Fri, 13 Mar 2020 14:46:44 -0400
X-MC-Unique: 2dBxM7HkOR-GIrWjGa1rjw-1
Received: by mail-wr1-f69.google.com with SMTP id p5so4684231wrj.17
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vnd4FALpLmZJRwlR3ZCkvqTCWgLQJadL3Do3+SkONxU=;
 b=Of+X0vHXvRF22G/w9nbb22h9YMmhVuSf5KL/fwy9HyxKolNp/ym9XN1scEKJBxBrdy
 li+20aSLWSWOLEvFcLo7DHSpMSSAqctEvRRVaGYlvPRtq9Kr4WJTUoJ+7mq2qIguP3Vo
 Ct/T9d9HIVgHu9+oCCLo+BbAvO+Z/23Bn4KHGlS6Mk4kewLbyi1YJMZEYI+X7b3Ctzx2
 WLO4x/RSyUiM6MgDmFCQQ7zY2/4Bs6lZagClv36ePLWPOJJSKCWbDpRhGyH9yRW38qFo
 TA9YcV5rEFtnMqxH6XZEQw1+vnV0jW4EtTqiOMQM58FWq6Bal2n4iQkMW+oGoz/dx7p8
 mJug==
X-Gm-Message-State: ANhLgQ0xZqMMWDwaXbKfp+S1vsTzFNOfUrwQGRVU/SpfFKdcvB8FTAfh
 5tmpo6LubhZ8gIlC5buS+Mz5cc7p4AekkJq1WTMrYwrY3xxF7ETnVa1RFj78B0gZqbRPsOcze1p
 tcreCKvj8bpueApE=
X-Received: by 2002:adf:f652:: with SMTP id x18mr18892209wrp.299.1584125202420; 
 Fri, 13 Mar 2020 11:46:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4l4M1XvjP9mmFEV8EqovZ4vbWR25DaqhTlJV63J+BhTZG5Vp/OuD3KW5G/n/xEsdBrZQWOw==
X-Received: by 2002:adf:f652:: with SMTP id x18mr18892153wrp.299.1584125201751; 
 Fri, 13 Mar 2020 11:46:41 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id v15sm14680126wrm.32.2020.03.13.11.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] hw/core/qdev-properties: Extract system-mode specific
 properties
Date: Fri, 13 Mar 2020 19:46:05 +0100
Message-Id: <20200313184607.11792-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move properties specific to machines into a separate file.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-properties-system.c | 602 ++++++++++++++++++++++++++++++-
 hw/core/qdev-properties.c        | 590 ------------------------------
 2 files changed, 594 insertions(+), 598 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c
index 70bfd4809b..4fbb008544 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -11,19 +11,24 @@
  */
=20
 #include "qemu/osdep.h"
-#include "audio/audio.h"
-#include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qapi/qapi-types-block.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qdev-prop-internal.h"
+
+#include "audio/audio.h"
+#include "chardev/char-fe.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "hw/block/block.h"
-#include "net/hub.h"
-#include "qapi/visitor.h"
-#include "chardev/char-fe.h"
-#include "sysemu/iothread.h"
-#include "sysemu/tpm_backend.h"
+#include "net/net.h"
+#include "hw/pci/pci.h"
=20
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
                         char *(*print)(void *ptr),
@@ -273,6 +278,99 @@ const PropertyInfo qdev_prop_chr =3D {
     .release =3D release_chr,
 };
=20
+/* --- mac address --- */
+
+/*
+ * accepted syntax versions:
+ *   01:02:03:04:05:06
+ *   01-02-03-04-05-06
+ */
+static void get_mac(Object *obj, Visitor *v, const char *name, void *opaqu=
e,
+                    Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
+    char buffer[2 * 6 + 5 + 1];
+    char *p =3D buffer;
+
+    snprintf(buffer, sizeof(buffer), "%02x:%02x:%02x:%02x:%02x:%02x",
+             mac->a[0], mac->a[1], mac->a[2],
+             mac->a[3], mac->a[4], mac->a[5]);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_mac(Object *obj, Visitor *v, const char *name, void *opaqu=
e,
+                    Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    int i, pos;
+    char *str;
+    const char *p;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (i =3D 0, pos =3D 0; i < 6; i++, pos +=3D 3) {
+        long val;
+
+        if (!qemu_isxdigit(str[pos])) {
+            goto inval;
+        }
+        if (!qemu_isxdigit(str[pos + 1])) {
+            goto inval;
+        }
+        if (i =3D=3D 5) {
+            if (str[pos + 2] !=3D '\0') {
+                goto inval;
+            }
+        } else {
+            if (str[pos + 2] !=3D ':' && str[pos + 2] !=3D '-') {
+                goto inval;
+            }
+        }
+        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
+            goto inval;
+        }
+        mac->a[i] =3D val;
+    }
+    g_free(str);
+    return;
+
+inval:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_macaddr =3D {
+    .name  =3D "str",
+    .description =3D "Ethernet 6-byte MAC Address, example: 52:54:00:12:34=
:56",
+    .get   =3D get_mac,
+    .set   =3D set_mac,
+};
+
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value)
+{
+    char str[2 * 6 + 5 + 1];
+    snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
+             value[0], value[1], value[2], value[3], value[4], value[5]);
+
+    object_property_set_str(OBJECT(dev), str, name, &error_abort);
+}
+
 /* --- netdev device --- */
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
@@ -456,3 +554,491 @@ void qdev_set_nic_properties(DeviceState *dev, NICInf=
o *nd)
     }
     nd->instantiated =3D 1;
 }
+
+/* --- lost tick policy --- */
+
+QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof(int));
+
+const PropertyInfo qdev_prop_losttickpolicy =3D {
+    .name  =3D "LostTickPolicy",
+    .enum_table  =3D &LostTickPolicy_lookup,
+    .get   =3D qdev_propinfo_get_enum,
+    .set   =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- Block device error handling policy --- */
+
+QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) !=3D sizeof(int));
+
+const PropertyInfo qdev_prop_blockdev_on_error =3D {
+    .name =3D "BlockdevOnError",
+    .description =3D "Error handling policy, "
+                   "report/ignore/enospc/stop/auto",
+    .enum_table =3D &BlockdevOnError_lookup,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- BIOS CHS translation */
+
+QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) !=3D sizeof(int));
+
+const PropertyInfo qdev_prop_bios_chs_trans =3D {
+    .name =3D "BiosAtaTranslation",
+    .description =3D "Logical CHS translation algorithm, "
+                   "auto/none/lba/large/rechs",
+    .enum_table =3D &BiosAtaTranslation_lookup,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- FDC default drive types */
+
+const PropertyInfo qdev_prop_fdc_drive_type =3D {
+    .name =3D "FdcDriveType",
+    .description =3D "FDC drive type, "
+                   "144/288/120/none/auto",
+    .enum_table =3D &FloppyDriveType_lookup,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- blocksize --- */
+
+static void set_blocksize(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    uint16_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    const int64_t min =3D 512;
+    const int64_t max =3D 32768;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_uint16(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    /* value of 0 means "unset" */
+    if (value && (value < min || value > max)) {
+        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
+                   dev->id ? : "", name, (int64_t)value, min, max);
+        return;
+    }
+
+    /* We rely on power-of-2 blocksizes for bitmasks */
+    if ((value & (value - 1)) !=3D 0) {
+        error_setg(errp,
+                  "Property %s.%s doesn't take value '%" PRId64 "', "
+                  "it's not a power of 2", dev->id ?: "", name, (int64_t)v=
alue);
+        return;
+    }
+
+    *ptr =3D value;
+}
+
+const PropertyInfo qdev_prop_blocksize =3D {
+    .name  =3D "uint16",
+    .description =3D "A power of two between 512 and 32768",
+    .get   =3D qdev_propinfo_get_uint16,
+    .set   =3D set_blocksize,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
+};
+
+/* --- MultiFDCompression --- */
+
+const PropertyInfo qdev_prop_multifd_compression =3D {
+    .name =3D "MultiFDCompression",
+    .description =3D "multifd_compression values, "
+                   "none/zlib/zstd",
+    .enum_table =3D &MultiFDCompression_lookup,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- pci address --- */
+
+/*
+ * bus-local address, i.e. "$slot" or "$slot.$fn"
+ */
+static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    int32_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
+    unsigned int slot, fn, n;
+    Error *local_err =3D NULL;
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_free(local_err);
+        local_err =3D NULL;
+        visit_type_int32(v, name, &value, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        } else if (value < -1 || value > 255) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       name ? name : "null", "pci_devfn");
+        } else {
+            *ptr =3D value;
+        }
+        return;
+    }
+
+    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) !=3D 2) {
+        fn =3D 0;
+        if (sscanf(str, "%x%n", &slot, &n) !=3D 1) {
+            goto invalid;
+        }
+    }
+    if (str[n] !=3D '\0' || fn > 7 || slot > 31) {
+        goto invalid;
+    }
+    *ptr =3D slot << 3 | fn;
+    g_free(str);
+    return;
+
+invalid:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+static int print_pci_devfn(DeviceState *dev, Property *prop, char *dest,
+                           size_t len)
+{
+    int32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
+
+    if (*ptr =3D=3D -1) {
+        return snprintf(dest, len, "<unset>");
+    } else {
+        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
+    }
+}
+
+const PropertyInfo qdev_prop_pci_devfn =3D {
+    .name  =3D "int32",
+    .description =3D "Slot and optional function number, example: 06.0 or =
06",
+    .print =3D print_pci_devfn,
+    .get   =3D qdev_propinfo_get_int32,
+    .set   =3D set_pci_devfn,
+    .set_default_value =3D qdev_propinfo_set_default_value_int,
+};
+
+/* --- pci host address --- */
+
+static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name=
,
+                                 void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
+    char buffer[] =3D "ffff:ff:ff.f";
+    char *p =3D buffer;
+    int rc =3D 0;
+
+    /*
+     * Catch "invalid" device reference from vfio-pci and allow the
+     * default buffer representing the non-existent device to be used.
+     */
+    if (~addr->domain || ~addr->bus || ~addr->slot || ~addr->function) {
+        rc =3D snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%0d",
+                      addr->domain, addr->bus, addr->slot, addr->function)=
;
+        assert(rc =3D=3D sizeof(buffer) - 1);
+    }
+
+    visit_type_str(v, name, &p, errp);
+}
+
+/*
+ * Parse [<domain>:]<bus>:<slot>.<func>
+ *   if <domain> is not supplied, it's assumed to be 0.
+ */
+static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name=
,
+                                 void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    char *str, *p;
+    const char *e;
+    unsigned long val;
+    unsigned long dom =3D 0, bus =3D 0;
+    unsigned int slot =3D 0, func =3D 0;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    p =3D str;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e =3D=3D p) {
+        goto inval;
+    }
+    if (*e !=3D ':') {
+        goto inval;
+    }
+    bus =3D val;
+
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p) {
+        goto inval;
+    }
+    if (*e =3D=3D ':') {
+        dom =3D bus;
+        bus =3D val;
+        p =3D (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p)=
 {
+            goto inval;
+        }
+    }
+    slot =3D val;
+
+    if (*e !=3D '.') {
+        goto inval;
+    }
+    p =3D (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e =3D=3D p) {
+        goto inval;
+    }
+    func =3D val;
+
+    if (bus > 0xff) {
+        goto inval;
+    }
+
+    if (*e) {
+        goto inval;
+    }
+
+    addr->domain =3D dom;
+    addr->bus =3D bus;
+    addr->slot =3D slot;
+    addr->function =3D func;
+
+    g_free(str);
+    return;
+
+inval:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_pci_host_devaddr =3D {
+    .name =3D "str",
+    .description =3D "Address (bus/device/function) of "
+                   "the host device, example: 04:10.0",
+    .get =3D get_pci_host_devaddr,
+    .set =3D set_pci_host_devaddr,
+};
+
+/* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
+
+const PropertyInfo qdev_prop_off_auto_pcibar =3D {
+    .name =3D "OffAutoPCIBAR",
+    .description =3D "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
+    .enum_table =3D &OffAutoPCIBAR_lookup,
+    .get =3D qdev_propinfo_get_enum,
+    .set =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+
+static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *na=
me,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
+    int speed;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_2_5GT:
+        speed =3D PCIE_LINK_SPEED_2_5;
+        break;
+    case QEMU_PCI_EXP_LNK_5GT:
+        speed =3D PCIE_LINK_SPEED_5;
+        break;
+    case QEMU_PCI_EXP_LNK_8GT:
+        speed =3D PCIE_LINK_SPEED_8;
+        break;
+    case QEMU_PCI_EXP_LNK_16GT:
+        speed =3D PCIE_LINK_SPEED_16;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *na=
me,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
+    int speed;
+    Error *local_err =3D NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_=
err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (speed) {
+    case PCIE_LINK_SPEED_2_5:
+        *p =3D QEMU_PCI_EXP_LNK_2_5GT;
+        break;
+    case PCIE_LINK_SPEED_5:
+        *p =3D QEMU_PCI_EXP_LNK_5GT;
+        break;
+    case PCIE_LINK_SPEED_8:
+        *p =3D QEMU_PCI_EXP_LNK_8GT;
+        break;
+    case PCIE_LINK_SPEED_16:
+        *p =3D QEMU_PCI_EXP_LNK_16GT;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_speed =3D {
+    .name =3D "PCIELinkSpeed",
+    .description =3D "2_5/5/8/16",
+    .enum_table =3D &PCIELinkSpeed_lookup,
+    .get =3D get_prop_pcielinkspeed,
+    .set =3D set_prop_pcielinkspeed,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
+/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
+
+static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *na=
me,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIExpLinkWidth *p =3D qdev_get_prop_ptr(dev, prop);
+    int width;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_X1:
+        width =3D PCIE_LINK_WIDTH_1;
+        break;
+    case QEMU_PCI_EXP_LNK_X2:
+        width =3D PCIE_LINK_WIDTH_2;
+        break;
+    case QEMU_PCI_EXP_LNK_X4:
+        width =3D PCIE_LINK_WIDTH_4;
+        break;
+    case QEMU_PCI_EXP_LNK_X8:
+        width =3D PCIE_LINK_WIDTH_8;
+        break;
+    case QEMU_PCI_EXP_LNK_X12:
+        width =3D PCIE_LINK_WIDTH_12;
+        break;
+    case QEMU_PCI_EXP_LNK_X16:
+        width =3D PCIE_LINK_WIDTH_16;
+        break;
+    case QEMU_PCI_EXP_LNK_X32:
+        width =3D PCIE_LINK_WIDTH_32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *na=
me,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    PCIExpLinkWidth *p =3D qdev_get_prop_ptr(dev, prop);
+    int width;
+    Error *local_err =3D NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_=
err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (width) {
+    case PCIE_LINK_WIDTH_1:
+        *p =3D QEMU_PCI_EXP_LNK_X1;
+        break;
+    case PCIE_LINK_WIDTH_2:
+        *p =3D QEMU_PCI_EXP_LNK_X2;
+        break;
+    case PCIE_LINK_WIDTH_4:
+        *p =3D QEMU_PCI_EXP_LNK_X4;
+        break;
+    case PCIE_LINK_WIDTH_8:
+        *p =3D QEMU_PCI_EXP_LNK_X8;
+        break;
+    case PCIE_LINK_WIDTH_12:
+        *p =3D QEMU_PCI_EXP_LNK_X12;
+        break;
+    case PCIE_LINK_WIDTH_16:
+        *p =3D QEMU_PCI_EXP_LNK_X16;
+        break;
+    case PCIE_LINK_WIDTH_32:
+        *p =3D QEMU_PCI_EXP_LNK_X32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_width =3D {
+    .name =3D "PCIELinkWidth",
+    .description =3D "1/2/4/8/12/16/32",
+    .enum_table =3D &PCIELinkWidth_lookup,
+    .get =3D get_prop_pcielinkwidth,
+    .set =3D set_prop_pcielinkwidth,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 534fc674db..1fd256dd22 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,20 +1,11 @@
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
-#include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "hw/pci/pci.h"
-#include "qapi/qapi-types-block.h"
-#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-types-migration.h"
-#include "hw/block/block.h"
-#include "net/hub.h"
 #include "qapi/visitor.h"
-#include "chardev/char.h"
 #include "qemu/uuid.h"
 #include "qdev-prop-internal.h"
=20
@@ -513,89 +504,6 @@ const PropertyInfo qdev_prop_string =3D {
     .set   =3D set_string,
 };
=20
-/* --- mac address --- */
-
-/*
- * accepted syntax versions:
- *   01:02:03:04:05:06
- *   01-02-03-04-05-06
- */
-static void get_mac(Object *obj, Visitor *v, const char *name, void *opaqu=
e,
-                    Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
-    char buffer[2 * 6 + 5 + 1];
-    char *p =3D buffer;
-
-    snprintf(buffer, sizeof(buffer), "%02x:%02x:%02x:%02x:%02x:%02x",
-             mac->a[0], mac->a[1], mac->a[2],
-             mac->a[3], mac->a[4], mac->a[5]);
-
-    visit_type_str(v, name, &p, errp);
-}
-
-static void set_mac(Object *obj, Visitor *v, const char *name, void *opaqu=
e,
-                    Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
-    int i, pos;
-    char *str;
-    const char *p;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    for (i =3D 0, pos =3D 0; i < 6; i++, pos +=3D 3) {
-        long val;
-
-        if (!qemu_isxdigit(str[pos])) {
-            goto inval;
-        }
-        if (!qemu_isxdigit(str[pos + 1])) {
-            goto inval;
-        }
-        if (i =3D=3D 5) {
-            if (str[pos + 2] !=3D '\0') {
-                goto inval;
-            }
-        } else {
-            if (str[pos + 2] !=3D ':' && str[pos + 2] !=3D '-') {
-                goto inval;
-            }
-        }
-        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
-            goto inval;
-        }
-        mac->a[i] =3D val;
-    }
-    g_free(str);
-    return;
-
-inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-const PropertyInfo qdev_prop_macaddr =3D {
-    .name  =3D "str",
-    .description =3D "Ethernet 6-byte MAC Address, example: 52:54:00:12:34=
:56",
-    .get   =3D get_mac,
-    .set   =3D set_mac,
-};
-
 /* --- on/off/auto --- */
=20
 const PropertyInfo qdev_prop_on_off_auto =3D {
@@ -607,307 +515,6 @@ const PropertyInfo qdev_prop_on_off_auto =3D {
     .set_default_value =3D qdev_propinfo_set_default_value_enum,
 };
=20
-/* --- lost tick policy --- */
-
-QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof(int));
-
-const PropertyInfo qdev_prop_losttickpolicy =3D {
-    .name  =3D "LostTickPolicy",
-    .enum_table  =3D &LostTickPolicy_lookup,
-    .get   =3D qdev_propinfo_get_enum,
-    .set   =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- Block device error handling policy --- */
-
-QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) !=3D sizeof(int));
-
-const PropertyInfo qdev_prop_blockdev_on_error =3D {
-    .name =3D "BlockdevOnError",
-    .description =3D "Error handling policy, "
-                   "report/ignore/enospc/stop/auto",
-    .enum_table =3D &BlockdevOnError_lookup,
-    .get =3D qdev_propinfo_get_enum,
-    .set =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- BIOS CHS translation */
-
-QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) !=3D sizeof(int));
-
-const PropertyInfo qdev_prop_bios_chs_trans =3D {
-    .name =3D "BiosAtaTranslation",
-    .description =3D "Logical CHS translation algorithm, "
-                   "auto/none/lba/large/rechs",
-    .enum_table =3D &BiosAtaTranslation_lookup,
-    .get =3D qdev_propinfo_get_enum,
-    .set =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- FDC default drive types */
-
-const PropertyInfo qdev_prop_fdc_drive_type =3D {
-    .name =3D "FdcDriveType",
-    .description =3D "FDC drive type, "
-                   "144/288/120/none/auto",
-    .enum_table =3D &FloppyDriveType_lookup,
-    .get =3D qdev_propinfo_get_enum,
-    .set =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- MultiFDCompression --- */
-
-const PropertyInfo qdev_prop_multifd_compression =3D {
-    .name =3D "MultiFDCompression",
-    .description =3D "multifd_compression values, "
-                   "none/zlib/zstd",
-    .enum_table =3D &MultiFDCompression_lookup,
-    .get =3D qdev_propinfo_get_enum,
-    .set =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- pci address --- */
-
-/*
- * bus-local address, i.e. "$slot" or "$slot.$fn"
- */
-static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    int32_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
-    unsigned int slot, fn, n;
-    Error *local_err =3D NULL;
-    char *str;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_free(local_err);
-        local_err =3D NULL;
-        visit_type_int32(v, name, &value, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-        } else if (value < -1 || value > 255) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       name ? name : "null", "pci_devfn");
-        } else {
-            *ptr =3D value;
-        }
-        return;
-    }
-
-    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) !=3D 2) {
-        fn =3D 0;
-        if (sscanf(str, "%x%n", &slot, &n) !=3D 1) {
-            goto invalid;
-        }
-    }
-    if (str[n] !=3D '\0' || fn > 7 || slot > 31) {
-        goto invalid;
-    }
-    *ptr =3D slot << 3 | fn;
-    g_free(str);
-    return;
-
-invalid:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-static int print_pci_devfn(DeviceState *dev, Property *prop, char *dest,
-                           size_t len)
-{
-    int32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
-
-    if (*ptr =3D=3D -1) {
-        return snprintf(dest, len, "<unset>");
-    } else {
-        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
-    }
-}
-
-const PropertyInfo qdev_prop_pci_devfn =3D {
-    .name  =3D "int32",
-    .description =3D "Slot and optional function number, example: 06.0 or =
06",
-    .print =3D print_pci_devfn,
-    .get   =3D qdev_propinfo_get_int32,
-    .set   =3D set_pci_devfn,
-    .set_default_value =3D qdev_propinfo_set_default_value_uint,
-};
-
-/* --- blocksize --- */
-
-static void set_blocksize(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    uint16_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
-    const int64_t min =3D 512;
-    const int64_t max =3D 32768;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_uint16(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    /* value of 0 means "unset" */
-    if (value && (value < min || value > max)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   dev->id ? : "", name, (int64_t)value, min, max);
-        return;
-    }
-
-    /* We rely on power-of-2 blocksizes for bitmasks */
-    if ((value & (value - 1)) !=3D 0) {
-        error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', "
-                  "it's not a power of 2", dev->id ?: "", name, (int64_t)v=
alue);
-        return;
-    }
-
-    *ptr =3D value;
-}
-
-const PropertyInfo qdev_prop_blocksize =3D {
-    .name  =3D "uint16",
-    .description =3D "A power of two between 512 and 32768",
-    .get   =3D qdev_propinfo_get_uint16,
-    .set   =3D set_blocksize,
-    .set_default_value =3D qdev_propinfo_set_default_value_uint,
-};
-
-/* --- pci host address --- */
-
-static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name=
,
-                                 void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
-    char buffer[] =3D "ffff:ff:ff.f";
-    char *p =3D buffer;
-    int rc =3D 0;
-
-    /*
-     * Catch "invalid" device reference from vfio-pci and allow the
-     * default buffer representing the non-existent device to be used.
-     */
-    if (~addr->domain || ~addr->bus || ~addr->slot || ~addr->function) {
-        rc =3D snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%0d",
-                      addr->domain, addr->bus, addr->slot, addr->function)=
;
-        assert(rc =3D=3D sizeof(buffer) - 1);
-    }
-
-    visit_type_str(v, name, &p, errp);
-}
-
-/*
- * Parse [<domain>:]<bus>:<slot>.<func>
- *   if <domain> is not supplied, it's assumed to be 0.
- */
-static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name=
,
-                                 void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
-    char *str, *p;
-    const char *e;
-    unsigned long val;
-    unsigned long dom =3D 0, bus =3D 0;
-    unsigned int slot =3D 0, func =3D 0;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    p =3D str;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e =3D=3D p) {
-        goto inval;
-    }
-    if (*e !=3D ':') {
-        goto inval;
-    }
-    bus =3D val;
-
-    p =3D (char *)e + 1;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p) {
-        goto inval;
-    }
-    if (*e =3D=3D ':') {
-        dom =3D bus;
-        bus =3D val;
-        p =3D (char *)e + 1;
-        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e =3D=3D p)=
 {
-            goto inval;
-        }
-    }
-    slot =3D val;
-
-    if (*e !=3D '.') {
-        goto inval;
-    }
-    p =3D (char *)e + 1;
-    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e =3D=3D p) {
-        goto inval;
-    }
-    func =3D val;
-
-    if (bus > 0xff) {
-        goto inval;
-    }
-
-    if (*e) {
-        goto inval;
-    }
-
-    addr->domain =3D dom;
-    addr->bus =3D bus;
-    addr->slot =3D slot;
-    addr->function =3D func;
-
-    g_free(str);
-    return;
-
-inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-const PropertyInfo qdev_prop_pci_host_devaddr =3D {
-    .name =3D "str",
-    .description =3D "Address (bus/device/function) of "
-                   "the host device, example: 04:10.0",
-    .get =3D get_pci_host_devaddr,
-    .set =3D set_pci_host_devaddr,
-};
-
 /* --- UUID --- */
=20
 static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaq=
ue,
@@ -1167,16 +774,6 @@ void qdev_prop_set_string(DeviceState *dev, const cha=
r *name, const char *value)
     object_property_set_str(OBJECT(dev), value, name, &error_abort);
 }
=20
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
-                           const uint8_t *value)
-{
-    char str[2 * 6 + 5 + 1];
-    snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
-             value[0], value[1], value[2], value[3], value[4], value[5]);
-
-    object_property_set_str(OBJECT(dev), str, name, &error_abort);
-}
-
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 {
     Property *prop;
@@ -1285,190 +882,3 @@ const PropertyInfo qdev_prop_link =3D {
     .name =3D "link",
     .create =3D create_link_property,
 };
-
-/* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
-
-const PropertyInfo qdev_prop_off_auto_pcibar =3D {
-    .name =3D "OffAutoPCIBAR",
-    .description =3D "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
-    .enum_table =3D &OffAutoPCIBAR_lookup,
-    .get =3D qdev_propinfo_get_enum,
-    .set =3D qdev_propinfo_set_enum,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- PCIELinkSpeed 2_5/5/8/16 -- */
-
-static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
-    int speed;
-
-    switch (*p) {
-    case QEMU_PCI_EXP_LNK_2_5GT:
-        speed =3D PCIE_LINK_SPEED_2_5;
-        break;
-    case QEMU_PCI_EXP_LNK_5GT:
-        speed =3D PCIE_LINK_SPEED_5;
-        break;
-    case QEMU_PCI_EXP_LNK_8GT:
-        speed =3D PCIE_LINK_SPEED_8;
-        break;
-    case QEMU_PCI_EXP_LNK_16GT:
-        speed =3D PCIE_LINK_SPEED_16;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
-}
-
-static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
-    int speed;
-    Error *local_err =3D NULL;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_=
err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    switch (speed) {
-    case PCIE_LINK_SPEED_2_5:
-        *p =3D QEMU_PCI_EXP_LNK_2_5GT;
-        break;
-    case PCIE_LINK_SPEED_5:
-        *p =3D QEMU_PCI_EXP_LNK_5GT;
-        break;
-    case PCIE_LINK_SPEED_8:
-        *p =3D QEMU_PCI_EXP_LNK_8GT;
-        break;
-    case PCIE_LINK_SPEED_16:
-        *p =3D QEMU_PCI_EXP_LNK_16GT;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-}
-
-const PropertyInfo qdev_prop_pcie_link_speed =3D {
-    .name =3D "PCIELinkSpeed",
-    .description =3D "2_5/5/8/16",
-    .enum_table =3D &PCIELinkSpeed_lookup,
-    .get =3D get_prop_pcielinkspeed,
-    .set =3D set_prop_pcielinkspeed,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
-
-/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
-
-static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIExpLinkWidth *p =3D qdev_get_prop_ptr(dev, prop);
-    int width;
-
-    switch (*p) {
-    case QEMU_PCI_EXP_LNK_X1:
-        width =3D PCIE_LINK_WIDTH_1;
-        break;
-    case QEMU_PCI_EXP_LNK_X2:
-        width =3D PCIE_LINK_WIDTH_2;
-        break;
-    case QEMU_PCI_EXP_LNK_X4:
-        width =3D PCIE_LINK_WIDTH_4;
-        break;
-    case QEMU_PCI_EXP_LNK_X8:
-        width =3D PCIE_LINK_WIDTH_8;
-        break;
-    case QEMU_PCI_EXP_LNK_X12:
-        width =3D PCIE_LINK_WIDTH_12;
-        break;
-    case QEMU_PCI_EXP_LNK_X16:
-        width =3D PCIE_LINK_WIDTH_16;
-        break;
-    case QEMU_PCI_EXP_LNK_X32:
-        width =3D PCIE_LINK_WIDTH_32;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
-}
-
-static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    PCIExpLinkWidth *p =3D qdev_get_prop_ptr(dev, prop);
-    int width;
-    Error *local_err =3D NULL;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_=
err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    switch (width) {
-    case PCIE_LINK_WIDTH_1:
-        *p =3D QEMU_PCI_EXP_LNK_X1;
-        break;
-    case PCIE_LINK_WIDTH_2:
-        *p =3D QEMU_PCI_EXP_LNK_X2;
-        break;
-    case PCIE_LINK_WIDTH_4:
-        *p =3D QEMU_PCI_EXP_LNK_X4;
-        break;
-    case PCIE_LINK_WIDTH_8:
-        *p =3D QEMU_PCI_EXP_LNK_X8;
-        break;
-    case PCIE_LINK_WIDTH_12:
-        *p =3D QEMU_PCI_EXP_LNK_X12;
-        break;
-    case PCIE_LINK_WIDTH_16:
-        *p =3D QEMU_PCI_EXP_LNK_X16;
-        break;
-    case PCIE_LINK_WIDTH_32:
-        *p =3D QEMU_PCI_EXP_LNK_X32;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-}
-
-const PropertyInfo qdev_prop_pcie_link_width =3D {
-    .name =3D "PCIELinkWidth",
-    .description =3D "1/2/4/8/12/16/32",
-    .enum_table =3D &PCIELinkWidth_lookup,
-    .get =3D get_prop_pcielinkwidth,
-    .set =3D set_prop_pcielinkwidth,
-    .set_default_value =3D qdev_propinfo_set_default_value_enum,
-};
--=20
2.21.1


