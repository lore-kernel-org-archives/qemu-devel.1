Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2516CC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E208B206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="LcICT2vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E208B206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1gd-0003Ws-U4
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TY-000891-Ih
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TV-0007pR-Vn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:59 -0500
Received: from mail-dm3nam03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::714]:27886
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TV-0007jr-Oh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRwfrQfY1q2rIC7fbc6Hy1eWb01F/iDR7+qH4hgsauYXmM4lX0W8Cj5aFfqINXYskjYiW78ib6KR/bJn4843a3ZgJh36J9OvLCkqKMTGlq0Wcw/QFXR+E09p0eTzAFqQP3holvdLFnVnY91N9fxg8CTshphju4it8fw2FpdO4WQTCbcOQGUOCjo3ATms8cI8zeChao5s6GnlzxmFeUOf7gX4rBXlq5iwDuDP6jBHd90XACxl/LWZEcq8tNzRvejHgLwtwa3FBqmypyY2JXLTpADYUfKF80wuZHcnodBncVEaqlO6V3t+jva/8MrNbPCJVN521y2Xe2k7CDCmJ5xBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/P7JmfGBnQiJoStfBuNwmO6R80dbzcWVnzmfjO3Z4=;
 b=G0BXiKk5jX119E2ggNMOyi5zp0I4u9cbIptMkvAvkr0oa1nAhGKtdx4hMpLe0QDiDK0pWLBHOzIroX8epqNuo4ZJOc8D1aX/o7lnEjDhxtil6zY2BnfYeyE+49viOs59pkBCHiCCB4p5GJM7QrHXZhGJeekZLgRmV+KGVp3XNDi+UafFFWHVfq24w3K5eHkXLl8CipU15D+EcBm/87ZEiWsHuncF/uhWrzgxyFOHxf9Il7C3j2F5SVRAn/BVSA0aMOZvPg0fm6Z+TKGbTonN9j9XZ8QUBn3xkhZHtUpuelp/8ulxSjmeKfL7D2GkvmqAw7TllaOxPNeUQCml8cVqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/P7JmfGBnQiJoStfBuNwmO6R80dbzcWVnzmfjO3Z4=;
 b=LcICT2vNZwX8LJ5fvunh+7bXs5xddnWH1XYjhpiXDsdfqq8o4ekhFh2nGFm1kgIfK0QrwR5zYjYovNqZ+nqzpO0gMe5LDvRQboT9PNDFeje0S1FiLA9kdmlMdOrmE+r3czhPjI6h9ohlQrbTnqmhlV6LU0bBvW+nplrNW7ynr1c=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:54 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:54 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 20/20] fuzz: add documentation to docs/devel/
