Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70629C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B86822AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="qXVBfO9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86822AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUMj-0005j2-Us
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUM9-0003wx-Nb
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUM7-0001nI-T1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:49 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUM7-0001mt-Gr
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjODJqCVBRrTnrBpkhcR/p18i1dYe8nT87j501cv0Td6fOzWy1ojnO7osxbtdbbgC6JSYX+9aP8bdFZHxB/oeu+TTi32c+DZiy7VEAcDBCXZtBfPqmJNHqA1LAHeN1Juk42AGtG9l6kdAyBIhJXBDohbpckgfw0Te7opuDklEnS26skGtrK0nMBw0cDE0ylsH6fTEVbgjJFRON7+fUz6ay2RUpaBDfulkkNprSJ8eGRQxgQSxfhXiZFCYiixJjp11/NhYrGXQ9r0wegJYhh2FbLK/WP8qKn39duXwxsNftyyalINDdoeqO6JsOCEU2Ewd0AaGtOQ/h4kFwFVrX+1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF6P8tm+mT/vaFmq9CV4Z5Z4k9PcA3EbBTJqdOiXyGg=;
 b=OyhZqbzqUdzUt5kYsX8c3PgaHiSIIvNYNxm94pcFSxgXaxz4QvvVGmHvTjM4iDgmF2d1rZNMQptfuIiDs39aeNNjGMlbq1l7LA7eOx/fijZvp7gJfxf0St8SnrCRf8js4b4OpAr022KC7Vbjj833ysyDPiKji2HZfLz+gfpCxH9WDWDGYKmPO3BZiWgqj7FdssVSJat3ls+IwqE4gyDf5XEHMyInc3HvRllOECAh4MXosfq1C+cpXINiqfhFvmWRNXVhe2zsi6VsLx0n9+KRSTF0sbGHSI+GNnUlfZ5RLyb5fmWppKi2MnyRMadnpt9+lOkOvCzfXCJQwSMgzLfBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF6P8tm+mT/vaFmq9CV4Z5Z4k9PcA3EbBTJqdOiXyGg=;
 b=qXVBfO9VtN/xRfIO3Hmi9CZU150x2qv0kYdHzb3P8K2Yy1tmwAtpLGIVB69tDJTxpp8iFEeV3+MNYNdaPK52VPlbagcs4LhlYBzHCau4eYcXPZSCMKpPM8tOxe1IQfokuOUuFr4UAZtAtBCVnqdrSFcKTcW9mqaQ5lTrjLKqGe8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:43 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:43 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 00/19] Add virtual device fuzzing support
Thread-Index: AQHVQphcmy1Y7E8GmkqXh37FIYF0Vg==
Date: Thu, 25 Jul 2019 03:23:43 +0000
Message-ID: <20190725032321.12721-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 20f778da-fbdc-4788-134e-08d710af7eff
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <CY4PR03MB27267704A48AA03D65CB085DBAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(966005)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(6306002)(2906002)(476003)(66946007)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vjBYkEgqgMHdKQ5hiAtfz1LHsc5eXhxlBoPzfLbdVr5kj6q1Z7d2L9h+LJ8kImSlAyxufFrhm9e04hDvXrePat4lSQ6SY16gveJEZS/wsq54pB/5QZnM0MJ0uPWZJbtK82EaSZQrwYowUahe1Y/FRyPh28XEMEgy5RbqLuQTqhY5AP6DiFlB8lTTTchFDxTeTKDR6BcaJIoGOU1bIDZsq+87lx6UYlfrwCvCj6GQj+6V92kQcbgA/+yVIzh73SMub/GN5kF4RT2edZwAk8ke2Qkr8J9YYLdl0MvUT4THR9ax8sVUGm0897Qsmam+KS5NjmjsVFBk5XSALMhUkhSWMTDOzGWsuIbR70DtzaFcNFd3SKHCjqPXvQcDVudMeZGmNfR33lk21wJGo6a1tA4TIGm/g1eVYohF2fGCVbDBFk4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f778da-fbdc-4788-134e-08d710af7eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:43.4570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 00/19] Add virtual device fuzzing support
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

As part of Google Summer of Code 2019, I'm working on integrating
fuzzing of virtual devices into QEMU [1]. This is a highly WIP patchset
adding this functionality.

Fuzzers provide random data to a program and monitor its execution for
errors. Coverage-guided fuzzers also observe the parts of the program
that are exercised by each input, and use this information to
mutate/guide the inputs to reach additional parts of the program. They
are quite effective for finding bugs in a wide range of software.=20

