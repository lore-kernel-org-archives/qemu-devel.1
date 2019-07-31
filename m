Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4D9C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D773206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="poaqP/0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D773206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstIt-0007Rj-Tw
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hstFP-0000rC-66
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hstFN-0002CS-Eh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:22:46 -0400
Received: from mail-eopbgr810112.outbound.protection.outlook.com
 ([40.107.81.112]:30607 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hstFL-0002BU-BX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTUNVaBOZEXiSE1vCSdgjAG3jeZs8rLnX6c83dw7qg2juxdFBYoVDNrdGqLZY/DjQMTJDgNYXwVW4eC5w79BDxrs0cHOuWMiIBKGv3k1rBmUHEFeHVSef1uDRqDe0+FKJST4w+Rj75+ppbuyLo6j4WcUNgYOsejEma0gCiTKulg70CBb2l1vSdFXPveBZfgbZsNcyKFrIjdfRP8M6P98dIZN4WI8X4d8eIHIUfPZeCtG9Q7ouIoQ+9MA/mECraZJqRCEI7NJt2XCAXSwwOzjDxFrdp9QO01E1LP8/b3LQ+IM3NWdHmwwXx4BFJ05wFPnaDr5DnyiKTL0kJECHxrf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqVQxTVbtjXDisMWhWYzcONr3eLheC/uAHFkpJmE4o=;
 b=WtHYfrTiVAvH80u9h49gRY1rqjUFWMAGpXPU2eIZg58lThBXm7KJF0VXja2u/Dc0SRKXezEf+jYiJoBCjK01nX3MPbpSTX5cvej7pU0KzIy8J2GQ3bRfbimF23OEDFqFWh+ZBb8kaxa1K0El5uNOaRC/Avdl4WzHFjmD3RtrweDuxDCJLKcZSWteGkvIZ3AMqAah2+YO+TMH+oYbRjuWk024T2O9XCm0G2ah1N8eQ5Zztgk6tu6jGwr2E/5yBUNyqadzSUA3XzEEN0R2e0iE8BA5BWPd1aRbrB9m5icO2S57Y2btHbKUrXTIe5lQUlzTcPvJ1IkDklU/qTUMCfzqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqVQxTVbtjXDisMWhWYzcONr3eLheC/uAHFkpJmE4o=;
 b=poaqP/0lsd7ZrH/QrZeMrI+jp+3oIPhN9ApJ51pHzjboKXk00UBG/8rlNeKl6hYO+G+INraAMBIjExG14Ep2t6AkAysZU27vk9zmUWMYvi406VbPhO0y3WgJ/8xIWPpZ+20ZYzrLa9tGdMVXzY8uFqwcr38BarMWm9DnRGWL7Zk=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1410.namprd22.prod.outlook.com (10.174.82.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 18:22:39 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 18:22:39 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH for 4.2 v4 12/12] linux-user: Add support for
 semtimedop() syscall
Thread-Index: AQHVR8yQ0dQij6yc9062nxyvqwOek6blCZ15
Date: Wed, 31 Jul 2019 18:22:39 +0000
Message-ID: <BN6PR2201MB1251C91F80B6BCFDFB76AAEFC6DF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1564597178-24649-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1564597178-24649-13-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd23bd26-1977-4f66-2678-08d715e411f9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1410; 
x-ms-traffictypediagnostic: BN6PR2201MB1410:
x-microsoft-antispam-prvs: <BN6PR2201MB1410A6D86994B335795EAEB1C6DF0@BN6PR2201MB1410.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(396003)(346002)(366004)(189003)(199004)(478600001)(33656002)(446003)(8936002)(2906002)(52536014)(186003)(486006)(55016002)(476003)(6506007)(26005)(102836004)(7736002)(71190400001)(4326008)(107886003)(6246003)(9686003)(8676002)(11346002)(81156014)(81166006)(6436002)(4744005)(14454004)(53936002)(66446008)(64756008)(110136005)(74316002)(66066001)(25786009)(2501003)(76176011)(305945005)(76116006)(91956017)(3846002)(6116002)(7696005)(71200400001)(54906003)(86362001)(66556008)(68736007)(256004)(316002)(66476007)(55236004)(99286004)(229853002)(5660300002)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1410;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SmMn61BLq1l38Hfdt6OOykEETJPI2hIMC9/ol5tgXChjHZ08JsqBASXb6BomcykiYoapR6hqgFzkaY72sy1Qe72jl8z3xGuHfWgts6pspnDJF2WhsVJl9Mp1bWQfD3El7PLaI+vCLrVUoyGykezvLHa3atuKkr/Ca/IFbL4d6fsPjnrsD8ZIbbb1YMjkfw+OLYRekHCI51E1p/qvOGyZ5QQ4RV83eHcRn0fJwayKzB9+DQO45QlP5/vNI/eV2YH1igUeHrADDiXWRIq7nBCe6zRa29soLcH0mJ/aMAvfvuBmCYNd9NmkAd6Ng2t502trppXly+4TubzcC1HNaLWSItMvYg3RhvgfrAu09a1/fgPpHF3CdyvEPAtaC1YB+HB6kb34Rd5Ei1ByD3jRca5371QaV/jreK7XewTH1nddOoI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd23bd26-1977-4f66-2678-08d715e411f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 18:22:39.2373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1410
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.112
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH for 4.2 v4 12/12] linux-user: Add
 support for semtimedop() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Rikalo <arikalo@wavecomp.com>=0A=
> =0A=
> Add support for semtimedop() emulation. It is based on invocation=0A=
> of safe_semtimedop().=0A=
=0A=
Hi, Laurent,=0A=
=0A=
Aleksandar R. is considering submitting this part too:=0A=
=0A=
diff --git a/linux-user/syscall.c b/linux-user/syscall.c=0A=
index b5bc6e4..0e56b8d 100644=0A=
--- a/linux-user/syscall.c=0A=
+++ b/linux-user/syscall.c=0A=
@@ -4194,6 +4194,17 @@ static abi_long do_ipc(CPUArchState *cpu_env,=0A=
     case IPCOP_shmctl:=0A=
         ret =3D do_shmctl(first, second, ptr);=0A=
         break;=0A=
+#ifdef __NR_ipc=0A=
+    case IPCOP_semtimedop: {=0A=
+        struct sembuf sops[nsops];=0A=
+        if (target_to_host_sembuf(first, ptr, second)) {=0A=
+            ret =3D -TARGET_EFAULT;=0A=
+        } else {=0A=
+            ret =3D get_errno(safe_ipc(IPCOP_semtimedop, first, second, 0,=
 sops, 0));=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+#endif=0A=
     default:=0A=
 	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);=0A=
 	ret =3D -TARGET_ENOSYS;=0A=
=0A=
Does this look fine to you?=0A=
=0A=
Sincerely,=0A=
Aleksandar=0A=
=0A=
=0A=

