Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB1C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE4824658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="r+Z7xBc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE4824658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35759 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dCW-0005yd-JX
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0004Hk-2M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBb-0005uz-68
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:40 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBa-0005uk-RF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcrnOiN0EJHBW25059Qbqt65r77F5Z4LDzPi80q/b2mRbsWBw3kcfbGCTbuq3w1IMt6A6I3qOfSmWHuicvc0Gu0Dh3eggWHV9WctdOAzfB9AjESdf/+/WPD1Zw1njU5AH2tZXHEDPksaDhRQOrSIZWsAhy6vDOmtREUqPv2SCnZUeq3MkRA2tdymM+Rj+37JTa30zhlfIfxZvw76ZMBAjpgFKKwOHbFigy/vWVZ+3S9eB7oUVH5A2Pam7pkB/BNA39tbl/kPg0+KJ5O2OBKREL9BSriFVySCYmA5JVujhVfW2FyGsUrE2Bt4yVH7XRa54C1obDXIn4mAkMw/+9UJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQWigN8qEGkNw/RfhfAmEocHGS0H9nA9WOjgV1S/6Sc=;
 b=GTFdOcyFFwmBW2LAlNo6ywqAFIPZvhnmsusilYJmpCPtGaWCyN53dZvwvncb3+tvdcxnhru0lwJh/fb5YxVmEqP8821kgNg9QkAi5ZsGhjuRa1IjTDfN9wN8ZrZb6IUO1l1amWX5dM2pEetp1PID0FC5yfvtmCZFwGNQ60rG37UzbC28bfTWA8xID5A166LXKsPPjOU0mBN5B9vusO+HgV1/Ha/piaf+Eft+My/p+FUAgJzytRhJpWhzcENdQFRranIkfKp1jaEsmxlueKIVR4OC6sBo+iamjoLFv8La3uGEBiGxO/PmzgFRh7Gpttrn7p9BfEJ245mZBcec9mS2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQWigN8qEGkNw/RfhfAmEocHGS0H9nA9WOjgV1S/6Sc=;
 b=r+Z7xBc/scgyEbfDG5ZlJ4G+meRKFXdvH8UNY0umjzaATAVBsgFCC4SBijJJEiG1IUNCiACC7yr+aiyMd7Of0X+lwKQ3jXQZkA5YwqC7O8QO7Xzy7ZSp4f2S/q1R7DUBO3XlnD2vT7dMg0fv2Z0+4jvgpY+6bkz/rPoo5b9udY8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:34 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 00/22] Add virtual device fuzzing support
Date: Wed, 19 Feb 2020 23:10:56 -0500
Message-ID: <20200220041118.23264-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:33 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a72f64-4729-4fe6-6a5f-08d7b5baf901
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB380747BC6474FEF25F5B50C9BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uda0O9gHOWvynFo5hMHPAu1otpV8q+WKv3MhRBYUzW6pfg9glFWA7ih+uQqYuFO3nXoKyD0vrbq/OM2wM8NdN5YR1cmUfU3RGPgwoQ5MVSgfNfqJU3hC54AzSjWTm2QTUm3stIMKuAxEyWrosIOog8MWnc0+O47NMa8Mw1N2AFgiu5a1O5iNAIbaXogTCYsUkdRBVrr1HPVyLKZuoHUjiHpnSd2eckH0THItgWzOLh+lnUyhIzDQ8lMKmSFfjQ7PA7K9UzMk3+nUOvwnHAm9aYeVxuJyx6FOh02NjuLQFZxCbbvehSnGuDLv6kCgAn44Dt9VJ66boG4so/JjRbEflqqQVna2zAZSirqfgjZvSD/hQIMknU/nqlMn85frwkOkU6Gt8SkgMYdbJtOPdtysF1QOBRGCYLVv+A1a7ESCcwUl9nEPzmwzuaU9iCE2+QAZ
X-MS-Exchange-AntiSpam-MessageData: DsMcthfI8Y0Dh/K7OHp6YnROD7RDs4JUzyB8xZ8O41IK2SWEWljYkzOAyYs/zqR6Vo0DLzzZdlT87vZ7vR89qaTB5I3cbKTy4PxhNyecCBRNIjFwNRKeoHFRwPkTSE0pCpTTGhwKcCF2KWudrzPn9w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a72f64-4729-4fe6-6a5f-08d7b5baf901
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:34.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr8Uwq/cHjxiXpNgntO6ABfL9suVkExJW8/P1W6I86ilC+JQTdCI3QSTku0NPy7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.123
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
libqos. Fuzzing can help discover device bugs, such as
assertion-failures, timeouts, and overflows, triggerable from within
guests.

V10:
 * Update MAINTAINERS for vl.c, main.c and tests/qtest/fuzz
 * Fix changes to checkpatch
 * Fix typos in virtio-scsi fuzzer

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

Alexander Bulekov (22):
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

 MAINTAINERS                         |  11 +-
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
 scripts/get_maintainer.pl           |   3 +-
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
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 213 +++++++++++++++++++++++++
 tests/qtest/libqos/i2c.c            |  10 +-
 tests/qtest/libqos/i2c.h            |   4 +-
 tests/qtest/libqos/qos_external.c   | 168 ++++++++++++++++++++
 tests/qtest/libqos/qos_external.h   |  28 ++++
 tests/qtest/libqtest.c              | 119 ++++++++++++--
 tests/qtest/libqtest.h              |   4 +
 tests/qtest/pca9552-test.c          |  10 +-
 tests/qtest/qos-test.c              | 132 +---------------
 util/module.c                       |   7 +
 37 files changed, 1969 insertions(+), 229 deletions(-)
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


