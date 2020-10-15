Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC7C43467
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88802223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RxdRNAAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88802223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3la-0000wj-Pz
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3kc-00085O-5V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:57:02 -0400
Received: from mail-eopbgr750134.outbound.protection.outlook.com
 ([40.107.75.134]:8400 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3kW-0002j4-2N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlpgqozy+q6KXc7dDr55omcCuDsojc5EqVcPvQynY0Ta216hP4lTsehuHj3KFLH+yCI5CPokcqsZnF3lhivTZ1PJIt81tVRBiwPHHNr1NxTqnNXt2jHfimPNi+NM9K/3VHzLGXajfB8hAfrHe+kWQaUDG9yfV/lAVnRx8xmv5HvYNeJOhF8DZtRzjcKjPNbQ/lT2iHNd2SOE4RM9JLtC1CcLWuSZzAlvrOINTw8pGyYBBKMTxeRE3oSTThaBK84iGz84wLAuoXLOrsz9GhZyhqfmMqjM+3H3aSe3YlDmIobI8pN3qImLgtQ2kHerQoovbXXM+JjPwLBLd0tIHmKBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArIRQzQ/V3jJ6TlSGUnFh5eAxNSnZyq8NL155+res3k=;
 b=P5J/YFD/x3PdMUY3ay9h8k2c3UGVCQ2xJqZORVTj4/+I5l3OOJ19TPTXtUOI75hz9q+N7cZPzZS7/IRY2LgPo8+/KwvWjAyEuL5zcFL3Y3ds6MkBtLngGM6rdx9F4QfMfSaC6KVn62iXbM7aILzJ7dgrxVtJYrC6h42gfHrKeiGZ0B/4oAr4vJS+CyE7TMsjOw3RMmZgLrgI5M0wJbIdUAIxFYsSXliGMWQ4CmRt+UVohQVDkNJQ7b3mWC46JQqvH25B9feGBo/oJnXXpx8nxIJvfIjfZBIkjigYPJH0BDpuugeP+CWY+87Cyo7nMZ3GmIZZ5oSZ1YWhYPwLBGCIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArIRQzQ/V3jJ6TlSGUnFh5eAxNSnZyq8NL155+res3k=;
 b=RxdRNAAUMSUXTklXV7UXpWL3B6ujM7c4ES6HpcQ7Rydw/CSeyTWe3RJzo7MvWyjr8aeoGLXSNWXnEGqnhxjPBno9pLVJuNtFCGTPnSjsvexcIq+9jpaILXxFiWRVYwiQQExvWF6kq8rIEBySmJzLNmibv1pJhMh2ZDbyFFqLVyQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:41:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:41:50 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/16] Add a General Virtual Device Fuzzer
