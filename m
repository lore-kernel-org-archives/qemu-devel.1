Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579EC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F4421D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="liJD3kXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F4421D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzFm-0002IH-Ln
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyuN-0005ha-Gr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:23:11 -0400
Received: from mail-dm6nam12on2130.outbound.protection.outlook.com
 ([40.107.243.130]:9723 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyuF-0000ir-Ly
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nICOtVnV4wlJB7qnBIQLfbeAF8GpcxcZM3CSKu5s6Snr7De6pc8NqZAKLB4EiViAjrTkyP+f/gRbvZ5Qv0ZkD6K04p3UBJ4Sw0lK0+laW3ROFiFqcLuak04s7X7n5W0ZcoEpGuQ+d3XmAP7xlOrhvPPYQpUPg1UnJrqMu8ELcMSOsfQzI7Wp2y8WaAyQn8n6ciaazeKJbBXbPO2SQkDe/k5iCOln460+hyVIBMpcVQRMAtNjXqRp3waebvSv9cjklcD/rAUuJlMPU1xrWHPgZiW3Sb6spBzsAkIV4R8Oi423jyytgGDJuyyWoXvQbqS5n4VjCNo65hz+u0IhvaLaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/3MFPVSGylys5hokU9F7vOg2llRD+aJgCNLY7M04sc=;
 b=kMZYB1aPxkub3eCa/mUiz4g8JT1qq2JilRdsL7ngQ8iwmMnUZAuugVX4UBF6H4Ox24lYwMJFvj8ze41yugi0aryXsxvvPRVXCVG46Z3tiIl3l0U34C1SFNxkBpbPx9CzOD7QE5C8CrZytDzpwkrh5M1x2Vb5fBZ5McWak6IORpyD8oKXJSP2TrHYALw4rTuSYm0u/TaGCaFVRyvMOa8i5KRbmViHzwj5l6Y4TijPUNzU9BbmrmXuMhJztsN9miN2CrTtkVxJQ8h7uH2AC+e+WnRCNxz7do+5oXGvMhCJvlatVYxaB0qGkHETRGO0eLHLYDj6rKCT3sIObagjb5VX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/3MFPVSGylys5hokU9F7vOg2llRD+aJgCNLY7M04sc=;
 b=liJD3kXIDDpGKPDErDAEVCBh1K5TKRidjRoifsfGgpGgWvGB1okrj3Rpzndw7N10x4t8LpvWfIv3ZrevQUMnrDKN1gz2d9NBGzKXV1zemB7U9iZCK8l1IkGN7SLGA0wdNcFYZKdoxkHWf31/gew2JeFyKYklq1ZrElFwN+sgjkA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:07:58 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:07:58 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/17] Add a Generic Virtual Device Fuzzer
