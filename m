Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34967C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ABD20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4e1bIaKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ABD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cOF-0002uu-6R
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG5-0006hh-Mp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cG3-0000Do-JR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cG3-0008My-7u
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=divJaRh9hJLA6/CskuGa+d2aKxaenXUl9290eiCnTq0W2oGlHATWZ/4tx7nTnXeNf8VFxkhH3JC/W3j9T++TfBezMfQ7DTeqmywsgbMW/rIl/ywFCNqNND16XIq1mTbo+qSZvfsFvfBDAVyCdnCwlBST+3N6rfD8FxtKJ1Aa/F3rgRhpv9f8uBq6pFV7ewehuCT4LdWItOVJULcyYoODNVJb8xuyoSNuv0NXq+zbM73KPlbK/i5pP37BS5dVauDTyoQ66beUXge2JHE9sVrm0AkfcB2Drm8zJi0xLvLH7Pog4NM3b+BaWy8TzPgczCGsOVrH0y7IxDjxShzIIppvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cktvTDTXYe8uMVWK4Z54RXGzV2P4V9b7TT+6HraiB48=;
 b=A6MlDgUhRPNXwNZbhbk+SigmK5QKHadE58ysif0dLOVl/ODS1shyAFTRj7R3OLnO0a7GOhttyvAettftELmx/RVt2vag8OYk32aJsFRib1BC8Wab2HzIna5zkmrBhApeKfDTeghbYC2q/7KG85tTGbwBRFZpSANpfJSfNr/aJUonu5OZMp0EXiWj1aqRZJjsxQolXXnt/PAO1pz9Fe/3+g2bp2yf6a/03EvFCNj11G5BeDgF2YIDgBDBqL3tREWIiS995iQRCKEcv7tZUmBgufTv1Bo2nf5Eip9E6+pSrAlVEBcDrUtsO2fXPeUDq/YPnzrSiV1+7TC2Ico42t1s1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cktvTDTXYe8uMVWK4Z54RXGzV2P4V9b7TT+6HraiB48=;
 b=4e1bIaKTmtA5GVjNwvX4SChezv1oXRUNUpNA9LCHy8JZgjq5Y8na+YmqCjJEIc00LE6iGj0bpanp2SijWRnLgMjBqCD3/Lbn9tQKDfeGw3i/hQquHsWMZba5tDznpO2irWjldLjVpQLEzXxva6qjUwoA161o/y24P5hrrtDfeNc=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 23/23] fuzz: add documentation to docs/devel/
