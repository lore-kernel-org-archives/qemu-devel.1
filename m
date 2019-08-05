Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D05C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A6F205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3CBwMWqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A6F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXEg-0006ej-0k
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9I-0003YM-F2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9G-00022C-SY
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:16 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com
 ([40.107.68.92]:46081 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9G-000220-NW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXA0OwCCJIPEABYBS2fikXs+4R0qUNP7+WgbIJh6TXL4356sxymr4G3cvCUf21Y1yTHU8Wg7Wi52oBST8jkdyqgdU3zFB4cCzcGNa8vJT/CvKEe8Ghpnm1/o9VL3sAvLFgEoEoitbds3ybQetK+jRb2VdSeWMsinAmdKz1xmYWLMV0aAiTbKa4yDf8mCSxHuFNx4cVdHpFVU6o25DihbK2h0iBAGJd4K8uLASjyMFr5dS9y2kFL5pdZv+cP6utwwsnE0o/oPLMzm23vb0VrYzrgQB1YCJvJ6ZPnDQXoDQ6RhFXrbVF4s6DAa2ENml6is1EpTkjUgIjZf3mlwyC5LpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXjFQYVbJwrHKx6I2AQobheaBTWxLRYjjRVTe2mDSIQ=;
 b=i9YAT3wUSfMJwZ2DnZ+MK+cGE5c8YGjJdD1QpYhjzElHIEq7b6Ywd9VbO6LMofYyyq+i4cKGyQsPJ+Tv/imKKOa1KVk6p/Itz/67o+F+HyQzE/2bxLHziK1a5bGFl3fNw99/N44EJxj69xqhd8HlNhbWcTKwI2aWCIdP1PbtqbWXNC/WyMXIHHG68Quv0lSpc8NREtRxtixg8MEiLD7SyVyx6lZuBk3P6OjUuB2kfnYhxxJc+fm72UorSPLHg6JUgiXHsUA5pK1q8jyJ9Tro5kfdqmqrWAQ79vvAlqPkCe6iJ+dsjjNNym8ZtN9MIL76sfuG0Noa9D+L/P4CdoorPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXjFQYVbJwrHKx6I2AQobheaBTWxLRYjjRVTe2mDSIQ=;
 b=3CBwMWqdkLu9RtqtX2af43gskY0jJ7g9tVxgp7Y528IXNn26Wl+bBf/jDNqMEgxHHWgyk0IK8WyLxoJvIsfTABV7tNsdnFZJEj+uzg7fTB2mxHoKpC2M7wwQ0sCcHIoemecdNQlq71HBJcrCtQ6j5kaqiMi80I8socg7QsB9uaI=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:13 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:13 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 12/17] fuzz: Add fuzzer skeleton
Thread-Index: AQHVS1z31dBdM7+zmk6fOqR7q/o/8Q==
Date: Mon, 5 Aug 2019 07:11:13 +0000
Message-ID: <20190805071038.32146-13-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 8541545d-1566-4e8e-1808-08d71974198f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646E92B74D32825D57DC600BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hHcc+v9kSU26ZupZBHAYBFMWhgCdZjBEGmsPmg8vwOZBNZRGWTNN/B93zFn+zOFLgT3wC2Z2h1QZdvvmZJL13tOPsFjcaXMPUSYex9G8DhXHSvWplTQT0YEFusPAZ846rmKIw0ry9bKUvXJ/BKNVTO9sOV3pRfzmLakSe0+34MrKmEJ7CCGCBg+WarONBx7WDs13F2rCPOATCsUwc5NAeBHG+2WLQGiFcTPGtE7t7CTDkq72NUZD7bbf3owwd1mVnFLa+cItm3clqqxLjGnOyolcwZQM0MUiZQMIZA8nvDnJSg7RFbh8cR5VYBD04lwq0nb6d+vF6GDu6bTNcrlf4P1XYpXgEv/BFhtQwe5Q412viKjAdqpBMsapLM65Icri9EYAy4a0as1kpECYncJHUKlH6WOTbFdcy7pDK5r7xTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8541545d-1566-4e8e-1808-08d71974198f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:13.4502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.92
Subject: [Qemu-devel] [RFC PATCH v2 12/17] fuzz: Add fuzzer skeleton
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

