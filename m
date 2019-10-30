Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14467CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A49520874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="yE9Ny86W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A49520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpYC-0000tT-HF
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIR-00053j-JP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIQ-0007KN-CB
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:03 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
 ([40.107.69.115]:23033 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIQ-0007Ax-4Q
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob/O8ADCS1WReBZ6hk3CNr5k21el4oQUy2NFEpLdVDyLUMF1PceElcwsI9kCOVOt+lLj+Rbwe1Y/0MXh/z7ZWEITDIm67eKI5iAkX43Hb1BUKOhfqKZ8MA6coHOsy4MKWxyick1bkhAQJRmBfr50khWgPq4bpWAdnNfJInFWfVnVkVjBJyP50ipqd5RN1qVIxg/WJ070idupoIVezrYm++qF30ioqpp/dqG1BqTHllOXxt7ELGqCRT/uVT2exqih/pfMDhynzevVuV/5sfhgo4YWPyx47qWVcCOmJjaA3XAQgu2vTpoKWKuIzQl3bOifmaEC3o9Q0pfECpIdq7fGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A2jXiUgW+IZC2QLmA+Q4LR+o2sg3npX/gkaI/Li8WI=;
 b=GTRBDNDjDMK4gg/gQdOGtDiQM6YzcxrMjwGSeNeC2aySteVOku+G1G3xT9wTJ6hJN/64op4J+dedPabGdRGu2vdfj19jKQoBv4jxjXlJKVe1tS7AMdmld8Q0LuM91IhaZEyRMULnwJ/aL5ESiiyzTcJMDPSogqBas1K2eKyL5WFW8BmMbeWb8Ue9qtwQIE2dfqs6zO1rwdWK8GhDYMPREKxY0+sUGSFrRrgFPsVlbfNBdsT8iu3H+V84N6cR21qjCiE06Imi8lEdAcMxswHwZ+4yKks73FteZRJwWX51BxFKqCcfsQ9Ov1zzqZfrBTt5Sm+kNjdBfnL+pyDDO5dUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A2jXiUgW+IZC2QLmA+Q4LR+o2sg3npX/gkaI/Li8WI=;
 b=yE9Ny86WoBg4KQ4tgKwQCXDmYE8OKvANE2UiFi+WZYep6528BSTtIbsMfukMwtLCWbeBYIRb85Jx/A5pa7pfJ50wG+bcGL/erGniDeuD0daJrYdopGLIeqmrQVpKcBHmkd9f20AMGY7bM4Zb3lhg1X/s8+Zk0/Zd9D8s/oq4uxs=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:49:59 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:59 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 13/20] fuzz: add configure flag --enable-fuzzing
Thread-Topic: [PATCH v4 13/20] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVjzFNJM1RkEcEfUWq2jVZP3MbOA==
Date: Wed, 30 Oct 2019 14:49:59 +0000
Message-ID: <20191030144926.11873-14-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 41e83748-740c-4189-fbd7-08d75d486fc8
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB495978EC3F866D1BA5B50122BA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw9hg+ho3XUeN1xXcvCfU+Xi88MEUV1+7loj2vTmXhIftp0tEKDApT+uSIMUYz2hxU4Mnn/IGDNGa44Iz2lfvDHEqpmqx6VLfKwyxJPobi4/1X63KgayM1o1Z/Y9Q+N4Ae/S5HOMEqby0iqwBRvrbVaRCBOyBs8GpMbQblEY093K2z1bhdo5xB246Kf2J8AKd0oW6C1bArSuPQklUrN+0pQtnw8JNa8vW/5yft/AtD2kT5KKODj909vEZ0hHh/jPgs9FLFVFVRPaCnb1adB0gDXmVaAar/6X6taI1e3ocift+zo51Xq8zoM4SclouOs8sDEdjELyNhBxrGKIgjxi6XkPdEFsIGeU1t1xnN0RusHg115IHgvS95BswpTRYa4iKyUIU98kmyfrqSs1MXNHSRogNMaqcLsBBR2FDUWQbuuvV5+dih68tUsiSAmxYjv7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e83748-740c-4189-fbd7-08d75d486fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:59.2694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kltoLeTetWkMHfB/yULXqN7mkg883N2P+QiIa6lDVDTUJHlM8RB6V31qcI8CyROB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.115
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

From: Alexander Oleinik <alxndr@bu.edu>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
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


