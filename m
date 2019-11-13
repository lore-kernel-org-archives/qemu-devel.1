Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9BC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A03206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RKkJ3q4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A03206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Xb-0002iH-BT
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-000840-Vz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007c0-2o
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TM-0007S1-Li
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHivrUapXYyTLpR82jl8qfEDXxI8U+T5PBYAg9LMaOzSyU7gS8NHPZ6sQzPQg26dyj8m4FR/3oV+7DGCyuKBgkHrG3/vpmF1r1+QJ1CCj8V5teMyhmb8UygpMPS9Xw5YvkHf8Di/GJyeTnnsShmsFAXzTXJLiKfIDn1RJCo5vPhzElCdIEQQ7Cf2CEQeqjReU4tHIzgb2f3kmXtpj+Oj+m39n3rCj1O+f++pXCsjFiOkSmepO5vWJAfH/Oir+UzUi2WXHtcVncUtdHe3PSFs/g2IGB7kToweuWAucnkaDfYBmmI35qjrihOWB/euaiKAZ84T5dzgIjxXnt0F6Q9Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S8Tox1xa0Kv8JfcLGiMndC8WdzfHsEq8E4UGEz9Fuw=;
 b=LNYBMSMJ5lDzb0oCYP240MeV1fTZyPSYwum61bZ5qDxpt2M6cz8JYHp25mCheSMweha+pDm5rRasPL85OcNNBsl4P/Sv8y7bUuBhE82e17I5g6cWi10Z+0sWLTp9ptueptkGrL19FDgac242ioDa/b7FrnjPzChkBcNUOrGi29pIFni5iCAV5hPTGxQayarFNDLEEze+M2FlYf2FcA6huzevxIGHbGLWY2H9mwyKeQ4sHr8yBW1JctURbnmKVAwHbubUeTHXTdxEIbIYE1r2oBVUdyq06tGZdhI0biORDlwHCObAbQlkS+J2lccQQ+oteNDs7KStG4dQ5hwwV4T3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S8Tox1xa0Kv8JfcLGiMndC8WdzfHsEq8E4UGEz9Fuw=;
 b=RKkJ3q4df+SYDIQBrEHtAg7Qtk9pv60yE7UhVengwlcV2clnZPSDa65+Ub9rHjcpiE9tmZuBpGMuvYmtjSMDbHSge+NTEYFA8EJkCBGWxOyUEbVmpGWr229oS/cyxSc1+EZqrCT/wCrZtyvuGdKCffUlO1EHeBUfv/jBTyFfWpU=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:41 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:41 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 00/20] Add virtual device fuzzing support
Thread-Topic: [PATCH v5 00/20] Add virtual device fuzzing support
Thread-Index: AQHVmnTG77CbXoJrvUGHcHHmfhQA0Q==
Date: Wed, 13 Nov 2019 22:50:41 +0000
Message-ID: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562aa295-1d82-4f0b-a518-08d7688be8e5
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024EC2D2A6F7481DADA430DBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(7736002)(99286004)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCuYXPyeS+2+vr8kYdmqsBCyQc7kpwRAB9OptApbw32n6kpNwqGI+uUOEIMQ7IU9iOeZzLqyVb05DEkY2lYns9H0+tdaZhOe+h79L9MkC3azG+JPHhuUvPvLLzP+zIBugmLF8FgdPeNiNstHjg9JwP1Xz9VLOlPk2rTJjRfnziBDrC83Uzt+7sSl99uK4I84v46DSmeSKs0x8ImRj7CJ4Uyb9yTEbQVEbwgUn50kxJCGnngoRHxVRp3TAF5wcXsOamR2TltXiokdjBl89KJoJXF764DsVk82RS3cI1xdchfAHYQVJEITHJiGrPeipffS0RCAegcQ4wBPC7dk0iSBN+R1c1EE4eZTwiQX5+fwigf1DzfKI5EbiTwVnujOYTYbprNUSqeJ763RmFPiMwdQxXdyj4Q5/BBRw2f7cPd19Yr0k8Hpk9uwszxeZ5YIrgS9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 562aa295-1d82-4f0b-a518-08d7688be8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:41.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDGZmFJ0o8eBETa/ZtqjU+J2QZkcUqYOjosbjYFF/m26zC03V8+Gi3FiMkLoxwsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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

