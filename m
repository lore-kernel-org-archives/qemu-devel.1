Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9601EC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6326221907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="kVh3soMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326221907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjGg-00028f-Tp
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjET-0000DE-Lj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjER-0002SA-Dw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:32 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com
 ([40.107.71.125]:35255 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjER-0002RC-41
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX56AOe6lhSokn6wzCAxZd91CQSP7FhgoYqAw/CjekI1XZ4eNwg5n+8hEM0LmemuhSKmWAZb+Kr4BuBs1F+QjrWZo3el7/xAkA2VHysbLIx0UwfYu7vY1XsYF+Gelt6ggDt3n8Bwh7poubZz3bG4LdFQtQQL5MxVrUi8b0qk2ch1zwD4HbJ2uu/vf5Dk4pZqFZbN7JqQK/CUK+sGq6npfLFSwpiAd1cx7K8Hr5+MjYLiJd3hkhST0sUb/+o6T2gWItJ3oj72sl7BqbKD5LF9MG6oypLNg2J/H+iS7c1Q/spxAl7w0VkFjENd0J8ifNicZIrCXzseRFeKvnwsRTtGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zi3OdE9xvWa29TEAFFKE5dOocUiD3O0MOuV4e8R3TU=;
 b=RmOwklgnKqVAtBgPZLryYkNamRGq5kzWsXsXWFHeqa/6DyulivOhgb65ehBBqXKB0FFsj7N1k5IWoKkkII7HWTCuuY7OBvQnP1RyvMO8sroe52ONxvXYtL6nDUUX9opgv1Tyv9XhCxa+8Gx9OLoTlzmGVZ/J+Nc/YcD5JZS06eJr5LyFf+ycJKvsQmgFrmCUBT9/PUdJTRqTfimumSJBpne0XZNJ/1L4wIHsxezvEnG8deL9HpzY9jt6sFiHD339Y4wSfePetlXMbCg6WCAmUtFUCtqvWgrV4jsqFBMBg3vXveoN+IcVy7UxD5BhnhX0z6iInqVyFi0Ez7E++DpuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zi3OdE9xvWa29TEAFFKE5dOocUiD3O0MOuV4e8R3TU=;
 b=kVh3soMZf5eAM3lFu1aMHWvo6XHBaiG0SZsCBxrbSQRHHzfHf/gw2703mV/ioA4zeI+104V7a3rbm2oMEcYTLhu/5RQhLhBKn/4XIqkoegt+QsZurDka1ud9zrCgiVlFZnK4Yx8FzfdX3WY3y2kXI4jWJPm1jEm/HG/TadgD0Jw=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:27 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:27 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 00/22] Add virtual device fuzzing support
Thread-Index: AQHVbneDhUwDeJhtQUSCHJfjd9g7LQ==
Date: Wed, 18 Sep 2019 23:19:27 +0000
Message-ID: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e23817-6f29-4d56-1b4d-08d73c8ea65a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016C06F5973D34047370DB6BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(14444005)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(186003)(102836004)(99286004)(66946007)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jqdx+bkLFzjODU9r627zBr0M+Vj6o8noOhamXD2eGuOlWLHoa+Xx9bHI/hyPn7Ihv/yeSWX+kEIB6ADTz7tKdr6B3VEOIIwym5bDdCxYUzaQHw9EfwYYSwFV8JaH6O31g9Z29xbgoqU2pjI9JbY+/48wXGQxuUC43lFgEeVaWxJw6FFoI6kTgB31SEdzjZ9llsENTtCqseEVQ8hrLFaWIGUYvKBKO3SmknSRlY5CcyxAds/qYhQuZkN+AblpkBfEHOWZ68yfQpzKXPWhlIqvC5NTLE6Op0x/YrCwpw16c0R5x/R0/a+/NCHnEyGxInyZY2oRfQ+ba/ra5rCNGihq8EaePAL4NNZMjylliv/jhEZWC3kAEOronRQ8Bw4DxcVUUiNciSsMCcJ1/Z34g0cvzRkIKNODKWjengvQpUQVF6Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e23817-6f29-4d56-1b4d-08d73c8ea65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:27.2179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E956Nyy5uQz1sI2IowB4m6yMjCUDFeXZhCsC2w1kQNgfFJxHXarZQZw7y/iQB7bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.125
Subject: [Qemu-devel] [PATCH v3 00/22] Add virtual device fuzzing support
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

