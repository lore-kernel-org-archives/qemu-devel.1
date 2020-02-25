Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9CC35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05B92082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6V2E-0000vd-0C
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j6V1g-0000Va-8E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j6V1e-0008UP-T2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:53:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3250 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1j6V1e-0008SM-IA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:53:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D58136A43795A35D16D8;
 Tue, 25 Feb 2020 15:52:59 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 15:52:49 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/smbios: add options for type 4 max_speed and current_speed
Date: Tue, 25 Feb 2020 15:50:46 +0800
Message-ID: <20200225075046.30151-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

Strictly speaking, the "max speed" and "current speed" in type 4
are not really for the max speed and current speed of processor, for
"max speed" identifies a capability of the system, and "current speed"
identifies the processor's speed at boot (see smbios spec), but some
applications do not tell the differences.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>

---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/smbios/smbios.c | 22 +++++++++++++++++++---
 qemu-options.hx    |  3 ++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ffd98727ee..1d5439643d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -94,6 +94,8 @@ static struct {
=20
 static struct {
     const char *sock_pfx, *manufacturer, *version, *serial, *asset, *par=
t;
+    uint32_t max_speed;
+    uint32_t current_speed;
 } type4;
=20
 static struct {
@@ -272,6 +274,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] =3D=
 {
         .name =3D "version",
         .type =3D QEMU_OPT_STRING,
         .help =3D "version number",
+    },{
+        .name =3D "max_speed",
+        .type =3D QEMU_OPT_NUMBER,
+        .help =3D "max speed in MHz",
+    },{
+        .name =3D "current_speed",
+        .type =3D QEMU_OPT_NUMBER,
+        .help =3D "speed at system boot in MHz",
     },{
         .name =3D "serial",
         .type =3D QEMU_OPT_STRING,
@@ -586,9 +596,8 @@ static void smbios_build_type_4_table(MachineState *m=
s, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
     t->voltage =3D 0;
     t->external_clock =3D cpu_to_le16(0); /* Unknown */
-    /* SVVP requires max_speed and current_speed to not be unknown. */
-    t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
-    t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
+    t->max_speed =3D cpu_to_le16(type4.max_speed);
+    t->current_speed =3D cpu_to_le16(type4.current_speed);
     t->status =3D 0x41; /* Socket populated, CPU enabled */
     t->processor_upgrade =3D 0x01; /* Other */
     t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
@@ -1129,6 +1138,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp=
)
             save_opt(&type4.serial, opts, "serial");
             save_opt(&type4.asset, opts, "asset");
             save_opt(&type4.part, opts, "part");
+            /*
+             * SVVP requires max_speed and current_speed to not be unkno=
wn, and
+             * we set the default value to 2000MHz as we did before.
+             */
+            type4.max_speed =3D qemu_opt_get_number(opts, "max_speed", 2=
000);
+            type4.current_speed =3D qemu_opt_get_number(opts, "current_s=
peed",
+                                                      2000);
             return;
         case 11:
             qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
diff --git a/qemu-options.hx b/qemu-options.hx
index ac315c1ac4..bc9ef0fda8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Ds=
tr][,serial=3Dstr]\n"
     "              [,asset=3Dstr][,part=3Dstr]\n"
+    "              [,max_speed=3D%d][,current_speed=3D%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr]=
[,serial=3Dstr]\n"
     "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
@@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
 @item -smbios type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][=
,serial=3D@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]
 Specify SMBIOS type 3 fields
=20
-@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}]=
[,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@=
var{str}]
+@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}]=
[,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@=
var{str}][,max_speed=3D@var{%d}][,current_speed=3D@var{%d}]
 Specify SMBIOS type 4 fields
=20
 @item -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufa=
cturer=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var=
{str}][,speed=3D@var{%d}]
--=20
2.19.1


