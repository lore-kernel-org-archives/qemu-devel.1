Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C1C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88712073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ETeAhB1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88712073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQMM-0007EY-R8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1j-0007Kx-BX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1h-0006Us-Ta
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:07 -0500
Received: from mail-bn7nam10on2117.outbound.protection.outlook.com
 ([40.107.92.117]:63553 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1h-0006US-P2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z30vFxhd0dJvLL6XoqztuTrAnyDK2psndBdIev43UWMj6Wfc4O/w5eI2lc/6opsGOy8cg3oI3j+U5Dv2EMglWFgSSlPRY7LVFLU+noPcO5kNBIe3bezcQ4MukIxqhClVP4FkUx4lhmHGadKu2z/b9oMWljviAbW9WSsy81mC50UagRQOdWDMBVjdLy5f72lzRhO9x6un/9Rz1Wm/OT4vMRy8BxhMkTKR+14DVBBgCy1QsO5zsVyMv6fVUi3XhGny7kv8wdO1q9FEb5n0kdBZwEqTjHSFk+k0KEh50sz1NlC0U+hwsPpXTyVaVyBrSs9/ep8ROP4KwZ8/EAdM7Jldog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/ubUos4wtL/P5M5qxu+ll1T+//2CDHmQI7QwjUhLZE=;
 b=JN+AO3L/RBtySBZ0FiUCQ+bzEM5YuwE+UJH09anoeIMfd5doZFqYiNklXWKd8r/CWxOYYKwNZt4tPMPMXhijbt1CEtvtH7xcp0VY1bv+RgsabnlGkb1m58qzuBOYsatdvDvfT9vqKX+r28e2Fv/jgJvM/LuxYfeJijrIZR0k23VC21AiZR2orQPfElIdl9gXBlP/8LwfekuNHSCvPIEG6rgd9EsArsk4DKorP86ffoQkMCJs0OHF2/lFKLji31aaZ5zGE0VCkM1oZF9FWinKRWoGDpXKJBOZxJNapcxC0/I5k7TYWHgRv5JnM35yxkOm5BJRJphFo3FP2axXEnffUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/ubUos4wtL/P5M5qxu+ll1T+//2CDHmQI7QwjUhLZE=;
 b=ETeAhB1maQbgba+dGoGrSXnk+z/5x2OiXGUVN+pBorYRYbVN/V5KqjsVtL6ur0laLwLUftbaBX6ILfD+UNDo64z6MkvMq+P5bPUpInfV3xgoRYos/d0dbHYVJI1OWf16qKlLWw+igXdkUEDedNJWmdBD11a0uwtEGrtVA0FuqyE=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:04 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:04 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:03 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 17/20] fuzz: add documentation to docs/devel/
Thread-Topic: [PATCH v7 17/20] fuzz: add documentation to docs/devel/
Thread-Index: AQHVz1YpLEtYFJT2PECngL6ZrM1U/Q==
Date: Mon, 20 Jan 2020 05:55:04 +0000
Message-ID: <20200120055410.22322-23-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecc62dcc-21ea-4bc3-532c-08d79d6d4bac
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439941C764D23BA9C5D47942BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wk8Ooe0e6JQfoS3T7ZONZrjyZ9j7sNYwOHimkN/v8SXoAdlPn1w9ld1NedkBmlUsY5swR4q0lzCxzePg7NjrL2KQ1a0+sOh4cIUj3varRqYQvPNK8+Ll5+WhmxufBzIcC1lbOGXtaHJ5zb5meN29FuZ5rlPUXM23/P65AVYlAqfGUmKK3zBUQdUzOIX5O6gCYsMOxXPEvmtn3A1g7qUMbgrCQGF4GsQ/NgCS4eGUTb6t/6gfb6DbD4bnvuQwY0q4IHy318PME2ch9Ww67tEs3nPNc/1bf816ubiZ6KpCLsQh3xZWm9mJnJR3df8mzCcEJ/gKsrSeXmCmgZKQPtRefe4avkpgPYm+5JG2vrBnlUd7eDBPsdCEqoV0/Gcn1tUebOtKMFcbSgGRBzrrpivKOsB8a6RSYeDngJn0PT5A5gUY33r488lLdlSKSw0YA1tG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc62dcc-21ea-4bc3-532c-08d79d6d4bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:04.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aBTZ/0faw9x9RzY113wlOsRIPpUBLisrQ1syXTxZvJaNxn45Z9Ov70qkK4tUFAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.117
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