Build instructions in docs/devel/fuzzing.txt

V3:
 * Rebased onto v4.1.0+
 * Add the fuzzer as a new build-target type in the build-system
 * Add indirection to qtest client/server communication functions
 * Remove ramfile and snapshot-based fuzzing support
 * Add i440fx fuzz-target as a reference for developers.
 * Add linker-script to assist with fork-based fuzzer

V2:
 * Split off changes to qos virtio-net and qtest server to other patches
 * Move vl:main initialization into new func: qemu_init
 * Moved useful functions from qos-test.c to a separate object
 * Use struct of function pointers for add_fuzz_target(), instead of
   arguments
 * Move ramfile to migration/qemu-file
 * Rewrite fork-based fuzzer pending patch to libfuzzer
 * Pass check-patch

Alexander Oleinik (22):
  softmmu: split off vl.c:main() into main.c
  libqos: Rename i2c_send and i2c_recv
  fuzz: Add FUZZ_TARGET module type
  qtest: add qtest_server_send abstraction
  libqtest: Add a layer of abstraciton to send/recv
  fuzz: add configure flag --enable-fuzzing
  fuzz: Add target/fuzz makefile rules
  module: check module wasn't already initialized
  qtest: add in-process incoming command handler
  tests: provide test variables to other targets
  libqos: split qos-test and libqos makefile vars
  libqos: move useful qos-test funcs to qos_external
  libqtest: make qtest_bufwrite send "atomic"
  libqtest: add in-process qtest.c tx/rx handlers
  fuzz: Add target/fuzz makefile rules
  fuzz: add fuzzer skeleton
  fuzz: add support for fork-based fuzzing.
  fuzz: expose fuzz target name
  fuzz: add support for qos-assisted fuzz targets
  fuzz: add i440fx fuzz targets
  fuzz: add virtio-net fuzz target
  fuzz: add documentation to docs/devel/

 Makefile                     |  26 ++++-
 Makefile.objs                |   6 +
 Makefile.target              |  17 +++
 configure                    |  13 +++
 docs/devel/fuzzing.txt       | 107 ++++++++++++++++++
 exec.c                       |   2 +
 include/qemu/module.h        |   4 +-
 include/sysemu/qtest.h       |   4 +
 include/sysemu/sysemu.h      |   4 +
 main.c                       |  29 +++++
 qtest.c                      |  24 +++-
 tests/Makefile.include       |  74 ++++++------
 tests/fuzz/Makefile.include  |  11 ++
 tests/fuzz/fork_fuzz.c       |  27 +++++
 tests/fuzz/fork_fuzz.h       |  12 ++
 tests/fuzz/fork_fuzz.ld      |  46 ++++++++
 tests/fuzz/fuzz.c            | 182 ++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h            |  31 +++++
 tests/fuzz/i440fx_fuzz.c     | 158 ++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.c        | 212 +++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.h        |  19 ++++
 tests/fuzz/virtio_net_fuzz.c | 120 ++++++++++++++++++++
 tests/libqos/i2c-imx.c       |   8 +-
 tests/libqos/i2c-omap.c      |   8 +-
 tests/libqos/i2c.c           |  10 +-
 tests/libqos/i2c.h           |   4 +-
 tests/libqos/qos_external.c  | 151 +++++++++++++++++++++++++
 tests/libqos/qos_external.h  |  10 ++
 tests/libqtest.c             | 114 ++++++++++++++++---
 tests/libqtest.h             |   4 +
 tests/pca9552-test.c         |  10 +-
 tests/qos-test.c             | 140 +----------------------
 util/module.c                |   7 ++
 vl.c                         |  25 ++---
 34 files changed, 1393 insertions(+), 226 deletions(-)
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


