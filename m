Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8ABC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC50205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="hfLqO8RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC50205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXGU-0001Mb-E7
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9K-0003fv-Qb
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9J-00023N-5f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:18 -0400
Received: from mail-eopbgr680111.outbound.protection.outlook.com
 ([40.107.68.111]:35968 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9I-000237-W5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2qSTbqTnKc4+j4qk/PAHFXcn/9ANg+9m8/oaYAK3Kb6Fe1+jBdA56SlYtbdE04T48ZbNaaIcYmXCdIJwla64BgV7Kmu5WN/U6EWsDTORHoryXKt/JPVaFTfMf5iGAq3Yqx6UYLWLjNeD+8DfK+dMH1lOF3tcEkjF21UzbWclOs+t0H4bqLCT8zYEsT7eTXQlTfeFbigGzF4COeBR45m9d9XznJL5lJ/5zHIvrf1fTQZH927VF+fXBo1wYLjFSjaOK8aF7/KQ/QI66+UgNn4SzUPxzBPO66CxY1T0QVGEJpmTdzUR3uJHP/ZBjfmtsO7Tv0gfm2LLjGbYhGeM06/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KCHVyzZSKjr2PTOKKS7t1UICzMJ9giXxQ5aY63arbw=;
 b=NIwQILJbK1Ce0FKEJyLBndZCXV0ib8kLS/zSZFGR8kT1FwT1X8V/pnI0/e36S5cVrjkeEgMqfTPA+JhDmVRAWm39lbfRM7oOnUvCBEn7mJNT848nkI8GGfUWN2CbL9k7g7BQVS55v+/H3zVtVYjv53F1yfpwYZmTyv1mhTHlB0n3EvlDdiyKrSvQ1+jlW03j7HUA927QGi7s5/un4Yh01JB6aay8HZjTLuAsNJ/P9puhK1pU+tGh1H7kCKwJcILf3kHzZ+K0W7eHzUnHicYfSzSuEyxEaI/hzZrdjxIgJ1WcDsP7EIQMY8Y2sOjObPoTRIAUN4PnRY4c4SrpfcbHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KCHVyzZSKjr2PTOKKS7t1UICzMJ9giXxQ5aY63arbw=;
 b=hfLqO8RVXmlBfyseeIrK6R1ubfANNmqb4SzDDb5QOm8InuY2OfGxSemzJnO+hZ8MZKKMRGyWH38IpuLSEp7+5lXxKOS5NUKM8fEGrndYQPArhWMTTdhjdSWbnCFUc3RuWbdyJccZFzLfqVxv4S8OqOhwslVbOWUGhAdUtLLqo4Y=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:16 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:15 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 15/17] fuzz: Add general qtest fuzz-target
Thread-Index: AQHVS1z4y4A/MADulEqNBrNhzpAPuA==
Date: Mon, 5 Aug 2019 07:11:15 +0000
Message-ID: <20190805071038.32146-16-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a36c1158-b428-4cac-1faf-08d719741b11
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26464F53A2F731EAFF530D74BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMu1DKn9RyDynLN5qfmAi6jQ5U3QxKyCbQq0t7jpnUTr1Kgr4yeWwzlGyVGS3nNCm0x0ZXeUPYPkxzgU+PTNu8Kkj/1oum1+hr1n4QbJLx0zPv3tAtuBvcMGQsU33WNZYxBXO5lHo9i1D0w38YFyAc1fwbAYST2anGTA6zRYjFPW6mmLT1ZZfD9Z1ZTeeu9mvDsiX7dIjcrSGqTi3sCTWrnUyhI4Ge9+Gh+xc6wrJDgKtTVErFrVqkeV84b08Njr14qm+xy38YtWFYKFoaEKktp/ygjyx07eNjqUmE1jL159gEVCZkd2GUuRm5GjjpEMtTBCIxGapwCEcBypUJVuzEO+DP+msoRRaKXfKUxcPcqRJLgvyIC+9OHUweQF6D0Si4VuWiruFNMFBbuNrktYeUuwVXU+Fem68SQtM3ORACU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a36c1158-b428-4cac-1faf-08d719741b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:15.9341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.111
Subject: [Qemu-devel] [RFC PATCH v2 15/17] fuzz: Add general qtest
 fuzz-target
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
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/qtest_fuzz.c | 260 ++++++++++++++++++++++++++++++++++++++++
 tests/fuzz/qtest_fuzz.h |  37 ++++++
 2 files changed, 297 insertions(+)
 create mode 100644 tests/fuzz/qtest_fuzz.c
 create mode 100644 tests/fuzz/qtest_fuzz.h

