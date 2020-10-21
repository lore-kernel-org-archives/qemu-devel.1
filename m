Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C862098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KlVK+D7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C862098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2uB-0000kH-6q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2qO-00068R-5d
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:23:12 -0400
Received: from mail-eopbgr750127.outbound.protection.outlook.com
 ([40.107.75.127]:17083 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2qL-0006NI-Pw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlFB7OzYs6Vusy0yWNHwBlijEoJGNFWrv8goCtRlG3iBnBJ0jqmxglZOU8mEDlUkful0VOYshuxYTdxeXafE7UN18knm/STQSWemHKD72IXC2nlFSRwbu3uIv6WbeqYtOZKD71Ps7Cc4lG2f/33HcTNcEWYJiDG29OsZg4/ha4d0SYF1z49JAcOcCEMLOs9WJh1sl80bgHqQ+lTt/0zbg2rb4oU7I4x7QUa+Xo/VD1/2s2etr3e9c1l3OzneJAkLJ+ir+Jnfnz9mL6T/FTUrSZQ41l0efFpJXQhWvSrPkL1mRI3Vpmwd0pyPEZoYTClS1fQQbYx7exXmJgbmc98xXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1eILD0pZknDWpNIJwfyNbytvrfSGhuI/81Mtp2sku4=;
 b=KUDXwQalyAsdTJf9Y4d+h3bJs3bkzvHDPDiHRkAbVRunwwwQAqCavPfNM5jFRnOO4W4dOJQ6ytQ59pXknHdxt4wKd5iZs8UMFkZVic/31AK3YFz6EGVC8pgibSKcFv5Rpny++tJMtoAi20s0XOAGPF9n8At6txrKI4QGVboUCV6hZV2vOnywCRj+6DtgMRt7HT/a6jONlI67IVxwvC/bPoSaCc7XvdMjQRmdSA/UGBXbqmDnGYum7lUAL8aSHBFLzBE6slTcOZIT11k4wDZHD4t6su1zAcQ/hefazJc5pIwKP5J4f+HcwQ4ZntE8YVi36uzyAChRqkIiIydw4PyHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1eILD0pZknDWpNIJwfyNbytvrfSGhuI/81Mtp2sku4=;
 b=KlVK+D7GFWW4tXpN7CYhLI/u49Yv7cfbhDs5fxn0yvifT3/zevKsm2fLvnE/nu/ZslietD/BUkrEcqF4k3tTib1PyR/s7Nn0jWcAnz2x4kALgGVOvMTU9tAKB/+xNZyeR6hH56CnJPoIvBCxIMRghK7YDKg7SJ0mJcvUh/pfTKE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:04 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:03 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/16] Add a Generic Virtual Device Fuzzer
Date: Tue, 20 Oct 2020 21:07:36 -0400
Message-Id: <20201021010752.973230-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d73458-53bc-42ba-52e1-08d8755dc2ef
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB233384BC478720FC1B8A631DBA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVnIjGDeKpdhVTc2B8rTLLssxPlYPIQXPFKy9NGs+/QoGl2VD4qyfl3gOPmFo/usZqG/HW2UHeoDey9jTdIqpV3qjZKSHPvYVxDIxl7n4Mxf4gTESNfb5HbYyB1bKbYRHYjjsPE4GWaH6quSJaIXPQgjPaFisXvQPLeLBM9nI8CqqwMPrSUwfQDx2e2KTz5yI0s2HU0kfzVOCBVsneQcpc20FBKHrmYGWoFqkx+lm0zzH5ynkLsQpOFn61ZwowJcrecOzN3OWONayikGgb5/XBs/YIwqQy4fsWkjDAu0KaZhtsQM0L5rQNqaQn+2JPVFfaNQrGr626DQdQZAfvmajD1VfqZABhvHqwhx5Q/X0YDK5Nn5eMiHsy4y9mCW2xxOb7blVPlgxrCwITEbN95ri8e4OY0TfC5n74/wMCc8s2H9PkobQaNI3C9uAHGdtjxlF3TjRIkcGwxw46KJqCECew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(86362001)(5660300002)(26005)(16526019)(186003)(966005)(6666004)(66946007)(2906002)(66476007)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9WxZwct6sNkEDxGC8zVB22prdHiNDopRoxz2CScx/IQX4qHPBt7a6/W6BX2ZO+IJ93K90rn5JFWurNklRqUOq/YQ/MG9+m6hhZJWJtceIQTdnI0/uCV5+lCZNcAq6CpBbpMFNOqOPO4viLvHQX1ydxPebOu1qY3F1bc9MRaGxYqFUOM8atzbVKRmFCEI4ep0rInVHlC//11t78OJSoLJnRPiwXHMVBK86ja5457dsGtxC8eWxE15N7yrT/gPIJNwjMFfI3BeU0u1kNWMLparFnJvcdsD4hVdDdPnyYfq7h4k1jHf4CarpsUIYIQ/vZWn87NIuVUzlGrji0Y0TG7pzENCE1gBLxC5JIYiOavapK/U5wNh59LbVrGYuCiKtlYhXRhzP30iK39GVdPwF8OD9/O1P2tIESb/OdrS/Ju7zdHWVijUHgW8yGOqSC6kRHm30dN2g3FaZS66zuMUoQF8yZXZ7rytXuN6ta2qIBuZcnar8s+Bf/S8tmWWgodRFTzM1vGPSoY92ti4XAiYgFn9vC3In7htRibRwKlxPCtIrGNXNvRNSKVH7OPiCrY0NPNN7t9hAd83kgkXunfJkjldyQIJo5fNYXIoEvjhuUmH1u2pzSFbIXGTatJcJoMoQ/qpWQjF0v5xJGtTuJoDKlknug==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d73458-53bc-42ba-52e1-08d8755dc2ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:03.9325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LceV5uNiiUGnXlVzwHjn9jOdnTnNNZ1r/62kaNRWOfHmMbXQOCAA5kWc8D2+32g0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.75.127; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:23:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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


