Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC90C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0648020856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ikhTMRyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpKE-00070M-K0
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIK-0004rh-79
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIH-00076v-M0
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:55 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com
 ([40.107.80.135]:59246 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIE-0006yI-Kl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO1+pZgBIygT8OqG1RlRlrXCP9u4UOb89ngQyNe6brD1TYlxSmQnNrgZryn7GvTfebsQh0vK38Vv+4UaWsJDE3FwFELgC5b8G0Pc2I7khJ+rMZzykGdOHZ/uwubQtFqSVpgKxGtfROlk+YwsqestQipO/M8RrCpNIQL1ot75QwJOllqnqO7QxUPvxVHBiB2ezMSdJT1BG0+NTxaflYOVSOExGh5k/UaAhHu84oASBGRXzCfFPLlkv14RP8zOJGs8IqUH+2tizgKVmp6PpA2l5CJflg6751QMqMPlq5d0NnoMc2YoqV7ty8oWcf5O0lMJVTgfGlz44ErBZUcVcw/4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8AK8yUZ89lchbeOdMHPFKvGEnvxFZCmpnOSAPObFWI=;
 b=Lu2ByLGNV3hkrr2PhHTEd1S9KDsrF7oyrmyXVyuANmDDsxAhYXZeT97Uf/Wy19O4byFEFPJTLJfH89ILfSmvTALe8MDUmbHgqUW/qKsPHO+DYsullS0m+zh8I3I9+t+oVkXtQkemVQ1LOUI9CMfHQQ4rRAvnT1FXy+e4sjYYX6RJq8Okfs2mQ+zNtxcMGbYbspxKm7N/YGYB/D363yp3VO6qXNa0aVEMX06g/4ZVwjUWG7LJFoVK5vVZMXQBzZyJv43mQpkuWpdEyoGFhH7bjUp2iJGgHhhL3V+3PSv7EBD2dEquwhHsAVNM850k/taPDLLZf/ZmOvMrqlSBxrEciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8AK8yUZ89lchbeOdMHPFKvGEnvxFZCmpnOSAPObFWI=;
 b=ikhTMRyjqQkSeuIuvENepyZHVYSk8hbCqlRZfqWgah1cATLMQW5hgRu3ZNWKgifmMRWWlQ2pOFfxo2DM6FnZcNj8OHKbsWtNn02SeN+jr3Ej2dC2bS9Pa5NEnmSkMEXxhaB5ccnv/qbCfpkgajpeEcuG+WbudrLZCFGYsyLtBa8=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:47 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 00/20] Add virtual device fuzzing support
Thread-Topic: [PATCH v4 00/20] Add virtual device fuzzing support
Thread-Index: AQHVjzFGwOSarK/JcECCKceiLt7E9A==
Date: Wed, 30 Oct 2019 14:49:47 +0000
Message-ID: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35264c41-2167-4d9c-8876-08d75d4868c4
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50544139A36D98550BDF710FBA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(14444005)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(6506007)(4326008)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWkMM+q0yT+PY3kouglevsnJJ6CJI793eE/YkYyHBIujTJHku1IKY28aoj6RVdeZxHQu8czWK8bt0HYAVZeP/K92bJsCWAbeNCLecOUtLhAQok5JI4QP3QRUZhkjLXhwhkhqFjzVlc0s9NudBcUwPX733x7tIG2mWzJlZBZGT3ZZot9ndRMf3WdTBlj6tE8w+TxaTnSzCQH+QmjBNL/eUISfubHDcvcqMPsRNghF3jyf9Et29bJ657VJM7tkXOBYRDsZ535VsVziJqJfLQxPO5//zt4g68PO8TZcev5qtM7ztqGp2YCcMWJ9FrS8qNvb072tYlNYtAYvu3qeroZkDuaFhDEhPXt2KBYbvkWlKuUugYyxQnstBNN7JfJ4WKkZAal74tFgVr51e+32/HJfADzoJn9jOJihfmRdn8LCN6Jh3UX6q1xI6ZeaM8LHdGZa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 35264c41-2167-4d9c-8876-08d75d4868c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:47.5462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBLWHY22mebOGE9hEazsKwlN5ak1MCfoR5scCHLjuUxLjE/QWSP1Vdvq7vhjMD8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.135
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a framework for coverage-guided fuzzing of
virtual-devices. Fuzzing targets are based on qtest and can make use of
the libqos abstractions.

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

Alexander Oleinik (20):
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
  libqtest: make qtest_bufwrite send "atomic"
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
 main.c                       |  52 ++++++++
 qtest.c                      |  30 ++++-
 tests/Makefile.include       |  75 +++++------
 tests/fuzz/Makefile.include  |  11 ++
 tests/fuzz/fork_fuzz.c       |  51 ++++++++
 tests/fuzz/fork_fuzz.h       |  23 ++++
 tests/fuzz/fork_fuzz.ld      |  37 ++++++
 tests/fuzz/fuzz.c            | 177 ++++++++++++++++++++++++++
 tests/fuzz/fuzz.h            |  66 ++++++++++
 tests/fuzz/i440fx_fuzz.c     | 176 ++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.c        | 232 +++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.h        |  33 +++++
 tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++
 tests/libqos/i2c-imx.c       |   8 +-
 tests/libqos/i2c-omap.c      |   8 +-
 tests/libqos/i2c.c           |  10 +-
 tests/libqos/i2c.h           |   4 +-
 tests/libqos/qos_external.c  | 168 +++++++++++++++++++++++++
 tests/libqos/qos_external.h  |  28 +++++
 tests/libqtest.c             | 109 ++++++++++++++--
 tests/libqtest.h             |   4 +
 tests/pca9552-test.c         |  10 +-
 tests/qos-test.c             | 140 +--------------------
 util/module.c                |   7 ++
 vl.c                         |  36 ++----
 34 files changed, 1601 insertions(+), 237 deletions(-)
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


