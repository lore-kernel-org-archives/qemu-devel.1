Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D4D2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mjberubeossiaco.onmicrosoft.com header.i=@mjberubeossiaco.onmicrosoft.com header.b="ewEA30d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D4D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossiaco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEjy-0001aj-P8
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZDg4-00016U-86
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZDg3-0001LX-3N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:41:16 -0500
Received: from mail-eopbgr670067.outbound.protection.outlook.com
 ([40.107.67.67]:47488 helo=CAN01-TO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZDg0-0001FS-ER; Mon, 25 Nov 2019 07:41:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc4kuliiiryoCmqKGZ7H9OsQNZdbS9a8r55EOkoXIuIHCJJCU4QvUMhu4KUz8kud+uMwAtKkxU/rPNJZ3jMM2qczG4rfttQ26SlbB4bXnXvLYgBdiDw8zco5A206aszQ64MBDqyskrlNYBWXsfAbIt28aedZUf+IqdSszt2nOX787rUKgXg7zNXfhdEVxhaP4IqVMKo2D05s6kmsRO4/bdyxzePUcf7ou+8Z63lfKiIja3LGrJb2uoSlUMAI8vQbzxgCh4KlO2LTcr6YNNxD0pOfBUh0fHicgl0hGpZtz4SeZ6UZiv36RyHhnnRP5RGqgLxmoG+S2n8Mou1XT5OlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlJzH3Ci31C5SPkJJp9StA5ANNvDy9cb5LlDl788HrQ=;
 b=DrPi8yL0qbSaNy+1O1K/jsA7TDeWtZ63MwRtEkpBUStCskw6G9w8pPNwWGze0cJUTZKcolhE5av+TGpGBxxznVroJ5vDjOzb02j2hOpseqlx1qtoMMereE30TlPFiMCYYrVQOx/53YELTO/6QFHstWLITZqvUNO1gOBOyjGkvHfx6mIsw48wOfSmWqUvezuDYNEY04IiGwRi3/Fxnd8pNHLQ0A5g+NvWrPTFx6VfLS/AZeGusyBqcwo7nChQ/W3EEmBgJ58WNkq/kutpi/IzsYlAdI89kig3nM2gHn96f2dnas2iPmnJi6qX2o0gQ9Q02ZF//QAPFZs09IngHLopuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ossiaco.com; dmarc=pass action=none header.from=ossiaco.com;
 dkim=pass header.d=ossiaco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mjberubeossiaco.onmicrosoft.com;
 s=selector2-mjberubeossiaco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlJzH3Ci31C5SPkJJp9StA5ANNvDy9cb5LlDl788HrQ=;
 b=ewEA30d7phy6fyBR6KpDqjiGvCm1tNINLr9nOkfz7ZqElL3SRdtZw9QIR59Exe/RrxmFQI2C3CnzITKU38etqBx8l2F/i0B9Z1W3Y36RqvfmvxZ9mCpuNIV6z4qJzQ3Wq+pg+c6n8DBLN/QLTCDyg95K4B1se5LqdtM5YKBbv50=
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM (52.132.79.154) by
 YQXPR0101MB1079.CANPRD01.PROD.OUTLOOK.COM (52.132.82.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 12:41:10 +0000
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d20:2d18:b0ed:3459]) by YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d20:2d18:b0ed:3459%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 12:41:09 +0000
From: =?iso-8859-1?Q?Jean-Hugues_Desch=EAnes?=
 <Jean-Hugues.Deschenes@ossiaco.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Allow loading elf from aliased ROM regions
