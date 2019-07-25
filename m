Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BF7C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C73222AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Z7D7x8qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C73222AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUQ7-0003Kp-Dz
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMM-0004ce-Kf
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMK-0001sq-Us
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:02 -0400
Received: from mail-eopbgr780120.outbound.protection.outlook.com
 ([40.107.78.120]:46306 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMK-0001sD-OH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrlNaPta2e/pVxhRYma/rAprOsSnFw628nzU+u/SpRanNO/dQ66NnFJR0HYjrllZzB6LLXIbx1UhSloak13Z/8oWA8FYfKQ/fFHUUyFUGiRM6GciFlE9ltgkPoQg15wtqNotkDVQiC5E8twiMYFzYkNzm/jAUGRTmAOTCxsHiCyImjpC1mFji89PyH9+YzmE4eEUR6auuvXo+5Ukgvm/NjfXibpsw6SxO2K2eHcPU9fNAYOqM1eoyNo93w0jIvU07MRXIx+8Qi7O2sx4rY1ichsnDkcVCDQZqcn3HdSk21U2Kwk1iivAsrADzQnIive6wLEfxXLCKXk2dr1ibTdkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkjTjOQ1C2EXgxcpilxRiWmQuSFU0QmsyL59hvTlZ5Y=;
 b=m6GXM0EsrKhptsBhkeKEvLua6YPaskxn8NnXKGlFqmFBSz6G/6qx5yAvgysPUH8fRLziDpFiUDIg/q37pkY5mZDRB2OYPdfeUOPE0mA2R0O6zSa7n7WgEkbWO30XkcKdrZIU83qbSCKe5bz7CftQGFUdTriFkU4d4ZjjKzGIhlZkkPWzTYZJP+0bZKTN5wU7a/SzLQa2QW9QR6rMhAeCdX2uPkAshP5Er05pLRZ0fVoUkw8a/6Y/WlU4soF+BUaCGd70Mwjb1wA1H7oAlLUTBunNJSDVv/0c8/Pki0gceR1XRr8DYtly4SuA4qP4DBGQpfvHiBwqB8lKVfIjuA3WHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkjTjOQ1C2EXgxcpilxRiWmQuSFU0QmsyL59hvTlZ5Y=;
 b=Z7D7x8qqaD1rW1RKUmpMS9jxUI5vv03wDlFWlOhd1asdXa08EsMeKzgvaYpT79JLrF4yw8G8X+N5oDT8yl9y5j1gyK6R25vqnhnlOO2/pXz1oc0RhRpQg6S6YnkuG2gOrLnn3x355rrB3Le8BWURaU/pAWY7MZmpKg3eWTyimjE=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2534.namprd03.prod.outlook.com (10.168.165.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:59 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:59 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 17/19] fuzz: add general qtest fuzz target
Thread-Index: AQHVQphlxaHCiH7M/0W0Igu3pl7HQA==
Date: Thu, 25 Jul 2019 03:23:59 +0000
Message-ID: <20190725032321.12721-18-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39a2d05d-9142-43b3-eefe-08d710af8857
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2534; 
x-ms-traffictypediagnostic: CY4PR03MB2534:
x-microsoft-antispam-prvs: <CY4PR03MB2534739F87079B83AE0A7867BAC10@CY4PR03MB2534.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(446003)(2501003)(186003)(86362001)(2906002)(26005)(2616005)(3846002)(6512007)(6116002)(256004)(476003)(53936002)(4326008)(11346002)(76176011)(81156014)(102836004)(75432002)(6916009)(52116002)(88552002)(386003)(81166006)(6506007)(2351001)(14454004)(25786009)(478600001)(36756003)(8936002)(316002)(486006)(66476007)(54906003)(71190400001)(1076003)(66066001)(5640700003)(50226002)(99286004)(6486002)(305945005)(5660300002)(64756008)(7736002)(786003)(8676002)(66446008)(66556008)(66946007)(68736007)(6436002)(71200400001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2534;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cGz8UjWYVj2gReCKrhIm8IezESC5sq5pKqSjo2SPU0IF0NCOmw2jO6MnxtyBwtPLjtzDaFG2VuOmEo+b3Ceet8+ZwOLUHBpcb2ibq4UZKQ3TrBpwwzs8AXgzMOBAgayBER952i/pp5D39quYXHA5bw3w+D3uPjHqzUyMr9xU3H5zH7ImFoRhmBfkgTnCmPLbrXQZKCEvKNSmLmD5J04pdFbSGXAKNhW0nkSd573tVYqOmWGrj+r6O185Rvp7cdNxIAoCUDZNUmXYw+OFiUvVdgDhpi93Ae/Piwn9OUQ++aNem6xaXdx0JfjgQER7/oQDTJ22mbSoHhyulW2sh+iTenUO/8w7ne7HDGEHucksBuWrJqIqhLclS58RrXaGs+GtApqtZm/nuaXqY/DC0v9ixxqrJr5NoVb/OrmfcEOR+vw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a2d05d-9142-43b3-eefe-08d710af8857
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:59.0539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2534
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.120
Subject: [Qemu-devel] [RFC 17/19] fuzz: add general qtest fuzz target
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These fuzz targets perform a range of qtest operations over mmio and
port i/o addresses mapped to devices.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/qtest_fuzz.c | 261 ++++++++++++++++++++++++++++++++++++++++
 tests/fuzz/qtest_fuzz.h |  38 ++++++
 2 files changed, 299 insertions(+)
 create mode 100644 tests/fuzz/qtest_fuzz.c
 create mode 100644 tests/fuzz/qtest_fuzz.h

diff --git a/tests/fuzz/qtest_fuzz.c b/tests/fuzz/qtest_fuzz.c
new file mode 100644
index 0000000000..6d6670838d
--- /dev/null
+++ b/tests/fuzz/qtest_fuzz.c
@@ -0,0 +1,261 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include <wordexp.h>
+#include "qemu-common.h"
+#include "fuzzer_hooks.h"
+
+
+#include "fuzz.h"
+#include "qtest_fuzz.h"
+#include "tests/libqtest.h"
+#include "fuzz/qos_fuzz.h"
+
+
+/* Make sure that the io_port is mapped to some device */
+static uint16_t normalize_io_port(uint64_t addr) {
+    addr =3D addr%total_io_mem;
+    fuzz_memory_region *fmr =3D fuzz_memory_region_head;
+    while(addr!=3D0) {
+        if(!fmr->io){
+            fmr =3D fmr->next;
+            continue;
+        }
+        if(addr <=3D fmr->length)
+        {
+            addr=3D fmr->start + addr;
+            break;
+        }
+        addr -=3D fmr->length +1;
+        fmr =3D fmr->next;
+    }
+    /* Stuff that times out or hotplugs.. */
+    if(addr>=3D0x5655 && addr<=3D0x565b)
+        return 0;
+    if(addr>=3D0x510 && addr<=3D0x518)
+        return 0;
+    if(addr>=3D0xae00 && addr<=3D0xae13) // PCI Hotplug
+        return 0;
+    if(addr>=3D0xaf00 && addr<=3D0xaf1f) // CPU Hotplug
+        return 0;
+    return addr;
+}
+
+/* Make sure that the memory address is mapped to some interesting device =
*/
+static uint16_t normalize_mem_addr(uint64_t addr) {
+    addr =3D addr%total_ram_mem;
+    fuzz_memory_region *fmr =3D fuzz_memory_region_head;
+    while(addr!=3D0) {
+        if(fmr->io){
+            fmr =3D fmr->next;
+            continue;
+        }
+        if(addr <=3D fmr->length)
+        {
+            return fmr->start + addr;
+        }
+        addr -=3D fmr->length +1;
+        fmr =3D fmr->next;
+    }
+    return addr;
+}
+
+static void qtest_fuzz(const unsigned char *Data, size_t Size){
+    const unsigned char *pos =3D Data;
+    const unsigned char *End =3D Data + Size;
+
+    qtest_cmd *cmd;
+
+    while(pos < Data+Size)
+    {
+        /* Translate the fuzz input to a qtest command */
+        cmd =3D &commands[(*pos)%(sizeof(commands)/sizeof(qtest_cmd))];
+        pos++;
+
+        if(strcmp(cmd->name, "clock_step") =3D=3D 0){
+            // TODO: This times out
+            /* qtest_clock_step_next(s); */
+        }=20
+        else if(strcmp(cmd->name, "outb") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) + sizeof(uint8_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint8_t val =3D *(uint16_t*)(pos);
+                pos +=3D sizeof(uint8_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outb(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "outw") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint16_t val =3D *(uint16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outw(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "outl") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) + sizeof(uint32_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint32_t val =3D *(uint32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outl(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "inb") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inb(s, addr);
+            }
+        }
+        else if(strcmp(cmd->name, "inw") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inw(s, addr);
+            }
+        }
+        else if(strcmp(cmd->name, "inl") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inl(s, addr);
+            }
+        }
+        else if(strcmp(cmd->name, "writeb") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) + sizeof(uint8_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint8_t val =3D *(uint8_t*)(pos);
+                pos +=3D sizeof(uint8_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writeb(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "writew") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) + sizeof(uint16_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint16_t val =3D *(uint16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writew(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "writel") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint32_t val =3D *(uint32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writel(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "readb") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readb(s, addr);
+            }
+        }
+        else if(strcmp(cmd->name, "readw") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readw(s, addr); } }
+        else if(strcmp(cmd->name, "readl") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readl(s, addr);
+            }
+        }
+        else if(strcmp(cmd->name, "write_dma") =3D=3D 0) {
+            if(pos + sizeof(uint32_t) + sizeof(uint16_t) < End) {
+                uint32_t addr =3D *(int32_t*)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint32_t val =3D 0x100000;
+                addr =3D normalize_mem_addr(addr);
+                qtest_writel(s, addr, val);
+            }
+        }
+        else if(strcmp(cmd->name, "out_dma") =3D=3D 0) {
+            if(pos + sizeof(uint16_t) + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t*)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint32_t val =3D 0x100000;
+                addr =3D normalize_io_port(addr);
+                qtest_outl(s, addr, val);
+            }
+        }
+        main_loop_wait(false);
+    }
+}
+
+static void *net_test_setup_nosocket(GString *cmd_line, void *arg)
+{
+    g_string_append(cmd_line, " -netdev hubport,hubid=3D0,id=3Dhs0 ");
+    return arg;
+}
+
+static void fuzz_fork(const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        qtest_fuzz(Data, Size);
+        counter_shm_store();
+        _Exit(0);
+    }
+    else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void init_fork(void) {
+    qos_init_path();
+}
+static void fork_pre_main(void) {
+    qos_setup();
+    counter_shm_init();
+}
+
+int qtest_argc;
+char **qtest_argv;
+static void register_qtest_fuzz_targets(void)
+{
+    QOSGraphTestOptions opts =3D {
+        .before =3D net_test_setup_nosocket,
+    };
+    fuzz_add_qos_target("qtest-fuzz", "fuzz qtest commands and a dma buffe=
r. Reset device state for each run",
+            "e1000e", &opts, &qos_setup, &qos_init_path, &save_vm_state, &=
load_vm_state,
+            NULL, &qtest_fuzz, NULL);
+    fuzz_add_qos_target("qtest-fork-fuzz", "fuzz qtest commands and a dma =
buffer. Use COW/forking to reset state",
+            "e1000e", &opts, &fork_pre_main, NULL, &init_fork, NULL,
+            NULL, &fuzz_fork, NULL);
+
+    GString *cmd_line =3D g_string_new("qemu-system-i386 -display none -ma=
chine accel=3Dfuzz -m 3");=20
+    wordexp_t result;
+    wordexp (cmd_line->str, &result, 0);
+    qtest_argc =3D result.we_wordc;
+    qtest_argv =3D result.we_wordv;
+    g_string_free(cmd_line, true);
+}
+
+fuzz_target_init(register_qtest_fuzz_targets);
diff --git a/tests/fuzz/qtest_fuzz.h b/tests/fuzz/qtest_fuzz.h
new file mode 100644
index 0000000000..bf472954e7
--- /dev/null
+++ b/tests/fuzz/qtest_fuzz.h
@@ -0,0 +1,38 @@
+#ifndef _QTEST_FUZZ_H_
+#define _QTEST_FUZZ_H_
+
+typedef struct qtest_cmd {
+	char name[32];
+	uint8_t size;
+} qtest_cmd;
+
+typedef uint32_t addr_type;
+
+static qtest_cmd commands[] =3D=20
+{
+	{"clock_step", 0},
+	{"clock_step", 0},
+	{"clock_set", 1},
+	{"outb", 2},
+	{"outw", 2},
+	{"outl", 2},
+	{"inb", 1},
+	{"inw", 1},
+	{"inl", 1},
+	{"writeb", 2},
+	{"writew", 2},
+	{"writel", 2},
+	{"writeq", 2},
+	{"readb", 1},
+	{"readw", 1},
+	{"readl", 1},
+	{"readq", 1},
+	{"read", 2},
+	{"write", 3},
+	{"b64read", 2},
+	{"b64write", 10},
+	{"memset", 3},
+	{"write_dma", 2},
+	{"out_dma", 2},
+};
+#endif
--=20
2.20.1


