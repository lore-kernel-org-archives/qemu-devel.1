Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD37C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA107206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mjberubeossiaco.onmicrosoft.com header.i=@mjberubeossiaco.onmicrosoft.com header.b="etFfIV0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA107206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossiaco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaPE-0008Mb-2r
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZaOM-0007jo-56
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZaOL-0005md-3R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:56:30 -0500
Received: from mail-eopbgr660071.outbound.protection.outlook.com
 ([40.107.66.71]:32142 helo=CAN01-QB1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1iZaOI-0005k0-EV; Tue, 26 Nov 2019 07:56:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk+oSSZauVJP1xU+8um8HKjQLVyL35nMgaRfSywOl3kMVqd+pko25Wu7B6buuEIxOo/S6Y0r482APWFM4PmIki274gQ91xNUAuYsM4CLTh2ne3ciL0WqujR9hIuftohfhpKcjYAlLWR1q1cy56n5E3plNdmO/YAx1azMpmjg++03nzp4ZCuZQhZaAtNv4yyPzWRrOh9yhy1kL9rvkHO0UyR0qSnhCS4eszmeGbOiUP63pAOaZNnNnI9rwFJbvHfYyXSQj4ojRkAJ1MoPFoiMgy21eokrT5KksvVkY69KPLh9xTaDzBkSrTQMg/Hcehi/kS8oo7qJGAaK3CF52fEAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLOdiNugfezjGlaxLbmLhoO0DoCvVRM8fgneB7sKL1k=;
 b=nADLFqn+G4zLMm5ZpopZkZKTe343Rme/fk/NFy1SCV81WkkTi1dHcSh+4+dy2BAZmQEPcci2kLORhDQb4qjMLoZo7ukzt2WiV6GKfynLUGpbEiySMUbuqGORhLi+/C0t5c3YEWsb2Wt1NstMRfxZ3itE3q7eB3e+Sr0Koxvf+4Ayz1gWz/HNH0h9jAXgLNAeigmrejUIUjxsH7Vhs1upHNNhZT9+FYwVvomP67MqWmP4hu8pouQfOOnHnvQn3Lg3eF+X96f5l2JodFxwNt4ot2NBn9WjDW6RbQjInrTcR4RRnWcrSh705eDMD31vf8hvGDr1baKBXG6ectYQmJF/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ossiaco.com; dmarc=pass action=none header.from=ossiaco.com;
 dkim=pass header.d=ossiaco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mjberubeossiaco.onmicrosoft.com;
 s=selector2-mjberubeossiaco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLOdiNugfezjGlaxLbmLhoO0DoCvVRM8fgneB7sKL1k=;
 b=etFfIV0/B+kX6jeNqjl/fF8pDvw1d6zbTeZI4n3ulHRGtflXxpEN0hGGXV3ek3Aj85KkAHsoN3/GCkyRWn8jvrMAFv8YmYsoAP3vruBiYbp2cmbth2Xsu/ga/Y3FuRLb2S07orIxowaSk12qR6+WB7jlj9/N4NE9fyMiFNlPLJg=
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM (52.132.79.154) by
 YQXPR0101MB2069.CANPRD01.PROD.OUTLOOK.COM (52.132.76.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 12:56:24 +0000
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d20:2d18:b0ed:3459]) by YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6d20:2d18:b0ed:3459%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 12:56:23 +0000
From: =?iso-8859-1?Q?Jean-Hugues_Desch=EAnes?=
 <Jean-Hugues.Deschenes@ossiaco.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: [PATCH v2] target/arm: Allow loading elf from aliased ROM regions
Thread-Topic: [PATCH v2] target/arm: Allow loading elf from aliased ROM regions
Thread-Index: AQHVpFjo2qJ5d5kPXkapkLNs4XYJ+Q==
Date: Tue, 26 Nov 2019 12:56:23 +0000
Message-ID: <20191126125600.2059-1-jean-hugues.deschenes@ossiaco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::32) To YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1f::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jean-Hugues.Deschenes@ossiaco.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [66.131.216.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d22427b7-dad9-4340-e94e-08d772700aa0
x-ms-traffictypediagnostic: YQXPR0101MB2069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <YQXPR0101MB2069943380B1E0F87F435F77A0450@YQXPR0101MB2069.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39830400003)(136003)(366004)(376002)(199004)(189003)(4326008)(386003)(6506007)(110136005)(54906003)(107886003)(1076003)(5660300002)(6486002)(86362001)(25786009)(2501003)(316002)(26005)(508600001)(186003)(52116002)(305945005)(102836004)(7736002)(81166006)(81156014)(2616005)(3846002)(6116002)(2906002)(8676002)(71200400001)(71190400001)(36756003)(256004)(14454004)(99286004)(66066001)(50226002)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002)(8936002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:YQXPR0101MB2069;
 H:YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ossiaco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpbVmUTISqeaV9Zu3X6KaCBrJ0As9zIqaSYY0LIl0jHj597K8y463yH/PSd3iwrq37Pyl9gNWSACLfaRfc336iqAoUaE4p8jqDBDs+hRvKLZBARtrtW63/f6z/dSjeu+Q4llzZLY1hlytVOmkXwY7IfTnQUctWyjCSLkv03moC1a2+vQ+lrr+oRa2qhNHyuvLujvoVlABz9TcXd+jBdOJmndnytDvMT54emy5pdFOniT88USPsGZC4iyGv7QJWidNwO6eniWkCXsTu4Egs6jmv12Z1587xAMd43KGreQpMJ5Kun2mqM6IL64Tt/V5jvUgQo9xJprPS9FWzYtNyk6nWzQ9rP6iNmF18wU0si42n/IHGiwZriJb9LQyRlyDeE4Tjbb+Ew8ArHKec+7gwy+qxEel6UCzpq7nVKL6iNW2E1Nfvht3PBmEAFfkfRRaivH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ossiaco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22427b7-dad9-4340-e94e-08d772700aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 12:56:23.7964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7b948053-cc61-434b-af8e-9de586f466aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpUjF4xVjTde6liMz0y0UxYagYbfJX0nLypduji4XtQngugXdcQ3KUUcnfhEJ+mHjaFMaTBQfRn0WpEvAKAhAjqhoJnXA5UiRb/E3VGf3JMh2kBGzusc30Iwz2tDthIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB2069
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.66.71
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
 "alistair@alistair23.me" <alistair@alistair23.me>,
 =?iso-8859-1?Q?Jean-Hugues_Desch=EAnes?= <Jean-Hugues.Deschenes@ossiaco.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch, we allow loading a ROM image at an aliased address,
when it is located in a memory region for which an alias exists.

Changes since v1:
- Removes unnecessary "else rom =3D NULL" clause after having verified mr.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@ossiaco.com>
---
 target/arm/cpu.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339b..bff81b51d1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -313,13 +313,30 @@ static void arm_cpu_reset(CPUState *s)
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


