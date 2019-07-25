Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152ABC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71A422AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="E7KU4vKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71A422AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUMe-0005Ih-Cs
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUM9-0003wy-Ne
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUM8-0001nX-Lj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:49 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUM8-0001mt-G3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJCuMYpgtRWwntCN3N5VU03IJzHRE6+jt9ouI8v4skSEYAN30tHUuh7MLyhIXdzFLsKCcQGvm+VsvdlX1JMLldC6a0tgh8oMjDDF6EE1AFZhFzu/PcqRsGebW4ZL6aFoHEJ7n2FrzA/0YQwJwD+4IUqVWlp48Tet1Z2CSMw8zg4NW3opJPe12NMqE2Dw50slHzoE93YHWP3McEl3BrWD3r37I00bd3gZ5zz8IMMRLoBdCsd+wbcJJ8CqFGgzyarieFeQoGeWC7rClzIh6iliu6UDWA4G6BslzLEYxaSGDb7mQsAkMn29jyiOPr5/XZTMwBD5pImF/T9hGGIAHirDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1GBEFxFADLwp3bfhDgDdG81Pos3Cs3BpKzzaukIGR4=;
 b=KubMeHNgYc3FolDQfTI7N+Kfxr1EFgGjme1+NwYJpxRSrMz3+X/0yT7in9umQnPkiiV3HikcUTetnEf+pqdG0ryYre+hmxUvP1Q3kLWBjGzMgXYZ9LMHX45P3wcK/TUmGyjKXAR50uNlyQ18GhlkJL5ceTq5CVc/ukY9NMx2j0uuYr61ee54sT8/YBlMkj7x8MG8cDstLQblHWkg/Ld//a1mThcXvOYNTNR+g3K9nB7h5O8rAZ6umvGCX8afQNXLVI5JXu4HR/VFqeW4Q++ghn3IeBqZH/2j9xGabP6PwAlpsM841+Io3+U8h9+3UrMmJmMsV7x6o26dxpKZEPXMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1GBEFxFADLwp3bfhDgDdG81Pos3Cs3BpKzzaukIGR4=;
 b=E7KU4vKVx3ji6GjqGwbS2veAEtK1NKKUufabriWGtUroigc5WvsBZzKisuU7G8GoK/A4eoNtkwgdIgsMXadsFO/1PInJlUmoD7bT8cVU1taoifRsCAEPtfBf5So/AyxsSw3WSKT1QVok5IMxsSEuVKF0LQOL9uqOfQdZoW/2eP8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:44 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:44 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 01/19] fuzz: add configure option and linker objects
Thread-Index: AQHVQphdXF61UqrZSEiFS77JxxqhMA==
Date: Thu, 25 Jul 2019 03:23:44 +0000
Message-ID: <20190725032321.12721-2-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 0125e2ac-828e-4030-3cf8-08d710af7f94
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB272668C8C5EDB3055C058C5BBAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SS+JW7EUvPyc4gGDNIn+KaHmoZ4KOS0lqk5zSEHymqXoPcKdakIWQCJWyUbg/k+sHaLnf1HCvp/PvjLnfEqhhIH1m9/6RyqFksNL/KHkHfEBxkKlEAZ4EXYaep7zWX9DJd65yV1sSbKL+JqQ3jlQL3MxtUCSgI8bQ5HyRPHdu5OFxfnUXLWHGISBuq4/fTzcfAMWu6zTdHGQ4z2yjAbw40CpddUmuz4ckoH21KSRSNBuPhNjPPvjoleOF8faC5cM6giQyV6XySYBwYvopb91Cngt4NsUNlrJ8Sre88TZ7S8+qlsZ8z6UNJCr0/WwgdNCIe5fwfW8XrVxDiko+mFh3+zDRkMV6RwZyh8CaJSL4VZqqEcbm4FyEebOi1K4aad110wgcA5DXg6wJasZpXrrzwGQZyPYmuzvgaVojkzXy4k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0125e2ac-828e-4030-3cf8-08d710af7f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:44.4266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 01/19] fuzz: add configure option and linker
 objects
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add -Wl,--wraps for the libfuzzer callees that we need to intercept

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 configure                 | 11 +++++++++++
 target/i386/Makefile.objs | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/configure b/configure
index 714e7fb6a1..0a40e77053 100755
--- a/configure
+++ b/configure
@@ -499,6 +499,7 @@ docker=3D"no"
 debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
+fuzzing=3D"no"
=20
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
@@ -1543,6 +1544,8 @@ for opt do
   ;;
   --disable-libpmem) libpmem=3Dno
   ;;
+  --enable-fuzzing) fuzzing=3Dyes
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6481,6 +6484,7 @@ echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "fuzzing support   $fuzzing"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7306,6 +7310,13 @@ fi
 if test "$sheepdog" =3D "yes" ; then
   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
 fi
+if test "$fuzzing" =3D "yes" ; then
+  QEMU_CFLAGS=3D"$QEMU_CFLAGS -fsanitize=3Dfuzzer,address  -fprofile-instr=
-generate"
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tests $QEMU_INCLUDES"
+  QEMU_LDFLAGS=3D"$LDFLAGS -fsanitize=3Dfuzzer,address"
+  QEMU_LDFLAGS=3D"$LDFLAGS -Wl,--wrap=3D__sanitizer_cov_8bit_counters_init=
,--wrap=3D__sanitizer_cov_trace_pc_guard_init "
+  echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
+fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..3d646848ef 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -18,5 +18,24 @@ endif
 obj-$(CONFIG_HVF) +=3D hvf/
 obj-$(CONFIG_WHPX) +=3D whpx-all.o
 endif
+
+# Need to link against target, qtest and qos.. Just list everything here, =
until
+# I find a better way to integrate into the build system
+ifeq ($(CONFIG_FUZZ),y)
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/ramfile.o ../../accel/fuzz.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/fuzz.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/virtio-net-fuzz.o=20
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qtest_fuzz.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/libqtest.o
+obj-$(CONFIG_FUZZ) +=3D ../../tests/libqos/qgraph.o ../../tests/libqos/lib=
qos.o=20
+obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qos_fuzz.o ../../tests/fuzz/qos_h=
elpers.o
+obj-$(CONFIG_FUZZ) +=3D  ../../tests/libqos/malloc.o ../../tests/libqos/pc=
i-pc.o \
+	../../tests/libqos/virtio-pci.o ../../tests/libqos/malloc-pc.o \
+	../../tests/libqos/libqos-pc.o ../../tests/libqos/fw_cfg.o \
+	../../tests/libqos/e1000e.o ../../tests/libqos/pci.o \
+	../../tests/libqos/pci-pc.o ../../tests/libqos/virtio.o \
+	../../tests/libqos/virtio-net.o ../../tests/libqos/x86_64_pc-machine.o
+endif
+
 obj-$(CONFIG_SEV) +=3D sev.o
 obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
--=20
2.20.1


