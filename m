Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E86C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C46420770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hp.com header.i=@hp.com header.b="W35AWzn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C46420770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGMl-0007re-8D
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kIGLR-0006je-OG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:10:25 -0400
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:38916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kIGLO-0001PT-Jx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1600197021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0APxmKDmjPSFU8WlOkNAV6Up2G4IHdrg6mXItJ4g3o=;
 b=W35AWzn71fadX5dMcjTpOVQZiNDCcouv8VmKi86cGCPbAs79YHDWCRvcvli/EeyGuEaLz9
 jRJcMpiOAtUlWlKrZIh9bhQqWv79mqCEe77CGJ/cCs4BB3+XXB8aqhUzObTm3fOle/frcw
 isDDXFriqOXkhUkVlbCN0ENL/7wQlAk=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-cJQwplOXP1S1aTW5L2yDQA-1; Tue, 15 Sep 2020 15:10:19 -0400
X-MC-Unique: cJQwplOXP1S1aTW5L2yDQA-1
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::9) by CS1PR8401MB0965.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7508::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 19:10:16 +0000
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c]) by CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c%12]) with mapi id 15.20.3370.019; Tue, 15 Sep
 2020 19:10:16 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: Re: PATCH: Increase System Firmware Max Size
Thread-Topic: PATCH: Increase System Firmware Max Size
Thread-Index: AQHWh9wbvH3PA15ju0WtYVYwRPIQ7qlqFivMgAABqbE=
Date: Tue, 15 Sep 2020 19:10:16 +0000
Message-ID: <CS1PR8401MB03279AC1D869BBBA8D810A19F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>,
 <CS1PR8401MB0327959D96C84FB32E071E49F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB0327959D96C84FB32E071E49F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.199.17.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eecb2917-eb58-48db-0f2a-08d859aafb32
x-ms-traffictypediagnostic: CS1PR8401MB0965:
x-microsoft-antispam-prvs: <CS1PR8401MB0965772938C6A5D4D83BEC7CF3200@CS1PR8401MB0965.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMj4lpfmxaM46Uhffu28po/vJ9DMqBxX26NrJtOdX4R3Ho6Xiy8Pq0bYCa3IDOZKEg/rz9gzrHubpD/crCmEwOEmcIc60ZTLAI5YDxszRIpFfielFAO2F1CyJvwBT9iWAP7v/M+kR19bTbSNqyeYNGRsc+OzfAGU2aRn3U89L9pDm9DmlM6klqmO/h4MmeweyV3mqtqNIMhRJcykoWy7iFuEVXc6Dqa2WczmCT2bc6/Lnsr4zea1W/ZnEmY5slj1c1XBUQVCOdjV/8jK2DnHVOj9N5DVzCDkwO5KymlKfRzQaKosMrtAR1eXeLF4GBxrVPchCv6fRFrtmB0LLZMI8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(316002)(7696005)(54906003)(478600001)(2906002)(9686003)(55016002)(8936002)(4326008)(2940100002)(6506007)(53546011)(71200400001)(76116006)(26005)(66946007)(6916009)(186003)(19627405001)(52536014)(66476007)(64756008)(66556008)(30864003)(8676002)(5660300002)(86362001)(33656002)(66446008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VUac7EAD5CeNDd4uOS20T0yLhPxObCbXeVVSQIQhqXw6I+3QHSxmU6K0hLMEitR4cktnic0DZ8U52aV+9UlR9aF79ncDuIPgINnctTadfwxcHe9Mf40jz9ZXxxxAlZEN48Xll5eBcstBn+IgQ2xMbLx3c4ftEB99KG8NTe5Kt1KM7bhVFjpoC9/3NKoSwVRGBNUG1EeI8p1g8bbCOa0NJ7d53WIv5UDzQEE1tEL9k9SoJMNhzJ5xsWGYNwaok4zyX7XHkMW96JGoHU6Q9p3SuKHNqm+GuA0/Fk011781MTEzW7IKB1GT45txUGTJblbo5WUVaDNhBVBf02yqXO9XQDkmvwYcYMcr/j/jCGeOL73MRCiOxRoFvWQ+KSPJTPW3G1fT/MCuwk8mOmNAR2h4WZLLGdtc+cImQWpnCPtY4gMpwqZXinCD9oBR01AzdE1ruJCHv5QRfsX7QH9lUXq1L84EeCWgD5SJN06DuuHqrjeD88R3PqUxpRg1lus3mj73VKBaBex8AcPrenqRUq5ISqhJSyW5Cgqj+siwNZjejexmX2knraRgP/MfxRSSmVAhJnQBZ68ewvh6Sv7YXQpM/dAV6XLIPYI1SAuF2HQP/IXRLs8XoK4To72IR0bqz2B/SYjtb9hxiCzHEfKvxvbu4w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb2917-eb58-48db-0f2a-08d859aafb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 19:10:16.4780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wapl6MZ/FJVMQxqdpwq7yI01orV7zGqdn78ip6t0FUiDEy/Rmb0NnAACf//Vm0701XiUwS6JvXc7MEcFGV9Qzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0965
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: hp.com
Content-Type: multipart/alternative;
 boundary="_000_CS1PR8401MB03279AC1D869BBBA8D810A19F3200CS1PR8401MB0327_"
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.162; envelope-from=erich.mcmillan@hp.com;
 helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 15:10:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: "McMillan, Erich" <erich.mcmillan@hp.com>
From: "McMillan, Erich" via <qemu-devel@nongnu.org>

--_000_CS1PR8401MB03279AC1D869BBBA8D810A19F3200CS1PR8401MB0327_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Apologies, ignore previous patch. The relevant patch is below:

From 473daf6129debf8d158a9ae1aff788c5bdbbc799 Mon Sep 17 00:00:00 2001
From: Erich McMillan <erich.mcmillan@hp.com>
Date: Tue, 15 Sep 2020 13:23:25 -0500
Subject: [PATCH 2/2] Add max firmware size as optional parameter

Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
---
 hw/i386/pc_sysfw.c  | 13 ++-----------
 include/hw/loader.h |  9 +++++++++
 qemu-options.hx     |  8 ++++++++
 softmmu/vl.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b6c0822..ba6c99d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -39,15 +39,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"

-/*
- * We don't have a theoretically justifiable exact lower bound on the base
- * address of any flash mapping. In practice, the IO-APIC MMIO range is
- * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving fre=
e
- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
- * size.
- */
-#define FLASH_SIZE_LIMIT (8 * MiB)
-
 #define FLASH_SECTOR_SIZE 4096

 static void pc_isa_bios_init(MemoryRegion *rom_memory,
@@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
         }
         if ((hwaddr)size !=3D size
             || total_size > HWADDR_MAX - size
-            || total_size + size > FLASH_SIZE_LIMIT) {
+            || total_size + size > MaxCombinedFirmwareSize) {
             error_report("combined size of system firmware exceeds "
                          "%" PRIu64 " bytes",
-                         FLASH_SIZE_LIMIT);
+                         MaxCombinedFirmwareSize);
             exit(1);
         }

