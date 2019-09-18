Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28536C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF084218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="uC7Z3DMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF084218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjT9-0007YP-Ak
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEZ-0000Ki-02
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEX-0002Wu-Om
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:38 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com
 ([40.107.71.122]:60960 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEX-0002W9-I9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqcIvrsCplMpGpool0fD0awgBogdj3yqkrGr0YDqOqFZbrqbmQHM6AdmRPcVQTAsxRh/3WkhP5OKxm+lcRyfz7Oqb+cGrfv6TVxmHjsVL34Ha7x82dyEnCR5C9tuMgzPkliKE9MpLlxchlm1oBvmsig/Lxw4PmTmAtE9NiNRKjYk19COGZd/+DjE1SBMO1wRlttsOzF6ERLxS4cZUpZXguJx8tKqXRm/4udyLcU9uhrLrSs4KEKaOML+bbUxM9AcNU/vwNM4Cs2ZHhwKSB1m65pJgGXI4xlizG4uYodOUAr2sQ5Fy73+sbqoAQDOA7rI7pcECqfxIFLWLeusHQqK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4INRMKvq6QfTgbFoOAKvbfjGL71Nt5vhan5vvp8Ebqs=;
 b=YTz/xgmiK2Bj07IzvArypUkbNsd/llwqwUtelt8sOI5tbzplHjqgfGFun64vifF22mQOFRLp0tYHRRY0KXSMpxl2dz+CF2JR72GSkxHPzkp0kJhA2iIj9RILy8ezf78/ZZZXQLaIt2dzbtCtei3QUEAWjijGOocEcNYpJ8S8GA6KTU4qHkIOUDtNVguEx3aomx8VlQJnsoy16lnuDZMUvRjZWCW+o9B71S77XLNKkDka3dp65e61z8JxKz0vOhFUpjPSInCjfCnkU74FrS+mGzpiCBBCjUSsvPpftesH+Efn2dTTZ0qLDPG+jzNR+zVvjyyp7fHsiv3kPFY3/sPWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4INRMKvq6QfTgbFoOAKvbfjGL71Nt5vhan5vvp8Ebqs=;
 b=uC7Z3DMGb/O8srEWECGXny/diT9NP9yumOaIJV2B+/bF+BbPbMLThVByAVd3+c1tq/0tCUlZbIz7krAe1m62zhTtpBo1Eo2m7a55lWFBslpbvA7xGUvN+gvC3JgnhZRIZSzODwz64uqsBc5sYPcvHheOzhhxnoqAAoMsGKXetuQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:34 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:34 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 06/22] fuzz: add configure flag --enable-fuzzing
Thread-Index: AQHVbneHyovnzJrtBU6Jp3gZ4trMkg==
Date: Wed, 18 Sep 2019 23:19:33 +0000
Message-ID: <20190918231846.22538-7-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 363a8246-6dd2-4112-43cd-08d73c8eaa2f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB301676450F71E57A823DB089BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lo67xPj/J4LLbtU2Xq3uRdvD/QdYop8px4vgLy0plxlqrlISY1LkGwpdAbEGPp7/9+Ni9nP+owu+gabkmckkRYvIU3F7i1jENh6eumnhPCVYqcSyT5dlyL5WLROGp+DM6ph0mHPpWYihHis4FHniJ55vvzZEao8OZx7tK+xqa7hmqznqyX8nIGReljhs3Pi6lRv6/gG3K8Qz2lOhcERTVaYmeT3JAQN65Oe+bb7HqzLvz7oFATzm6OkW76RgvKmO1o99mNgDaj0qRADy/hzB87impUXQNSIEZcWN01dVv8VjLgiKaOcdElYh8Y4kcxeVm/Oe3fMMcLmv/bRUPKKOwYBYj/lGP/aLULf0MC0b/jHupTzxylv9s++Fa5mtey228cq+5QJWjK5RP3+Qxrv8Sl08MfqwJzcM/u5Ubszz2Dw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 363a8246-6dd2-4112-43cd-08d73c8eaa2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:33.6010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EimLHxeIyuKFqpi9Aiwr4kLk8xyNhBgvy0WrcFGrVSgOeVKTKYGYyWgsR6UCsGEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.122
Subject: [Qemu-devel] [PATCH v3 06/22] fuzz: add configure flag
 --enable-fuzzing
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 30aad233d1..775f46f55a 100755
--- a/configure
+++ b/configure
@@ -498,6 +498,7 @@ libxml2=3D""
 debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
+fuzzing=3D"no"
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -1521,6 +1522,8 @@ for opt do
   ;;
   --disable-libpmem) libpmem=3Dno
   ;;
+  --enable-fuzzing) fuzzing=3Dyes
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6429,6 +6432,7 @@ echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "fuzzing support   $fuzzing"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7258,6 +7262,10 @@ fi
 if test "$sheepdog" =3D "yes" ; then
   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
 fi
+if test "$fuzzing" =3D "yes" ; then
+  FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+  FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
@@ -7339,6 +7347,11 @@ if test "$libudev" !=3D "no"; then
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


