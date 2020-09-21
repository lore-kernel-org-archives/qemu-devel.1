Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B5C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560F52078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="vYgxnJxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F52078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBll-0003s8-Eg
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBkk-0003Ma-DC
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:40:30 -0400
Received: from mail-co1nam11on2133.outbound.protection.outlook.com
 ([40.107.220.133]:31457 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBkf-00039Q-7E
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqC98MzAJnRd0EOKR3rAwLJcvvm976/VGFCRCjapuDgwVYGVS9EYJRjO3yWuCIr3+qVnRHp4tAJuyNlgEU38VtAdC+SJS+lGYxdQttkRkZE1qIKCYKXA8qLU3Q1VTmeJLsfkPubPAcdZ6Hw6Q/EmldNsnijlNEQOeAjX3cHPkUD634PKYuH9v8BObAope7bOioWLTzu2YJZnj/PlNyPdgOq7UxmFs1fztioFH+lKD9HRvasjSu4+FrDzKP4yfuCd2OpG98vUVNdhl1pCnyPFaYXVgxHkW2xZU41ySmQ3lrJMEOQcNFUFrjfMvK9/gHR57E/l9dD6311cCE2v4kEIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OoJB9jrz2YdMM1ULMIcRzUCg32MxdWxLiMW7Le64qk=;
 b=TP75GTIdczKZyyYd0dwkyn8zK+YSJhVFaTHOkCjtW7neFdf/+v5qq84dsJbliD7lUU2A0YDQ02B46TIegohWni8JuyO55IX6y+241953RKhIOOAAQuRwCDsQMK+5qH71f18ZVGege+9TwWrVcoio//ZHyDFRrbIUwuWGHblMD0S1QyghT3tO4OnBdEGsqjmCApboo3oEhNgM7H1hZuLgVITYYRePlNCShPAcDI0ArqJw8NuARstN3ZtMYsQtNE5oPLKijdc/08s781b77dduLufHfVcGI4aW4dRN4kBgjR7vlwKpzFTe4I9WdTX0+yDKbsjzicJHe/sBEHD8DNFB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OoJB9jrz2YdMM1ULMIcRzUCg32MxdWxLiMW7Le64qk=;
 b=vYgxnJxyKQeaVsZ1pa7M/n6W+d6b5idBT8SJeRLK9SKVjkxV6DvvgbcQVGU7w3+n9XlXOCua9X2+3e95z78xYEM7rWwA5TBltcm2Y049GSKzCXokYJ7eXpHAPsY477skrR6nVqtyOauRWL+akn1Xi6iR9ZexL1ixrGJJxfKsovA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] Add a General Virtual Device Fuzzer
Date: Sun, 20 Sep 2020 22:24:50 -0400
Message-Id: <20200921022506.873303-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:18 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 580b04ef-de9a-4e79-4c25-08d85dd5955c
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237F73C6A9E2B477D7EDB28BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mk3RGY1PnFNHT0XdNVcgGMkZc0bPzsKHlKwF/OCztWuUKrlarmeXdvybuj1HteYb/mCX6EsQFSs+/0I7CxgufJVPHN+Yy7UAiGz4LvLYfyv6zAm3iNbc4ofSDHCCG/8mbz/Ktd9URhY0eiQ3sQtaZyll7qgENKN06Bnt6L8mH83ftG8NoM8+IXiyZni+uVrldru3LnoZRyw5KNBGPiaIhZtCoIcgBA12N5EQExSlHBBqNq9L0d3Dmg4PcntBrUSUJDEvWtfD8OG7w/QHZYoZ2ewjXL24rntEfQkjuAsE+dnMEASjNOv7BgcB5xTR0ZKMne+AN602eD576al9IJOhcJAT9JnnsqCAYDpTiZrfnzcJV4l5vjiGXtSdCFu1tMCIaKvQZ+FckOjUvHciAq3aGLZJlxKyXkQ+Za5NPTpz+PiShT2h3iVR+pAOIJPYXcb0eK13NsQRaDsGYhpkCgyytg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(966005)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e2qKXTWVL4kiinjv15tjjx2CThJudT1w2hUD9eigkXanw+M2Qx7EYjMivz7mgkt0+QSRfaLvfBRTA/Cu/sJNaK6G+xCTeth4bzHecddvH1cFArT9DSeZ71b5O99ZkneBF562roIUjDo8lkfx0Y2aQOjTNCZbV5GucPo3NjPjFlvRDPRz9CpQAWsfkwKXIvyRFeWKCWS/HqGNQIZtjexYTL2TIKnivS5VdJj2yny4zhQRXlZDOIyiqGzdAOCaXfH6qiD4XuisTA2ysTIEZTS2yy/f9vP8SgfWsSZMPZeyJe4GloaR9V2+/M+RMKQKqKqkkgEZ9bKHu0Z1eXiw2bgUkTuqBa/cCzD+/j3sNXzUkILgK1vrc/6fjHYCCKVkIuPfTzFHajPjWap7LiCb4fkiN8jeeLPCgBuK781jGIcl5p1W54o8VTPWMvQd70SeFqEXmuc9LoVCP3qdyxh1XM0iMPLrWSwePKNCbsu33NJqBzgqKYk2BNkKuByBs2+4mRst7H7vHa10DJcKzO2VHDOPq5XctdBZYLDi0cPrVnbXhAme+SYjATZfvo0DhMHOIo1zgiKbAyrrgQTLR4lLL4wBpaci5UuN7SmWrjN+p/c0PmIP1/J3CdzPSOkHdEl8z1qWftM7+4HGVQMFvbyMobLKuw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 580b04ef-de9a-4e79-4c25-08d85dd5955c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:19.0375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cd3/xltmynvULm8D+EfKiOTrTHd6EKMuRBLTAubNPrI65Ctow4bvLBkJrJ49o/xF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.220.133; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:40:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
  scripts/oss-fuzz: Add wrapper program for generic fuzzer
  scripts/oss-fuzz: Add general-fuzzer build script
  scripts/oss-fuzz: Add general-fuzzer configs for oss-fuzz
  scripts/oss-fuzz: build the general-fuzzer configs
  scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
  scripts/oss-fuzz: Add crash trace minimization script
  fuzz: Add instructions for using general-fuzz

 docs/devel/fuzzing.txt                        |  38 +
 exec.c                                        |   2 +
 include/exec/memory.h                         |  21 +
 include/exec/memory_ldst_cached.h.inc         |   3 +
 memory_ldst.c.inc                             |   4 +
 scripts/oss-fuzz/build.sh                     |   7 +
 scripts/oss-fuzz/build_general_fuzzers.py     |  69 ++
 scripts/oss-fuzz/general_fuzzer_configs.yml   | 103 +++
 scripts/oss-fuzz/minimize_qtest_trace.py      | 157 ++++
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |  94 ++
 scripts/oss-fuzz/target_template.c            |  40 +
 softmmu/memory.c                              |  23 +
 tests/qtest/fuzz/fuzz.c                       |  13 +
 tests/qtest/fuzz/fuzz.h                       |  27 +
 tests/qtest/fuzz/general_fuzz.c               | 854 ++++++++++++++++++
 tests/qtest/fuzz/meson.build                  |   1 +
 16 files changed, 1456 insertions(+)
 create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
 create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 scripts/oss-fuzz/target_template.c
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

-- 
2.28.0