diff --git a/include/hw/loader.h b/include/hw/loader.h
index a9eeea3..7898b63 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -318,4 +318,13 @@ int rom_add_option(const char *file, int32_t bootindex=
);
  * overflow on real hardware too. */
 #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)

+/*
+ * We don't have a theoretically justifiable exact lower bound on the base
+ * address of any flash mapping. In practice, the IO-APIC MMIO range is
+ * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving fre=
e
+ * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
+ * size, but allow user to specify larger size via command line.
+ */
+extern uint64_t MaxCombinedFirmwareSize;
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index b0f0205..32eed3a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1377,6 +1377,14 @@ SRST
         |qemu_system_x86| -hda a -hdb b
 ERST

+DEF("maxfirmwaresize", HAS_ARG, QEMU_OPTION_maxfirmwaresize,
+    "-maxfirmwaresize [size=3D]megs  specify maximum combined firmware siz=
e, default is 8MiB. Known issues if value exceeds 16MiB.\n",
+    QEMU_ARCH_ALL)
+SRST
+``-maxfirmwaresize [size=3D]megs``
+    Specify maximum combined firmware size, default is 8MiB. Known issues =
if value exceeds 16MiB.
+ERST
+
 DEF("mtdblock", HAS_ARG, QEMU_OPTION_mtdblock,
     "-mtdblock file  use 'file' as on-board Flash memory image\n",
     QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0cc86b0..fcf41d2 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -116,6 +116,8 @@

 #define MAX_VIRTIO_CONSOLES 1

+uint64_t MaxCombinedFirmwareSize =3D 8 * MiB;
+
 static const char *data_dir[16];
 static int data_dir_idx;
 const char *bios_name =3D NULL;
@@ -448,6 +450,20 @@ static QemuOptsList qemu_mem_opts =3D {
     },
 };

+static QemuOptsList qemu_max_fw_size_opts =3D {
+    .name =3D "maxfirmwaresize",
+    .implied_opt_name =3D "size",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_max_fw_size_opts.head),
+    .merge_lists =3D true,
+    .desc =3D {
+        {
+            .name =3D "size",
+            .type =3D QEMU_OPT_SIZE,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_icount_opts =3D {
     .name =3D "icount",
     .implied_opt_name =3D "shift",
@@ -2576,6 +2592,23 @@ static bool object_create_delayed(const char *type, =
QemuOpts *opts)
     return !object_create_initial(type, opts);
 }

+static void set_max_firmware_size(uint64_t *maxfwsize)
+{
+    const char *max_fw_size_str;
+    QemuOpts *opts =3D qemu_find_opts_singleton("maxfirmwaresize");
+
+    max_fw_size_str =3D qemu_opt_get(opts, "size");
+
+    if (max_fw_size_str) {
+        if (!*max_fw_size_str) {
+            error_report("missing 'size' option value");
+            exit(EXIT_FAILURE);
+        }
+
+        *maxfwsize =3D qemu_opt_get_size(opts, "size", 8 * MiB);
+    }
+}
+

 static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_siz=
e,
                                MachineClass *mc)
@@ -2904,6 +2937,7 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
     qemu_add_opts(&qemu_mem_opts);
+    qemu_add_opts(&qemu_max_fw_size_opts);
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
     qemu_add_opts(&qemu_add_fd_opts);
@@ -3160,6 +3194,10 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(EXIT_FAILURE);
                 }
                 break;