Thread-Topic: [PATCH] target/arm: Allow loading elf from aliased ROM regions
Thread-Index: AQHVo42dAgdlcFdTL0aHTFeU06w+BA==
Date: Mon, 25 Nov 2019 12:41:09 +0000
Message-ID: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1f::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jean-Hugues.Deschenes@ossiaco.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [66.131.216.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad7e87be-5c24-4236-c638-08d771a4bf6a
x-ms-traffictypediagnostic: YQXPR0101MB1079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <YQXPR0101MB1079FF9C23A048A035AA9391A04A0@YQXPR0101MB1079.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39830400003)(396003)(136003)(199004)(189003)(66476007)(66946007)(6436002)(8936002)(2906002)(50226002)(25786009)(6486002)(8676002)(6512007)(107886003)(71200400001)(71190400001)(4326008)(66066001)(81156014)(81166006)(6116002)(3846002)(102836004)(6506007)(386003)(316002)(7736002)(26005)(2616005)(36756003)(5660300002)(54906003)(256004)(110136005)(2501003)(508600001)(305945005)(14454004)(86362001)(66446008)(99286004)(1076003)(66556008)(64756008)(186003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:YQXPR0101MB1079;
 H:YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ossiaco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBBmv2pE5m+pN9vJizEAv6mYzyT6xk3wcxAIMwXtWv0wRONSXWZZ/o0YxuRnbcDbo9pabiYbWNdslET7ejgx6KNUUrraOh6OLDpx2oBqlBCuPTyYUEn7cwFVeYh++NHmAb+CZRhXwQPrdNLBrsupCWv8rKFVNQoa7P7dUGfs3c+GZlWpT2xBwsdbB5Tagb6f5qSPdgu1Z71APObYlbz+5s8xtFjwEMoG+iYx43pqBxPDTC+dhwzl3NINuYGolF0Cl0HZwCIQrQgQucyYgMsaZ2J9blHD+O+jLc1hKiZfDMskWwmWugTmaCK8mymb6arja0ZzETfR/PAEYgngQ+IwVICJPBHQLtR1FOOay+62b1+nlZbr9Ro3TWtoz3iJK0M5WO9evZlogfInIhU41spwxJ/87QBJZadWvveN6SkgftUW4EsjS6HER5RR9poz2Nih
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ossiaco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7e87be-5c24-4236-c638-08d771a4bf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 12:41:09.8194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7b948053-cc61-434b-af8e-9de586f466aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fb6plKJNkdpSE0T1A4iqdxa15Hqqh7AjbqKu4/iwxkap5w4EUhc6lssGZ0WCd6EjKKGF7VT3ER4aFCrkJNhLZUGkJoS/nhB9XoAqdEjPUnj1tzY++0qZuVd0E71AcXB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1079
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.67.67
X-Mailman-Approved-At: Mon, 25 Nov 2019 08:43:30 -0500
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "martin.galvan@tallertechnologies.com" <martin.galvan@tallertechnologies.com>,
 =?iso-8859-1?Q?Jean-Hugues_Desch=EAnes?= <Jean-Hugues.Deschenes@ossiaco.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch, we allow loading a ROM image at an aliased address,
when it is located in a memory region for which an alias exists.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@ossiaco.com>
---
 target/arm/cpu.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339b..00d89f8c38 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -313,13 +313,32 @@ static void arm_cpu_reset(CPUState *s)
             initial_msp =3D ldl_p(rom);
             initial_pc =3D ldl_p(rom + 4);
         } else {
-            /* Address zero not covered by a ROM blob, or the ROM blob
-             * is in non-modifiable memory and this is a second reset afte=
r
-             * it got copied into memory. In the latter case, rom_ptr
-             * will return a NULL pointer and we should use ldl_phys inste=
ad.
-             */
-            initial_msp =3D ldl_phys(s->as, vecbase);
-            initial_pc =3D ldl_phys(s->as, vecbase + 4);
+            /* See if the ROM blob is aliased somewhere */
+            hwaddr len =3D 0, xlat =3D 0;
+            MemoryRegion *mr =3D address_space_translate(s->as, vecbase, &=
xlat,
+                    &len, false, MEMTXATTRS_UNSPECIFIED);
+
+            if (mr) {
+                rom =3D rom_ptr(mr->addr + xlat, 8);
+            } else {
+                rom =3D NULL;
+            }
+
+            if (rom) {
+                initial_msp =3D ldl_p(rom);
+                initial_pc =3D ldl_p(rom + 4);
+            } else {
+
+                /*
+                 * Address zero not covered by a ROM blob, or the ROM blob
+                 * is in non-modifiable memory and this is a second reset =
after
+                 * it got copied into memory. In the latter case, rom_ptr
+                 * will return a NULL pointer and we should use ldl_phys
+                 * instead.
+                 */
+                initial_msp =3D ldl_phys(s->as, vecbase);
+                initial_pc =3D ldl_phys(s->as, vecbase + 4);
+            }
         }
=20
         env->regs[13] =3D initial_msp & 0xFFFFFFFC;
--=20
2.17.1


