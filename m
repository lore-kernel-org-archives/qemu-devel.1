Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5389C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7B6206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="lu1H7ukP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B6206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySKn-0001L7-QT
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jySKB-0000ps-T1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:55:15 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:44680 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jySK9-00049p-5t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRlu/Zd7yPjvPkuA3Tqx9cKTuwGkEO2oHR+NLr+E+P7QJRfvJp+KKe9xYtNY7p57daFNxfBWLyPJIc8e900u5kY/UwJm2jVgf7IhaVv2P6juGzw/F6sw9s+b36EBZoaGz2cR6DOUnvjJYjPSgUq1+cIBdmRnDt+1i/m8GhFPRuIGA2NW8XE3v+A+fqtesBNXrJxKr5IdChpD07p2tNwpzEeKSOqbIUjijKVjGAsZrvkZIpUsf/3dKMJIwK9cJq+mXcCOVPmlmgiOoybaIPWSwaerW93PufcZrdkfdOFuiSTRmJ/0RpbqkXdaritzIdI1dAifY9ga4Jy10JbTHoeNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz4bBBc4IUbAdutgRMG/No/YHYV766MDd6i5zcZWNHA=;
 b=KBjTABRzdkPS6qEHx86whEd4FtvtYWxSq4hQTswKXMiNnUywJTadyUMTQTYuVOzi6jZ+bCuGtjuytC9wLf0KtAprOojho5C9KNMg4GBi/b2/nnqOzCf9JCwPG7HXvt0MQNF7pnunajCHzzRqgAvtusJj15zi5DTM1YwHO6r0Q6uAz481DHCZfAxqOO2SjP7Xgy3rz1O8KSw6vSFcR8XDwBNpArOkO8Ib2qUhVvzaNwKpJH+HsDuPHKFE1mHeq/vjN0T2R4N7Q8Kxvj7niWiAB4A2kePPrmNYVFG/IFewaVNXEbbHPNVM8QNjNvcnEaqbEUYvvXcN7/QnAcF8caPnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz4bBBc4IUbAdutgRMG/No/YHYV766MDd6i5zcZWNHA=;
 b=lu1H7ukPKu0K1rlWBlcCCm+iQ7Z654GiTm2w+0l9P3/K1X32nVHZlcZFfu0+GA8bCoYKSwne2yM75pNGJkLgR+cCoJA9safii3VtbXCK7BWzWZTCZvtzkETOjBQazasaqaCv3H4dN2sXDQ6ZTOs7NOOd89cpU0+hS8SiVeUURhA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:05 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:05 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] Add a General Virtual Device Fuzzer
