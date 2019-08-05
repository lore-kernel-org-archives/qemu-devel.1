Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348ADC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BD920657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KEEsUv67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXB5-0008Cv-9n
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX98-00039z-OD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX97-0001rf-P8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:06 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
 ([40.107.79.111]:12064 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX97-0001qn-JK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSzASds9dqhtay5brkMUvtwBCar1DoIRpLsuDLsrtttBycKluN+9k23w4ztNmDzUCxsjmSNHrgLu2JUpWBwE14UiSTQfYMRLZqP1mQWDVDucRlHemwOQm/OqWGVfj8+zBQp145AYqeVxMevekLKgM6Po3YjceU3A7xi8XQH/W5ShpTlzqdB4liPQ0j9zzAlDdvyQhFJA+UdEmaPH5TGxLlb1Vd5aHAf6gwDdZGiDgfeYQZfZRNBzaG6ii1996POfqqxdDHGlpBb09aMe+VdR2DKB7Zv+DRhQCsMU/Uz3csetnHl+7RIpGAlW+95zN+9vVte4sb1CYw5SDqvsxKGOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jvbPeaPw6nCitq2oGc+/NppRWhZpntgqK/cnLaFGPk=;
 b=VgIQ77xXNDS4TVjesIecCkFGXXTY+VyQc0EoH2Uf7uwmYO8O0Zt770p2P/kzDlO9z13cjoBF3VfXsOO2Do65+mMqMeexllPzFg/AEHd58agDihTD1Kto3rU68PcYaMT/B2/iEdGUOGT90DGLiS7fBDtIAFd6jMOqcnUhn31TBknBSg2WBWfdTdDuFLQzWgwyplVljE9T0evJM+ulnt6WRxL4leEgT7I0Rqo1zIL6j+EHGXImHq9JH/24w3Ca0fjB2PhN9pJuJUQRj3X4cPRVOCZCHhgHktBSeTX3LcQGFgwbvgCjAPEJRjsW6eMHMGm4KZqCicuzRnIbTGPYp0piow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jvbPeaPw6nCitq2oGc+/NppRWhZpntgqK/cnLaFGPk=;
 b=KEEsUv67xKp98obi5dFtDXf7pFaCnIlx8idTKeTjDmXDgA8UDZ+zCn4yDUzF6jOdivGQHYRB0naDtuHprxA4wU9TTC6qknBs9DRPpYbWaMgUd+8isj9iruRd8OmCj5OgzO/awy9w0Vv0RxNaGqI6Opj50NZbNIoze9UdqWRgSAc=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:04 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:03 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 02/17] fuzz: Add fuzzer configure options
Thread-Index: AQHVS1zx9SvDhiU2WUGEo5Mghzc1qg==
Date: Mon, 5 Aug 2019 07:11:03 +0000
Message-ID: <20190805071038.32146-3-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13671440-06fd-41b2-fed0-08d7197413dc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB264647AFFC02A1FD1CA95171BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sa+jA6MGhD5z5+NNhQMSP0N3Og3I6TRVSKfx+IiywtyQhfpKb0owj15RrBnli4ojez92lyaxlBDd+s09KwpX63yl30pTW/oTMnW2IpFR2j2Sa0P2qBF8lcz7d0/VjNcum1fFbpWanNRp8NPK0nLYIPUIlmlgIafDHQe7Ro+9Dv9R8dr/Or31ro0kktbxjwRgwu8+sbbsT/r01Ohr1JQ76EroFzjx4pfAaBM09hW37sdRbNuOrjBpPDPKxFX6FIX/LkPiSBhfYsZZP8/DvYqjK+sl78xZrhf9daaonrX0lYdJPFbnJ6qE6it/jYKmafAdVNSIuBNK28bVZLjcZkmnayS2voP2fMwhtxECIUJmEaTQtt+TW94qkS7dw6jSmONwtYzYCVTtYrfis2F28kVb3HNG40QKrpHw/cS1cMAPV7o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 13671440-06fd-41b2-fed0-08d7197413dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:03.8554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.111
Subject: [Qemu-devel] [RFC PATCH v2 02/17] fuzz: Add fuzzer configure options
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

This adds sanitizer/fuzzer related cflags and adds tests/ to the include
path. This include change is needed for qos to build, and is normally
located in tests/Makefile.include, but currently the fuzzer builds from
the i386-softmmu target, not anything in tests.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 configure | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configure b/configure
index 714e7fb6a1..69ef1e7c7d 100755
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
@@ -7306,6 +7310,17 @@ fi
 if test "$sheepdog" =3D "yes" ; then
   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
 fi
+if test "$fuzzing" =3D "yes" ; then
+  QEMU_CFLAGS=3D"$QEMU_CFLAGS -fsanitize=3Dfuzzer,address  -fprofile-instr=
-generate"
+  QEMU_CFLAGS=3D"$QEMU_CFLAGS -fprofile-instr-generate -fcoverage-mapping"
+  QEMU_LDFLAGS=3D"$LDFLAGS -fsanitize=3Dfuzzer,address"
+
+  # Add tests/ to include path, since this is done in tests/Makefile.inclu=
de,
+  # and required for QOS objects to build. This can be removed if/when the
+  # fuzzer is compiled using rules in tests/Makefile.include
+  QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tests $QEMU_INCLUDES"
+  echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
+fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
--=20
2.20.1