Thread-Topic: [PATCH v5 20/20] fuzz: add documentation to docs/devel/
Thread-Index: AQHVmnTOmgQ0G5owjUiCu5II/ELl4w==
Date: Wed, 13 Nov 2019 22:50:54 +0000
Message-ID: <20191113225030.17023-21-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: b4827b9b-a9f3-4ac5-8f0a-08d7688bf086
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024ED90077451AE004AD40ABA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(1496009)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSNQzu0yE9dXui9T7MHn0u7EX6l/yU/2Jf+6y/kPuOBfJsURPWWZAYXxE5pANj6kYEwpqVLcB60uRxBOFbgA70hA5HsEsaRdgb9YTs5MZ8aQI0VkmTXgOH9i9Z0cNH/2bNkySSQ3HMxp9rqWs6SsdZ0FNYM2stAcZallVI5IwqgJGQlO+IGVzVn5Pxrrg9YIQ5trK4UhpNxMbp+k9qBb7DIUP9tOCBTvEcTqRCxe5RL+R8A8lwiYC8HqWA7RSprYK4T8+lt/leaHEoveC4wmPjzGj4EsNyw8Vwv2g6rIIwyQN+/IwRzYbPJqCtFb/ICgwlwWrm33njw7/7KX9sZ9s/dkvTZ4YwpiVE20pNVrBrjh5PgmIZuW4RTXyULF+O4gGh47UhGe/Ikpqba1KHFjpGJ7V5WZPjKooxQVlHoTD89UCwhpf9t78B2WI3M+MvBD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4827b9b-a9f3-4ac5-8f0a-08d7688bf086
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:54.4605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAVM00OlQ5oYZaZcvjEzoqQm1aWG2cJrZTJrcbd4lHydNmRHi7Qz3QIwsPkw2SzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::714
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 119 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 docs/devel/fuzzing.txt

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
new file mode 100644
index 0000000000..b0cceb2a6b
--- /dev/null
+++ b/docs/devel/fuzzing.txt
@@ -0,0 +1,119 @@
+=3D Fuzzing =3D
+
+=3D=3D Introduction =3D=3D
+
+This document describes the virtual-device fuzzing infrastructure in QEMU =
and
+how to use it to implement additional fuzzers.
+
+=3D=3D Basics =3D=3D
+
+Fuzzing operates by passing inputs to an entry point/target function. The
+fuzzer tracks the code coverage triggered by the input. Based on these
+findings, the fuzzer mutates the input and repeats the fuzzing.=20
+
+To fuzz QEMU, we rely on libfuzzer. Unlike other fuzzers such as AFL, libf=
uzzer
+is an _in-process_ fuzzer. For the developer, this means that it is their
+responsibility to ensure that state is reset between fuzzing-runs.
+
+=3D=3D Building the fuzzers =3D=3D
+
+NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer =
is
+much faster, since the page-map has a smaller size. This is due to the fac=
t that
+AddressSanitizer mmaps ~20TB of memory, as part of its detection. This res=
ults
+in a large page-map, and a much slower fork().
+
+To build the fuzzers, install a recent version of clang:
+Configure with (substitute the clang binaries with the version you install=
ed):
+
+    CC=3Dclang-8 CXX=3Dclang++-8 /path/to/configure --enable-fuzzing
+
+Fuzz targets are built similarly to system/softmmu:
+
+    make i386-softmmu/fuzz
+
+This builds ./i386-softmmu/qemu-fuzz-i386
+
+The first option to this command is: --fuzz_taget=3DFUZZ_NAME
+To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
+
+eg:
+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=3Dvirtio-net-fork-fuzz
+
+Internally, libfuzzer parses all arguments that do not begin with "--".
+Information about these is available by passing -help=3D1
+
+Now the only thing left to do is wait for the fuzzer to trigger potential
+crashes.
+
+=3D=3D Adding a new fuzzer =3D=3D
+Coverage over virtual devices can be improved by adding additional fuzzers=
.=20
+Fuzzers are kept in tests/fuzz/ and should be added to
+tests/fuzz/Makefile.include
+
+Fuzzers can rely on both qtest and libqos to communicate with virtual devi=
ces.
+
+1. Create a new source file. For example ``tests/fuzz/fuzz-foo-device.c``.
+
+2. Write the fuzzing code using the libqtest/libqos API. See existing fuzz=
ers
+for reference.
+
+3. Register the fuzzer in ``tests/fuzz/Makefile.include`` by appending the
+corresponding object to fuzz-obj-y
+
+Fuzzers can be more-or-less thought of as special qtest programs which can
+modify the qtest commands and/or qtest command arguments based on inputs
+provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly =
the
+fuzzer loops over the byte-array interpreting it as a list of qtest comman=
ds,
+addresses, or values.
+
+
+=3D Implementation Details =3D
+
+=3D=3D The Fuzzer's Lifecycle =3D=3D
+
+The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it=
's
+own main(), which performs some setup, and calls the entrypoints:
+
+LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of t=
he
+necessary state
+
+LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input a=
nd
+resets the state at the end of each run.
+
+In more detail:
+
+LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with t=
wo
+dashes, so they are ignored by libfuzzer main()). Currently, the arguments
+select the fuzz target. Then, the qtest client is initialized. If the targ=
et
+requires qos, qgraph is set up and the QOM/LIBQOS modules are initialized.
+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
+
+After this, the vl.c:qemu__main is called to set up the guest. There are
+target-specific hooks that can be called before and after qemu_main, for
+additional setup(e.g. PCI setup, or VM snapshotting).
+
+LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
+input. It is also responsible for manually calling the main loop/main_loop=
_wait
+to ensure that bottom halves are executed and any cleanup required before =
the
+next input.=20
+
+
+Since the same process is reused for many fuzzing runs, QEMU state needs t=
o
+be reset at the end of each run. There are currently two implemented
+options for resetting state:=20
+1. Reboot the guest between runs.
+   Pros: Straightforward and fast for simple fuzz targets.=20
+   Cons: Depending on the device, does not reset all device state. If the
+   device requires some initialization prior to being ready for fuzzing
+   (common for QOS-based targets), this initialization needs to be done af=
ter
+   each reboot.
+   Example target: i440fx-qtest-reboot-fuzz
+2. Run each test case in a separate forked process and copy the coverage
+   information back to the parent. This is fairly similar to AFL's "deferr=
ed"
+   fork-server mode [3]
+   Pros: Relatively fast. Devices only need to be initialized once. No nee=
d
+   to do slow reboots or vmloads.
+   Cons: Not officially supported by libfuzzer. Does not work well for dev=
ices
+   that rely on dedicated threads.
+   Example target: virtio-net-fork-fuzz
+
--=20
2.23.0


