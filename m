Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8j-0003Ls-3Y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8e-000184-Vp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8e-00017s-MV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B77ABC057FA5
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:27 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:14:54 +0800
Message-Id: <20170714021509.23681-6-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/20] qdev: Add const qualifier to
 PropertyInfo definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The remaining non-const ones are in e1000e which modifies description at
runtime. They can be addressed separatedly.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/core/qdev-properties-system.c |  8 +++----
 hw/core/qdev-properties.c        | 44 +++++++++++++++++-----------------
 hw/s390x/css.c                   |  4 ++--
 hw/s390x/s390-pci-bus.c          |  2 +-
 include/hw/qdev-core.h           |  4 ++--
 include/hw/qdev-properties.h     | 52 ++++++++++++++++++++--------------------
 include/hw/s390x/css.h           |  4 ++--
 target/i386/cpu.c                |  2 +-
 target/ppc/translate_init.c      |  2 +-
 9 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3bef419..ec10da7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -159,7 +159,7 @@ static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
     set_pointer(obj, v, opaque, parse_drive, name, errp);
 }
 
-PropertyInfo qdev_prop_drive = {
+const PropertyInfo qdev_prop_drive = {
     .name  = "str",
     .description = "Node name or ID of a block device to use as a backend",
     .get   = get_drive,
@@ -228,7 +228,7 @@ static void release_chr(Object *obj, const char *name, void *opaque)
     qemu_chr_fe_deinit(be, false);
 }
 
-PropertyInfo qdev_prop_chr = {
+const PropertyInfo qdev_prop_chr = {
     .name  = "str",
     .description = "ID of a chardev to use as a backend",
     .get   = get_chr,
@@ -313,7 +313,7 @@ out:
     g_free(str);
 }
 
-PropertyInfo qdev_prop_netdev = {
+const PropertyInfo qdev_prop_netdev = {
     .name  = "str",
     .description = "ID of a netdev to use as a backend",
     .get   = get_netdev,
@@ -393,7 +393,7 @@ static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
     *ptr = hubport;
 }
 
-PropertyInfo qdev_prop_vlan = {
+const PropertyInfo qdev_prop_vlan = {
     .name  = "int32",
     .description = "Integer VLAN id to connect to",
     .print = print_vlan,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5429c63..f22bd71 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -132,7 +132,7 @@ static void set_default_value_bool(Object *obj, const Property *prop)
     object_property_set_bool(obj, prop->defval.u, prop->name, &error_abort);
 }
 
-PropertyInfo qdev_prop_bit = {
+const PropertyInfo qdev_prop_bit = {
     .name  = "bool",
     .description = "on/off",
     .get   = prop_get_bit,
@@ -191,7 +191,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
     bit64_prop_set(dev, prop, value);
 }
 
-PropertyInfo qdev_prop_bit64 = {
+const PropertyInfo qdev_prop_bit64 = {
     .name  = "bool",
     .description = "on/off",
     .get   = prop_get_bit64,
@@ -226,7 +226,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_bool(v, name, ptr, errp);
 }
 
-PropertyInfo qdev_prop_bool = {
+const PropertyInfo qdev_prop_bool = {
     .name  = "bool",
     .get   = get_bool,
     .set   = set_bool,
@@ -270,7 +270,7 @@ static void set_default_value_uint(Object *obj, const Property *prop)
     object_property_set_uint(obj, prop->defval.u, prop->name, &error_abort);
 }
 
-PropertyInfo qdev_prop_uint8 = {
+const PropertyInfo qdev_prop_uint8 = {
     .name  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
@@ -304,7 +304,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
     visit_type_uint16(v, name, ptr, errp);
 }
 
-PropertyInfo qdev_prop_uint16 = {
+const PropertyInfo qdev_prop_uint16 = {
     .name  = "uint16",
     .get   = get_uint16,
     .set   = set_uint16,
@@ -363,14 +363,14 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_int32(v, name, ptr, errp);
 }
 
-PropertyInfo qdev_prop_uint32 = {
+const PropertyInfo qdev_prop_uint32 = {
     .name  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
     .set_default_value = set_default_value_uint,
 };
 
-PropertyInfo qdev_prop_int32 = {
+const PropertyInfo qdev_prop_int32 = {
     .name  = "int32",
     .get   = get_int32,
     .set   = set_int32,
@@ -404,7 +404,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, ptr, errp);
 }
 
-PropertyInfo qdev_prop_uint64 = {
+const PropertyInfo qdev_prop_uint64 = {
     .name  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
@@ -457,7 +457,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
     *ptr = str;
 }
 
-PropertyInfo qdev_prop_string = {
+const PropertyInfo qdev_prop_string = {
     .name  = "str",
     .release = release_string,
     .get   = get_string,
@@ -467,7 +467,7 @@ PropertyInfo qdev_prop_string = {
 /* --- pointer --- */
 
 /* Not a proper property, just for dirty hacks.  TODO Remove it!  */
-PropertyInfo qdev_prop_ptr = {
+const PropertyInfo qdev_prop_ptr = {
     .name  = "ptr",
 };
 
@@ -541,7 +541,7 @@ inval:
     g_free(str);
 }
 
-PropertyInfo qdev_prop_macaddr = {
+const PropertyInfo qdev_prop_macaddr = {
     .name  = "str",
     .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
     .get   = get_mac,
@@ -550,7 +550,7 @@ PropertyInfo qdev_prop_macaddr = {
 
 /* --- on/off/auto --- */
 
-PropertyInfo qdev_prop_on_off_auto = {
+const PropertyInfo qdev_prop_on_off_auto = {
     .name = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = OnOffAuto_lookup,
@@ -563,7 +563,7 @@ PropertyInfo qdev_prop_on_off_auto = {
 
 QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 
-PropertyInfo qdev_prop_losttickpolicy = {
+const PropertyInfo qdev_prop_losttickpolicy = {
     .name  = "LostTickPolicy",
     .enum_table  = LostTickPolicy_lookup,
     .get   = get_enum,
@@ -575,7 +575,7 @@ PropertyInfo qdev_prop_losttickpolicy = {
 
 QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
 
-PropertyInfo qdev_prop_blockdev_on_error = {
+const PropertyInfo qdev_prop_blockdev_on_error = {
     .name = "BlockdevOnError",
     .description = "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
@@ -589,7 +589,7 @@ PropertyInfo qdev_prop_blockdev_on_error = {
 
 QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
 
-PropertyInfo qdev_prop_bios_chs_trans = {
+const PropertyInfo qdev_prop_bios_chs_trans = {
     .name = "BiosAtaTranslation",
     .description = "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
@@ -601,7 +601,7 @@ PropertyInfo qdev_prop_bios_chs_trans = {
 
 /* --- FDC default drive types */
 
-PropertyInfo qdev_prop_fdc_drive_type = {
+const PropertyInfo qdev_prop_fdc_drive_type = {
     .name = "FdcDriveType",
     .description = "FDC drive type, "
                    "144/288/120/none/auto",
@@ -677,7 +677,7 @@ static int print_pci_devfn(DeviceState *dev, Property *prop, char *dest,
     }
 }
 
-PropertyInfo qdev_prop_pci_devfn = {
+const PropertyInfo qdev_prop_pci_devfn = {
     .name  = "int32",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
@@ -726,7 +726,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     *ptr = value;
 }
 
-PropertyInfo qdev_prop_blocksize = {
+const PropertyInfo qdev_prop_blocksize = {
     .name  = "uint16",
     .description = "A power of two between 512 and 32768",
     .get   = get_uint16,
@@ -841,7 +841,7 @@ inval:
     g_free(str);
 }
 
-PropertyInfo qdev_prop_pci_host_devaddr = {
+const PropertyInfo qdev_prop_pci_host_devaddr = {
     .name = "str",
     .description = "Address (bus/device/function) of "
                    "the host device, example: 04:10.0",
@@ -950,7 +950,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     }
 }
 
-PropertyInfo qdev_prop_arraylen = {
+const PropertyInfo qdev_prop_arraylen = {
     .name = "uint32",
     .get = get_uint32,
     .set = set_prop_arraylen,
@@ -1208,7 +1208,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_size(v, name, ptr, errp);
 }
 
-PropertyInfo qdev_prop_size = {
+const PropertyInfo qdev_prop_size = {
     .name  = "size",
     .get = get_size,
     .set = set_size,
@@ -1228,7 +1228,7 @@ static void create_link_property(Object *obj, Property *prop, Error **errp)
                              errp);
 }
 
-PropertyInfo qdev_prop_link = {
+const PropertyInfo qdev_prop_link = {
     .name = "link",
     .create = create_link_property,
 };
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d67fffa..cd0b776 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2095,7 +2095,7 @@ out:
     g_free(str);
 }
 
-PropertyInfo css_devid_propinfo = {
+const PropertyInfo css_devid_propinfo = {
     .name = "str",
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
@@ -2103,7 +2103,7 @@ PropertyInfo css_devid_propinfo = {
     .set = set_css_devid,
 };
 
-PropertyInfo css_devid_ro_propinfo = {
+const PropertyInfo css_devid_ro_propinfo = {
     .name = "str",
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5651483..061e0c6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1018,7 +1018,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
     zpci->fid_defined = true;
 }
 
-static PropertyInfo s390_pci_fid_propinfo = {
+static const PropertyInfo s390_pci_fid_propinfo = {
     .name = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 08d1d2c..5348815 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -223,7 +223,7 @@ struct BusState {
 
 struct Property {
     const char   *name;
-    PropertyInfo *info;
+    const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
     union {
@@ -231,7 +231,7 @@ struct Property {
         uint64_t u;
     } defval;
     int          arrayoffset;
-    PropertyInfo *arrayinfo;
+    const PropertyInfo *arrayinfo;
     int          arrayfieldsize;
     const char   *link_type;
 };
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 876ba2e..f6692d5 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -5,32 +5,32 @@
 
 /*** qdev-properties.c ***/
 
-extern PropertyInfo qdev_prop_bit;
-extern PropertyInfo qdev_prop_bit64;
-extern PropertyInfo qdev_prop_bool;
-extern PropertyInfo qdev_prop_uint8;
-extern PropertyInfo qdev_prop_uint16;
-extern PropertyInfo qdev_prop_uint32;
-extern PropertyInfo qdev_prop_int32;
-extern PropertyInfo qdev_prop_uint64;
-extern PropertyInfo qdev_prop_size;
-extern PropertyInfo qdev_prop_string;
-extern PropertyInfo qdev_prop_chr;
-extern PropertyInfo qdev_prop_ptr;
-extern PropertyInfo qdev_prop_macaddr;
-extern PropertyInfo qdev_prop_on_off_auto;
-extern PropertyInfo qdev_prop_losttickpolicy;
-extern PropertyInfo qdev_prop_blockdev_on_error;
-extern PropertyInfo qdev_prop_bios_chs_trans;
-extern PropertyInfo qdev_prop_fdc_drive_type;
-extern PropertyInfo qdev_prop_drive;
-extern PropertyInfo qdev_prop_netdev;
-extern PropertyInfo qdev_prop_vlan;
-extern PropertyInfo qdev_prop_pci_devfn;
-extern PropertyInfo qdev_prop_blocksize;
-extern PropertyInfo qdev_prop_pci_host_devaddr;
-extern PropertyInfo qdev_prop_arraylen;
-extern PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_bit;
+extern const PropertyInfo qdev_prop_bit64;
+extern const PropertyInfo qdev_prop_bool;
+extern const PropertyInfo qdev_prop_uint8;
+extern const PropertyInfo qdev_prop_uint16;
+extern const PropertyInfo qdev_prop_uint32;
+extern const PropertyInfo qdev_prop_int32;
+extern const PropertyInfo qdev_prop_uint64;
+extern const PropertyInfo qdev_prop_size;
+extern const PropertyInfo qdev_prop_string;
+extern const PropertyInfo qdev_prop_chr;
+extern const PropertyInfo qdev_prop_ptr;
+extern const PropertyInfo qdev_prop_macaddr;
+extern const PropertyInfo qdev_prop_on_off_auto;
+extern const PropertyInfo qdev_prop_losttickpolicy;
+extern const PropertyInfo qdev_prop_blockdev_on_error;
+extern const PropertyInfo qdev_prop_bios_chs_trans;
+extern const PropertyInfo qdev_prop_fdc_drive_type;
+extern const PropertyInfo qdev_prop_drive;
+extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_vlan;
+extern const PropertyInfo qdev_prop_pci_devfn;
+extern const PropertyInfo qdev_prop_blocksize;
+extern const PropertyInfo qdev_prop_pci_host_devaddr;
+extern const PropertyInfo qdev_prop_arraylen;
+extern const PropertyInfo qdev_prop_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index eb0e26f..dc1001b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -112,7 +112,7 @@ typedef struct CssDevId {
     bool valid;
 } CssDevId;
 
-extern PropertyInfo css_devid_propinfo;
+extern const PropertyInfo css_devid_propinfo;
 
 #define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)
@@ -196,7 +196,7 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
 #endif
 
-extern PropertyInfo css_devid_ro_propinfo;
+extern const PropertyInfo css_devid_ro_propinfo;
 
 #define DEFINE_PROP_CSS_DEV_ID_RO(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, css_devid_ro_propinfo, CssDevId)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c571772..1b089c5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1961,7 +1961,7 @@ static void x86_set_hv_spinlocks(Object *obj, Visitor *v, const char *name,
     cpu->hyperv_spinlock_attempts = value;
 }
 
-static PropertyInfo qdev_prop_spinlocks = {
+static const PropertyInfo qdev_prop_spinlocks = {
     .name  = "int",
     .get   = x86_get_hv_spinlocks,
     .set   = x86_set_hv_spinlocks,
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 783bf98..ae25faf 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8435,7 +8435,7 @@ static void getset_compat_deprecated(Object *obj, Visitor *v, const char *name,
     visit_type_null(v, name, NULL);
 }
 
-static PropertyInfo ppc_compat_deprecated_propinfo = {
+static const PropertyInfo ppc_compat_deprecated_propinfo = {
     .name = "str",
     .description = "compatibility mode (deprecated)",
     .get = getset_compat_deprecated,
-- 
2.9.4
