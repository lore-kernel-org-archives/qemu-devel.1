Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D922C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEA220657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="eSlLeOcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEA220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huX9r-0004lK-FU
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37199)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX98-00039x-7W
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX97-0001rJ-0C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:06 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
 ([40.107.79.111]:12064 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX96-0001qn-LV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckT6r+FtrdTUw3ty8KDCL10uMv7hN8gyQ4YX7rZzUj8FfWKBFSwZlcuNF2lzxI6M7g0prDbq9IklZYAty9T04ZboP8hanyr/6vHrPvq0NATJEWxxRM/qbxJiSx8cqejOWBUbY+S2BrhzIFYnE5KbC/Boe22KWa7ZPHxaBnWwz5gQDg57qjZxo2qwBcWu96Kpd4GgL2TOjnaN14AWTZDWP0oxn/mu8PJmHwXTq/xVUEjKCdnjq/4HeNtujX+djcovbebxxxuaXIgrz2fULJyX3g4RRdOqo2Am/kCClEsjVdys1V5USNnXJV3SsuIig/HYCkTjvSFG5q8oZwuxnN5F7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4aZ21J6+lcfbBhm8yUhBM7AE5+PXYAZh1RSdAEp7qc=;
 b=RiCBqCijeM0tTaAj4kV3srBaIAQ2GmGkxSAPxGtvXUjgkxzJDbmCNxAKMyd3L8Es88pEkUz2SVEiHd8XnOuINREYBW07dRviauiOmABRltr0ypjivgM3TdXEbQrWpjFSWWvbCpq3WB6nUI1bcmHWaRmIRCZgCTy05swrIt0/05x+OgFIXepVTzPytU9O1DC6DzMDhJqyb5jFjAGfXO6xdWfNap1irWCJptBIa7FyVY/I9pyfkP2hUF/6EXXnaWq5AUhgyswnZ6rduYCqAYW+mRO0g+QStieTzMbuw4AsfqvpPpJGVcIkb21/6stck/ZMv+Up8FvRahU2ohVjN/hhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4aZ21J6+lcfbBhm8yUhBM7AE5+PXYAZh1RSdAEp7qc=;
 b=eSlLeOcmzeh/vKbJqLl5Mk8exUxa7Rei5fYjjCLNv1IKByHhrubkeLx/WvMSh0zT3vZm1BFYlMU9kOWrrn3VueAFAQbaifyg/Mt7vVcq89mO+0kuVmHr63qb9RCmHw7YlkLnMiX5UdLE3yQbsEr5aWKr4BtJ+lef1TfN350rlSg=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:02 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:02 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 00/17] Add virtual device fuzzing support
Thread-Index: AQHVS1zwRoWB3hU23U20ghvShPoNVA==
Date: Mon, 5 Aug 2019 07:11:02 +0000
Message-ID: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bc57f4b-4a3a-4584-5b67-08d7197412c4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646BF3499A33129589928BABADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 96wa2xfU70tobBV9SmsZzVB+tUhNAshvm1xdc0YthS9D+2R24omwmOw47qN2wyg1u7rqGAlkkHVtZJVk2yyC+HuxJfigwB/uRGQ2ScaxkyRiuyI08M6gxypPV0EiPfEvEckW4YKcv6A8PXCpSs/bN89BwMhXq2wvlHZAHL6fJV0n0vS5dla8D/mraq7T0TmlKYrfsf9GJOjEouOCCMiVEuriAeTs7puwadekyzT6t7R6UGKhNoRQ6JeVd1R4eZeSqFsDrlMdRqPrWNVtL9kgvYTtVwGj94CcvaHX9U13tgty7FsFBE4fsLRvJL+JoHKy9QqYOtpUJX9JNXWttNGsvwuyUnTLAholI72dkVOj1ZYZqB6LYrhM++JdlqPbqGGJ21qOHDFRsb3FgkfH2IFbvVIFQgTp0zr24/sVYZ0A5us=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc57f4b-4a3a-4584-5b67-08d7197412c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:02.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.111
Subject: [Qemu-devel] [RFC PATCH v2 00/17] Add virtual device fuzzing support
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
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v1
 * Split off changes to qos virtio-net and qtest server to other patches
 * Move vl:main initialization into new func: qemu_init
 * Moved useful functions from qos-test.c to a separate object
 * Use struct of function pointers for add_fuzz_target(), instead of
   arguments
 * Move ramfile to migration/qemu-file
 * Rewrite fork-based fuzzer pending patch to libfuzzer
 * Pass check-patch

Based-on: 20190805032400.8054-1-alxndr@bu.edu
Based-on: 20190805031240.6024-1-alxndr@bu.edu

---
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

Alexander Oleinik (17):
  fuzz: Move initialization from main to qemu_init
  fuzz: Add fuzzer configure options
  fuzz: Keep memory mapped for fork-based fuzzer
  fuzz: Skip modules that were already initialized
  fuzz: Add direct receive function for qtest server
  fuzz: Add FUZZ_TARGET module type
  fuzz: Add ramfile qemu-file type
  fuzz: Export the qemu_savevm_live_state function
  fuzz: hardcode needed objects into i386 target
  fuzz: qtest client directly interacts with server
  fuzz: Move useful qos functions to separate object
  fuzz: Add fuzzer skeleton
  fuzz: Add libqos support to the fuzzer
  fuzz: Add forking support to the fuzzer
  fuzz: Add general qtest fuzz-target
  fuzz: Add virtio-net fuzz targets
  fuzz: Add fuzz accelerator type

 accel/fuzz.c                 |  48 +++++++
 configure                    |  15 ++
 exec.c                       |   2 +
 include/qemu/module.h        |   4 +-
 include/sysemu/fuzz.h        |  15 ++
 include/sysemu/qtest.h       |   4 +
 include/sysemu/sysemu.h      |   5 +
 migration/qemu-file.c        |  84 +++++++++++
 migration/qemu-file.h        |  11 ++
 migration/savevm.c           |   9 +-
 migration/savevm.h           |   2 +
 qtest.c                      |  14 ++
 target/i386/Makefile.objs    |  20 +++
 tests/fuzz/fuzz.c            | 245 +++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h            |  70 ++++++++++
 tests/fuzz/fuzzer_hooks.c    |  62 +++++++++
 tests/fuzz/fuzzer_hooks.h    |  21 +++
 tests/fuzz/qos_fuzz.c        |  58 ++++++++
 tests/fuzz/qos_fuzz.h        |  23 ++++
 tests/fuzz/qos_helpers.c     | 190 +++++++++++++++++++++++++
 tests/fuzz/qos_helpers.h     |  17 +++
 tests/fuzz/qtest_fuzz.c      | 260 +++++++++++++++++++++++++++++++++++
 tests/fuzz/qtest_fuzz.h      |  37 +++++
 tests/fuzz/virtio-net-fuzz.c | 254 ++++++++++++++++++++++++++++++++++
 tests/libqos/qos_external.c  | 149 ++++++++++++++++++++
 tests/libqos/qos_external.h  |   8 ++
 tests/libqtest.c             |  61 +++++++-
 tests/libqtest.h             |   6 +
 tests/qos-test.c             | 132 +-----------------
 util/module.c                |   7 +
 vl.c                         |  25 +++-
 31 files changed, 1720 insertions(+), 138 deletions(-)
 create mode 100644 accel/fuzz.c
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
 create mode 100644 tests/fuzz/virtio-net-fuzz.c
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

--=20
2.20.1