+            case QEMU_OPTION_maxfirmwaresize:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("maxfirmwa=
resize"),
+                                               optarg, true);
+                break;
 #ifdef CONFIG_TPM
             case QEMU_OPTION_tpmdev:
                 if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) < 0=
) {
@@ -3845,6 +3883,8 @@ void qemu_init(int argc, char **argv, char **envp)
     have_custom_ram_size =3D set_memory_options(&ram_slots, &maxram_size,
                                               machine_class);

+    set_max_firmware_size(&MaxCombinedFirmwareSize);
+
     os_daemonize();
     rcu_disable_atfork();

--
2.25.1



________________________________
From: McMillan, Erich <erich.mcmillan@hp.com>
Sent: Tuesday, September 15, 2020 2:09 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: mst@redhat.com <mst@redhat.com>; marcel.apfelbaum@gmail.com <marcel.apf=
elbaum@gmail.com>; qemu-trivial@nongnu.org <qemu-trivial@nongnu.org>
Subject: Re: PATCH: Increase System Firmware Max Size

Hi all,

I've rewritten the FLASH_SIZE_LIMIT as a command line parameter as requeste=
d, but I'd like some feedback. My current concerns are:

  1.  I'm not too happy using an global variable in this manner, but I'm no=
t sure the appropriate way to share this information between vl.c and pc_sy=
sfw.c. Is there a way for other .c modules to query the QemuOpts, or is thi=
s not preferred.
  2.  Would appreciate feedback on the help strings, I think the formatting=
 is correct based on -m (memory size) flag.
  3.  If global variable is acceptable then is it appropriate for it to be =
shared via loader.h, this seemed the most appropriate place to put it witho=
ut adding new includes to either vl.c or pc_sysfw.c.

Thank you,
Erich

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 05d1a4cb6bf863b6ac1df8f94694c073fa4f8d90..a34995819fa14ef728d82ab179e=
f3a2e468e2365 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -442,6 +442,20 @@ static QemuOptsList qemu_mem_opts =3D {
     },
 };

+static QemuOptsList qemu_max_fw_size_opts =3D {
+    .name =3D "maxfirmwaresize",
+    .implied_opt_name =3D "fwsize",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_max_fw_size_opts.head),
+    .merge_lists =3D true,
+    .desc =3D {
+        {
+            .name =3D "size",
+            .type =3D QEMU_OPT_SIZE,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_icount_opts =3D {
     .name =3D "icount",
     .implied_opt_name =3D "shift",
@@ -2559,6 +2573,23 @@ static bool object_create_delayed(const char *type, =
QemuOpts *opts)
     return !object_create_initial(type, opts);
 }

+static void set_max_firmware_size(uint64_t *maxfwsize)
+{
+    const char *max_fw_size_str;
+    QemuOpts *opts =3D qemu_find_opts_singleton("maxfirmwaresize");
+
+    max_fw_size_str =3D qemu_opt_get(opts, "size");
+
+    if (max_fw_size_str) {
+        if (!*max_fw_size_str) {
+            error_report("missing 'size' option value");
+            exit(EXIT_FAILURE);
+        }
+
+        *maxfwsize =3D qemu_opt_get_size(opts, "size", 8 * MiB);
+    }
+}
+

 static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_siz=
e,
                                MachineClass *mc)
@@ -2887,6 +2918,7 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
     qemu_add_opts(&qemu_mem_opts);
+    qemu_add_opts(&qemu_max_fw_size_opts);
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
     qemu_add_opts(&qemu_add_fd_opts);
@@ -3143,6 +3175,10 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(EXIT_FAILURE);
                 }
                 break;
