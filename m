Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2DD206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Xgvr9IMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2DD206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb69m-00062F-RY
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67x-0004MG-Ur
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:21 -0500
Received: from mail-dm6nam08on2113.outbound.protection.outlook.com
 ([40.107.102.113]:7896 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67v-0002XB-4u
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvY8frrfPMOYXHpaupZdbOYi9e5iZ/MQxRm4WZZoh3jC4Zl/dCIfru3gB6n+NyniIYe9CNtolEdM8Wkrg9zZFMY0q6aomlLlbeKLy4R5IVWsr4kpoivPrivYYGS45iEzWDRR56wYdFufHz7GavQf7C2CsIwIxwosPr6vfnz7looQlCIAxcNWl53wnXAzejVqVFSNwU9LMZKzNX2fsIyqL/B7Z02ccsExsq3WHR0FguxwOaoHxjSiN6BMFRnE03eRvOIuqhkvU6FzAywj0uYiRHwsec8phVwtfXa7WzcabpHsf2C/gTDvQu96rwf2ecDX5xiNiVUGRlKKReyDusJTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yVbIbdl18C4f45HtFVfIfRIsKldg+5gVRRd+GzYd2U=;
 b=S//GXRUEsHTl0BV7N4Yv4d6wFyE6lHH4tiCkSo/h8dM2AV9sUGSzDwkFLIBaFeCL4R4yMioSHEOfvsc7wpVL5VUslYZyb7AQybWW3ZcoSnMbc7uk/NsHrGjCSL9J1W14QjATmcnG9zBcw6524BUGI+37Sb/iFyaLcoOmkkGmUKG65QZeI5lVDfPzA5QnflLyjHc6dgRt1+QQ7iH26F1IEd5DGjIAq/xH+h8JKEBTuDdTRzniowSCw5lZEnvyHYos6S2Z/dBd6O2pESalzUOA9zX/BnN6KpUc83yWY0tGMCiWTsDRf7EKa4m64RSDPGs66Y5MsLPb5rlwk7M+j9rOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yVbIbdl18C4f45HtFVfIfRIsKldg+5gVRRd+GzYd2U=;
 b=Xgvr9IMKMOm2wubu59nrhX7b1OjkwlpzE0HklKVKkj9fowlfhg+gM0BBjBQ4Jk+H+BFr8qhXtIgniGY7ddR43pooxA4JdZm9jwD+XVc+L9cBGXXfrDpWJYEn42fk5e6us6tLqxiN2+aLOLqO3askvlTMpwLJBBwn5O3Yp2Sh4do=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2207.namprd03.prod.outlook.com (2603:10b6:804:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 18:06:14 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 18:06:14 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] docs/fuzz: rST-ify the fuzzing documentation
Date: Fri,  6 Nov 2020 13:05:59 -0500
Message-Id: <20201106180600.360110-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106180600.360110-1-alxndr@bu.edu>
References: <20201106180600.360110-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR06CA0004.namprd06.prod.outlook.com (2603:10b6:208:23d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 18:06:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e29af97-970e-488e-349d-08d8827ea64a
X-MS-TrafficTypeDiagnostic: SN2PR03MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22077907B6C785CB044ED400BAED0@SN2PR03MB2207.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/Be8Qwfm266fONIUctVGJUNGbsTkaHKKwB5qZD79xhq2X5QZp0/VG/fkj9XphxNiK/FmwolmRjsVlji8nxdnTgFLV/S8wUqiLrpkCZ6QtWYMzgpqFbHT1J/4pXczDl4bA+QRWzvDhRJGa0XnSh4EP25w1oymvKXYlilYVoUjG9xZbdep7t2cIctwHizv1zA73BOwwk17orx5oqPaAhm4IaJdcatDenGxPoIC7Cqn8CiI5vI8F+Q0JO0+jGssJGqI5aErm8E5bUajw6tx/X6tfkeQwOPpsRUzbXqEgv1DCkbSEkR6iYUxxRfQ/Elxe6wbpdS8xYItI09FjP/pc9m6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(478600001)(83380400001)(956004)(786003)(316002)(54906003)(8676002)(4326008)(66476007)(2906002)(6486002)(186003)(66946007)(36756003)(66556008)(1076003)(52116002)(30864003)(6916009)(86362001)(16526019)(26005)(5660300002)(6506007)(8936002)(75432002)(6512007)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vwnO9mzaL9JDO3NNn5ImqS526iA5qn9JccTwnXUbcjWUPBwO/8RtwmxeOG7voUnPoOCc7iMjrdRhlqsZKAhcObaiND9h1/0PwgZCPs+XdUPv9G1JAfkZHUkWM7MqI5gsz6+touGDh4Bhha5tjGe2ySP42RrhCIYw1EjVVXlkrukqLlv/2q1QUeFH6bBXLHLv0CQLkFLiYDfWKqv6iei6NoY8qOA7zs78BsuFpIv1TkLmqzH9n460zLKQY+TtAAiL0NvSo5NDMsuU9QRqFSE8x/tOcLeVkAVtS4d6iDJSfVvyFrtltpo/TbiBigJH5MR7id/+kA265g9/ivlbNVOUTUyFsclctFuzGjVbNq+hn172NkIAP10qZtIrcJ6hqo74iAobyAb06te5Fw3LniLau79mjFZyYPGUxRyPNJ9UUJfh04McjUUzv/YZrmZ5FgjeybBeB5LTDHroEhUZvUW7A/8wjWomehFfOB9Lme7qadV9zhD8NdMavleFE07YHjE68QXoQC/SBXw6cLbNsEDck97WzSHqI0lgeV1WOvWdbN56CpZhUYGMedmU6NC0edhvOVfuEwxsu7OnwPljas5BPv0PNgh/IJywKOqGcIrM/xsyve3C0SR9J9Lvw3S5eX/I8sjEGB+K1g7i/8gDVxfUVQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e29af97-970e-488e-349d-08d8827ea64a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:06:14.2525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IugHKCOM2syZXVowDDy+nWh8oQVslPMKqS2wiSubHzL9xszuHpv0z6IwCInFOZS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2207
Received-SPF: pass client-ip=40.107.102.113; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 13:06:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 MAINTAINERS            |   2 +-
 docs/devel/fuzzing.rst | 236 +++++++++++++++++++++++++++++++++++++++++
 docs/devel/fuzzing.txt | 214 -------------------------------------
 docs/devel/index.rst   |   1 +
 4 files changed, 238 insertions(+), 215 deletions(-)
 create mode 100644 docs/devel/fuzzing.rst
 delete mode 100644 docs/devel/fuzzing.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 63223e1183..da1ef68ff1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2517,7 +2517,7 @@ R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: tests/qtest/fuzz/
 F: scripts/oss-fuzz/
-F: docs/devel/fuzzing.txt
+F: docs/devel/fuzzing.rst
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/docs/devel/fuzzing.rst b/docs/devel/fuzzing.rst
new file mode 100644
index 0000000000..f19d75ceff
--- /dev/null
+++ b/docs/devel/fuzzing.rst
@@ -0,0 +1,236 @@
+========
+Fuzzing
+========
+
+This document describes the virtual-device fuzzing infrastructure in QEMU and
+how to use it to implement additional fuzzers.
+
+Basics
+------
+
+Fuzzing operates by passing inputs to an entry point/target function. The
+fuzzer tracks the code coverage triggered by the input. Based on these
+findings, the fuzzer mutates the input and repeats the fuzzing.
+
+To fuzz QEMU, we rely on libfuzzer. Unlike other fuzzers such as AFL, libfuzzer
+is an *in-process* fuzzer. For the developer, this means that it is their
+responsibility to ensure that state is reset between fuzzing-runs.
+
+Building the fuzzers
+--------------------
+
+*NOTE*: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer is
+much faster, since the page-map has a smaller size. This is due to the fact that
+AddressSanitizer maps ~20TB of memory, as part of its detection. This results
+in a large page-map, and a much slower ``fork()``.
+
+To build the fuzzers, install a recent version of clang:
+Configure with (substitute the clang binaries with the version you installed).
+Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
+such as out-of-bounds accesses, use-after-frees, double-frees etc.::
+
+    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
+                                                --enable-sanitizers
+
+Fuzz targets are built similarly to system targets::
+
+    make i386-softmmu/fuzz
+
+This builds ``./i386-softmmu/qemu-fuzz-i386``
+
+The first option to this command is: ``--fuzz-target=FUZZ_NAME``
+To list all of the available fuzzers run ``qemu-fuzz-i386`` with no arguments.
+
+For example::
+
+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
+
+Internally, libfuzzer parses all arguments that do not begin with ``"--"``.
+Information about these is available by passing ``-help=1``
+
+Now the only thing left to do is wait for the fuzzer to trigger potential
+crashes.
+
+Useful libFuzzer flags
+----------------------
+
+As mentioned above, libFuzzer accepts some arguments. Passing ``-help=1`` will
+list the available arguments. In particular, these arguments might be helpful:
+
+* ``CORPUS_DIR/`` : Specify a directory as the last argument to libFuzzer.
+  libFuzzer stores each "interesting" input in this corpus directory. The next
+  time you run libFuzzer, it will read all of the inputs from the corpus, and
+  continue fuzzing from there. You can also specify multiple directories.
+  libFuzzer loads existing inputs from all specified directories, but will only
+  write new ones to the first one specified.
+
+* ``-max_len=4096`` : specify the maximum byte-length of the inputs libFuzzer
+  will generate.
+
+* ``-close_fd_mask={1,2,3}`` : close, stderr, or both. Useful for targets that
+  trigger many debug/error messages, or create output on the serial console.
+
+* ``-jobs=4 -workers=4`` : These arguments configure libFuzzer to run 4 fuzzers in
+  parallel (4 fuzzing jobs in 4 worker processes). Alternatively, with only
+  ``-jobs=N``, libFuzzer automatically spawns a number of workers less than or equal
+  to half the available CPU cores. Replace 4 with a number appropriate for your
+  machine. Make sure to specify a ``CORPUS_DIR``, which will allow the parallel
+  fuzzers to share information about the interesting inputs they find.
+
+* ``-use_value_profile=1`` : For each comparison operation, libFuzzer computes
+  ``(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12)`` and places this in the
+  coverage table. Useful for targets with "magic" constants. If Arg1 came from
+  the fuzzer's input and Arg2 is a magic constant, then each time the Hamming
+  distance between Arg1 and Arg2 decreases, libFuzzer adds the input to the
+  corpus.
+
+* ``-shrink=1`` : Tries to make elements of the corpus "smaller". Might lead to
+  better coverage performance, depending on the target.
+
+Note that libFuzzer's exact behavior will depend on the version of
+clang and libFuzzer used to build the device fuzzers.
+
+Generating Coverage Reports
+---------------------------
+
+Code coverage is a crucial metric for evaluating a fuzzer's performance.
+libFuzzer's output provides a "cov: " column that provides a total number of
+unique blocks/edges covered. To examine coverage on a line-by-line basis we
+can use Clang coverage:
+
+ 1. Configure libFuzzer to store a corpus of all interesting inputs (see
+    CORPUS_DIR above)
+ 2. ``./configure`` the QEMU build with ::
+
+    --enable-fuzzing \
+    --extra-cflags="-fprofile-instr-generate -fcoverage-mapping"
+
+ 3. Re-run the fuzzer. Specify $CORPUS_DIR/* as an argument, telling libfuzzer
+    to execute all of the inputs in $CORPUS_DIR and exit. Once the process
+    exits, you should find a file, "default.profraw" in the working directory.
+ 4. Execute these commands to generate a detailed HTML coverage-report::
+
+      llvm-profdata merge -output=default.profdata default.profraw
+      llvm-cov show ./path/to/qemu-fuzz-i386 -instr-profile=default.profdata \
+      --format html -output-dir=/path/to/output/report
+
+Adding a new fuzzer
+-------------------
+
+Coverage over virtual devices can be improved by adding additional fuzzers.
+Fuzzers are kept in ``tests/qtest/fuzz/`` and should be added to
+``tests/qtest/fuzz/Makefile.include``
+
+Fuzzers can rely on both qtest and libqos to communicate with virtual devices.
+
+1. Create a new source file. For example ``tests/qtest/fuzz/foo-device-fuzz.c``.
+
+2. Write the fuzzing code using the libqtest/libqos API. See existing fuzzers
+   for reference.
+
+3. Register the fuzzer in ``tests/fuzz/Makefile.include`` by appending the
+   corresponding object to fuzz-obj-y
+
+Fuzzers can be more-or-less thought of as special qtest programs which can
+modify the qtest commands and/or qtest command arguments based on inputs
+provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
+fuzzer loops over the byte-array interpreting it as a list of qtest commands,
+addresses, or values.
+
+The Generic Fuzzer
+------------------
+
+Writing a fuzz target can be a lot of effort (especially if a device driver has
+not be built-out within libqos). Many devices can be fuzzed to some degree,
+without any device-specific code, using the generic-fuzz target.
+
+The generic-fuzz target is capable of fuzzing devices over their PIO, MMIO,
+and DMA input-spaces. To apply the generic-fuzz to a device, we need to define
+two env-variables, at minimum:
+
+* ``QEMU_FUZZ_ARGS=`` is the set of QEMU arguments used to configure a machine, with
+  the device attached. For example, if we want to fuzz the virtio-net device
+  attached to a pc-i440fx machine, we can specify::
+
+    QEMU_FUZZ_ARGS="-M pc -nodefaults -netdev user,id=user0 \
+    -device virtio-net,netdev=user0"
+
+* ``QEMU_FUZZ_OBJECTS=`` is a set of space-delimited strings used to identify
+  the MemoryRegions that will be fuzzed. These strings are compared against
+  MemoryRegion names and MemoryRegion owner names, to decide whether each
+  MemoryRegion should be fuzzed. These strings support globbing. For the
+  virtio-net example, we could use one of ::
+
+    QEMU_FUZZ_OBJECTS='virtio-net'
+    QEMU_FUZZ_OBJECTS='virtio*'
+    QEMU_FUZZ_OBJECTS='virtio* pcspk' # Fuzz the virtio devices and the speaker
+    QEMU_FUZZ_OBJECTS='*' # Fuzz the whole machine``
+
+The ``"info mtree"`` and ``"info qom-tree"`` monitor commands can be especially
+useful for identifying the ``MemoryRegion`` and ``Object`` names used for
+matching.
+
+As a generic rule-of-thumb, the more ``MemoryRegions``/Devices we match, the
+greater the input-space, and the smaller the probability of finding crashing
+inputs for individual devices. As such, it is usually a good idea to limit the
+fuzzer to only a few ``MemoryRegions``.
+
+To ensure that these env variables have been configured correctly, we can use::
+
+    ./qemu-fuzz-i386 --fuzz-target=generic-fuzz -runs=0
+
+The output should contain a complete list of matched MemoryRegions.
+
+Implementation Details / Fuzzer Lifecycle
+-----------------------------------------
+
+The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it's
+own ``main()``, which performs some setup, and calls the entrypoints:
+
+``LLVMFuzzerInitialize``: called prior to fuzzing. Used to initialize all of the
+necessary state
+
+``LLVMFuzzerTestOneInput``: called for each fuzzing run. Processes the input and
+resets the state at the end of each run.
+
+In more detail:
+
+``LLVMFuzzerInitialize`` parses the arguments to the fuzzer (must start with two
+dashes, so they are ignored by libfuzzer ``main()``). Currently, the arguments
+select the fuzz target. Then, the qtest client is initialized. If the target
+requires qos, qgraph is set up and the QOM/LIBQOS modules are initialized.
+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
+
+After this, the ``vl.c:qemu_main`` is called to set up the guest. There are
+target-specific hooks that can be called before and after qemu_main, for
+additional setup(e.g. PCI setup, or VM snapshotting).
+
+``LLVMFuzzerTestOneInput``: Uses qtest/qos functions to act based on the fuzz
+input. It is also responsible for manually calling ``main_loop_wait`` to ensure
+that bottom halves are executed and any cleanup required before the next input.
+
+Since the same process is reused for many fuzzing runs, QEMU state needs to
+be reset at the end of each run. There are currently two implemented
+options for resetting state:
+
+- Reboot the guest between runs.
+  - *Pros*: Straightforward and fast for simple fuzz targets.
+
+  - *Cons*: Depending on the device, does not reset all device state. If the
+    device requires some initialization prior to being ready for fuzzing (common
+    for QOS-based targets), this initialization needs to be done after each
+    reboot.
+
+  - *Example target*: ``i440fx-qtest-reboot-fuzz``
+
+- Run each test case in a separate forked process and copy the coverage
+   information back to the parent. This is fairly similar to AFL's "deferred"
+   fork-server mode [3]
+
+  - *Pros*: Relatively fast. Devices only need to be initialized once. No need to
+    do slow reboots or vmloads.
+
+  - *Cons*: Not officially supported by libfuzzer. Does not work well for
+     devices that rely on dedicated threads.
+
+  - *Example target*: ``virtio-net-fork-fuzz``
diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
deleted file mode 100644
index 03585c1a9b..0000000000
--- a/docs/devel/fuzzing.txt
+++ /dev/null
@@ -1,214 +0,0 @@
-= Fuzzing =
-
-== Introduction ==
-
-This document describes the virtual-device fuzzing infrastructure in QEMU and
-how to use it to implement additional fuzzers.
-
-== Basics ==
-
-Fuzzing operates by passing inputs to an entry point/target function. The
-fuzzer tracks the code coverage triggered by the input. Based on these
-findings, the fuzzer mutates the input and repeats the fuzzing.
-
-To fuzz QEMU, we rely on libfuzzer. Unlike other fuzzers such as AFL, libfuzzer
-is an _in-process_ fuzzer. For the developer, this means that it is their
-responsibility to ensure that state is reset between fuzzing-runs.
-
-== Building the fuzzers ==
-
-NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer is
-much faster, since the page-map has a smaller size. This is due to the fact that
-AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
-in a large page-map, and a much slower fork().
-
-To build the fuzzers, install a recent version of clang:
-Configure with (substitute the clang binaries with the version you installed).
-Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
-such as out-of-bounds accesses, use-after-frees, double-frees etc.
-
-    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
-                                                --enable-sanitizers
-
-Fuzz targets are built similarly to system/softmmu:
-
-    make i386-softmmu/fuzz
-
-This builds ./i386-softmmu/qemu-fuzz-i386
-
-The first option to this command is: --fuzz-target=FUZZ_NAME
-To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
-
-For example:
-    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
-
-Internally, libfuzzer parses all arguments that do not begin with "--".
-Information about these is available by passing -help=1
-
-Now the only thing left to do is wait for the fuzzer to trigger potential
-crashes.
-
-== Useful libFuzzer flags ==
-
-As mentioned above, libFuzzer accepts some arguments. Passing -help=1 will list
-the available arguments. In particular, these arguments might be helpful:
-
-$CORPUS_DIR/ : Specify a directory as the last argument to libFuzzer. libFuzzer
-stores each "interesting" input in this corpus directory. The next time you run
-libFuzzer, it will read all of the inputs from the corpus, and continue fuzzing
-from there. You can also specify multiple directories. libFuzzer loads existing
-inputs from all specified directories, but will only write new ones to the
-first one specified.
-
--max_len=4096 : specify the maximum byte-length of the inputs libFuzzer will
-generate.
-
--close_fd_mask={1,2,3} : close, stderr, or both. Useful for targets that
-trigger many debug/error messages, or create output on the serial console.
-
--jobs=4 -workers=4 : These arguments configure libFuzzer to run 4 fuzzers in
-parallel (4 fuzzing jobs in 4 worker processes). Alternatively, with only
--jobs=N, libFuzzer automatically spawns a number of workers less than or equal
-to half the available CPU cores. Replace 4 with a number appropriate for your
-machine. Make sure to specify a $CORPUS_DIR, which will allow the parallel
-fuzzers to share information about the interesting inputs they find.
-
--use_value_profile=1 : For each comparison operation, libFuzzer computes 
-(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12) and places this in the coverage
-table. Useful for targets with "magic" constants. If Arg1 came from the fuzzer's
-input and Arg2 is a magic constant, then each time the Hamming distance
-between Arg1 and Arg2 decreases, libFuzzer adds the input to the corpus.
-
--shrink=1 : Tries to make elements of the corpus "smaller". Might lead to
-better coverage performance, depending on the target.
-
-Note that libFuzzer's exact behavior will depend on the version of
-clang and libFuzzer used to build the device fuzzers.
-
-== Generating Coverage Reports ==
-Code coverage is a crucial metric for evaluating a fuzzer's performance.
-libFuzzer's output provides a "cov: " column that provides a total number of
-unique blocks/edges covered. To examine coverage on a line-by-line basis we
-can use Clang coverage:
-
- 1. Configure libFuzzer to store a corpus of all interesting inputs (see
-    CORPUS_DIR above)
- 2. ./configure the QEMU build with:
-    --enable-fuzzing \
-    --extra-cflags="-fprofile-instr-generate -fcoverage-mapping"
- 3. Re-run the fuzzer. Specify $CORPUS_DIR/* as an argument, telling libfuzzer
-    to execute all of the inputs in $CORPUS_DIR and exit. Once the process
-    exits, you should find a file, "default.profraw" in the working directory.
- 4. Execute these commands to generate a detailed HTML coverage-report:
- llvm-profdata merge -output=default.profdata default.profraw
- llvm-cov show ./path/to/qemu-fuzz-i386 -instr-profile=default.profdata \
- --format html -output-dir=/path/to/output/report
-
-== Adding a new fuzzer ==
-Coverage over virtual devices can be improved by adding additional fuzzers.
-Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-tests/qtest/fuzz/Makefile.include
-
-Fuzzers can rely on both qtest and libqos to communicate with virtual devices.
-
-1. Create a new source file. For example ``tests/qtest/fuzz/foo-device-fuzz.c``.
-
-2. Write the fuzzing code using the libqtest/libqos API. See existing fuzzers
-for reference.
-
-3. Register the fuzzer in ``tests/fuzz/Makefile.include`` by appending the
-corresponding object to fuzz-obj-y
-
-Fuzzers can be more-or-less thought of as special qtest programs which can
-modify the qtest commands and/or qtest command arguments based on inputs
-provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
-fuzzer loops over the byte-array interpreting it as a list of qtest commands,
-addresses, or values.
-
-== The Generic Fuzzer ==
-Writing a fuzz target can be a lot of effort (especially if a device driver has
-not be built-out within libqos). Many devices can be fuzzed to some degree,
-without any device-specific code, using the generic-fuzz target.
-
-The generic-fuzz target is capable of fuzzing devices over their PIO, MMIO,
-and DMA input-spaces. To apply the generic-fuzz to a device, we need to define
-two env-variables, at minimum:
-
-QEMU_FUZZ_ARGS= is the set of QEMU arguments used to configure a machine, with
-the device attached. For example, if we want to fuzz the virtio-net device
-attached to a pc-i440fx machine, we can specify:
-QEMU_FUZZ_ARGS="-M pc -nodefaults -netdev user,id=user0 \
-                -device virtio-net,netdev=user0"
-
-QEMU_FUZZ_OBJECTS= is a set of space-delimited strings used to identify the
-MemoryRegions that will be fuzzed. These strings are compared against
-MemoryRegion names and MemoryRegion owner names, to decide whether each
-MemoryRegion should be fuzzed. These strings support globbing. For the
-virtio-net example, we could use QEMU_FUZZ_OBJECTS=
- * 'virtio-net'
- * 'virtio*'
- * 'virtio* pcspk' (Fuzz the virtio devices and the PC speaker...)
- * '*' (Fuzz the whole machine)
-
-The "info mtree" and "info qom-tree" monitor commands can be especially useful
-for identifying the MemoryRegion and Object names used for matching.
-
-As a generic rule-of-thumb, the more MemoryRegions/Devices we match, the greater
-the input-space, and the smaller the probability of finding crashing inputs for
-individual devices. As such, it is usually a good idea to limit the fuzzer to
-only a few MemoryRegions.
-
-To ensure that these env variables have been configured correctly, we can use:
-
-./qemu-fuzz-i386 --fuzz-target=generic-fuzz -runs=0
-
-The output should contain a complete list of matched MemoryRegions.
-
-= Implementation Details =
-
-== The Fuzzer's Lifecycle ==
-
-The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it's
-own main(), which performs some setup, and calls the entrypoints:
-
-LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of the
-necessary state
-
-LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input and
-resets the state at the end of each run.
-
-In more detail:
-
-LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with two
-dashes, so they are ignored by libfuzzer main()). Currently, the arguments
-select the fuzz target. Then, the qtest client is initialized. If the target
-requires qos, qgraph is set up and the QOM/LIBQOS modules are initialized.
-Then the QGraph is walked and the QEMU cmd_line is determined and saved.
-
-After this, the vl.c:qemu__main is called to set up the guest. There are
-target-specific hooks that can be called before and after qemu_main, for
-additional setup(e.g. PCI setup, or VM snapshotting).
-
-LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
-input. It is also responsible for manually calling the main loop/main_loop_wait
-to ensure that bottom halves are executed and any cleanup required before the
-next input.
-
-Since the same process is reused for many fuzzing runs, QEMU state needs to
-be reset at the end of each run. There are currently two implemented
-options for resetting state:
-1. Reboot the guest between runs.
-   Pros: Straightforward and fast for simple fuzz targets.
-   Cons: Depending on the device, does not reset all device state. If the
-   device requires some initialization prior to being ready for fuzzing
-   (common for QOS-based targets), this initialization needs to be done after
-   each reboot.
-   Example target: i440fx-qtest-reboot-fuzz
-2. Run each test case in a separate forked process and copy the coverage
-   information back to the parent. This is fairly similar to AFL's "deferred"
-   fork-server mode [3]
-   Pros: Relatively fast. Devices only need to be initialized once. No need
-   to do slow reboots or vmloads.
-   Cons: Not officially supported by libfuzzer. Does not work well for devices
-   that rely on dedicated threads.
-   Example target: virtio-net-fork-fuzz
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 77baae5c77..f10ed77e4c 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,6 +22,7 @@ Contents:
    stable-process
    testing
    qtest
+   fuzzing
    decodetree
    secure-coding-practices
    tcg
-- 
2.28.0