Date: Thu, 15 Oct 2020 09:41:20 -0400
Message-Id: <20201015134137.205958-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:41:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 269c48e8-297c-4fc8-ba01-08d87110118e
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465926C15226F32A5850E15BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5LMcHZ/1D1XB3uOEvHuk9SfQzEJQCq9JCWRzHTSWuvMSn1PC5gHDJVMOIwFalvzWGWjefbsy1mHAC4kwgsjEgU8H/hluv4SkUHmtErHeN8I7TLPweaHiDZ56fy+88Kwdjx5BDvslQHOskY6ny+Blh0nuEbFiV8Rk2JvzBNk0lDKvV0eJ4guzyeIdoMMDZdjm2I9cX7N37NQboRkeWX/iqNbm0AER8Ag7azFXYUD8Ka+34zuUsteVlge4Mxq9fv7odpw/iT8LKQ0BEBoK8W2fwJKk+6l6dLWh6+Y37GpRUm+9DsYLKFPrC+B13iufYi9fBAsS1lqT04e5/MX7ZMPwrrK3Djo+aj0fCISRJG1+pl7CfolUnT+7hKNcbhUUQoknsMYxfL0Obha1ntjb+YLIbofIipVqSTvKwvFPMS1I93gVN3gRfcxYp38p16PY2wHIbAaC4KqAFGEor/CFHMbQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(2906002)(6506007)(26005)(6916009)(52116002)(66556008)(966005)(36756003)(478600001)(86362001)(186003)(786003)(316002)(16526019)(8936002)(34490700002)(2616005)(66476007)(66946007)(83080400001)(1076003)(5660300002)(6666004)(8676002)(75432002)(6486002)(83380400001)(956004)(4326008)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T9ub9jS4NrzcQRPF5bADfXxs/ULNmLi0KIuq69fUp7chf4YweTq2q/uG0g76hv1B7KhlwfbKnSzH0zVH3l1VxLMiJQaU6Z4SNqAFfysm2Fr2Yjke2cmXysK+uKFsrSFvX8gy/iuDq1N6dEbq4DMeUggFsFgRnshEt9TnWvnU+3vJaGMuETfXC0F0wEOIZGGh8rm/WktEVz7834YR4xXhFHkyZz9aYOQXisYTPYpBVnpXhP8eqDFG+LTzECwtsTPcZt/eSOeLW7qRq+be5HX5qfgf+6nRCScj4iqgiaQCNKHzf+JrqSun/fDP9YJpSxbIFTIMvpHStxIu0iIpL6Z58DDsEkZNZ0G6xxOCklVHfBhFb+pGh3DJXKTbr00Mw9o/BXd5oP2TmsJO7Wu15yKQsJMov7DoUO0/i0JG/5M8hRYpLv9O5nT7mfKTpPAflZFrn2jhT3KBnUHpEetg5H99zPrB1G3gSYS1K6pdIqiDLAf2/st3RvAX9OM9Kr/B9+w4d4EMPSSzCGU51CHn2JGazougohPbhLod7ZKKx4W7Qkip6Aaz0vJ/B4LyrutQxqxwFI1JcjREXPw2OhibxkokXfWMS2/FKty3Gfj17aktzsAseRV1vj5saXM6fWTHCvNBb8Dow/o4nbaLqnxonCmapA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 269c48e8-297c-4fc8-ba01-08d87110118e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:41:50.3575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/gUyKtbnYIa5rNF21sdICXT0t6e0oTOadlhg7IBaB+unTSoMYciAUA36RL9zOnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.134; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:56:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
    - Replace yaml + c template-based oss-fuzz configs, with C code to
      register a FuzzTarget for each config (as suggested by Paolo)
    - Replicate the functionality of address_space_write_rom to ensure
      matching behavior when QTEST_LOG is enabled
    - Improve code documentation/comments
    - Small formatting changes
v3:
	- Use flatviews to help select regions for fuzzing 
	- Meson-related changes
    - Add some documentation
	- Improve minimalization script to trim write{bwlq} commands
v2:
	- Remove QOS dependency.
	- Add a custom crossover function
	- Fix broken minimization scripts
	- Fixes to the IO region and DMA handling code

This is a general virtual-device fuzzer, designed to fuzz devices over Port IO,
MMIO, and DMA.

To get started with this:
 1. Build the fuzzers (see docs/devel/fuzzing.txt)
    Note: Build with --enable-sanitizers, or create a "dictionary file":
    echo kw1=\"FUZZ\" > dict
    and pass it as an argument to libFuzzer with -dict=./dict
    This magic value is a command separator that lets the fuzzer perform
    multiple IO actions with a single input.

 2. Pick the qemu arguments you wish to fuzz:
    export QEMU_FUZZ_ARGS="-M q35 -device virtio-balloon"

 3. Tell the fuzzer which QOM objects or MemoryRegion names to fuzz. I find the
 "info qom-tree", "info qtree" and "info mtree" commands useful for identifying
 these. Supports globbing. Here I will try to simultaneously fuzz(for no good
 reason) virtio-balloon and e1000e, which is included by default in the q35:
    export QEMU_FUZZ_OBJECTS='virtio* e1000*'
    You can also try to fuzz the whole machine:
    export QEMU_FUZZ_OBJECTS='*'

 4. Run the fuzzer for 0 inputs. The fuzzer should output a list of
 MemoryRegions/PCI Devices it will try to fuzz. Confirm that these match your
 expectations.
    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0

 5. Run the fuzzer:
    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz 