This series adds a framework for coverage-guided fuzzing of
virtual-devices. Fuzzing targets are based on qtest and can make use of
the libqos abstractions.

V5:
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

Alexander Bulekov (20):
  softmmu: split off vl.c:main() into main.c
  libqos: Rename i2c_send and i2c_recv
  fuzz: Add FUZZ_TARGET module type
  qtest: add qtest_server_send abstraction
  libqtest: Add a layer of abstraciton to send/recv
  module: check module wasn't already initialized
  qtest: add in-process incoming command handler
  tests: provide test variables to other targets
  libqos: split qos-test and libqos makefile vars
  libqos: move useful qos-test funcs to qos_external
  libqtest: make bufwrite rely on the TransportOps
  libqtest: add in-process qtest.c tx/rx handlers
  fuzz: add configure flag --enable-fuzzing
  fuzz: Add target/fuzz makefile rules
  fuzz: add fuzzer skeleton
  fuzz: add support for fork-based fuzzing.
  fuzz: add support for qos-assisted fuzz targets
  fuzz: add i440fx fuzz targets
  fuzz: add virtio-net fuzz target
  fuzz: add documentation to docs/devel/

 Makefile                     |  16 ++-
 Makefile.objs                |   4 +
 Makefile.target              |  18 ++-
 configure                    |  39 ++++++
 docs/devel/fuzzing.txt       | 119 ++++++++++++++++++
 exec.c                       |  12 +-
 include/qemu/module.h        |   4 +-
 include/sysemu/qtest.h       |   4 +
 include/sysemu/sysemu.h      |   4 +
 main.c                       |  53 ++++++++
 qtest.c                      |  31 ++++-
 tests/Makefile.include       |  75 +++++------
 tests/fuzz/Makefile.include  |  11 ++
 tests/fuzz/fork_fuzz.c       |  55 +++++++++
 tests/fuzz/fork_fuzz.h       |  23 ++++
 tests/fuzz/fork_fuzz.ld      |  37 ++++++
 tests/fuzz/fuzz.c            | 179 +++++++++++++++++++++++++++
 tests/fuzz/fuzz.h            |  94 ++++++++++++++
 tests/fuzz/i440fx_fuzz.c     | 176 ++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.c        | 232 +++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.h        |  33 +++++
 tests/fuzz/virtio_net_fuzz.c | 100 +++++++++++++++
 tests/libqos/i2c.c           |  10 +-
 tests/libqos/i2c.h           |   4 +-
 tests/libqos/qos_external.c  | 168 +++++++++++++++++++++++++
 tests/libqos/qos_external.h  |  28 +++++
 tests/libqtest.c             | 108 ++++++++++++++--
 tests/libqtest.h             |   4 +
 tests/pca9552-test.c         |  10 +-
 tests/qos-test.c             | 140 +--------------------
 util/module.c                |   7 ++
 vl.c                         |  38 ++----
 32 files changed, 1607 insertions(+), 229 deletions(-)
 create mode 100644 docs/devel/fuzzing.txt
 create mode 100644 main.c
 create mode 100644 tests/fuzz/Makefile.include
 create mode 100644 tests/fuzz/fork_fuzz.c
 create mode 100644 tests/fuzz/fork_fuzz.h
 create mode 100644 tests/fuzz/fork_fuzz.ld
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h
 create mode 100644 tests/fuzz/i440fx_fuzz.c
 create mode 100644 tests/fuzz/qos_fuzz.c
 create mode 100644 tests/fuzz/qos_fuzz.h
 create mode 100644 tests/fuzz/virtio_net_fuzz.c
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

--=20
2.23.0


