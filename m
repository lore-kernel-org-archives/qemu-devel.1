Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B0CA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2D520848
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PRLO2IwO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="huDjZZ8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2D520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRAlD-0001Z2-VM
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 02:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjd-0008I9-Rp
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjc-0003t3-Se
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjZ-0003po-Cw; Sun, 03 Nov 2019 02:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572767737; x=1604303737;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/ITj0ywC3DPHtnCF2WlDaELAwxT+3DRuxefGThUb2Vk=;
 b=PRLO2IwOkd88uthyxFjal+lyni17+oVOKlBiGlnurSI68Je3wCH5CnHs
 fk1rLpJXYFGWiqRYSARwmi+HieN/8boi+Dmo2YKiEp7pXmyltSD/hfgx0
 7G6ZNE9MtS9gOS85t2EE+uWDAkKz/st/wNCaS9Bd8j5/CVLazl24ymPKf
 6U0bHOzybb2VZe79JbDxC86P8jNdaQX1lv1s6fVM2KDCLXdFfL7w36q8F
 XpjJnEmONXrfvCyYYuuP78LaeGXO6V2De5UXIX35hH2cu6cn6iR1gdqfx
 i1kGSpHIwXcPl8/feyV4PPtZ3MbJmTd8x0rlBJLAQXf6fQxcpw0KpPvh6 g==;
IronPort-SDR: Jbj8zQZLmt0pCcbSYg3zYs0e/0CCOfvBIG09H0GPCJuP17IEYpNYe+upOgPFRvK+lac/BVcrGQ
 fm+solsVqBvhP8n5rCxQX8urI9S6lpY3PzyRTMFdkfuKxe0bPC/UEnlRTv4ZN426Rm45/IkYhQ
 HZcJ4Ee9Em7hrd1I8uVl5fG+HQok2PE0Yj2ekTtt6Wp2TsTNocwYIawR87t6kJbfhyLkHY9jn3
 l7Yt/GskD3mb1jXbsXFYaqR0n6VnJDoiSpmzuw4peNvqlZ/jsnUM1S0S/KTqDF1hc4Qqdd3AK+
 WFs=
