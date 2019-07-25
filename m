Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841DC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8CA22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6ZVBcGzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8CA22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUPp-0002Q7-Th
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMM-0004b3-77
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMK-0001sf-GO
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:02 -0400
Received: from mail-eopbgr780120.outbound.protection.outlook.com
 ([40.107.78.120]:46306 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMK-0001sD-7k
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4+0rgHDpuCMinRpXG3kpP/DP2tUafPRtkQPSuf/6NNXkXsRhHxvlIcKXMhwyKXMhzgseXHbzOnSfrfYj6olnkZHX+IdsBttSaeT+Cwr7C309Y7d19dBYSWUkVM11AG3jgLdNnMNtmcJGCbpwxav5ek1Kcbhnpz1woUYweEG4hoPDd5eHbE4IwPsn9nMYB9BFVm1ERsb/eAjfgS2ExOT3SD6kPm+iIPsm+yy0E0HXHQewTtiVamq8++/EovNmSglj+yfW09151YF/zr4rbcHh0/JB3Bz+UgslSOxAn2rn9bjVFwdMI9N2cGwkchgD4qYh9TtY70acgz/iIlnF/Mwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWMwWHTMUJcqMPtbEQj5oi72ooiECKQkr2WpCkDGuI4=;
 b=dFTMzQ8V8EUc0lPvj3h6nZhlUMZZIT6A4NPMi81jJJTb7ZGL+KnLWqlkCe5ExlRABSbqDq3iWGl7j6W6tyK8TCyAGq8cWvqO5I/FxBNbcGvuiXWEpG2maQb1Ciixp5WA76Y15moCvOBD3uJoYARkmDiAh11LuNNFVh/j80NZHplmO6kSy1i+DwScdw+MSbOmcHDq8OAw0hPGuHPfYYvs+Nls8Lncz8rpzhxysCbo0svm/A8WQHI08fFRjMwTGXjJo0XDrv2qJKQXyFvnwfbcGysYoE4VuN5l6lN6uRCIQeZSbUAmMNG9alwLWfqiOtcyB2gI+SYLyRwmlEkTgkdBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWMwWHTMUJcqMPtbEQj5oi72ooiECKQkr2WpCkDGuI4=;
 b=6ZVBcGzp2pm9SQ8ITzbAt3Y7ycsNXYh0o03z3NtD+P0oYXc75xu9ZS85QZjow/yUmv2p7tOkGvW9U+GyYQwU6ydwmnVv2IV5cxPyha7KOpAQFl5bVJOYWYsEZpU6Z0TXaIWvjlsC9LqL/wdL5VX67S3lwu3Cl3R+QS3fo0PE8ts=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2534.namprd03.prod.outlook.com (10.168.165.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:58 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:58 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 16/19] fuzz: add general fuzzer entrypoints
Thread-Index: AQHVQphlQx62aD1/gEu8q68D053Ppw==
Date: Thu, 25 Jul 2019 03:23:58 +0000
Message-ID: <20190725032321.12721-17-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 67f9b823-0fac-4102-d1d3-08d710af87ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2534; 
x-ms-traffictypediagnostic: CY4PR03MB2534:
x-microsoft-antispam-prvs: <CY4PR03MB2534BED5A3798DC9CFFE3D63BAC10@CY4PR03MB2534.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(446003)(2501003)(186003)(86362001)(14444005)(2906002)(26005)(2616005)(3846002)(6512007)(6116002)(256004)(476003)(53936002)(4326008)(11346002)(76176011)(81156014)(102836004)(75432002)(6916009)(52116002)(88552002)(386003)(81166006)(6506007)(2351001)(14454004)(25786009)(478600001)(36756003)(8936002)(316002)(486006)(66476007)(54906003)(71190400001)(1076003)(66066001)(5640700003)(50226002)(99286004)(6486002)(305945005)(5660300002)(64756008)(7736002)(786003)(8676002)(66446008)(66556008)(66946007)(68736007)(6436002)(71200400001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2534;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LHXi8DCG54jUDZ4ZUAGIbOmtIprTE4zHRd+3FiQNNOFfMCmqbCC2eAnSYih9nWiOEpcWHDXzgSsteVJlXGE52c5pX6C3MWpyFm5bstifH/ZBCKVST9xr9qleyUo8M4B2ZSo9PX/OpLvSFJpZDu2AfRKJkwPMlA1Nq5xVwso3qDQ0LnmQekQe990kg+dIB8DWTBjHHQhJ/fdwwtS7BP1v1MVJAcxx8PmqSijwns/bmIuKI4i9exyQPcksg1vyTmrZtayM5B4Fmto4TOHBHMWEyLE5f1fEofTrLfFGt9vA5KSA/CyJ0cqhrH9dqo8++qOeN6UYJbIj3kUfDo1Z69Tk+d5kbHWNLwKoY5lp7vF8o9zxRYIX+YUZBmlNj/hP37n31JCJWjpgefS1+oA4gSE+aQmGwXsDAh/tMIGOgYxh/ms=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f9b823-0fac-4102-d1d3-08d710af87ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:58.1983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2534
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.120
Subject: [Qemu-devel] [RFC 16/19] fuzz: add general fuzzer entrypoints
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

Defines LLVMFuzzerInitialize and LLVMFuzzerTestOneInput

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/fuzz.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h |  96 +++++++++++++++++
 2 files changed, 358 insertions(+)
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h

diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
new file mode 100644
index 0000000000..0421b9402c
--- /dev/null
+++ b/tests/fuzz/fuzz.c
@@ -0,0 +1,262 @@
+#include "tests/fuzz/ramfile.h"
+#include "migration/qemu-file.h"
+#include "migration/global_state.h"
+#include "migration/savevm.h"
+#include "tests/libqtest.h"
+#include "exec/memory.h"
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
+ram_disk *rd;=20
+typedef QSLIST_HEAD(, FuzzTarget) FuzzTargetList;
+
+FuzzTargetList* fuzz_target_list;
+
+uint64_t total_mr_size =3D 0;
+uint64_t mr_index =3D 0;
+
+const MemoryRegion* mrs[1000];
+
+
+// Save just the VMStateDescriptors
+void save_device_state(void)
+{
+    writefile =3D qemu_fopen_ram(&rd);
+    global_state_store();
+    qemu_save_device_state(writefile);
+    qemu_fflush(writefile);
+    ramfile =3D qemu_fopen_ro_ram(rd);
+}
+
+// Save the entire vm state including RAM
+void save_vm_state(void)=20
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
+    if (ret < 0){
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
+    /* qemu_system_reset(SHUTDOWN_CAUSE_NONE); */
+
+    int ret =3D qemu_loadvm_state(ramfile);
+    if (ret < 0){
+        printf("reset error\n");
+        exit(-1);
+    }
+    migration_incoming_state_destroy();
+    vm_start();
+}
+
+void qtest_setup()
+{
+    s =3D qtest_init_fuzz(NULL, NULL);
+    global_qtest =3D s;
+}
+
+void fuzz_add_target(const char* name,
+        const char* description,
+        void(*init_pre_main)(void),
+        void(*init_pre_save)(void),
+        void(*save_state)(void),
+        void(*reset)(void),
+        void(*pre_fuzz)(void),
+        void(*fuzz)(const unsigned char*, size_t),
+        void(*post_fuzz)(void),
+        int* main_argc,
+        char*** main_argv)
+{
+
+    FuzzTarget *target;
+    FuzzTarget *tmp;
+    if(!fuzz_target_list)
+        fuzz_target_list =3D g_new0(FuzzTargetList, 1);
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->name->str, name) =3D=3D 0) {
+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",=
 name);
+            abort();
+        }
+    }
+    target =3D g_new0(FuzzTarget, 1);
+    target->name =3D g_string_new(name);
+    target->description =3D g_string_new(description);
+    target->init_pre_main =3D init_pre_main;
+    target->init_pre_save =3D init_pre_save;
+    target->save_state =3D save_state;
+    target->reset =3D reset;
+    target->pre_fuzz =3D pre_fuzz;
+    target->fuzz =3D fuzz;
+    target->post_fuzz =3D post_fuzz;
+    target->main_argc =3D main_argc;
+    target->main_argv =3D main_argv;
+    QSLIST_INSERT_HEAD(fuzz_target_list, target, target_list);
+}
+
+
+FuzzTarget* fuzz_get_target(char* name)
+{
+    FuzzTarget* tmp;
+    if(!fuzz_target_list){
+        fprintf(stderr, "Fuzz target list not initialized");
+        abort();
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->name->str, name) =3D=3D 0) {
+            break;
+        }
+    }
+    return tmp;
+}
+
+FuzzTarget* fuzz_target;
+
+
+
+static void usage(void)
+{
+    printf("Usage: ./fuzz --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n");
+    printf("where --FUZZ_TARGET is one of:\n");
+    FuzzTarget* tmp;
+    if(!fuzz_target_list){
+        fprintf(stderr, "Fuzz target list not initialized");
+        abort();
+    }
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+            printf(" --%s  : %s\n", tmp->name->str, tmp->description->str)=
;
+        }
+        exit(0);
+    }
+}
+
+// TODO: Replace this with QEMU's built-in linked list
+static void enum_memory(void)
+{
+    mtree_info(true, true, true);
+    fuzz_memory_region *fmr =3D g_new0(fuzz_memory_region, 1);
+
+    fmr->io =3D false;
+    fmr->start =3D 0x100000;
+    fmr->length =3D 0x10000;
+    fmr->next =3D fuzz_memory_region_head;
+    fuzz_memory_region_tail->next =3D fmr;
+    fuzz_memory_region_tail =3D fmr;
+    fmr =3D fuzz_memory_region_head;
+
+    while(true){
+        fmr =3D fmr->next;
+        if(fmr =3D=3D fuzz_memory_region_head)
+            break;
+    }
+}
+
+/* Executed for each fuzzing-input */
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
+{
+    /* e.g. Device bootstrapping */
+    if(fuzz_target->pre_fuzz)
+        fuzz_target->pre_fuzz();
+
+    if(fuzz_target->fuzz)
+        fuzz_target->fuzz(Data, Size);
+
+    /* e.g. Copy counter bitmap to shm*/
+    if(fuzz_target->post_fuzz)
+        fuzz_target->post_fuzz();
+
+    /* e.g. Reboot the machine or vmload */
+    if(fuzz_target->reset)
+        fuzz_target->reset();
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
+    // Initialize qgraph and modules
+    qos_graph_init();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_LIBQOS);
+
+    if(*argc <=3D 1)
+        usage();
+
+
+    /* Identify the fuzz target */
+    target_name =3D (*argv)[1];
+    target_name+=3D2;
+    fuzz_target =3D fuzz_get_target(target_name);
+
+    if(!fuzz_target)
+    {
+        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n", tar=
get_name);
+        usage();
+    }
+
+    if(fuzz_target->init_pre_main)
+        fuzz_target->init_pre_main();
+
+    /* Run QEMU's regular vl.c:main */
+    real_main(*(fuzz_target->main_argc), *(fuzz_target->main_argv), NULL);
+
+
+    /* Enumerate memory to identify mapped MMIO and I/O regions */
+    enum_memory();
+
+    /* Good place to do any one-time device initialization (such as QOS in=
it) */
+    if(fuzz_target->init_pre_save)
+        fuzz_target->init_pre_save();
+
+    /* If configured, this is where we save vm or device state to ramdisk =
*/
+    if(fuzz_target->save_state)
+        fuzz_target->save_state();
+
+    return 0;
+}
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
new file mode 100644
index 0000000000..02f26752eb
--- /dev/null
+++ b/tests/fuzz/fuzz.h
@@ -0,0 +1,96 @@
+#ifndef FUZZER_H_
+#define FUZZER_H_
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "tests/libqtest.h"
+#include "migration/qemu-file.h"
+#include "ramfile.h"
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
+	GString* name;
+	GString* description;
+	void(*init_pre_main)(void);
+	void(*init_pre_save)(void);
+	void(*save_state)(void);
+	void(*reset)(void);
+	void(*pre_fuzz)(void);
+	void(*fuzz)(const unsigned char*, size_t);
+	void(*post_fuzz)(void);
+	int* main_argc;
+	char*** main_argv;
+	QSLIST_ENTRY(FuzzTarget) target_list;
+
+} FuzzTarget;
+
+extern void* _ZN6fuzzer3TPCE;
+/* extern uint8_t __sancov_trace_pc_guard_8bit_counters; */
+/* extern uint8_t __sancov_trace_pc_pcs; */
+extern void* __prof_nms_sect_data;
+extern void* __prof_vnodes_sect_data;
+
+#define TPC_SIZE 0x0443c00
+#define PROFILE_SIZE ( &__prof_vnodes_sect_data - &__prof_nms_sect_data)
+
+#define NUMPCS (1 << 21)
+/* #define TPC_SIZE 0x33c00 */
+
+extern uint8_t *TPCCopy;
+extern uint8_t *ARGCopy;
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
+FuzzTarget* fuzz_get_target(char* name);
+
+extern FuzzTarget* fuzz_target;
+
+typedef struct fuzz_memory_region {
+	bool io;
+	uint64_t start;
+	uint64_t length;
+	struct fuzz_memory_region* next;
+} fuzz_memory_region;
+
+extern fuzz_memory_region *fuzz_memory_region_head;
+extern fuzz_memory_region *fuzz_memory_region_tail;
+
+extern uint64_t total_io_mem;
+extern uint64_t total_ram_mem;
+
+void fuzz_add_target(const char* name,
+	const char* description,
+	void(*init_pre_main)(void),
+	void(*init_pre_save)(void),
+	void(*save_state)(void),
+	void(*reset)(void),
+	void(*pre_fuzz)(void),
+	void(*fuzz)(const unsigned char*, size_t),
+	void(*post_fuzz)(void),
+	int* main_argc,
+	char*** main_argv);
+
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
+
+#endif
+
--=20
2.20.1


