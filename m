Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4380A2464B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="oj36ibQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4380A2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaoEV-0005dj-FF
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianum-0000Cw-LW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-0002yG-RU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:00 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuk-0002ik-MU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdgBbQzusF4Nq+aA4yOT+X291wrLBhOtKDYK2UqIL28NQzgkS3qxla6Br3nuURIZ/D8dipF5y4evpzwCdzEFZWBvwFoiWy/VCIXqk+Ej+GoQlLEMZk1ZmPSwL4F0YX7er53PSBZzGsCfi7/Jj1EK4FsrqFbyTKZnCcTYAV5SOTasuhS6GjqIeaqxrxNTS2PbYP+eNujEnXAlpoVVFZSjXiPDWfcVj6nqIBaq9dtA0PCAQbSNpQuW0vMfzMmcZ/3KAIvhO/o/iV9q5YWidge7Sn7vxJq+7l6CCQff2/qudYgg9P8RfhD4hLGDf5dFTXLgVdG9t3YApw7198++TQrMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/P7JmfGBnQiJoStfBuNwmO6R80dbzcWVnzmfjO3Z4=;
 b=cc+F94k43azi0wKoqPkheuOqFhV3Mof4xCx2OTRvT77yx+qXVYb7gxy8sQqZjiYfikn4M2H40tkatUq8tp37wFyJ1WWPJBy2j9H05HxEcZghxmpy3wOrb092HBf3TRWT2bs81cwkuZu2VQrHju0R90jWRWWSKwIw2ZEWERpg1ONnhu4PWKPTQGsggZN+w1CwHhnHDD5tiwuVCzJL0e9yJL+JltjajbYrggTx6yaf4yXkXkcvQCM32QZ1WezQyDfH7wgbZcYUzNhPOvMaYu3cNweXIEKwz7V0eUJ6sNj9jGRu61pRJp8uWe+NB87Tn/xyd/c6ztSSSJWiTG+Z3UCygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD/P7JmfGBnQiJoStfBuNwmO6R80dbzcWVnzmfjO3Z4=;
 b=oj36ibQAS+C81VTR0eRilMb7wSKONiTPuSuWzjyXMdivQWPAg47cHuWbf4rmL/V/Z9n26CgUL/xA3MBD8PNfAbb0HsUpYR+8NyqEk/CbBREZQoJL7V090xQI2z1tEuUSXUFcx94ybN/AaAjn8grls9IsYLwMZ1Iy8zpr3nKubQU=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:54 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:54 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 21/21] fuzz: add documentation to docs/devel/
Thread-Topic: [PATCH v6 21/21] fuzz: add documentation to docs/devel/
Thread-Index: AQHVpvzWx6h6mJxidEijXKIWIRsvAA==
Date: Fri, 29 Nov 2019 21:34:54 +0000
Message-ID: <20191129213424.6290-22-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: ee8be65a-f581-4729-a813-08d77513f92e
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050230B1DF23E1C5797305BBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tubj1RmNFLjhF98QLCap9yr7dcTuZo8YhtbfDAfyWIWib98ii9u99bmO4WS1AJZz/b0+UgAdt93joJ4nCnvAmA0m074snVNO9F89EgJJsT3zgPmaAuOhlg7xNWnhmcQHfkUSC1q0Gfhq6OVzNsWZ9X1S7e+jgb1Xn+v/5Fy+E4IxyImmh7iqdJQBIfJpViVkRc5u2oGZGbSVHfE4GA2w0tTRdDS2PL02h2OK8eq9RKaVmuN9ETZ+HOHm2JLmf6baQN8hqLNLUxWs30zECspxdUahgXN9ZqL5j6Z5h9hk+VRQn/UFX2oHxmwK+MUaOeeg/i5qvL/S1rqdau2m8Rb3tSgH3rGpgjsiQTlFp/R4gvnhWvgAnlEkQ31mwC05lfFqKcXgcivi8aeTEGPVZy0B0TytQIRjgcRT4fRYoaiGFwXA7X72wfeVtaKHCFotlDoD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8be65a-f581-4729-a813-08d77513f92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:54.3236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFftWpo7jlrrxANXoVimlNPpo1cvPv6wJWfs8Zsz9MP3HAp1kMow1RLuEDxosFuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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


