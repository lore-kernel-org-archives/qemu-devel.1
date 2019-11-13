Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E749C43141
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FCA206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Bbmp5y0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FCA206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Zg-0005Bt-Kh
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TR-00084a-7y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TQ-0007hf-09
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007aZ-NT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKRYvUhaTTSFD8mrs7RmCnj2zUd8yTavO/MijaoSxeYJ7vnM/arPmx9bepG/o7yPB3skJciOHsZ9ANAlTtJzUdFbJMeeX3Bz5gVJn6Q0HOMVVCa2v4XyKZ5aB7q1flDxCeH4Dx1vjt4dQ5QUmJckhygHQtAR5xDy5GkA3Kp4raXCfOLKYd5th5TID3y88a6SqcuLrynVyPkcqDmvmVIyH5Vxh6vSQHfrxwIGLYxtGtW9tvL+TD0W/KDzC6A+5urp5uu/284zwDUh0/djoF9E0wt52iuKxRo3sosFbct5eRentRaJYtP2XjvUNUIZgaHtgy83U3V/3dAAJNBQUOkMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgOMV2Up7UBlqzDW7iis7dRqXQbhKkLFW8hVYLhDyIg=;
 b=JhpeU8lFuB6f/lbiCyKBKHYs9yseUSfqac+vlhhnckpXUZ6NSuNlTfC1no6qRA7UNpCrI6prp0KtTdznjhxdIDMMAwZhWjSf3RX4pSCyj/RDz6SA69GOpGyhNw+0oVw54wLd55YeWLeveEN0iyFZqTQfFuCKoyc03q+NYJvqKxrS7OnrZeJKNNSHrpmybYfnVZ9csExqybaICDfRE3TW44/grCxh9ZiwNK5sQXXgSY7qqcRzqX23yqipLfWkLVfGaw8GL8sFqnsveqB77fj++br1UQYxXMLlB2r9Fa+9FAwkWqRDvUEk/9pHeuS/bRIcspC/fJ+yHULKcl6GUvTUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgOMV2Up7UBlqzDW7iis7dRqXQbhKkLFW8hVYLhDyIg=;
 b=Bbmp5y0lat3I/2R1ELz4o2YvcXhb17A4aKS4vtzPPsLCdI0AFxCd2VHrQhSzPC0l+pFyGBet+/XE+aBgYyZQ9kILpWdf9XJev1Q+TVpo8RDunRDWEOpHFto+H9laDU5ZsTPRKMoHQaArW1waXULv6Pws1E7Aakar5rWyF5r9cz8=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:49 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:49 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 13/20] fuzz: add configure flag --enable-fuzzing
Thread-Topic: [PATCH v5 13/20] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVmnTLT9bg34K9q0GkA116N0oLEQ==
Date: Wed, 13 Nov 2019 22:50:49 +0000
Message-ID: <20191113225030.17023-14-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: e8798723-6904-4b8a-e8c2-08d7688bedbf
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024BAE65BA70B299378FD25BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDt+oufkcci/XeE2mQ8TetBp/UqjFWvEHrKDAqurHPY2Z3n5JNVNuRdp8hAOVwdqHCIKi0kgdA5FXE4laipn9oWr8nUoxdOl9zvL9IUXRVX1MHoUmhA2K7RghLF3NL/RNu+InLIBvJ174VDTVUx0rwMtXlGiRzOA1301wtQ1KNMvO0cOwNPPLSVYEivfZpcT6uRzqy6zmyemlKKC1HecYto1lm7LwoqsAYqHVm2H0w5x2n+vqCXacDCRG+Won9Hr5dd5BbzjK9CakUUYrS4Sfo+7LsPmUmairmP64onZYAH/qSdfozKlmuWV70zfjcIpG1KE3a1HeLg7T+9KS5QG9T27M53o21rfO57ZpGGOBhnP3XV6d3qI45SUMTqXduOS2F2Z2gtwaWmBhcnnnArPICjfI356zYz+bfX09x/ySgaYlbN5bIrFZoLSKl/0A1iR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e8798723-6904-4b8a-e8c2-08d7688bedbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:49.7193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqCawVJkkG3GgpqpvFCrSg1lda6ZVWeHwjAAhrU8NxW7E5AxcwwivjJTFQ0z0Cb8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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
 configure | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/configure b/configure
index 3be9e92a24..aeca632dd9 100755
--- a/configure
+++ b/configure
@@ -501,6 +501,7 @@ libxml2=3D""
 debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
+fuzzing=3D"no"
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -630,6 +631,15 @@ int main(void) { return 0; }
 EOF
 }
=20
+write_c_fuzzer_skeleton() {
+    cat > $TMPC <<EOF
+#include <stdint.h>
+#include <sys/types.h>
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
+EOF
+}
+
 if check_define __linux__ ; then
   targetos=3D"Linux"
 elif check_define _WIN32 ; then
@@ -1532,6 +1542,10 @@ for opt do
   ;;
   --disable-xkbcommon) xkbcommon=3Dno
   ;;
+  --enable-fuzzing) fuzzing=3Dyes
+  ;;
+  --disable-fuzzing) fuzzing=3Dno
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -5911,6 +5925,15 @@ EOF
   fi
 fi
=20
+##########################################
+# checks for fuzzer
+if test "$fuzzing" =3D "yes" ; then
+  write_c_fuzzer_skeleton
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress,fuzzer" ""; th=
en
+      have_fuzzer=3Dyes
+  fi
+fi
+
 ##########################################
 # check for libpmem
=20
@@ -6491,6 +6514,7 @@ echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "fuzzing support   $fuzzing"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7327,6 +7351,16 @@ fi
 if test "$sheepdog" =3D "yes" ; then
   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
 fi
+if test "$fuzzing" =3D "yes" ; then
+  if test "$have_fuzzer" =3D "yes"; then
+    FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+    FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+    CFLAGS=3D" -fsanitize=3Daddress"
+  else
+    error_exit "Your compiler doesn't support -fsanitize=3Daddress,fuzzer"
+    exit 1
+  fi
+fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
@@ -7409,6 +7443,11 @@ if test "$libudev" !=3D "no"; then
     echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
     echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
 fi
+if test "$fuzzing" !=3D "no"; then
+    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
+    echo "FUZZ_CFLAGS=3D$FUZZ_CFLAGS" >> $config_host_mak
+    echo "FUZZ_LDFLAGS=3D$FUZZ_LDFLAGS" >> $config_host_mak
+fi
=20
 # use included Linux headers
 if test "$linux" =3D "yes" ; then
--=20
2.23.0