diff --git a/tests/fuzz/qtest_fuzz.c b/tests/fuzz/qtest_fuzz.c
new file mode 100644
index 0000000000..a4560535e1
--- /dev/null
+++ b/tests/fuzz/qtest_fuzz.c
@@ -0,0 +1,260 @@
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
+static uint16_t normalize_io_port(uint64_t addr)
+{
+    return addr;
+    addr =3D addr % total_io_mem;
+    fuzz_memory_region *fmr =3D fuzz_memory_region_head;
+    while (addr !=3D 0) {
+        if (!fmr->io) {
+            fmr =3D fmr->next;
+            continue;
+        }
+        if (addr <=3D fmr->length) {
+            addr =3D fmr->start + addr;
+            break;
+        }
+        addr -=3D fmr->length + 1;
+        fmr =3D fmr->next;
+    }
+    /* Stuff that times out or hotplugs.. */
+    if (addr >=3D 0x5655 && addr <=3D 0x565b) {
+        return 0;
+    }
+    if (addr >=3D 0x510 && addr <=3D 0x518) {
+        return 0;
+    }
+    /* PCI Hotplug */
+    if (addr >=3D 0xae00 && addr <=3D 0xae13) {
+        return 0;
+    }
+    /* CPU Hotplug */
+    if (addr >=3D 0xaf00 && addr <=3D 0xaf1f) {
+        return 0;
+    }
+    return addr;
+}
+
+/* Make sure that the memory address is mapped to some interesting device =
*/
+static uint16_t normalize_mem_addr(uint64_t addr)
+{
+    return addr;
+    addr =3D addr % total_ram_mem;
+    fuzz_memory_region *fmr =3D fuzz_memory_region_head;
+    while (addr !=3D 0) {
+        if (fmr->io) {
+            fmr =3D fmr->next;
+            continue;
+        }
+        if (addr <=3D fmr->length) {
+            return fmr->start + addr;
+        }
+        addr -=3D fmr->length + 1;
+        fmr =3D fmr->next;
+    }
+    return addr;
+}
+
+static void qtest_fuzz(const unsigned char *Data, size_t Size)
+{
+    const unsigned char *pos =3D Data;
+    const unsigned char *End =3D Data + Size;
+
+    qtest_cmd *cmd;
+
+    while (pos < Data + Size) {
+        /* Translate the fuzz input to a qtest command */
+        cmd =3D &commands[(*pos) % (sizeof(commands) / sizeof(qtest_cmd))]=
;
+        pos++;
+
+        if (strcmp(cmd->name, "clock_step") =3D=3D 0) {
+            /* TODO: This times out */
+            /* qtest_clock_step_next(s); */
+        } else if (strcmp(cmd->name, "outb") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) + sizeof(uint8_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint8_t val =3D *(uint16_t *)(pos);
+                pos +=3D sizeof(uint8_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outb(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "outw") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint16_t val =3D *(uint16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outw(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "outl") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) + sizeof(uint32_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint32_t val =3D *(uint32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_io_port(addr);
+                qtest_outl(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "inb") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inb(s, addr);
+            }
+        } else if (strcmp(cmd->name, "inw") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inw(s, addr);
+            }
+        } else if (strcmp(cmd->name, "inl") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) < End) {
+                uint16_t addr =3D *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_io_port(addr);
+                qtest_inl(s, addr);
+            }
+        } else if (strcmp(cmd->name, "writeb") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) + sizeof(uint8_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint8_t val =3D *(uint8_t *)(pos);
+                pos +=3D sizeof(uint8_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writeb(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "writew") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) + sizeof(uint16_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint16_t val =3D *(uint16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writew(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "writel") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint32_t val =3D *(uint32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_writel(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "readb") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readb(s, addr);
+            }
+        } else if (strcmp(cmd->name, "readw") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readw(s, addr); }
+        } else if (strcmp(cmd->name, "readl") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                addr =3D normalize_mem_addr(addr);
+                qtest_readl(s, addr);
+            }
+        } else if (strcmp(cmd->name, "write_dma") =3D=3D 0) {
+            if (pos + sizeof(uint32_t) + sizeof(uint16_t) < End) {
+                uint32_t addr =3D *(int32_t *)(pos);
+                pos +=3D sizeof(uint32_t);
+                uint32_t val =3D 0x100000;
+                addr =3D normalize_mem_addr(addr);
+                qtest_writel(s, addr, val);
+            }
+        } else if (strcmp(cmd->name, "out_dma") =3D=3D 0) {
+            if (pos + sizeof(uint16_t) + sizeof(uint16_t) < End) {
+                uint16_t addr  =3D  *(int16_t *)(pos);
+                pos +=3D sizeof(uint16_t);
+                uint32_t val =3D 0x100000;
+                addr =3D normalize_io_port(addr);
+                qtest_outl(s, addr, val);
+            }
+        }
+        /* main_loop_wait(false); */
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
+    } else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void fork_pre_main(void)
+{
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
+    FuzzTarget fuzz_opts =3D {
+        .pre_main =3D qos_setup,
+        .pre_save_state =3D qos_init_path,
+        .save_state =3D &save_vm_state,
+        .reset =3D &load_vm_state,
+        .pre_fuzz =3D NULL,
+        .fuzz =3D &qtest_fuzz,
+        .post_fuzz =3D NULL,
+    };
+    fuzz_add_qos_target("qtest-fuzz", "fuzz qtest commands and a dma buffe=
r. \
+            Reset device state for each run", "e1000e", &opts, &fuzz_opts)=
;
+
+    fuzz_opts.pre_main =3D &fork_pre_main;
+    fuzz_opts.pre_fuzz =3D NULL;
+    fuzz_opts.fuzz =3D &fuzz_fork;
+    fuzz_opts.reset =3D NULL;
+    fuzz_add_qos_target("qtest-fork-fuzz", "fuzz qtest commands and a dma =
\
+            buffer. Use COW/forking to reset state", "e1000e", &opts,
+            &fuzz_opts);
+
+}
+
+fuzz_target_init(register_qtest_fuzz_targets);
diff --git a/tests/fuzz/qtest_fuzz.h b/tests/fuzz/qtest_fuzz.h
new file mode 100644
index 0000000000..c4cf08f5a2
--- /dev/null
+++ b/tests/fuzz/qtest_fuzz.h
@@ -0,0 +1,37 @@
+#ifndef _QTEST_FUZZ_H_
+#define _QTEST_FUZZ_H_
+
+typedef struct qtest_cmd {
+    char name[32];
+    uint8_t size;
+} qtest_cmd;
+
+typedef uint32_t addr_type;
+
+static qtest_cmd commands[] =3D {
+    {"clock_step", 0},
+    {"clock_step", 0},
+    {"clock_set", 1},
+    {"outb", 2},
+    {"outw", 2},
+    {"outl", 2},
+    {"inb", 1},
+    {"inw", 1},
+    {"inl", 1},
+    {"writeb", 2},
+    {"writew", 2},
+    {"writel", 2},
+    {"writeq", 2},
+    {"readb", 1},
+    {"readw", 1},
+    {"readl", 1},
+    {"readq", 1},
+    {"read", 2},
+    {"write", 3},
+    {"b64read", 2},
+    {"b64write", 10},
+    {"memset", 3},
+    {"write_dma", 2},
+    {"out_dma", 2},
+};
+#endif
--=20
2.20.1