Date: Fri, 23 Oct 2020 11:07:29 -0400
Message-Id: <20201023150746.107063-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:07:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce82ad33-c36b-4734-4f72-08d877656d09
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB436863794666731B94FFA13FBA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aG+nNqhBCrJXY39JLPyEUR1eN4yCeqlwTSlQybo9Ka0ev7zRzXL02RNFTtKFOEhPhQ5FsUrD55ZIXamLPpvuYjlkWR1aiuSJQQ+gkVewS9oXLOJbpT0HLkNbILubuUCFzICCJEun62NFfW5pAZKXHO33I/RKpxVdjfVw/1aadBgIfGT2byBzVC7kp8DNXuOOM2craqCCBCz5YgmYG4JDgtQLt0mcC4ASbuDyTkDAVpFiVLPD08zUZxZ/aokUZWtNZJ5fKzQnlxCYcVuADQR087Wd9+qtAvLWYtTFE1pDonBk4aCC87mqTzC2yukMCnDxoV4qKfFZS3EBDNOcwlyLkZtnikI0wlS6nkB3zrpALMMmVw1p3trwuwEsv9Iv8cTYL8Ax6u1kgrEL65Ph0AjkBGQ2HQj8ECKnjwhzZm/jvyEM31VtXiwJNQIh2uVOGO0B6w939j3paX3WHUeGYjLJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(83380400001)(966005)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(2616005)(36756003)(52116002)(5660300002)(6512007)(4326008)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zB4k0gEGxgA5WHM6Bz9agq5ZgHuXg+znPCB5Kwe85Ja2CntSEowp1iCEDEUQkzEs8agB0yOZrRPVLU6yYATj6XNMuWu4tBocXvupl0Y3T14kSf7l3H3WGQ45WgcGJ2SF62R1ONac8M8Fa3jMehY/tHJfbpWXP28efB++QPklLMrPetmwojLRI8ZT96fVBHiLGCtmTrgjEX/oDobOj5so9yThB5Ld3gDVx02G2SRlZXqwidcjU2D3gFcelUp4U9R0Clqisa4Lh8YHzRAgOb/CXftfFEzHVjnKptNzeZWWS+eUmMeqx0KtKHNXQV6OeBfXiJfkFRLvDe5RpS9rZu8Mp7JhtY2c9wuECgdoqjb8GSLBpBjMAUXMRlJu2jOPWKZ23QW4KxoqRtMnZQ8SGtNyOTODhElotZI/sfi2ijVgyJUFC/yKCoJw4Skky6oy/p6zbDD89OLWKCXkEtZRz5b50sUufw35ldX/CKU6C75RsDVCxwp5b7r7ISWIWCjTar43QyAQiioBAP5po16rY/YXboxyTc2LQy7OkEj/qe8cn8ZgskC290U6pON/RFq1xpX4v+mN/1tuEkIZpZeYFvRoBXfcT4TjKt29SCPjokBHYwkIO6d65HsX6dDBITBxDQ3kjy537uxIxJD5SK7GMcB1jQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce82ad33-c36b-4734-4f72-08d877656d09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:07:58.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKJXl2t4a2EGA2WH054tsU2XH8jsXl38VuugbAsytOau2k7aAF0n/G0sHiJc8duc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.243.130; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:23:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/a1xndr/qemu/-/pipelines/206883920
^^ This is still running, but I also performed some local oss-fuzz
builds. Hopefully there should not be any failures.

v7:
    - Use hard-links instead of duplicating the same fuzzer binary
      (Patch 16)
    - Trivial formatting-changes and null-ptr checks as suggested by
      Darren
v6:
    - Some More "General" -> "Generic"
    - Fix broken build between commits (build-tested after each commit
      and through gitlab CI)
    - Fix some predefined generic-fuzz configs that failed to run
v5:
    - Replace GArray-based predefined fuzzer configs with a static
      struct array
    - "General" -> "Generic"
    - Fix bugs with wrong timeout denominator and skipping DMA memwrites
      without QTEST_LOG
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

Alexander Bulekov (17):
  memory: Add FlatView foreach function
  fuzz: Add generic virtual-device fuzzer
  fuzz: Add PCI features to the generic fuzzer
  fuzz: Add DMA support to the generic-fuzzer
  fuzz: Declare DMA Read callback function
  fuzz: Add fuzzer callbacks to DMA-read functions
  fuzz: Add support for custom crossover functions
  fuzz: add a DISABLE_PCI op to generic-fuzzer
  fuzz: add a crossover function to generic-fuzzer
  scripts/oss-fuzz: Add script to reorder a generic-fuzzer trace
  scripts/oss-fuzz: Add crash trace minimization script
  fuzz: Add instructions for using generic-fuzz
  fuzz: add an "opaque" to the FuzzTarget struct
  fuzz: add generic-fuzz configs for oss-fuzz
  fuzz: register predefined generic-fuzz configs
  scripts/oss-fuzz: use hardlinks instead of copying
  scripts/oss-fuzz: ignore the generic-fuzz target

 docs/devel/fuzzing.txt                        |  39 +
 include/exec/memory.h                         |  21 +
 include/exec/memory_ldst_cached.h.inc         |   3 +
 memory_ldst.c.inc                             |   4 +
 scripts/oss-fuzz/build.sh                     |  14 +-
 scripts/oss-fuzz/minimize_qtest_trace.py      | 157 +++
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 103 ++
 softmmu/memory.c                              |  27 +
 softmmu/physmem.c                             |   2 +
 tests/qtest/fuzz/fuzz.c                       |  13 +
 tests/qtest/fuzz/fuzz.h                       |  28 +
 tests/qtest/fuzz/generic_fuzz.c               | 952 ++++++++++++++++++
 tests/qtest/fuzz/generic_fuzz_configs.h       | 121 +++
 tests/qtest/fuzz/meson.build                  |   1 +
 14 files changed, 1484 insertions(+), 1 deletion(-)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 tests/qtest/fuzz/generic_fuzz.c
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h

-- 
2.28.0


