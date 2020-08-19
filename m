Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35973C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B220738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ctSWjdEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HZU-0003Dm-6e
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HYb-0002YY-Al
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:26:45 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:20309 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HYY-0003gY-G6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCnyJk883+8EnhNo5hW4tjXE0/Hzz+qvbRZvgfh5CJ9T6N7nJRkiBONfpE7r5YI48kvdIw9BI4dDh7UHeIgeWtfVVGb3QdYgvyfnGOm+QKJgJljMbjaCC9XvbFmjAQxwiVaiUnAossurFldDbYlXkqSiazaT+bEkShlvF0HPOCRgFNe2GXr7+DGD9z6XTNCxWoIxQXGH+rwANjWzieEaUsvxchhHxQUSgTwWcVRdN4QF60tVEPTSmfUnXwAHDvNRxmJJJd4SH6ouON7daoF7HnsHk0ZtwPTci95DgIz1F5ASkrazRD2qqPg5mLMpFJbt/OUa+FlRzoaBb2A1UV3MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgeyNx97sy5jcDLMPsyPqysWBu/UoxcFophXuqmQ5Fw=;
 b=lf/d1A6TedilloxbaKR2jSbeARhVX09X75BN25wJtG2znspPdEsehnCRR1VckJ/I3bY6TjSGFYuun/MpBJeudmSMLca+Qk4JbhsjSMlQWKGg7Dncnei7HSzNKJu45ckvsmKTaA0OeSiFguu6bb09qaEEem8A8VY6X2TfoOd4HIYDsZ8YcCjPnOODMNcZ42G/fVyYiKfAtk0Ogn/SHSM0mQ3c0yRGH7ApGSoY1lnwZI0JE085JjvCR2bNaJSVJYYuY4x6YtFpy8Llso8eLenMMRHNhHrt31H3ENywjG7MWpeOyL0vuRbS3Y8jTV/W+5GpWErUpTnRohTNMDvJ2LftVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgeyNx97sy5jcDLMPsyPqysWBu/UoxcFophXuqmQ5Fw=;
 b=ctSWjdEANMipJiHfbMG23N4fzBhWD6npUz/YcMfFulVL61lWD3210YY40A21nc5QQuMCEA2pwfVv0k+8SUF3SgvD/Q0LBeI4ijWZkRG9GVjErjbA8bMXu8jp4gI5LRIqRvPODCiuyp+QpQqKQdcsmxeGv99HeI+kdLDcjvRSjd4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:31 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:31 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] Add a General Virtual Device Fuzzer
Date: Wed, 19 Aug 2020 02:10:55 -0400
Message-Id: <20200819061110.1320568-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:30 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917d46d8-c2d8-4a60-67a6-08d84406b71c
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3934A7A00476C347B757247EBA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AboevFCh43xUeiSIq3QGEZiNTdGF7iJqixkaKQuIfnCLtHT2iaw4HG29LsFceGT995qF8l3TiTiucnpAOInUa5isrHZB/skuiAXRi+o48lsMTwMrl5CCEHGWQlsvYfsLOyaNn5HZbexDmh7lDQsWvjPZZ114wAg7YmdYv9EEco46uLjcZLR1N5ARGPhOc/+Le2DWZSpxhv9bMEiSJZrjClIKs2UX4IiHTC+PIED1x6HpDxEagehXNI7GhudDN9c2GTyDR6LfOuX9K994nEB7Y4OHzO06eIFg0nOobi5BMFOBfiGqg35D9/rg7cpMuX/5Csw+bpublX28OI0VZCk6zIUH99G/aTrto6CPqtgErMeHVaqNA/yHXn9saXv+EQsdY95j6kzlIf2RffmB1GgIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(83380400001)(6486002)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(966005)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: andP8MowKa/p2q6EA2c/0uTyqh+VOIdS0l4HWgOalPSPCLsEJralT+oRPkVa3aF/CEnZL+SFEVnW55Qdr6uR5jFz9/OZaTgVsvnvmwjV0JUVRNg+O2xrP5qN6c9QZKjCQv5GMDRgKO2hv83pVgop+XVP2MFjGUV4Kv6jBtNHowpRYltIij0RpQtzryZwBYFvwI5225leRqrDd+FOGHzCgXAgr4ObgMKPvT+1Glb+Uc9d4nokIDAlpmbaaMdYclNb/1/zgfz/iop5fmbFiNtfd9BjZFQ4YmzkfMX7Yf8PwnANohqHMGQz/uAd/zLWwsWFz2s1G+OXRCSKK2zVBR40VZBXe9ab3Ajv47MNO14E2VuXdYi+J6tNwVO68z9hcRYDSP+SWVwgUGNZZ7QKhEIwSKrM65rHg6M3UrWVjbQqSIaulyOkH+EMdSzZ3reZOnvmypY+ay94lKUfaHdKjD6lAYsonVUhW88ecFcx+5pmPrUeGopmy+MBVehBI4Dj7nxjk+p4w7B0iHQzxAq4EYO0Ci2LwKoK7jm1ZIMhzHWdQCyiqLAoYsF6Ppfwh0u/6OhhgOXucCPkXitkOsRF5i7PpLmOjcv5RxBnYoKcNE0SNu9AzFnQRYacJeDtWwh7IV2XqDTgO8WXr0Aror7QDqenBQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 917d46d8-c2d8-4a60-67a6-08d84406b71c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:30.9707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wdXTHUKSqAbB2OQf0SDGbTyld6B7tFpzku66THMEIwRbjcAFmuGRiopFZUzAvkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.243.109; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:26:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

*** BLURB HERE ***

Alexander Bulekov (15):
  fuzz: Change the way we write qtest log to stderr
  fuzz: Add general virtual-device fuzzer
  fuzz: Add PCI features to the general fuzzer
  fuzz: Add DMA support to the generic-fuzzer
  fuzz: Declare DMA Read callback function
  fuzz: Add fuzzer callbacks to DMA-read functions
  fuzz: Add support for custom crossover functions
  fuzz: add a DISABLE_PCI op to general-fuzzer
  fuzz: add a crossover function to generic-fuzzer
  scripts/oss-fuzz: Add wrapper program for generic fuzzer
  scripts/oss-fuzz: Add general-fuzzer build script
  scripts/oss-fuzz: Add general-fuzzer configs for oss-fuzz
  scripts/oss-fuzz: build the general-fuzzer configs
  scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
  scripts/oss-fuzz: Add crash trace minimization script

 exec.c                                        |   2 +
 include/exec/memory.h                         |  16 +
 include/exec/memory_ldst_cached.inc.h         |   3 +
 memory_ldst.inc.c                             |   4 +
 scripts/oss-fuzz/build.sh                     |   8 +-
 scripts/oss-fuzz/build_general_fuzzers.py     |  62 ++
 scripts/oss-fuzz/general_fuzzer_configs.yml   | 103 +++
 scripts/oss-fuzz/minimize_qtest_trace.py      | 118 +++
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |  94 ++
 scripts/oss-fuzz/target.c                     |  40 +
 softmmu/memory.c                              |  14 +
 tests/qtest/fuzz/Makefile.include             |   1 +
 tests/qtest/fuzz/fuzz.c                       |  18 +-
 tests/qtest/fuzz/fuzz.h                       |  26 +
 tests/qtest/fuzz/general_fuzz.c               | 843 ++++++++++++++++++
 15 files changed, 1348 insertions(+), 4 deletions(-)
 create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
 create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 scripts/oss-fuzz/target.c
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

-- 
2.27.0