+            case QEMU_OPTION_maxfirmwaresize:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("maxfirmwa=
resize"),
+                                               optarg, true);
+                break;
 #ifdef CONFIG_TPM
             case QEMU_OPTION_tpmdev:
                 if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) < 0=
) {
@@ -3831,6 +3867,8 @@ void qemu_init(int argc, char **argv, char **envp)
     have_custom_ram_size =3D set_memory_options(&ram_slots, &maxram_size,
                                               machine_class);

+    set_max_firmware_size(&MaxCombinedFirmwareSize);
+
     os_daemonize();

     /*
diff --git a/include/hw/loader.h b/include/hw/loader.h
index a9eeea39521d2d5b5e9b73e0fcbd4d4ce9292046..9e982cd60f8f2173a3160f56316=
7e48b7ca88aa9 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -318,4 +318,13 @@ int rom_add_option(const char *file, int32_t bootindex=
);
  * overflow on real hardware too. */
 #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)

+/*
+ * We don't have a theoretically justifiable exact lower bound on the base
+ * address of any flash mapping. In practice, the IO-APIC MMIO range is
+ * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving fre=
e
+ * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
+ * size, but allow user to specify larger size via command line.
+ */
+uint64_t MaxCombinedFirmwareSize =3D (8 * MiB);
+
 #endif
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..012c28a3b4de1c1618404faefd6=
3a99267636935 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -39,14 +39,8 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"

-/*
- * We don't have a theoretically justifiable exact lower bound on the base
- * address of any flash mapping. In practice, the IO-APIC MMIO range is
- * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving fre=
e
- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
- * size.
- */
-#define FLASH_SIZE_LIMIT (8 * MiB)
+
+extern MaxCombinedFirmwareSize;

 #define FLASH_SECTOR_SIZE 4096

@@ -177,10 +171,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
         }
         if ((hwaddr)size !=3D size
             || total_size > HWADDR_MAX - size
-            || total_size + size > FLASH_SIZE_LIMIT) {
+            || total_size + size > MaxCombinedFirmwareSize) {
             error_report("combined size of system firmware exceeds "
                          "%" PRIu64 " bytes",
-                         FLASH_SIZE_LIMIT);
+                         MaxCombinedFirmwareSize);
             exit(1);
         }




________________________________
From: McMillan, Erich
Sent: Thursday, September 10, 2020 8:45 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: mst@redhat.com <mst@redhat.com>; marcel.apfelbaum@gmail.com <marcel.apf=
elbaum@gmail.com>; qemu-trivial@nongnu.org <qemu-trivial@nongnu.org>
Subject: PATCH: Increase System Firmware Max Size

Hi all,

(this is my first Qemu patch submission, please let me know if my formattin=
g/content needs to be fixed).
We have a need for increased firmware size, currently we are building Qemu =
with the following change to test our Uefi Firmware and it works well for u=
s. Hope that this change can be made to open source. Thank you.
-------
Increase allowed system firmware size to 16M per comment suggesting up to 1=
8M is permissible.

 Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355fbd19f=
fdcdb71ea75ca 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -46,7 +46,7 @@
  * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
  * size.
  */
-#define FLASH_SIZE_LIMIT (8 * MiB)
+#define FLASH_SIZE_LIMIT (16 * MiB)

 #define FLASH_SECTOR_SIZE 4096
-------