Basically, at the core, this fuzzer is an interpreter that splits the input
into a series of commands, such as mmio_write, pio_write, etc. We structure
these commands to hit only MemoryRegions that are associated with the devices
specified in QEMU_FUZZ_OBJECTS. Additionally, these patches add "hooks" to
functions that are typically used by virtual-devices to read from RAM (DMA).
These hooks attempt to populate these DMA regions with fuzzed data, just in
time.

Some of the issues I have found or reproduced with this fuzzer:
https://bugs.launchpad.net/bugs/1525123
https://bugs.launchpad.net/bugs/1681439
https://bugs.launchpad.net/bugs/1777315
https://bugs.launchpad.net/bugs/1878034
https://bugs.launchpad.net/bugs/1878043
https://bugs.launchpad.net/bugs/1878054
https://bugs.launchpad.net/bugs/1878057
https://bugs.launchpad.net/bugs/1878067
https://bugs.launchpad.net/bugs/1878134
https://bugs.launchpad.net/bugs/1878136
https://bugs.launchpad.net/bugs/1878253
https://bugs.launchpad.net/bugs/1878255
https://bugs.launchpad.net/bugs/1878259
https://bugs.launchpad.net/bugs/1878263
https://bugs.launchpad.net/bugs/1878323
https://bugs.launchpad.net/bugs/1878641
https://bugs.launchpad.net/bugs/1878642
https://bugs.launchpad.net/bugs/1878645
https://bugs.launchpad.net/bugs/1878651
https://bugs.launchpad.net/bugs/1879223
https://bugs.launchpad.net/bugs/1879227
https://bugs.launchpad.net/bugs/1879531
https://bugs.launchpad.net/bugs/1880355
https://bugs.launchpad.net/bugs/1880539
https://bugs.launchpad.net/bugs/1884693
https://bugs.launchpad.net/bugs/1886362
https://bugs.launchpad.net/bugs/1887303
https://bugs.launchpad.net/bugs/1887309
https://bugs.launchpad.net/bugs/697510

Alexander Bulekov (16):
  memory: Add FlatView foreach function
  fuzz: Add general virtual-device fuzzer
  fuzz: Add PCI features to the general fuzzer
  fuzz: Add DMA support to the generic-fuzzer
  fuzz: Declare DMA Read callback function
  fuzz: Add fuzzer callbacks to DMA-read functions
  fuzz: Add support for custom crossover functions
  fuzz: add a DISABLE_PCI op to general-fuzzer
  fuzz: add a crossover function to generic-fuzzer
  scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
  scripts/oss-fuzz: Add crash trace minimization script
  fuzz: Add instructions for using general-fuzz
  fuzz: add an "opaque" to the FuzzTarget struct
  fuzz: add general-fuzz configs for oss-fuzz
  fuzz: register predefined general-fuzz configs
  scripts/oss-fuzz: remove the general-fuzz target

 docs/devel/fuzzing.txt                        |  39 +
 include/exec/memory.h                         |  21 +
 include/exec/memory_ldst_cached.h.inc         |   3 +
 memory_ldst.c.inc                             |   4 +
 scripts/oss-fuzz/build.sh                     |   6 +
 scripts/oss-fuzz/minimize_qtest_trace.py      | 157 +++
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 103 ++
 softmmu/memory.c                              |  23 +
 softmmu/physmem.c                             |   2 +
 tests/qtest/fuzz/fuzz.c                       |  13 +
 tests/qtest/fuzz/fuzz.h                       |  28 +
 tests/qtest/fuzz/general_fuzz.c               | 948 ++++++++++++++++++
 tests/qtest/fuzz/general_fuzz_configs.c       | 140 +++
 tests/qtest/fuzz/general_fuzz_configs.h       |  24 +
 tests/qtest/fuzz/meson.build                  |   1 +
 15 files changed, 1512 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 tests/qtest/fuzz/general_fuzz.c
 create mode 100644 tests/qtest/fuzz/general_fuzz_configs.c
 create mode 100644 tests/qtest/fuzz/general_fuzz_configs.h

-- 
2.28.0


