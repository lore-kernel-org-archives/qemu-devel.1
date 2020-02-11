Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACEC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B116920714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="uYgHWjdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B116920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cHC-00088l-PC
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFh-0006MM-TY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFg-00085a-65
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:25 -0500
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com
 ([40.107.236.120]:36865 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFf-00083m-TI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoBSMISSKneOKT3Yh5woQ4JCaeawClGbuX5oiTNubARfzlF8w5wuD7EjfPFyX23vwe1AqsDHyQyO/3JuGoUNiFWqn4xzDbNIr3hssd+1qaUstOTOlXBRr7UsKhO+FMJXQzLW28g7YJddbnCTbIPoG/LBx6AbAZbksyHbT0/iXuAhtXPdCh//Zkxr+8dUghDqEh+a3+GzgvzKOxGlFS6JAh8QJwJEGZUlhuAiuxbuWJKbhwZg3hcRCLj1BHCLzQjZwKCVRvXf0JtN87g20DVw4c7pimfKhCSFbAWKmQi9cFGS/NbjfYwcIb3m2iM61zKrhshtKK5ryVMb/8y5WdkzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ALXLmbzosCHPoTm1IlhlUxp8dcSeatzPX6KEJpp9V4=;
 b=JNU2L6ry3YDRm7okH+FOg0ft8toV+xYERSzDM93oRxKTgxkXOap1sxpcMNMZiSRQ+XeHSPo4NVqgj2BSqM744qP8T2lFLsZ5Z/KlK91HYvyoQDs/ygEeiE333Frpu/6Kjej57vVo79u/hx52LgvVgy2kSsQ5Bh+Gg5LKrA2uoA84iaftsbuwQyS6C0tTtz7Hjibcg7briwr/kAZp1RCMd7BtVTloPgdXKpAemuvSg3CPCVSyqr2e+q4aBtrjejAGHmqOWrKIitnFFWlFFr7JaSii7J3Nv9fxqiFzpCQWv2bsPMeqpGDiprMPL8EpJxpCkTHUEB7xgAc68jTtg/stDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ALXLmbzosCHPoTm1IlhlUxp8dcSeatzPX6KEJpp9V4=;
 b=uYgHWjdGmswC5f/j6nugrlRaE7MLFIhNtxMRDPKH/4+dhzw16ZfiUA/39K6T/LJqWOEgvqYWStmMGaHeHc0I7WE/ACdsspzWXfquO53iEYXCdbEmvMg4FHSprbsEkrXM+lTTLm3V5ZvZtSYkkdc6G3A16kFt4rNHpXK59JtYwJ8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:21 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:21 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/23] Add virtual device fuzzing support
Date: Tue, 11 Feb 2020 15:34:47 -0500
Message-ID: <20200211203510.3534-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:21 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 785e83b0-133d-4570-6997-08d7af31ea57
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB359907F96531F8340699E003BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rd0KSaMCfAQK8h7r9dveTKDlrwJsonMu45/ecxJUsojlxJhE+dxsk93nceKJ79d85ZaTH2q1WFUW7BZRbi1//V48a+TebfhxDCyh72uOD3oHDwaRfTTe7coWCpzsdTf71DaAMERY9f96tQZ3EDz18rdiWtOAwHDMU/Pa2NoMDTNyDGi6xfN0huEAMf1KYJffybFKOfkSYsVG2RJoEK8MJ73bnbwTJNW9snvsbGkJfC06zwxyUh4BJJkKDlbT30Zs+GkXA8JGHqB47IiSkTT8ub7vsVNuijAMDJlGT3MwsTblP2rI3Jkxo66g74JDli3AnbXQJNvuVWtwQJPoLSqQ9PAzqzg7B7Ln6bPb+tMhn/KDvMurEo3QQzZOSP2sGRFdTcT+o7FoBFj1HVn8keAo4Z9tbZwwfsBwMT3XdyKsj8ekpqm0YA/+haKMQGKFnsfM
X-MS-Exchange-AntiSpam-MessageData: NU4js67iVGPtzFGWnVK25Tw7QCoYkpizHAYQ3zNuZzUw9pTz9Tyy7paEwb9QFGiZDtoT20CNBcfSNPcX18SNjO1A4AMDzCqueoXInDAKsSGNuzV8b9AJUFiNGDzRdo+C+lXiAjsLULz0fEE0qRKjbQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 785e83b0-133d-4570-6997-08d7af31ea57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:21.8028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOjmpkrfWT+8FTFHIu/xt2ebgiucszOqllaQm46/q3/qvQLs8F/2JMUTtcK8CpIX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.120
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This series adds a framework for coverage-guided fuzzing of
virtual-devices. Fuzzing targets are based on qtest and can make use of
the libqos abstractions.

V9:
 * Fix bug in the virtio-scsi fuzzer. Virtqueues were being kicked only
   if free_head !=3D 0 (which it never was).
 * Move vl.c and main.c into a new directory: softmmu/
 * virtio-net-fuzz: refactor the looop over used descriptor.
 * Improve comments for i440fx and virtio-scsi fuzzers.

V8:
 * Small fixes to the virtio-net.
 * Keep rcu_atfork when not using qtest.

V7:
 * virtio-net: add virtio-net-check-used which waits for inputs on
 the tx/ctrl vq by watching the used vring.
 * virtio-net: add virtio-net-socket which uses the socket backend and can
 exercise the rx components of virtio-net.
 * virtio-net: add virtio-net-slirp which uses the user backend and exercis=
es
 slirp. This may lead to real traffic emitted by qemu so it is best to
 run in an isolated network environment.
 * build should succeed after each commit

