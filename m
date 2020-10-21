Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7781C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A7720848
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="P1KwnpI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLbQ-00007b-Mt
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMd-00034n-4P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:43 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122]:45277 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMa-00083h-Hr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc4Ycojdoe18iSTqzQhRzESiIzatrbxVDCsN7S2BzXHYlw9mbo1NQv2CxcPN9tvwJumoFmr9wkfxh83iEk64E2MacP/nq6PTu3zq0krJCUCf0nhFnnf/aDrD0FhR2duIxXGZSq1+bPyZH2v7iyZQRZ2ud02O4SNswVzqKq0+JNWo9VbDbqmLXCSX6GUeupDWpbm27lF6mvMyiBPuHI9zhtTWzebUU3yg/t9hlx/YbkwqL/4ORtyCligrSzh3011okxtgKI681PgF2VCrHFjp2imQPEVNK6CqykbWpfHn6QblPhPYwIVQGsspZwokGCSDlD5LoeEbjcZuXAK710mMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az+yB17ezUkVLFSG3HmZRcGJQYFaxqmDhIInDX7Rvhg=;
 b=bdUB8g6OtgKglc/aMjjvLRoSgA2k7l2lTHnBylGMEoychU/uZvpIeYyIKc879zJx4kMQotA29171+886+/1UvadALyLuxKVds7vgAaL583izfK6HQSPDX1GD2Arbzas/BeUR4bXt8qwmQVI5Lh+HjAPQzKuzH88exYkiI6kGBiWo/ajt/dsuCY8cDPKHmxjDlMHwg++ctRXiNs9lsjl5vw7ExPer8XKifpvzXXYQKMiwUBg7CU268nqacstykOQW5mQVj+kcoY1RpFJvGI6k8qqAolRtszKb/GfV58aMRomgvYkQasbpHg4gQe2+FSdkMR7B8nvN3WggU5ve4FsdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az+yB17ezUkVLFSG3HmZRcGJQYFaxqmDhIInDX7Rvhg=;
 b=P1KwnpI2tt6kkzMC/0UsL3s32FABbEDVzIzneLksK1uVwJcTf9owzG+FHPFrKTdLKV/EW8+pmX42aLgcQDLNwy0De25G5TQ7/UfI0AYs9NJbTwPtAxbz4r26/cPd46afCXfQTPuilVpErFbg7bjYVeApdCNdSHh14j9pvvrnm0I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:34 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/16] Add a Generic Virtual Device Fuzzer
Date: Wed, 21 Oct 2020 17:09:06 -0400
Message-Id: <20201021210922.572955-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f46dae83-a4fa-4ff4-0c3a-08d876059c1f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045B4E58DD7F3C193973D19BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3YswcGN0D8m1n1yHhm2sgk0FkSYPGT0DC8TTQsygfGZkn1CXUOFJ3gPKkogiVGzRnqNAzM8nM3GP/5CcEXZvwaXrcm0QCOSL86x+CBCqRcNtrl0X2tzNCrT9ne2GHi5ccxrJno1eQYxMzqIZDwBjImo8DPS2mT4ddKVH+US1Gd+dbteLLVL0Qr+eaWbQfU+EdUanTCgp4MD9rdmBLmzaFf5biCvwnFBwb3Agf2ZOBaN8NLrXU70DYkWdQYSlrteGnqgsCZbkZpsAUupkuqaiwmc8hhAicvM5eI+OpYHWMDReP9w3xi26GYFST80Owdwef+xLMBJjtvtQQADKkWLWrTp4fSWzecQq9Rx6q0GxDwyE1VJyC6IYN9TyY4NY79vp6fVHy5JUBZYjLFtfn+aFM4n5Ech0JgiMwq9fYjxJwHyOjrSeUZHNhm9FBu+FRzaykSRwBSt39mCVfjZdGOSMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(966005)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: u4O47OpxiLw2xHSUaSfh/TOS8n5bjuJR/grANrttttG4/V/DU8nbsIs8cjZXnKQpZVu0rVN3dKjAz4sOAe7QYvpZT03IUhX7OtTllmGnvxmHmXDCQoOpVwhDlDOTSjSliZKwvfBb/W+M+GIdSwbKOXuQaALYGE+xaxdhVDf3h6VIr0pB5+DFBqiL/z91mTRGyOMJjZ1qr6L84tHbw5Tzu9ZuQXCmUqYVqHCHNCafkqrDpvRDSCU+aKkxG0HP0Ia0NuyeyiwgIU50F3in2l51drU2cbEY8TysvBxKl/aTVIdoBkUDpGL4uDwBJKdhkbzaE/CEBD+dZ/54u6m1mvF67/ghB1ZdrHbNrbRKf9eGMFDak89kJqTKEWYttxaWybPxUaTYkzZOF3reBmLPvIvOMq7rB6OOu3ZPP2ZlYGkK36WA3uDQsLrWXZi7kz7VMebYOMc8afMuc7qrX+AVZ3yxtfV24v0Mmf4O5W4YoBwAuDeZiDDH1WPRC9mfAJCjk7I3EXmhEiN6XzNsBnKW5IAWKTH0tvTAEfjcuiAHXYHn8tdnwarVJGoiz89hhxrKjZKnhZzdiI7FJ77whFSOTIpJNgHZjeuTrdVzow4x+lTUXjdSsLEaGSal2iGSfHwGsBSlbqXt9cDIuqEJXzVnrEwdMA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f46dae83-a4fa-4ff4-0c3a-08d876059c1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:34.1958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gyI3U9lnY9x/nvgjYEo+U1/kd0If2bkNLYAsX0DvyM3DyKkcnC9WHtlxFDjeqb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.122; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
v5:
    - Replace GArray-based predefined fuzzer configs with a static
      struct array
    - "General" -> "Generic"
    - Fix bugs with wrong timeout denominator and skipping DMA memwrites
      without QTEST_LOG

Alexander Bulekov (16):
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
  scripts/oss-fuzz: remove the generic-fuzz target

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
 tests/qtest/fuzz/generic_fuzz.c               | 948 ++++++++++++++++++
 tests/qtest/fuzz/generic_fuzz_configs.h       | 121 +++
 tests/qtest/fuzz/meson.build                  |   1 +
 14 files changed, 1469 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 tests/qtest/fuzz/generic_fuzz.c
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h

-- 
2.28.0