Date: Tue, 11 Feb 2020 15:35:10 -0500
Message-ID: <20200211203510.3534-24-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6660641f-1b26-44f0-422c-08d7af31f6b4
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336ED8645D649EF9B1A1221BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5aFvZFOZI657c1RERe89R9z5aWeeFMmEKopAT2PMIlP9SEiwxf748T4BSWN8YoC7gv2BrqhTsRBMOsPooCpw7CB6+X9+ITVTnuZwrQKjKcuGMgA67JBX1lCvRZVvGYUfFmi+r97nCJVjkcWf7gaOs6x3Nk0c9Dxr7r1E3qGeKp73alQ1l82i+Mf5MKmbGeIi/ZWNaHMSQ5MiOYg2/NX+KRQOGyobd/Fzh5YL6lUi87S5f7wIha82nV5K1YR7iEZXh8RPONSSzM98nkfjk19Vv1lvuq/8b/QmpiyxvB0yd5+o/SiLAs6yGEysgSxhtPhOgHl8nJX1jdp0KFDqJ9pDD8rvuubc3m4h/coSho7O6pju5XwXVbSoud/9NmgR0cxzFoTNiN8GRkHe7AOuIHHPzkWRmU1GIej9+3YCZn+2I31KuFYRYjPx1gtM+BcHHYy
X-MS-Exchange-AntiSpam-MessageData: 2ioO0GDNpG73/4F4MvHuGeRzFkkauZ4+bj8J638lcOZMIxG0Yg3LINJNqSsdUiTaSKn5/Jrvun+UpxN1V5xNpWHF1zWwSLtCsfJTxzh4awiUo+3D06YG2o11ZI3jTO0n0goJiZY43Ou2JYOfgPXXuw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6660641f-1b26-44f0-422c-08d7af31f6b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:42.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1I4Y4hxZRJ1sfba0uGcPKvLAg2pmNmDsXrELuaiTsIFS2DE8P5ZtfI2F5DaEBn3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.69.106
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 docs/devel/fuzzing.txt | 116 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 docs/devel/fuzzing.txt

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
new file mode 100644
index 0000000000..324d2cd92b
--- /dev/null
+++ b/docs/devel/fuzzing.txt
@@ -0,0 +1,116 @@
+=3D Fuzzing =3D
+
+=3D=3D Introduction =3D=3D
+
+This document describes the virtual-device fuzzing infrastructure in QEMU =
and
+how to use it to implement additional fuzzers.
+
+=3D=3D Basics =3D=3D
+
+Fuzzing operates by passing inputs to an entry point/target function. The
+fuzzer tracks the code coverage triggered by the input. Based on these
+findings, the fuzzer mutates the input and repeats the fuzzing.
+
+To fuzz QEMU, we rely on libfuzzer. Unlike other fuzzers such as AFL, libf=
uzzer
+is an _in-process_ fuzzer. For the developer, this means that it is their
+responsibility to ensure that state is reset between fuzzing-runs.
+
+=3D=3D Building the fuzzers =3D=3D
+
+NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer =
is
+much faster, since the page-map has a smaller size. This is due to the fac=
t that
+AddressSanitizer mmaps ~20TB of memory, as part of its detection. This res=
ults
+in a large page-map, and a much slower fork().
+
+To build the fuzzers, install a recent version of clang:
+Configure with (substitute the clang binaries with the version you install=
ed):
+
+    CC=3Dclang-8 CXX=3Dclang++-8 /path/to/configure --enable-fuzzing
+
+Fuzz targets are built similarly to system/softmmu:
+
+    make i386-softmmu/fuzz
+
+This builds ./i386-softmmu/qemu-fuzz-i386
+
+The first option to this command is: --fuzz_taget=3DFUZZ_NAME
+To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
+
+eg:
+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=3Dvirtio-net-fork-fuzz
+
+Internally, libfuzzer parses all arguments that do not begin with "--".
+Information about these is available by passing -help=3D1
+
+Now the only thing left to do is wait for the fuzzer to trigger potential
+crashes.
+
+=3D=3D Adding a new fuzzer =3D=3D
+Coverage over virtual devices can be improved by adding additional fuzzers=
.
+Fuzzers are kept in tests/qtest/fuzz/ and should be added to
+tests/qtest/fuzz/Makefile.include
+
+Fuzzers can rely on both qtest and libqos to communicate with virtual devi=
ces.
+
+1. Create a new source file. For example ``tests/qtest/fuzz/foo-device-fuz=
z.c``.
+
+2. Write the fuzzing code using the libqtest/libqos API. See existing fuzz=
ers
+for reference.
+
+3. Register the fuzzer in ``tests/fuzz/Makefile.include`` by appending the
+corresponding object to fuzz-obj-y
+
+Fuzzers can be more-or-less thought of as special qtest programs which can
+modify the qtest commands and/or qtest command arguments based on inputs
+provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly =
the
+fuzzer loops over the byte-array interpreting it as a list of qtest comman=
ds,
+addresses, or values.
+
+=3D Implementation Details =3D
+
+=3D=3D The Fuzzer's Lifecycle =3D=3D
+
+The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it=
's
+own main(), which performs some setup, and calls the entrypoints:
+
+LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of t=
he
+necessary state
+
+LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input a=
nd
+resets the state at the end of each run.
+
+In more detail:
+
+LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with t=
wo
+dashes, so they are ignored by libfuzzer main()). Currently, the arguments
+select the fuzz target. Then, the qtest client is initialized. If the targ=
et
+requires qos, qgraph is set up and the QOM/LIBQOS modules are initialized.
+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
+
+After this, the vl.c:qemu__main is called to set up the guest. There are
+target-specific hooks that can be called before and after qemu_main, for
+additional setup(e.g. PCI setup, or VM snapshotting).
+
+LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
+input. It is also responsible for manually calling the main loop/main_loop=
_wait
+to ensure that bottom halves are executed and any cleanup required before =
the
+next input.
+
+Since the same process is reused for many fuzzing runs, QEMU state needs t=
o
+be reset at the end of each run. There are currently two implemented
+options for resetting state:
+1. Reboot the guest between runs.
+   Pros: Straightforward and fast for simple fuzz targets.
+   Cons: Depending on the device, does not reset all device state. If the
+   device requires some initialization prior to being ready for fuzzing
+   (common for QOS-based targets), this initialization needs to be done af=
ter
+   each reboot.
+   Example target: i440fx-qtest-reboot-fuzz
+2. Run each test case in a separate forked process and copy the coverage
+   information back to the parent. This is fairly similar to AFL's "deferr=
ed"
+   fork-server mode [3]
+   Pros: Relatively fast. Devices only need to be initialized once. No nee=
d
+   to do slow reboots or vmloads.
+   Cons: Not officially supported by libfuzzer. Does not work well for dev=
ices
+   that rely on dedicated threads.
+   Example target: virtio-net-fork-fuzz
--=20
2.25.0