V5/V6:
 * added virtio-scsi fuzzer
 * add support for using fork-based fuzzers with multiple libfuzzer
   workers
 * misc fixes addressing V4 comments
 * cleanup in-process handlers/globals in libqtest.c
 * small fixes to fork-based fuzzing and support for multiple workers
 * changes to the virtio-net fuzzer to kick after each vq add

V4:
 * add/transfer license headers to new files
 * restructure the added QTestClientTransportOps struct
 * restructure the FuzzTarget struct and fuzzer skeleton
 * fork-based fuzzer now directly mmaps shm over the coverage bitmaps
 * fixes to i440 and virtio-net fuzz targets
 * undo the changes to qtest_memwrite
 * possible to build /fuzz and /all in the same build-dir
 * misc fixes to address V3 comments

V3:
 * rebased onto v4.1.0+
 * add the fuzzer as a new build-target type in the build-system
 * add indirection to qtest client/server communication functions
 * remove ramfile and snapshot-based fuzzing support
 * add i440fx fuzz-target as a reference for developers.
 * add linker-script to assist with fork-based fuzzer

V2:
 * split off changes to qos virtio-net and qtest server to other patches
 * move vl:main initialization into new func: qemu_init
 * moved useful functions from qos-test.c to a separate object
 * use struct of function pointers for add_fuzz_target(), instead of
   arguments
 * move ramfile to migration/qemu-file
 * rewrite fork-based fuzzer pending patch to libfuzzer
 * pass check-patch

Alexander Bulekov (23):
  checkpatch: replace vl.c in the top of repo check
  softmmu: move vl.c to softmmu/
  softmmu: split off vl.c:main() into main.c
  module: check module wasn't already initialized
  fuzz: add FUZZ_TARGET module type
  qtest: add qtest_server_send abstraction
  libqtest: add a layer of abstraction to send/recv
  libqtest: make bufwrite rely on the TransportOps
  qtest: add in-process incoming command handler
  libqos: rename i2c_send and i2c_recv
  libqos: split qos-test and libqos makefile vars
  libqos: move useful qos-test funcs to qos_external
  fuzz: add fuzzer skeleton
  exec: keep ram block across fork when using qtest
  main: keep rcu_atfork callback enabled for qtest
  fuzz: support for fork-based fuzzing.
  fuzz: add support for qos-assisted fuzz targets
  fuzz: add target/fuzz makefile rules
  fuzz: add configure flag --enable-fuzzing
  fuzz: add i440fx fuzz targets
  fuzz: add virtio-net fuzz target
  fuzz: add virtio-scsi fuzz target
  fuzz: add documentation to docs/devel/

 Makefile                            |  15 +-
 Makefile.objs                       |   2 -
 Makefile.target                     |  19 ++-
 configure                           |  39 +++++
 docs/devel/fuzzing.txt              | 116 ++++++++++++++
 exec.c                              |  12 +-
 include/qemu/module.h               |   4 +-
 include/sysemu/qtest.h              |   4 +
 include/sysemu/sysemu.h             |   4 +
 qtest.c                             |  31 +++-
 scripts/checkpatch.pl               |   2 +-
 softmmu/Makefile.objs               |   3 +
 softmmu/main.c                      |  53 +++++++
 vl.c =3D> softmmu/vl.c                |  48 +++---
 tests/qtest/Makefile.include        |  72 ++++-----
 tests/qtest/fuzz/Makefile.include   |  18 +++
 tests/qtest/fuzz/fork_fuzz.c        |  55 +++++++
 tests/qtest/fuzz/fork_fuzz.h        |  23 +++
 tests/qtest/fuzz/fork_fuzz.ld       |  37 +++++
 tests/qtest/fuzz/fuzz.c             | 179 +++++++++++++++++++++
 tests/qtest/fuzz/fuzz.h             |  95 +++++++++++
 tests/qtest/fuzz/i440fx_fuzz.c      | 193 +++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.c         | 234 ++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.h         |  33 ++++
 tests/qtest/fuzz/virtio_net_fuzz.c  | 198 +++++++++++++++++++++++
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 214 +++++++++++++++++++++++++
 tests/qtest/libqos/i2c.c            |  10 +-
 tests/qtest/libqos/i2c.h            |   4 +-
 tests/qtest/libqos/qos_external.c   | 168 ++++++++++++++++++++
 tests/qtest/libqos/qos_external.h   |  28 ++++
 tests/qtest/libqtest.c              | 119 ++++++++++++--
 tests/qtest/libqtest.h              |   4 +
 tests/qtest/pca9552-test.c          |  10 +-
 tests/qtest/qos-test.c              | 132 +---------------
 util/module.c                       |   7 +
 35 files changed, 1958 insertions(+), 227 deletions(-)
 create mode 100644 docs/devel/fuzzing.txt
 create mode 100644 softmmu/Makefile.objs
 create mode 100644 softmmu/main.c
 rename vl.c =3D> softmmu/vl.c (99%)
 create mode 100644 tests/qtest/fuzz/Makefile.include
 create mode 100644 tests/qtest/fuzz/fork_fuzz.c
 create mode 100644 tests/qtest/fuzz/fork_fuzz.h
 create mode 100644 tests/qtest/fuzz/fork_fuzz.ld
 create mode 100644 tests/qtest/fuzz/fuzz.c
 create mode 100644 tests/qtest/fuzz/fuzz.h
 create mode 100644 tests/qtest/fuzz/i440fx_fuzz.c
 create mode 100644 tests/qtest/fuzz/qos_fuzz.c
 create mode 100644 tests/qtest/fuzz/qos_fuzz.h
 create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c
 create mode 100644 tests/qtest/fuzz/virtio_scsi_fuzz.c
 create mode 100644 tests/qtest/libqos/qos_external.c
 create mode 100644 tests/qtest/libqos/qos_external.h

--=20
2.25.0