X-IronPort-AV: E=Sophos;i="5.68,262,1569254400"; d="scan'208";a="229199005"
Received: from mail-dm3nam03lp2050.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.50])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2019 15:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RilWPVP0EET9zwFmFm2EuGIGx+PqgQGfaA9AwPnyeJhdtn29rCtZu1o69dnq14sTxbAE6unsUemXck1wGAMnEohq31N3ry5pjETKm+Wl9oqs24FmHNUd5q2XfQMF8ffXNzJqnMAQljV55glkzClNzmQqL5pvKmIPAqX0p/IR7vvqYeqjSuZAZMJBGTOaYagoU9vBK6jdGrf/6ktxV9tInS0rdf/CpqCpgbd7eJ/jpGuqsc2kLw5QLZZbAgFebZc9E8pZxGby0wp+DSycImVfdCJ2h6FyyNJYgHAdkic5ASlbPPPpYs8P6JnPWw0uPL2RzEem75DwJ+hBy/Rzz41L8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ITj0ywC3DPHtnCF2WlDaELAwxT+3DRuxefGThUb2Vk=;
 b=GQF0PV66m5Y8UQ2GSxJQCYNI8IqiDVn2kYU/V9RRkJF7hlYCZudGdbGPg9DGlB+mTHtMGh8mzmVoc/iSzdQr4ExADpsHyR0R96ZLLOZTIRvRi0oEZn/BQgfJrtZXNmQ2njjZc71nGllpnsZMtwnZR/D4w3bW2bNIqNpNAJa50HjX2sfl72fNgAdtHjGTUbbUaPdsljSast4AbsfgivN0aP3D5Yk6Z4LDehUkKYoLcyLwoEI7K23tgzeXWLLZE3uPUq7QTvEHnjQGSs0StTPo2fyR/uSB8G5ltrkyWaaHEhHqzPgnKdNc5JmPjtIPA8FKrYy7CXkUG6HyP1zVlbNdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ITj0ywC3DPHtnCF2WlDaELAwxT+3DRuxefGThUb2Vk=;
 b=huDjZZ8EtI1dwEWbBVVVBmgeX8CAop/gNtX1xdFFgcRhPQm7Hm0R7L2mSXO/4Q2XFYMdzaYmNie1OrUlTul+Qn2Ss9AT0zH/96zuEFwaRhi0h34H1s89lQ3wDXxIP2XyH0mB8Q2rX43WX0+xE+4fr1rqVbpVjnvLOPXHFe3+pnk=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4635.namprd04.prod.outlook.com (20.176.106.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sun, 3 Nov 2019 07:55:35 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 07:55:35 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v6 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Topic: [PATCH v6 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Index: AQHVkhwTNac9UOM2A0el+gnppmNvDg==
Date: Sun, 3 Nov 2019 07:55:35 +0000
Message-ID: <20191103075353.86497-4-anup.patel@wdc.com>
References: <20191103075353.86497-1-anup.patel@wdc.com>
In-Reply-To: <20191103075353.86497-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbeee93a-2128-48dc-797c-08d760333554
x-ms-traffictypediagnostic: DM6PR04MB4635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB463563E24F3F7F4F7AD760468D7C0@DM6PR04MB4635.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(71200400001)(55236004)(4326008)(305945005)(66556008)(71190400001)(6116002)(76176011)(3846002)(14454004)(102836004)(36756003)(256004)(476003)(110136005)(8936002)(7736002)(99286004)(54906003)(81166006)(386003)(316002)(2616005)(11346002)(25786009)(26005)(6436002)(50226002)(66066001)(6506007)(1076003)(66476007)(478600001)(2171002)(81156014)(8676002)(9456002)(5660300002)(6512007)(64756008)(4744005)(446003)(52116002)(486006)(6486002)(66946007)(44832011)(2906002)(186003)(66446008)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4635;
 H:DM6PR04MB6059.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mb2ENPgfe7L0N7ML5fsVfzQGhkkWWbudEFvATItGztnrry4tSBgk9eRS8LziNMV3U5xaqWml9P/J7aIC/fKjrQCygVJvHiXLLBSV7cHrhJnAaEoamAsQO9jgzPx/G9JQvfhxSY+OoBwt1l7ugd0CO1XETkgmiMbaXiJ28JtYAio9ZEO+aKY4FU9eX6IFg+w+6yHDIhc4GyHVrPUdZKyIH+nM7lsRaKoJoh5OHR9wDZBc01e82yktu27jprt9CCOy7Hp834mQ172MIpnWIu8DEB2BmpsgiiGCBXSKq937xGjPCptaH+k4ZAwv850IaPayOXO4JvY30wg458+vmcuISWbrRXxQdOOhER5eY05yKVIRRxyNsZnPfOLqW0B9KhXRX4U9AphNPNEU9hD8TT1vqTkgG0yLnCMS5bxJvELENAFnfWJm7JTYmTk78SCYzcwd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5000714358876C459B6F9DE0DE69F7CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeee93a-2128-48dc-797c-08d760333554
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 07:55:35.5358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecLuNzfbBQMC3hJi/5IcoQXIlCZ6SSxcCgo1lyGnCucjN2ciXs1irxi3hnJ3CdHtG1wNSmpkcbO0YObKR1+JMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4635
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add myself as Goldfish RTC maintainer until someone else is
willing to maintain it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2a68555ae..f200e985da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -558,6 +558,13 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
=20
+Goldfish RTC
+M: Anup Patel <anup.patel@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/rtc/goldfish_rtc.c
+F: include/hw/rtc/goldfish_rtc.h
+
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daud?? <f4bug@amsat.org>
--=20
2.17.1


