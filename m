Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A684CC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B4022AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bcFsCVo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B4022AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUQO-0004B5-KA
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMO-0004lj-Mt
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMN-0001tl-0F
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:04 -0400
Received: from mail-eopbgr780098.outbound.protection.outlook.com
 ([40.107.78.98]:31872 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMM-0001tF-NL
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAlgI4K5eejMxtRY04v3BXl1OVw+bicptuTHFv/m8SgOBRvTl8/JUB4uhMKH0OyqqOfSlo7DaMn47U8VYXBMJ20LL3EJEQ9ySuGR91qt53VqGN8uLNemvXss1oXWrB1/coblXdM0dkzWDj33I6eY+CtYSkMsvhmCyLnASjcY2F0Y1BDNQPPtJxO49hPcJLqgmyBjj20I1kTrPx/x4/S/eCXE5O0p+yIPtGQZsV6q7/PyIxWkbKFH1Mp6fEYSsB9uJl12lfrQtpyGStrzZ++Nyna1I7Ah7D2yr/kXm1NUjXYeDwEosso9wFG99v3kLw+xCme477leLmqppQ0sjUpVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdhwTAejz65AruqHk5MKVedvgmVs4JiMcSYl5KaHrpw=;
 b=eVT8VVZMp8EacTQkI8JF/lGAS37QCVqhrtw5jAxtQeoBEtdDp/bXLjpN4P2TjYGE+5WC9W8K0U3e69gwvaIFe7VQLn8u5NX30bLFMiCXjOoAAkmf8X35CV7zcro88XST2wB737XrMOuDAAyiVEN5W/eVLhWgOwOdiwZkakCDsl5EW5LASvUmasGLRiNHxmzhtgLEERyNmjuOHOKrcrNYM9WG3VPR3lcCGsbMSXzy5/aM8bx+Fa8VbjPJLlFZdgParSUuWGC2C9YF2I/LoSM4P71n0dZkG9kfKiYZ3xKRnplJb8sjGPYHzkKRmyo/E5g0QRivHRbyxKcHU5GFHJyi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdhwTAejz65AruqHk5MKVedvgmVs4JiMcSYl5KaHrpw=;
 b=bcFsCVo4Q/fZqeFj+/d4lzOyUXCSivzEDZ2WcyUVUgAghbggJH95EkIMbSHdh2QlGcgt6QMzrWLX06z+svf7z/GNjKDwZ+9iQmw+bNx+B8YYNyechzLs3Y6spoUrJ6hR0NiRgO/0GuB9qz8/2GWQ5QfACmdJqtBHQaTnA2ghMD8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2534.namprd03.prod.outlook.com (10.168.165.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:24:01 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:24:01 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 19/19] fuzz: Add documentation about the fuzzer to docs/
Thread-Index: AQHVQphndssS1QYbsUiIR1Bu+bdplA==
Date: Thu, 25 Jul 2019 03:24:00 +0000
Message-ID: <20190725032321.12721-20-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600a7588-6c7f-416f-dae1-08d710af8972
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2534; 
x-ms-traffictypediagnostic: CY4PR03MB2534:
x-microsoft-antispam-prvs: <CY4PR03MB2534B9F25AB79CA86FDB2BA5BAC10@CY4PR03MB2534.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(446003)(2501003)(186003)(86362001)(14444005)(2906002)(26005)(2616005)(3846002)(6512007)(6116002)(256004)(476003)(53936002)(4326008)(11346002)(76176011)(45080400002)(81156014)(102836004)(75432002)(6916009)(52116002)(88552002)(386003)(81166006)(6506007)(2351001)(14454004)(25786009)(478600001)(36756003)(8936002)(316002)(486006)(66476007)(54906003)(71190400001)(1076003)(66066001)(5640700003)(50226002)(99286004)(6486002)(305945005)(5660300002)(64756008)(7736002)(786003)(8676002)(66446008)(66556008)(66946007)(68736007)(6436002)(71200400001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2534;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4/HFt+ghzHZIMPRNKUDC+bWEfmGa7UexNYRV83VDKt36z3XP8RQzc1XzH00NSgeqRS/RNTbatI4o5VAI51cye2CiriFFFUKKQzhgJXKYebtslWJIDcfQwASsmnq2OtvPhX1YspfO35as/ylJZkUk8M2yK7rVfbgYTwwoGf38o3bKlTOs6rFtgxLCUQPBoVRWomJ59+sMVSv8WXshtiFi6s7XKrI/z2Hc9cZXUS5fawNXVN8Kpd87pGkQRfZCy/Gvq7utOhN4Ao+cktdTrLp+U2ssMaAEAMn/I7MdTIXLViXJaUs6LVe75WBoMxfKc+eKOqmJB23+zg1amsZKl00davRAQppdqEoTKPinFeZWaM8S55IPUOrm6fgHCGmW8bKkNvA5mrKUxfAYfMmtbZ6gqpFV3O5iQucGw63w4Fa1Lgg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a7588-6c7f-416f-dae1-08d710af8972
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:24:00.9550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2534
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.98
Subject: [Qemu-devel] [RFC 19/19] fuzz: Add documentation about the fuzzer
 to docs/
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 145 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 docs/devel/fuzzing.txt

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
new file mode 100644
index 0000000000..321e005e8c
--- /dev/null
+++ b/docs/devel/fuzzing.txt
@@ -0,0 +1,145 @@
+=3D Fuzzing =3D
+
+=3D=3D Introduction =3D=3D
+
+This document describes the fuzzing infrastructure in QEMU and how to use =
it
+to add additional fuzzing targets.
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
+libfuzzer provides its own main() and expects the developer to implement t=
he
+entrypoint "LLVMFuzzerTestOneInput".
+
+Currently, Fuzz targets are built out to fuzz virtual-devices from guests.=
 The
+fuzz targets can use qtest and qos functions to pass inputs to virtual dev=
ices.
+
+=3D=3D Main Modifications required for Fuzzing =3D=3D
+
+Fuzzing is enabled with the -enable-fuzzing flag, which adds the needed cf=
lags
+to enable Libfuzzer and AddressSanitizer. In the code, most of the changes=
 to
+existing qemu source are surrounded by #ifdef CONFIG_FUZZ statements. Here=
 are
+the key areas that are changed:
+
+=3D=3D=3D General Changes =3D=3D=3D
+
+vl.c:main renamed to real_main to avoid conflicts when libfuzzer is linked=
 in.
+Also, real_main returns where it would normally call main_loop.=20
+
+The fuzzer adds an accelerator. The accelerator does not do anything, much
+like the qtest accelerator.
+
+=3D=3D=3D Changes to SaveVM =3D=3D=3D
+
+There aren't any particular changes to SaveVM, but the fuzzer adds a type
+of file "ramfile" implemented in test/fuzz/ramfile.c which allocates a buf=
fer
+on the heap to which it saves the vmstate.
+
+=3D=3D=3D Changes to QTest =3D=3D=3D
+
+QEMU-fuzz modifies the qtest server(qtest.c) and qtest client
+(tests/libqtest.c) so that they communicate within the same QEMU process. =
In
+the qtest server, there is a qtest_init_fuzz function to initialize the
+QTestState. Normally, qtest commands are passed to socket_send which
+communicates the command to the server/QEMU process over a socket. The fuz=
zer,
+instead, directly calls the qtest server recieve function with the the com=
mand
+string as an argument. The server usually responds to commands with an "OK=
"
+command. To support this, there is an added qtest_client_recv function in
+libqtest.c, which the server calls directly.
+
+At the moment, qtest's qmp wrapper functions are not supported.
+
+=3D=3D=3D Chages to QOS =3D=3D=3D
+
+QOS tests are usually linked against the compiled tests/qos-test.c. The ma=
in
+function in this file initializes the QOS graph and uses some QMP commands=
 to
+query the qtest server for the available devices. It also registers the te=
sts
+implemented in all of the linked qos test-case files. Then it uses a DFS w=
alker
+to iterate over QOS graph and determine the required QEMU devices/argument=
s and
+device initialization functions to perform each test.
+
+The fuzzer doesn't link against qos-test, but re-uses most of the function=
ality
+in test/fuzz/qos_helpers.c The major changes are that the walker simply sa=
ves
+the last QGraph path for later use in the fuzzer. The
+qos_set_machines_devices_available function is changed to directly used qm=
p_*
+commands. Note that to populate the QGraph, the fuzzer still needs to be l=
inked
+against the devices described in test/libqos/*.o
+
+=3D=3D The Fuzzer's Lifecycle =3D=3D
+
+The fuzzer has two entrypoints that libfuzzer calls.
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
+requires qos, qgraph is set up and the QOM/LIBQOS modules are initailized.
+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
+
+After this, the vl.c:real_main is called to set up the guest. After this, =
the
+fuzzer saves the initial vm/device state to ram, after which the initiliza=
tion
+is complete.
+
+LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
+input. It is also responsible for manually calling the main loop/main_loop=
_wait
+to ensure that bottom halves are executed. Finally, it calls reset() which
+restores state from the ramfile and/or resets the guest.
+
+
+Since the same process is reused for many fuzzing runs, QEMU state needs t=
o
+be reset at the end of each run. There are currently three implemented
+options for resetting state:=20
+1. Reboot the guest between runs.
+   Pros: Straightforward and fast for simple fuzz targets.=20
+   Cons: Depending on the device, does not reset all device state. If the
+   device requires some initialization prior to being ready for fuzzing
+   (common for QOS-based targets), this initialization needs to be done af=
ter
+   each reboot.
+   Example target: --virtio-net-ctrl-fuzz
+2. vmsave the state to RAM, once, and restore it after each run.
+   Alternatively only save the device state(savevm.c:qemu_save_device_stat=
e)
+   Pros: Do not need to initialize devices prior to each run.
+   VMStateDescriptions often specify more state the device resetting
+   functions called during reboots.
+   Cons: Restoring state is often slower than rebooting. There is
+   currently no way to save the QOS object state, so the objects usually
+   needs to be re-allocated, defeating the purpose of one-time device
+   initialization.
+   Example target: --qtest-fuzz
+3. Run each test case in a separate forked process and copy the coverage
+   information back to the parent. This is fairly similar to AFL's "deferr=
ed"
+   fork-server mode [3]
+   Pros: Relatively fast. Devices only need to be initialized once. No nee=
d
+   to do slow reboots or vmloads.
+   Cons: Not officially supported by libfuzzer and the implementation is v=
ery
+   flimsy. Does not work well for devices that rely on dedicated threads.
+   Example target: --qtest-fork-fuzz
+
+=3D=3D Adding new Targets =3D=3D
+1. Create a file : tests/fuzz/[file].c
+2. Add target registration function and fuzz_target_init(FUNC) at the bott=
om of
+the file.
+3. In the registration function, register targets using fuzz_add_qos_targe=
t or
+fuzz_add_target. The arguments to thes function specify the resetting meth=
od
+and QOS path.
+4. These functions refererence a fuzz function which should be a:
+static void func(const unsigned char* Data, size_t Size)
+Inside the fuzz function, translate the "Data" into qtest actions.
+5. Add [file].o to target/i386/Makefile.objs
+
+tests/fuzz/qtest_fuzz.c and tests/fuzz/virtio-net-fuzz.c both contain exam=
ples
+of fuzz targets that follow this structure.
--=20
2.20.1


