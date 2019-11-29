Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C254C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B0F206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="kV8KHAnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B0F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ianwd-0001pY-B9
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianuX-0008WQ-Ab
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuT-0002iD-49
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:43 -0500
Received: from mail-eopbgr740129.outbound.protection.outlook.com
 ([40.107.74.129]:22092 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuS-0002eA-Rf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of1nWZkDDZayO2a2OZSqxAZ5w2SW6OqvdfkQZxaREJ1t3fxVe8rkRkoHkDLfWnyiVELCkDRZEnpF7OirOSWcPsl6X+8eQGqhNIes06uzVFBM3BJoxi0maWuMM8llWIb4avdmYx/MN4AT5pUDiBEPFbEUHdQb131S2/HFaznk4xnGBh1qRmyCWk/vTLqZomQA+igV4k6VacWelwg4kBLzkdEUucaJGVGhj96d8/OYUGT3h64ljF3ntE9xB5DX+TnDdtSousRyhwB2Wg12dkEVqRrBIxYKkuiRMmxUIBaCqvpmt0K90M7lAPUKkkZxfaWk6eWyzZ5ginvV7mO4yf4HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyUOU/rUDG3X0pV7OcV2FCw36aicVmiVbejUXY/LU3s=;
 b=gkkKbpwWQJCNheYfH3U3AK/DDXl96fMglMmYoe1zH+kQcQX78QvlLyOUta1YX+N+efczpEge3QjpAsJW7UBG8uT0NNJSllqsMNVJ9QnQj/g5xMHLbF2Rm617lqe8DSjdxtU9z1PaxlNV8joLAsdCDVW0GiaIbvuWqK6Dev9TIwzlY0cusU9CECYp8tF4ofTBo6Njiv36UXrqO1h+NXr7K5w3dZ1v7RuETsyWNpUTMi/Mv0sJG5ZshgzOPNLyENnI4Rlon5OHrYTpKx6nqvn76KpJ74ZXj0VjGKcqEAtC1DfD/VsO/+HRaawnd+4/3kEhAG+xhGBkIosDd1cuOKoT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyUOU/rUDG3X0pV7OcV2FCw36aicVmiVbejUXY/LU3s=;
 b=kV8KHAnRP+9tqKjytwk/ZFxiwzuvdruACMLfg8PZTGHK0ozIt2QgzVrCjhJH9sGYNaDkLI0S2hfpa2SwPZS3IUtqx9skNZbGbEbQ5+tisICrtM98pH2J7Anoy0VVRi+S1DxcsUCVowQdZBduiZR0QwWkpQ76sAyc0vf4+JIN8kE=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:36 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:35 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 00/21] Add virtual device fuzzing support
Thread-Topic: [PATCH v6 00/21] Add virtual device fuzzing support
Thread-Index: AQHVpvzL6KDjnUzP7EaLws+tg6oqdA==
Date: Fri, 29 Nov 2019 21:34:35 +0000
Message-ID: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 778ace97-801e-4d80-b9fe-08d77513ee07
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB50505664B918EB269994EF78BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(186003)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oX3OAvT1zBbBxbO5SSGzJyoGihnE/DyX2jRf7JKjYTtGOy7/pXTyEZ8S6hW/S7oDQ3tyv63xdN9gwhOuO/KFOue/lImt8tCI9kSzlMhFcgz8GgU8PrKtZrWqg/Bo0s4iMhT5SFl2acSU9JgToLRLEiJH/aaxel3zt37omnFXw3HPd+Hrnue4dHv7beuGckpchNMaZbIooX3cCDpG2fBkt8Jw4IniVHSQlopFC0JHX6tZF347p4htZfBFS4jah9yCKzjdzlVPlVw+p486PGHIp61AXa23+BYVTWh68BZ3p/6AGUlP9wEoOHydVE8nujYHIcS7LkDWUkaR9BLgUK9JjcD5vZrK+bd7j8JvjdX02TKH+xsn3r2sY41mUWtwpyZr4mMp51AY6jE/1LvI937WahA+juCgETFMfp4MjIY1HZvhlq54a/1//3axlXHokuH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ace97-801e-4d80-b9fe-08d77513ee07
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:35.6535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDGqWDzd4YcwYbdrvzK0C0Je8oYMptRCgdUkueyzoqjgTMuoQfSZtAxonr9EPpdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.129
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

In this version, I added a virtio-scsi fuzzer. The actual fuzzing code
is very similar to the the virtio-net fuzzer. I experimented with using
a single fuzzer with device-specific initialization for each virtio
device, but it did not come out as cleanly as I hoped, since I could not
find an easy way to override the qos drivers for devices that have
more-complete qos support (such as virtio-net), so these changes have
not made it into v6.

V5/V6: (V5 did not have review tags)
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

Alexander Bulekov (21):
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
  fuzz: add virtio-scsi fuzz target
  fuzz: add documentation to docs/devel/

 Makefile                      |  16 ++-
 Makefile.objs                 |   4 +
 Makefile.target               |  18 ++-
 configure                     |  39 ++++++
 docs/devel/fuzzing.txt        | 119 +++++++++++++++++
 exec.c                        |  12 +-
 include/qemu/module.h         |   4 +-
 include/sysemu/qtest.h        |   4 +
 include/sysemu/sysemu.h       |   4 +
 main.c                        |  53 ++++++++
 qtest.c                       |  31 ++++-
 tests/Makefile.include        |  75 +++++------
 tests/fuzz/Makefile.include   |  12 ++
 tests/fuzz/fork_fuzz.c        |  55 ++++++++
 tests/fuzz/fork_fuzz.h        |  23 ++++
 tests/fuzz/fork_fuzz.ld       |  37 ++++++
 tests/fuzz/fuzz.c             | 179 ++++++++++++++++++++++++++
 tests/fuzz/fuzz.h             |  94 ++++++++++++++
 tests/fuzz/i440fx_fuzz.c      | 176 ++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.c         | 232 ++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_fuzz.h         |  33 +++++
 tests/fuzz/virtio_net_fuzz.c  | 105 +++++++++++++++
 tests/fuzz/virtio_scsi_fuzz.c | 200 +++++++++++++++++++++++++++++
 tests/libqos/i2c.c            |  10 +-
 tests/libqos/i2c.h            |   4 +-
 tests/libqos/qos_external.c   | 168 ++++++++++++++++++++++++
 tests/libqos/qos_external.h   |  28 ++++
 tests/libqtest.c              | 108 ++++++++++++++--
 tests/libqtest.h              |   4 +
 tests/pca9552-test.c          |  10 +-
 tests/qos-test.c              | 140 +-------------------
 util/module.c                 |   7 +
 vl.c                          |  38 ++----
 33 files changed, 1813 insertions(+), 229 deletions(-)
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
 create mode 100644 tests/fuzz/virtio_scsi_fuzz.c
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

--=20
2.23.0