Date: Wed, 22 Jul 2020 23:39:21 -0400
Message-Id: <20200723033933.21883-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 244eaef3-600e-4b51-955f-08d82eba162a
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982872B30666DBDC82A41FBBA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHbto+zkPyChZEWiazyeDePKbY0a+QZSb+kubTGlrw8XKtaqyRmVRv6LEpyV4ZG8gTgmagKoJAfcsP9QL4urm1lpUp+2X+0fu490OLocjzR9mX50sip1emqmX/erMZU4awn5FQMP8QLLEIogOO2x4OsihKKrLS1EWMpQHANLpbond06gbBUg8Y4Q/CEGjKC/j0nyty2bH1C4aDwGBjhC9F6DwgkJ8a+kirviuu1zpf2262i10cKIWpRaQygtTfn01C5hF/b6N4pvd9TFBsJ0Q5Ylb+jD5OTIJIYIpAewKPDLhcrdt+IbVGg6yyNQwU6/7qHhFe+XgQj81gXn0YlSlqZ7DJbAE/BlcleXxP/9mwzzTv/VEnm1HTS4kt5HObUYISyhch9TlYpnfyhWyKTtgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(5660300002)(966005)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1OtWahQVmfU0nMpahJHFsOjhXwBpyfCfvzPSc3QJjzNc064gBVqMYJ1PyF3yfrwZOpOEpXcXDohq/AHoF59asp1zyQkcVfy4qoEAae+HuHOSnnnlW5kRiKa3A4l6Ml6vqxTwad6ffPLH6uj9v1c8D6L7XTShG8CSu1OmDJT/+Ti7OBAuJA2lVHUZZkV0LjL23IXsZf4g0lMCcY6VN6+BUwWy4ngQHgx1R7b7Fh4m3cruNyXh7+6NdAfMS8Fa31sfkCnHBr+mu/98ezW1+qPP0GzztxoayI4+OC5rFn9qRr0NUEdt+Cfpk0vDWKPa6I8JGrGl7IFv9yfwgmUubck1YyBIbTP0K3+AqGPCn0krYhfhuwHHYVX48NzsHvdF5mlphcmA6aFjDGvmWEFxDozUufJsTjNeTEC3M1sgDsoLQ5t1s43CBqXEk40gAwL+c5oaKrUjMTzldJVTsYfwtx4eNcGb7ygLnQVq7b6QcwRIPhE=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 244eaef3-600e-4b51-955f-08d82eba162a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:04.9436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NgOu3ZyddhPSdiAyhzHdkmUxBb1J0cFHsP55zVJJyvL/TfxL+8ZDDqbK/9EVn0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:55:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a general virtual-device fuzzer, designed to fuzz devices over Port IO,
MMIO, and DMA.
To get started with this:
 1. Build the fuzzers (see docs/devel/fuzzing.txt)
    Note: Build with --enable-sanitizers, or create a "dictionary file":
    echo kw1=\"\x84\x05\x5C\x5E\" > dict
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

Patch 1 changes the way we tell QTest to log to stderr (becomes important when
building reproducers with this fuzzer)

Patches 2-6 add the fuzzer and the necessary DMA callbacks

Patches 7-10 are my (very rough) attempt at integrating this into OSS-Fuzz

Patches 11-12 contain the "reordering" and minimization scripts used to
produce a QTest reproducer for a crash.

Additional notes:
 * With the latest changes, the
 fuzzer is quite effective at only targeting the device we care about,
 so it will probably be beneficial to allow reboot() as an option for
 resetting state, rather than fork(), for devices where that works well.

 * We have only scratched the surface for device "backends". I.e. I am using
 fake null-co:// drives for block devices and SLiRP for network devices (see
 scripts/oss-fuzz/general_fuzzer_configs.yml). Using more complex backends will
 likely break due to forking/threading/statefulness related reasons and will
 require more work.

* Because I still can't figure out how to make QOS do what I want, this
  only maps PCI BARs on i386. For other targets, the fuzzer can still
  try to do it on its own :). Only did a very simple test on ppc and arm

 * This is failing on GitLab due to a leak:
 https://gitlab.com/a1xndr/qemu/-/jobs/652179729
 I am not sure how to work around it yet, since I don't think we can
 free what the trace says we should free (argv from wordexp that we pass
 to qemu_main).


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

-Alex

Alexander Bulekov (12):
  fuzz: Change the way we write qtest log to stderr
  fuzz: Add general virtual-device fuzzer
  fuzz: Add PCI features to the general fuzzer
  fuzz: Add DMA support to the generic-fuzzer
  fuzz: Declare DMA Read callback function
  fuzz: Add fuzzer callbacks to DMA-read functions
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
 scripts/oss-fuzz/minimize_qtest_trace.py      | 117 +++
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |  94 +++
 scripts/oss-fuzz/target.c                     |  40 +
 softmmu/memory.c                              |  14 +
 tests/qtest/fuzz/Makefile.include             |   1 +
 tests/qtest/fuzz/fuzz.c                       |   5 +-
 tests/qtest/fuzz/general_fuzz.c               | 758 ++++++++++++++++++
 14 files changed, 1223 insertions(+), 4 deletions(-)
 create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
 create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 scripts/oss-fuzz/target.c
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

-- 
2.27.0