--_000_CS1PR8401MB03279AC1D869BBBA8D810A19F3200CS1PR8401MB0327_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Apologies, ignore previous patch. The relevant patch is below:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
From 473daf6129debf8d158a9ae1aff788c5bdbbc799 Mon Sep 17 00:00:00 2001
<div>From: Erich McMillan &lt;erich.mcmillan@hp.com&gt;</div>
<div>Date: Tue, 15 Sep 2020 13:23:25 -0500</div>
<div>Subject: [PATCH 2/2] Add max firmware size as optional parameter</div>
<div><br>
</div>
<div>Signed-off-by: Erich McMillan &lt;erich.mcmillan@hp.com&gt;</div>
<div>---</div>
<div>&nbsp;hw/i386/pc_sysfw.c &nbsp;| 13 ++-----------</div>
<div>&nbsp;include/hw/loader.h | &nbsp;9 +++++++++</div>
<div>&nbsp;qemu-options.hx &nbsp; &nbsp; | &nbsp;8 ++++++++</div>
<div>&nbsp;softmmu/vl.c &nbsp; &nbsp; &nbsp; &nbsp;| 40 +++++++++++++++++++=
+++++++++++++++++++++</div>
<div>&nbsp;4 files changed, 59 insertions(+), 11 deletions(-)</div>
<div><br>
</div>
<div>diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c</div>
<div>index b6c0822..ba6c99d 100644</div>
<div>--- a/hw/i386/pc_sysfw.c</div>
<div>+++ b/hw/i386/pc_sysfw.c</div>
<div>@@ -39,15 +39,6 @@</div>
<div>&nbsp;#include &quot;hw/block/flash.h&quot;</div>
<div>&nbsp;#include &quot;sysemu/kvm.h&quot;</div>
<div>&nbsp;</div>
<div>-/*</div>
<div>- * We don't have a theoretically justifiable exact lower bound on the=
 base</div>
<div>- * address of any flash mapping. In practice, the IO-APIC MMIO range =
is</div>
<div>- * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leavin=
g free</div>
<div>- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping t=
o 8MB in</div>
<div>- * size.</div>
<div>- */</div>
<div>-#define FLASH_SIZE_LIMIT (8 * MiB)</div>
<div>-</div>
<div>&nbsp;#define FLASH_SECTOR_SIZE 4096</div>
<div>&nbsp;</div>
<div>&nbsp;static void pc_isa_bios_init(MemoryRegion *rom_memory,</div>
<div>@@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *=
pcms,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((hwaddr)size !=3D size</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size &gt; HWA=
DDR_MAX - size</div>
<div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size + size &gt; F=
LASH_SIZE_LIMIT) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size + size &gt; M=
axCombinedFirmwareSize) {</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;error_report(&quot;com=
bined size of system firmware exceeds &quot;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &quot;%&quot; PRIu64 &quot; bytes&quot;,</div>
<div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; FLASH_SIZE_LIMIT);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; MaxCombinedFirmwareSize);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;exit(1);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp;</div>
<div>diff --git a/include/hw/loader.h b/include/hw/loader.h</div>
<div>index a9eeea3..7898b63 100644</div>
<div>--- a/include/hw/loader.h</div>
<div>+++ b/include/hw/loader.h</div>
<div>@@ -318,4 +318,13 @@ int rom_add_option(const char *file, int32_t boot=
index);</div>
<div>&nbsp; * overflow on real hardware too. */</div>
<div>&nbsp;#define UBOOT_MAX_GUNZIP_BYTES (64 &lt;&lt; 20)</div>
<div>&nbsp;</div>
<div>+/*</div>
<div>+ * We don't have a theoretically justifiable exact lower bound on the=
 base</div>
<div>+ * address of any flash mapping. In practice, the IO-APIC MMIO range =
is</div>
<div>+ * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leavin=
g free</div>
<div>+ * only 18MB-4KB below 4G. For now, restrict the cumulative mapping t=
o 8MB in</div>
<div>+ * size, but allow user to specify larger size via command line.</div=
>
<div>+ */</div>
<div>+extern uint64_t MaxCombinedFirmwareSize;</div>
<div>+</div>
<div>&nbsp;#endif</div>
<div>diff --git a/qemu-options.hx b/qemu-options.hx</div>
<div>index b0f0205..32eed3a 100644</div>
<div>--- a/qemu-options.hx</div>
<div>+++ b/qemu-options.hx</div>
<div>@@ -1377,6 +1377,14 @@ SRST</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|qemu_system_x86| -hda a -hdb b</div=
>
<div>&nbsp;ERST</div>
<div>&nbsp;</div>
<div>+DEF(&quot;maxfirmwaresize&quot;, HAS_ARG, QEMU_OPTION_maxfirmwaresize=
,</div>
<div>+ &nbsp; &nbsp;&quot;-maxfirmwaresize [size=3D]megs &nbsp;specify maxi=
mum combined firmware size, default is 8MiB. Known issues if value exceeds =
16MiB.\n&quot;,</div>
<div>+ &nbsp; &nbsp;QEMU_ARCH_ALL)</div>
<div>+SRST</div>
<div>+``-maxfirmwaresize [size=3D]megs``</div>
<div>+ &nbsp; &nbsp;Specify maximum combined firmware size, default is 8MiB=
. Known issues if value exceeds 16MiB.</div>
<div>+ERST</div>
<div>+</div>
<div>&nbsp;DEF(&quot;mtdblock&quot;, HAS_ARG, QEMU_OPTION_mtdblock,</div>
<div>&nbsp; &nbsp; &nbsp;&quot;-mtdblock file &nbsp;use 'file' as on-board =
Flash memory image\n&quot;,</div>
<div>&nbsp; &nbsp; &nbsp;QEMU_ARCH_ALL)</div>
<div>diff --git a/softmmu/vl.c b/softmmu/vl.c</div>
<div>index 0cc86b0..fcf41d2 100644</div>
<div>--- a/softmmu/vl.c</div>
<div>+++ b/softmmu/vl.c</div>
<div>@@ -116,6 +116,8 @@</div>
<div>&nbsp;</div>
<div>&nbsp;#define MAX_VIRTIO_CONSOLES 1</div>
<div>&nbsp;</div>
<div>+uint64_t MaxCombinedFirmwareSize =3D 8 * MiB;</div>
<div>+</div>
<div>&nbsp;static const char *data_dir[16];</div>
<div>&nbsp;static int data_dir_idx;</div>
<div>&nbsp;const char *bios_name =3D NULL;</div>
<div>@@ -448,6 +450,20 @@ static QemuOptsList qemu_mem_opts =3D {</div>
<div>&nbsp; &nbsp; &nbsp;},</div>
<div>&nbsp;};</div>
<div>&nbsp;</div>
<div>+static QemuOptsList qemu_max_fw_size_opts =3D {</div>
<div>+ &nbsp; &nbsp;.name =3D &quot;maxfirmwaresize&quot;,</div>
<div>+ &nbsp; &nbsp;.implied_opt_name =3D &quot;size&quot;,</div>
<div>+ &nbsp; &nbsp;.head =3D QTAILQ_HEAD_INITIALIZER(qemu_max_fw_size_opts=
.head),</div>
<div>+ &nbsp; &nbsp;.merge_lists =3D true,</div>
<div>+ &nbsp; &nbsp;.desc =3D {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;{</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.name =3D &quot;size&quot;,=
</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.type =3D QEMU_OPT_SIZE,</d=
iv>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;},</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;{ /* end of list */ }</div>
<div>+ &nbsp; &nbsp;},</div>
<div>+};</div>
<div>+</div>
<div>&nbsp;static QemuOptsList qemu_icount_opts =3D {</div>
<div>&nbsp; &nbsp; &nbsp;.name =3D &quot;icount&quot;,</div>
<div>&nbsp; &nbsp; &nbsp;.implied_opt_name =3D &quot;shift&quot;,</div>
<div>@@ -2576,6 +2592,23 @@ static bool object_create_delayed(const char *t=
ype, QemuOpts *opts)</div>
<div>&nbsp; &nbsp; &nbsp;return !object_create_initial(type, opts);</div>
<div>&nbsp;}</div>
<div>&nbsp;</div>
<div>+static void set_max_firmware_size(uint64_t *maxfwsize)</div>
<div>+{</div>
<div>+ &nbsp; &nbsp;const char *max_fw_size_str;</div>
<div>+ &nbsp; &nbsp;QemuOpts *opts =3D qemu_find_opts_singleton(&quot;maxfi=
rmwaresize&quot;);</div>
<div>+</div>
<div>+ &nbsp; &nbsp;max_fw_size_str =3D qemu_opt_get(opts, &quot;size&quot;=
);</div>
<div>+</div>
<div>+ &nbsp; &nbsp;if (max_fw_size_str) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;if (!*max_fw_size_str) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;error_report(&quot;missing =
'size' option value&quot;);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;exit(EXIT_FAILURE);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>+</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;*maxfwsize =3D qemu_opt_get_size(opts, &q=
uot;size&quot;, 8 * MiB);</div>
<div>+ &nbsp; &nbsp;}</div>
<div>+}</div>
<div>+</div>
<div>&nbsp;</div>
<div>&nbsp;static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *=
maxram_size,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; MachineClass *mc)</div>
<div>@@ -2904,6 +2937,7 @@ void qemu_init(int argc, char **argv, char **env=
p)</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_machine_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_accel_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_mem_opts);</div>
<div>+ &nbsp; &nbsp;qemu_add_opts(&amp;qemu_max_fw_size_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_smp_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_boot_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_add_fd_opts);</div>
<div>@@ -3160,6 +3194,10 @@ void qemu_init(int argc, char **argv, char **en=
vp)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;exit(EXIT_FAILURE);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</=
div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case QEMU_OPTION_maxfirmwar=
esize:</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;opts =3D qemu=
_opts_parse_noisily(qemu_find_opts(&quot;maxfirmwaresize&quot;),</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; optarg, true);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</div>
<div>&nbsp;#ifdef CONFIG_TPM</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case QEMU_OPTION_tpmde=
v:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (tpm_=
config_parse(qemu_find_opts(&quot;tpmdev&quot;), optarg) &lt; 0) {</div>
<div>@@ -3845,6 +3883,8 @@ void qemu_init(int argc, char **argv, char **env=
p)</div>
<div>&nbsp; &nbsp; &nbsp;have_custom_ram_size =3D set_memory_options(&amp;r=
am_slots, &amp;maxram_size,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;machine_class);</div>
<div>&nbsp;</div>
<div>+ &nbsp; &nbsp;set_max_firmware_size(&amp;MaxCombinedFirmwareSize);</d=
iv>
<div>+</div>
<div>&nbsp; &nbsp; &nbsp;os_daemonize();</div>
<div>&nbsp; &nbsp; &nbsp;rcu_disable_atfork();</div>
<div>&nbsp;</div>
<div>-- </div>
<div>2.25.1</div>
<div><br>
</div>
<br>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> McMillan, Erich &lt;e=
rich.mcmillan@hp.com&gt;<br>
<b>Sent:</b> Tuesday, September 15, 2020 2:09 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> mst@redhat.com &lt;mst@redhat.com&gt;; marcel.apfelbaum@gmail.co=
m &lt;marcel.apfelbaum@gmail.com&gt;; qemu-trivial@nongnu.org &lt;qemu-triv=
ial@nongnu.org&gt;<br>
<b>Subject:</b> Re: PATCH: Increase System Firmware Max Size</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
=09{margin-top:0;
=09margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Hi all,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
I've rewritten the FLASH_SIZE_LIMIT as a command line parameter as requeste=
d, but I'd like some feedback. My current concerns are:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<ol>
<li>I'm not too happy using an global variable in this manner, but I'm not =
sure the appropriate way to share this information between vl.c and pc_sysf=
w.c. Is there a way for other .c modules to query the QemuOpts, or is this =
not preferred.</li><li>Would appreciate feedback on the help strings, I thi=
nk the formatting is correct based on -m (memory size) flag.</li><li>If glo=
bal variable is acceptable then is it appropriate for it to be shared via l=
oader.h, this seemed the most appropriate place to put it without adding ne=
w includes to either vl.c or pc_sysfw.c.</li></ol>
<div>Thank you,</div>
<div>Erich</div>
<div><br>
</div>
<div>diff --git a/softmmu/vl.c b/softmmu/vl.c
<div>index 05d1a4cb6bf863b6ac1df8f94694c073fa4f8d90..a34995819fa14ef728d82a=
b179ef3a2e468e2365 100644</div>
<div>--- a/softmmu/vl.c</div>
<div>+++ b/softmmu/vl.c</div>
<div>@@ -442,6 +442,20 @@ static QemuOptsList qemu_mem_opts =3D {</div>
<div>&nbsp; &nbsp; &nbsp;},</div>
<div>&nbsp;};</div>
<div>&nbsp;</div>
<div>+static QemuOptsList qemu_max_fw_size_opts =3D {</div>
<div>+ &nbsp; &nbsp;.name =3D &quot;maxfirmwaresize&quot;,</div>
<div>+ &nbsp; &nbsp;.implied_opt_name =3D &quot;fwsize&quot;,</div>
<div>+ &nbsp; &nbsp;.head =3D QTAILQ_HEAD_INITIALIZER(qemu_max_fw_size_opts=
.head),</div>
<div>+ &nbsp; &nbsp;.merge_lists =3D true,</div>
<div>+ &nbsp; &nbsp;.desc =3D {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;{</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.name =3D &quot;size&quot;,=
</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.type =3D QEMU_OPT_SIZE,</d=
iv>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;},</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;{ /* end of list */ }</div>
<div>+ &nbsp; &nbsp;},</div>
<div>+};</div>
<div>+</div>
<div>&nbsp;static QemuOptsList qemu_icount_opts =3D {</div>
<div>&nbsp; &nbsp; &nbsp;.name =3D &quot;icount&quot;,</div>
<div>&nbsp; &nbsp; &nbsp;.implied_opt_name =3D &quot;shift&quot;,</div>
<div>@@ -2559,6 +2573,23 @@ static bool object_create_delayed(const char *t=
ype, QemuOpts *opts)</div>
<div>&nbsp; &nbsp; &nbsp;return !object_create_initial(type, opts);</div>
<div>&nbsp;}</div>
<div>&nbsp;</div>
<div>+static void set_max_firmware_size(uint64_t *maxfwsize)</div>
<div>+{</div>
<div>+ &nbsp; &nbsp;const char *max_fw_size_str;</div>
<div>+ &nbsp; &nbsp;QemuOpts *opts =3D qemu_find_opts_singleton(&quot;maxfi=
rmwaresize&quot;);</div>
<div>+</div>
<div>+ &nbsp; &nbsp;max_fw_size_str =3D qemu_opt_get(opts, &quot;size&quot;=
);</div>
<div>+</div>
<div>+ &nbsp; &nbsp;if (max_fw_size_str) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;if (!*max_fw_size_str) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;error_report(&quot;missing =
'size' option value&quot;);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;exit(EXIT_FAILURE);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>+</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp;*maxfwsize =3D qemu_opt_get_size(opts, &q=
uot;size&quot;, 8 * MiB);</div>
<div>+ &nbsp; &nbsp;}</div>
<div>+}</div>
<div>+</div>
<div>&nbsp;</div>
<div>&nbsp;static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *=
maxram_size,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; MachineClass *mc)</div>
<div>@@ -2887,6 +2918,7 @@ void qemu_init(int argc, char **argv, char **env=
p)</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_machine_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_accel_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_mem_opts);</div>
<div>+ &nbsp; &nbsp;qemu_add_opts(&amp;qemu_max_fw_size_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_smp_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_boot_opts);</div>
<div>&nbsp; &nbsp; &nbsp;qemu_add_opts(&amp;qemu_add_fd_opts);</div>
<div>@@ -3143,6 +3175,10 @@ void qemu_init(int argc, char **argv, char **en=
vp)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;exit(EXIT_FAILURE);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</=
div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case QEMU_OPTION_maxfirmwar=
esize:</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;opts =3D qemu=
_opts_parse_noisily(qemu_find_opts(&quot;maxfirmwaresize&quot;),</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; optarg, true);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;</div>
<div>&nbsp;#ifdef CONFIG_TPM</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case QEMU_OPTION_tpmde=
v:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (tpm_=
config_parse(qemu_find_opts(&quot;tpmdev&quot;), optarg) &lt; 0) {</div>
<div>@@ -3831,6 +3867,8 @@ void qemu_init(int argc, char **argv, char **env=
p)</div>
<div>&nbsp; &nbsp; &nbsp;have_custom_ram_size =3D set_memory_options(&amp;r=
am_slots, &amp;maxram_size,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;machine_class);</div>
<div>&nbsp;</div>
<div>+ &nbsp; &nbsp;set_max_firmware_size(&amp;MaxCombinedFirmwareSize);</d=
iv>
<div>+</div>
<div>&nbsp; &nbsp; &nbsp;os_daemonize();</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;/*</div>
<div>diff --git a/include/hw/loader.h b/include/hw/loader.h</div>
<div>index a9eeea39521d2d5b5e9b73e0fcbd4d4ce9292046..9e982cd60f8f2173a3160f=
563167e48b7ca88aa9 100644</div>
<div>--- a/include/hw/loader.h</div>
<div>+++ b/include/hw/loader.h</div>
<div>@@ -318,4 +318,13 @@ int rom_add_option(const char *file, int32_t boot=
index);</div>
<div>&nbsp; * overflow on real hardware too. */</div>
<div>&nbsp;#define UBOOT_MAX_GUNZIP_BYTES (64 &lt;&lt; 20)</div>
<div>&nbsp;</div>
<div>+/*</div>
<div>+ * We don't have a theoretically justifiable exact lower bound on the=
 base</div>
<div>+ * address of any flash mapping. In practice, the IO-APIC MMIO range =
is</div>
<div>+ * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leavin=
g free</div>
<div>+ * only 18MB-4KB below 4G. For now, restrict the cumulative mapping t=
o 8MB in</div>
<div>+ * size, but allow user to specify larger size via command line.</div=
>
<div>+ */</div>
<div>+uint64_t MaxCombinedFirmwareSize =3D (8 * MiB);</div>
<div>+</div>
<div>&nbsp;#endif</div>
<div>diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c</div>
<div>index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..012c28a3b4de1c1618404f=
aefd63a99267636935 100644</div>
<div>--- a/hw/i386/pc_sysfw.c</div>
<div>+++ b/hw/i386/pc_sysfw.c</div>
<div>@@ -39,14 +39,8 @@</div>
<div>&nbsp;#include &quot;hw/block/flash.h&quot;</div>
<div>&nbsp;#include &quot;sysemu/kvm.h&quot;</div>
<div>&nbsp;</div>
<div>-/*</div>
<div>- * We don't have a theoretically justifiable exact lower bound on the=
 base</div>
<div>- * address of any flash mapping. In practice, the IO-APIC MMIO range =
is</div>
<div>- * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leavin=
g free</div>
<div>- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping t=
o 8MB in</div>
<div>- * size.</div>
<div>- */</div>
<div>-#define FLASH_SIZE_LIMIT (8 * MiB)</div>
<div>+</div>
<div>+extern MaxCombinedFirmwareSize;</div>
<div>&nbsp;</div>
<div>&nbsp;#define FLASH_SECTOR_SIZE 4096</div>
<div>&nbsp;</div>
<div>@@ -177,10 +171,10 @@ static void pc_system_flash_map(PCMachineState *=
pcms,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((hwaddr)size !=3D size</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size &gt; HWA=
DDR_MAX - size</div>
<div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size + size &gt; F=
LASH_SIZE_LIMIT) {</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|| total_size + size &gt; M=
axCombinedFirmwareSize) {</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;error_report(&quot;com=
bined size of system firmware exceeds &quot;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &quot;%&quot; PRIu64 &quot; bytes&quot;,</div>
<div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; FLASH_SIZE_LIMIT);</div>
<div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; MaxCombinedFirmwareSize);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;exit(1);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div>&nbsp;</div>
<br>
<br>
</div>
<div><br>
</div>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> McMillan, Erich<br>
<b>Sent:</b> Thursday, September 10, 2020 8:45 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> mst@redhat.com &lt;mst@redhat.com&gt;; marcel.apfelbaum@gmail.co=
m &lt;marcel.apfelbaum@gmail.com&gt;; qemu-trivial@nongnu.org &lt;qemu-triv=
ial@nongnu.org&gt;<br>
<b>Subject:</b> PATCH: Increase System Firmware Max Size</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
=09{margin-top:0;
=09margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Hi all,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
(this is my first Qemu patch submission, please let me know if my formattin=
g/content needs to be fixed).<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
We have a need for increased firmware size, currently we are building Qemu =
with the following change to test our Uefi Firmware and it works well for u=
s. Hope that this change can be made to open source. Thank you.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
-------<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Increase allowed system firmware size to 16M per comment suggesting up to 1=
8M is permissible.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
&nbsp;Signed-off-by: Erich McMillan &lt;erich.mcmillan@hp.com&gt;<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
<div>index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355f=
bd19ffdcdb71ea75ca 100644</div>
<div>--- a/hw/i386/pc_sysfw.c</div>
<div>+++ b/hw/i386/pc_sysfw.c</div>
<div>@@ -46,7 +46,7 @@</div>
<div>&nbsp; * only 18MB-4KB below 4G. For now, restrict the cumulative mapp=
ing to 8MB in</div>
<div>&nbsp; * size.</div>
<div>&nbsp; */</div>
<div>-#define FLASH_SIZE_LIMIT (8 * MiB)</div>
<div>+#define FLASH_SIZE_LIMIT (16 * MiB)</div>
<div>&nbsp;</div>
<div>&nbsp;#define FLASH_SECTOR_SIZE 4096</div>
<div>-------<br>
</div>
&nbsp;<br>
</div>
</div>
</div>
</body>
</html>

--_000_CS1PR8401MB03279AC1D869BBBA8D810A19F3200CS1PR8401MB0327_--


