Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31385C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36B2207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gLUig08M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36B2207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwgBc-00033B-7O
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzm-0008Jq-6C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzj-0002B8-J1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:34 -0500
Received: from mail-mw2nam10on2107.outbound.protection.outlook.com
 ([40.107.94.107]:63936 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzj-00029U-Ba
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbGmNKkJKhXgp9svlKQt/DH8LN6BsO0GA3BSdRUKIcyAXghqEZ5lnhM3vNnu5qRXe4nfjoYIVo2dQ04AVxlX7zuOMoyY5KouMy2VTDD8cc697AomGvaxh7FktMRo0RluMnakjJD6AJeQsvruxDtcDBEijctZ8u61yrVqsbv6Fma2gLyF4dtC7KmUum1EtHSkMTTvwqYH7yn7ho8TjLswHxpaMy9KD5A5rPWx1OaTV9HTl45SPHljtR0XGhzv01aT+5sgPAjPRqGGncRbzbl5lnN1jGS2Y8NwLC1oy/2La4NgstPE77+6UpR3ZqzGp7WXIepInY09Cm6wyf0Mp46xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23rREpJOr49xI2ix6ikkwHcbZDyhY36SLSiC5Wi+0gA=;
 b=cZY0LXBtv7EDB9G2VKQyVJg0EFBeYYwYLFfgXIjzTNFV+//cFGW6TY0ldQrfLk45DwPegTDWpxk4QElfqZmMs2L6xN12cKTBkWhGeflQ0oLYwkszDCWdWZAvprgQxaj55VKFlSdo7L75F8nBfmH1O3Bfx3gnIGr+ZhQwC7ah/etp6RschKCmrKc51YT3+QuHYEDt4+Zg/PUGsQpBhkIrg58PaUPL+GA0eLtHuBDjqwbiwCdOIXbDUXfVpxDs7xulIXnUx2yOqOMN8XAF0bhQzS429lEhl9rpHesa39HZGO1ZBs6HaHSZ9a1hFbwXCbptx1B6LZXUj6iISrOkKgH1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23rREpJOr49xI2ix6ikkwHcbZDyhY36SLSiC5Wi+0gA=;
 b=gLUig08MPOQyFQYJ6drz+daPuZxPXGRUY21Xrh9T+c71NJ6pKO3UzwbpP4qvjwHx/CZBOmL4AlYLcKJ5u3KFmV+R2mfEgKl5363/RjOMee75mZR87d4UhrKX48QBRG82DuElHHFJhQz7Qd3JSylJYjRHm/ZNhzR2+XI6VsOUhCw=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:29 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:29 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:28 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 21/21] fuzz: add documentation to docs/devel/
Thread-Topic: [PATCH v8 21/21] fuzz: add documentation to docs/devel/
Thread-Index: AQHV1mXGpBrL/suYG0CxJ7KtL99wPQ==
Date: Wed, 29 Jan 2020 05:34:29 +0000
Message-ID: <20200129053357.27454-22-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80e12a88-5a7a-4643-3d97-08d7a47ce91d
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206F9CD509A36D7E5C08280BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5DP28Eea3cYrkhjzQWrorwVQnU/iR3kR/zS8aCvIx/HIf9TWCp8bvGeQymXHfs6ztNpSMfRpYrJqQeIzGufR+V4WnKDOGSPOLqpqF/g5mUTrUfdVaDfC8WxsOpvsUfjBg5F9tY/bmNDqZNgWvw/GZqLE0ofn8bXC4aZmpNRFuMu/afluoPx2uQry2KpcyZwuPC/OVkI8NBTnZAID1Uo15bmPRV60mHdBk7dPZvYket7un7mVRyj7Cf8I71Tz9I2Hc0kQPFBs5qe8YTkOJ9sxDWbL5YuMKfLR10KqvRnHL+sknjxDOG7ps64O2YHHWzxa6/gB0RBr4l87YPwKSvyTWUlbWrGF3q/Eo7951BqR5LC0EczxAIp5b6an/TqgAG14IY/AyoB95dpR+gIXIcKNg3MVGc37QcLOhwkUlC7T0CoYLggIQt6oG3bhgtJ5GFd
x-ms-exchange-antispam-messagedata: +UYiba89vfFcLGsyioG2LKlTeIb6SRW3CbntFlk6tha3koyzNXL5mC0SVyR3nu3V3QzEoNFX1jX8PXR0SkSXdZmrqNVr27RH0r37Y1UribBV/8wQMFV3pdLrZfGNDPgVlLnnDsf8Ce3h8xWtZkPCyw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e12a88-5a7a-4643-3d97-08d7a47ce91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:29.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFJOlPTojZiIQEwni80RWOb8P3jWUn+scM+u/NfpExOEFm80zVKAOqUSo75ojnkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.107
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
 "Bulekov, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/fuzzing.txt | 116 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 docs/devel/fuzzing.txt

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
new file mode 100644
index 0000000000..324d2cd92b
--- /dev/null
+++ b/docs/devel/fuzzing.txt
@@ -0,0 +1,116 @@
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
+findings, the fuzzer mutates the input and repeats the fuzzing.
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
.
+Fuzzers are kept in tests/qtest/fuzz/ and should be added to
+tests/qtest/fuzz/Makefile.include
+
+Fuzzers can rely on both qtest and libqos to communicate with virtual devi=
ces.
+
+1. Create a new source file. For example ``tests/qtest/fuzz/foo-device-fuz=
z.c``.
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
+next input.
+
+Since the same process is reused for many fuzzing runs, QEMU state needs t=
o
+be reset at the end of each run. There are currently two implemented
+options for resetting state:
+1. Reboot the guest between runs.
+   Pros: Straightforward and fast for simple fuzz targets.
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
--=20
2.23.0