Summary:
 - The virtual-device fuzzers use libfuzzer [2] for coverage-guided
   in-process fuzzing.
 - To fuzz a device, create a new fuzz "target" - i.e. a function that
   exercises QEMU based on inputs provided by the fuzzer.
 - Fuzz targets rely on qtest and libqos to turn inputs into actions.
 - Since libfuzzer does in-process fuzzing, the QEMU state needs to be
   reset after each fuzz run. These patches provide three methods for
   resetting state.
 - There are currently few targets, but they have already helped
   discover bugs in the console, and virtio-net, and have reproduced
   previously-reported vulnerabilities.

Here are some main implementation details:
 - The fuzzing occurs within a single process. QTest and QOS are
   modified so the QTest client and server coexist within the same
   process. They communicate with each other through direct function
   calls. Similar to qtest, the fuzzer uses a lightweight accelerator to
   skip CPU emulation. The fuzzing target is responsible for manually
   executing the main loop.
 - Since the same process is reused for many fuzzing runs, QEMU state
   needs to be reset at the end of each run. There are currently three
   implemented options for resetting state:=20
   1. Reboot the guest between runs.
      Pros: Straightforward and fast for simple fuzz targets.=20
      Cons: Depending on the device, does not reset all device state. If
      the device requires some initialization prior to being ready for
      fuzzing (common for QOS-based targets), this initialization needs
      to be done after each reboot.
      Example target: --virtio-net-ctrl-fuzz
   2. vmsave the state to RAM, once, and restore it after each run.
      Alternatively, only save the device state
      (savevm.c:qemu_save_device_state)
      Pros: Do not need to initialize devices prior to each run.
      VMStateDescriptions often specify more state than the device
      resetting functions called during reboots.
      Cons: Restoring state is often slower than rebooting. There is
      currently no way to save the QOS object state, so the objects
      usually needs to be re-allocated, defeating the purpose of
      one-time device initialization.
      Example target: --qtest-fuzz
   3. Run each test case in a separate forked process and copy the=20
      coverage information back to the parent. This is fairly similar to
      AFL's "deferred" fork-server mode [3]
      Pros: Relatively fast. Devices only need to be initialized once.
      No need to do slow reboots or vmloads.
      Cons: Not officially supported by libfuzzer and the implementation
      is very flimsy. Does not work well for devices that rely on
      dedicated threads.
      Example target: --qtest-fork-fuzz
 - Fuzz targets are registered using QEMU's module system, similar to
   QOS test cases. Base qtest targets are registed with fuzz_add_target
   and QOS-based targets with fuzz_add_qos_target.
 - There are two entry points for the fuzzer:
    LLVMFuzzerInitialize: Run once, prior to fuzzing. Here, we set up
   qtest/qos, register the fuzz targets and partially execute vl.c:main.
   This is also where we would take a snapshot, if using the vmsave
   approach to resetting.
    LLVMFuzzerTestOneInput: Run for each fuzzing input. This function is
   responsible for taking care of device initialization, calling the
   actual fuzz target, and resetting state at the end of each run.
   Both of these functions are defined in tests/fuzz/fuzz.c
 - There are many libfuzzer flags which should be used to configure the
   coverage metrics and storage of interesting fuzz inputs. [2] These
   flags can also be helpful in evaluating fuzzing performance through
   metrics such as inputs/seconds and line-coverage.

Here are some key issues with the current state of the code:
 - The patches change vl.c, main-loop.c, qtest.c, tests/libqtest.c,
   savevm.c, memory.c. I wrapped the changes with #ifdef CONFIG_FUZZ,
   but many of these changes can and should be avoided.
 - tests/fuzz/qos_helpers.c is largely a copy of tests/qos-test.c.
 - The fuzzer is not properly integrated into the build system.
   Currently I simply added all of the necessary objects to
   target/i386/Makefile.objs, but there should be a simple way to build
   for other arches. The binary needs to be linked against libqemuutil,
   libqtest, qos and the qos objects, and the requirements for softmmu
   targets.
 - Some of the fuzz targets leak memory during state-resetting that need
   to be tracked down and fixed.=20
 - As mentioned already, running each test in a separate process does
   not seem to be supported by libfuzzer, and the implementation
   reflects this (tests/fuzz/fuzzer_hooks.c)
 - The existing fuzz targets should be cleaned up as they have issues
   with memory alignment and contain redundant checks. The should also
   use qtest's clock_step. The fork fuzz targets are dependant on
   a hard-coded section size.

Building and running:
Libfuzzer requires clang.
  $ CC=3Dclang-7 CXX=3Dclang++-7 ./configure --enable-fuzzing
  $ make i386-softmmu/all
  $ i386-softmmu/qemu-system-i386 --qtest-dma-fuzz -detect_leaks=3D0