The code defines the lifecycle of the fuzzer, and provides rebooting,
vmload and device_load as means of resetting state between fuzz runs

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/fuzz.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h |  70 +++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h

diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
new file mode 100644
index 0000000000..9e03e15d7b
--- /dev/null
+++ b/tests/fuzz/fuzz.c
@@ -0,0 +1,245 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/iov.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "migration/qemu-file.h"
+
+#include "migration/qemu-file.h"
+#include "migration/global_state.h"
+#include "migration/savevm.h"
+#include "tests/libqtest.h"
+#include "migration/migration.h"
+#include "fuzz.h"
+#include "tests/libqos/qgraph.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+
+QTestState *s;
+
+QEMUFile *ramfile;
+QEMUFile *writefile;
+ram_disk *rd;
+
+
+typedef struct FuzzTargetState {
+        FuzzTarget *target;
+        QSLIST_ENTRY(FuzzTargetState) target_list;
+} FuzzTargetState;
+
+typedef QSLIST_HEAD(, FuzzTargetState) FuzzTargetList;
+
+FuzzTargetList *fuzz_target_list;
+
+/* Save just the VMStateDescriptors */
+void save_device_state(void)
+{
+    writefile =3D qemu_fopen_ram(&rd);
+    global_state_store();
+    qemu_save_device_state(writefile);
+    qemu_fflush(writefile);
+    ramfile =3D qemu_fopen_ro_ram(rd);
+}
+
+/* Save the entire vm state including RAM */
+void save_vm_state(void)
+{
+    writefile =3D qemu_fopen_ram(&rd);
+    vm_stop(RUN_STATE_SAVE_VM);
+    global_state_store();
+    qemu_savevm_state(writefile, NULL);
+    qemu_fflush(writefile);
+    ramfile =3D qemu_fopen_ro_ram(rd);
+}
+
+/* Reset state by rebooting */
+void reboot()
+{
+    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
+}
+
+/* Restore device state */
+void load_device_state()
+{
+    qemu_freopen_ro_ram(ramfile);
+
+    int ret =3D qemu_load_device_state(ramfile);
+    if (ret < 0) {
+        printf("reset error\n");
+        exit(-1);
+    }
+}
+
+/* Restore full vm state */
+void load_vm_state()
+{
+    qemu_freopen_ro_ram(ramfile);
+
+    vm_stop(RUN_STATE_RESTORE_VM);
+
+    int ret =3D qemu_loadvm_state(ramfile);
+    if (ret < 0) {
+        printf("reset error\n");
+        exit(-1);
+    }
+    migration_incoming_state_destroy();
+    vm_start();
+}
+
+void qtest_setup()
+{
+    s =3D qtest_fuzz_init(NULL, NULL);
+    global_qtest =3D s;
+}
+
+void fuzz_add_target(const char *name, const char *description,
+        FuzzTarget *target)
+{
+
+    FuzzTargetState *tmp;
+    FuzzTargetState *target_state;
+    if (!fuzz_target_list) {
+        fuzz_target_list =3D g_new0(FuzzTargetList, 1);
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->target->name->str, name) =3D=3D 0) {
+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",
+                    name);
+            abort();
+        }
+    }
+    target_state =3D g_new0(FuzzTargetState, 1);
+    target_state->target =3D g_new0(FuzzTarget, 1);
+    *(target_state->target) =3D *target;
+    target_state->target->name =3D g_string_new(name);
+    target_state->target->description =3D g_string_new(description);
+    QSLIST_INSERT_HEAD(fuzz_target_list, target_state, target_list);
+}
+
+
+static FuzzTarget *fuzz_get_target(char* name)
+{
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized");
+        abort();
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->target->name->str, name) =3D=3D 0) {
+            break;
+        }
+    }
+    return tmp->target;
+}
+
+FuzzTarget *fuzz_target;
+
+
+
+static void usage(void)
+{
+    printf("Usage: ./fuzz --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n");
+    printf("where --FUZZ_TARGET is one of:\n");
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized");
+        abort();
+    }
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        printf(" --%s  : %s\n", tmp->target->name->str,
+                tmp->target->description->str);
+    }
+    exit(0);
+}
+
+static void enum_memory(void)
+{
+    /* TODO: Enumerate interesting memory using memory_region_is_ram */
+    return;
+}
+
+/* Executed for each fuzzing-input */
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
+{
+    /* e.g. Device bootstrapping */
+    if (fuzz_target->pre_fuzz) {
+        fuzz_target->pre_fuzz();
+    }
+
+    if (fuzz_target->fuzz) {
+        fuzz_target->fuzz(Data, Size);
+    }
+
+    /* e.g. Copy counter bitmap to shm*/
+    if (fuzz_target->post_fuzz) {
+        fuzz_target->post_fuzz();
+    }
+
+    /* e.g. Reboot the machine or vmload */
+    if (fuzz_target->reset) {
+        fuzz_target->reset();
+    }
+
+    return 0;
+}
+
+/* Executed once, prior to fuzzing */
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
+{
+
+    char *target_name;
+
+    /* Initialize qgraph and modules */
+    qos_graph_init();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_LIBQOS);
+
+    if (*argc <=3D 1) {
+        usage();
+    }
+
+
+    /* Identify the fuzz target */
+    target_name =3D (*argv)[1];
+    target_name +=3D 2;
+    fuzz_target =3D fuzz_get_target(target_name);
+
+    if (!fuzz_target) {
+        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n",
+                target_name);
+        usage();
+    }
+
+    if (fuzz_target->pre_main) {
+        fuzz_target->pre_main();
+    }
+
+    /* Run QEMU's regular vl.c:main */
+    qemu_init(*(fuzz_target->main_argc), *(fuzz_target->main_argv), NULL);
+
+
+    /* Enumerate memory to identify mapped MMIO and I/O regions */
+    enum_memory();
+
+    /* Good place to do any one-time device initialization (such as QOS in=
it) */
+    if (fuzz_target->pre_save_state) {
+        fuzz_target->pre_save_state();
+    }
+
+    /* If configured, this is where we save vm or device state to ramdisk =
*/
+    if (fuzz_target->save_state) {
+        fuzz_target->save_state();
+    }
+
+    return 0;
+}
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
new file mode 100644
index 0000000000..46ec38d4ea
--- /dev/null
+++ b/tests/fuzz/fuzz.h
@@ -0,0 +1,70 @@
+#ifndef FUZZER_H_
+#define FUZZER_H_
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "tests/libqtest.h"
+#include "migration/qemu-file.h"
+
+#include <linux/userfaultfd.h>
+
+
+extern QTestState *s;
+extern QEMUFile *writefile;
+extern QEMUFile *ramfile;
+extern ram_disk *rd;
+
+typedef struct FuzzTarget {
+    GString *name;
+    GString *description;
+    void(*pre_main)(void);
+    void(*pre_save_state)(void);
+    void(*save_state)(void);
+    void(*reset)(void);
+    void(*pre_fuzz)(void);
+    void(*fuzz)(const unsigned char*, size_t);
+    void(*post_fuzz)(void);
+    int *main_argc;
+    char ***main_argv;
+} FuzzTarget;
+
+
+void save_device_state(void);
+void save_vm_state(void);
+void reboot(void);
+
+void load_device_state(void);
+void load_vm_state(void);
+
+
+void save_device_state(void);
+void qtest_setup(void);
+void fuzz_register_mr(const MemoryRegion *mr);
+
+extern FuzzTarget *fuzz_target;
+
+typedef struct fuzz_memory_region {
+    bool io;
+    uint64_t start;
+    uint64_t length;
+    struct fuzz_memory_region *next;
+} fuzz_memory_region;
+
+extern fuzz_memory_region *fuzz_memory_region_head;
+extern fuzz_memory_region *fuzz_memory_region_tail;
+
+extern uint64_t total_io_mem;
+extern uint64_t total_ram_mem;
+
+
+
+void fuzz_add_target(const char *name, const char *description, FuzzTarget
+        *target);
+
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
+
+#endif
+
--=20
2.20.1


