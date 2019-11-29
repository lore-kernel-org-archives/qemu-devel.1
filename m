Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E166C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D26215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gLBVKxS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D26215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao9g-0000sI-1Y
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianui-00006u-RS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianug-0002vB-QD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:56 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianug-0002ik-LU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+0WAG+b8mt6wr/srMZUurujFWdN+1gcrKL0dQft4XxQgOErahU2r9CFzk2+XwRpVBaKEC+G2jsEsRSCM1yrVwwbX773VuNiSM08TMGgaOaEupgSRcQDdnKk9WpPzYi7QA0Kiyk1ROGxtLgHKjluS20QlUw6kX7VX21DuO57CygCd9cvQyThc70kBjCZa5PZA+EtYjosnlQMF7TXglSUU/eocIzrkhe0ryJoNyU5BfP4/OgrFJFOLZ7PRw8VjhKbIdrANtEb3ZRM7K6iErks1ddZ9YdZXkyZcRs7zSg8HAQ03AW3zFX3W0tPlnko3bhJrxhQGDozLnNoO5KQGfeqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bTuEk1zV3MAfj5AA6t6udvyIBlqf1bUwbzBtVDYJBY=;
 b=A6pnZR9IGJ70ZFtuc+drQaToykaCtSkzC8IYhmQ7jT0PP91qb3cm8p6Zirrs4R8Jb34dipLQOluw0sc4PTrNWjPv8yXVWvASG+gxfIOY8k+FC8NB1IlHMILfrX/08RNv+MgZBzTZ0wCqYg/tIlCG3Q4oSN5gIKP3rvJ+gN5fESoky1aJDDBw5Gie6aXYkC0gJ0GX0hjyfM26SiEg28o/Q7Oc45EYW0bMQ9vwxpcsVWZi8oTjJYC0EXSf4CKaiLXhSjbR78i8+ErUdHzAckuRLKSrB40Cel1HVfNbYUqoaWvNjKCacHiYGYSov3OrDsbUjh9A4VFhg3sHAPrC4TdyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bTuEk1zV3MAfj5AA6t6udvyIBlqf1bUwbzBtVDYJBY=;
 b=gLBVKxS4n1vLsoqA+rm99PVdyJvILTN73DAnzgk1Q4DvJAtwpgUPdYYXWWLU2VR+2DD0+4vKZ0eQ+jMktHR91JeMhRlOHK64/EBKup7ioL9/NR7dKnPXoJqTn/z69P+Caos8yV70NxXN78rFJtecymWbcCUIIQeL2xpyNwj0elQ=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:48 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 13/21] fuzz: add configure flag --enable-fuzzing
Thread-Topic: [PATCH v6 13/21] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVpvzT7B4c2YwLh0e9DlnxntAFSg==
Date: Fri, 29 Nov 2019 21:34:48 +0000
Message-ID: <20191129213424.6290-14-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 2f4359a8-02ba-48bc-c93c-08d77513f58d
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB50505FEC754AD1DB38DF3973BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: poKtjtn4CH2gRIp4DXK9kq/5glhqVXeahn9vZF56f8jp/hlqNZFtkGljxnAwHmfYGZylkggI1U98sbL53FbhhjG71Ar9uLe1bhCcKkcHMIkAylEUKmfbFIkIRy7T2CvR+1j6nCMPAkRODyulsAsBdWOvZL/BGXUoF0R9okVozev23BbImIzJCVyx9Uc6/ABb2IXfxI+uhis9BQ5Pln28OOhLVr1xgeMIJDd/dhSjLfjbuwESLIKIxSKdbTjW28jvkZZVlnuJdPt1/QcYKjXdENq4wQByF8c0qkNq9lxdxuM5/rtTnjgfYnIaK7YtjUM70F/Rfk4A8JmTO3wX2wQ1DxOH0QEnEkczbd7rfJ3ByXKLzMJ4yROnkVuKlVr8i1seHGdDlc5MYHDrNztzCw43qQhhKsmzQDQ+q3tSLr+kuUkmZSJnHDQ36FUo06Hr1CLc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4359a8-02ba-48bc-c93c-08d77513f58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:48.2102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0oNOioZcdkC9cfr2SXcN4lxEUsfsrggIXGTguBsF7f6dGUOAkKz73u5v2nsQNpr
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/configure b/configure
index 6099be1d84..5fb2494a8e 100755
--- a/configure
+++ b/configure
@@ -504,6 +504,7 @@ debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
 plugins=3D"no"
+fuzzing=3D"no"
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -633,6 +634,15 @@ int main(void) { return 0; }
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
@@ -1539,6 +1549,10 @@ for opt do
   ;;
   --disable-plugins) plugins=3D"no"
   ;;
+  --enable-fuzzing) fuzzing=3Dyes
+  ;;
+  --disable-fuzzing) fuzzing=3Dno
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6018,6 +6032,15 @@ EOF
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
@@ -6599,6 +6622,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "fuzzing support   $fuzzing"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7435,6 +7459,16 @@ fi
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
 if test "$plugins" =3D "yes" ; then
     echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
@@ -7538,6 +7572,11 @@ if test "$libudev" !=3D "no"; then
     echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
     echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
 fi
+if test "$fuzzing" !=3D "no"; then
+    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
+    echo "FUZZ_CFLAGS=3D$FUZZ_CFLAGS" >> $config_host_mak
+    echo "FUZZ_LDFLAGS=3D$FUZZ_LDFLAGS" >> $config_host_mak
+fi
=20
 if test "$edk2_blobs" =3D "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
--=20
2.23.0