Here "qtest-dma-fuzz" is the fuzz target name. Running qemu-system-i386
without any arguments should print all of the available fuzz targets.
The -help=3D1 command prints out the available libfuzzer options.

There are more details, including instructions for adding new fuzz
targets in docs/devel/fuzzing.txt

In the coming weeks I would like to fix the issues listed above, more
fuzzing targets, and ideally work on getting QEMU into oss-fuzz[4],
where it can be fuzzed continuously.

I appreciate any feedback. Thanks
-Alex

[1] https://wiki.qemu.org/Internships/ProjectIdeas/QtestOssFuzz
[2] Trophy Case section: http://lcamtuf.coredump.cx/afl/
[3] https://llvm.org/docs/LibFuzzer.html
[4] https://github.com/mirrorer/afl/blob/master/llvm_mode/README.llvm#L82
[5] https://github.com/google/oss-fuzz


Alexander Oleinik (19):
  fuzz: add configure option and linker objects
  fuzz: add FUZZ_TARGET type to qemu module system
  fuzz: add fuzz accelerator
  fuzz: Add qos support to fuzz targets
  fuzz: expose qemu_savevm_state & skip state header
  fuzz: Add ramfile for fast vmstate/vmload
  fuzz: Modify libqtest to directly invoke qtest.c
  fuzz: add shims to intercept libfuzzer init
  fuzz: use mtree_info to find mapped addresses
  fuzz: expose real_main (aka regular vl.c:main)
  fuzz: add direct send/receive in qtest client
  fuzz: hard-code all of the needed files for build
  fuzz: add ctrl vq support to virtio-net in libqos
  fuzz: hard-code a main-loop timeout
  fuzz: add fuzz accelerator type
  fuzz: add general fuzzer entrypoints
  fuzz: add general qtest fuzz target
  fuzz: Add virtio-net tx and ctrl fuzz targets
  fuzz: Add documentation about the fuzzer to docs/

 accel/fuzz.c                 |  47 ++++++
 configure                    |  11 ++
 docs/devel/fuzzing.txt       | 145 +++++++++++++++++
 include/qemu/module.h        |   7 +-
 include/sysemu/fuzz.h        |  15 ++
 include/sysemu/qtest.h       |   7 +-
 include/sysemu/sysemu.h      |   4 +
 memory.c                     |  34 ++++
 migration/savevm.c           |   8 +-
 migration/savevm.h           |   3 +
 qtest.c                      |  19 ++-
 target/i386/Makefile.objs    |  19 +++
 tests/fuzz/fuzz.c            | 262 +++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h            |  96 ++++++++++++
 tests/fuzz/fuzzer_hooks.c    | 106 +++++++++++++
 tests/fuzz/fuzzer_hooks.h    |   9 ++
 tests/fuzz/qos_fuzz.c        |  63 ++++++++
 tests/fuzz/qos_fuzz.h        |  29 ++++
 tests/fuzz/qos_helpers.c     | 295 +++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_helpers.h     |  17 ++
 tests/fuzz/qtest_fuzz.c      | 261 +++++++++++++++++++++++++++++++
 tests/fuzz/qtest_fuzz.h      |  38 +++++
 tests/fuzz/ramfile.c         | 127 +++++++++++++++
 tests/fuzz/ramfile.h         |  20 +++
 tests/fuzz/virtio-net-fuzz.c | 226 +++++++++++++++++++++++++++
 tests/libqos/virtio-net.c    |   2 +-
 tests/libqtest.c             |  53 ++++++-
 tests/libqtest.h             |   6 +
 util/main-loop.c             |   3 +
 vl.c                         |  21 ++-
 30 files changed, 1945 insertions(+), 8 deletions(-)
 create mode 100644 accel/fuzz.c
 create mode 100644 docs/devel/fuzzing.txt
 create mode 100644 include/sysemu/fuzz.h
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h
 create mode 100644 tests/fuzz/fuzzer_hooks.c
 create mode 100644 tests/fuzz/fuzzer_hooks.h
 create mode 100644 tests/fuzz/qos_fuzz.c
 create mode 100644 tests/fuzz/qos_fuzz.h
 create mode 100644 tests/fuzz/qos_helpers.c
 create mode 100644 tests/fuzz/qos_helpers.h
 create mode 100644 tests/fuzz/qtest_fuzz.c
 create mode 100644 tests/fuzz/qtest_fuzz.h
 create mode 100644 tests/fuzz/ramfile.c
 create mode 100644 tests/fuzz/ramfile.h
 create mode 100644 tests/fuzz/virtio-net-fuzz.c

--=20
2.20.1


