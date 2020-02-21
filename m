Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D109C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F53208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="RFxjgM+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F53208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j52Eg-0006jG-7m
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 01:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j52Dw-0006K7-P9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j52Dt-0003SF-80
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:55:42 -0500
Received: from smtpe1.intersmtp.com ([213.121.35.73]:52500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j52Ds-0003Im-M3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:55:41 -0500
Received: from tpw09926dag15f.domain1.systemhost.net (10.9.212.23) by
 BWP09926078.bt.com (10.36.82.109) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 21
 Feb 2020 06:50:28 +0000
Received: from tpw09926dag04h.domain1.systemhost.net (10.9.202.31) by
 tpw09926dag15f.domain1.systemhost.net (10.9.212.23) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 21 Feb 2020 06:50:28 +0000
Received: from bwp09926081.bt.com (10.36.82.112) by
 tpw09926dag04h.domain1.systemhost.net (10.9.202.31) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 06:50:28
 +0000
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.54) by
 smtpe1.intersmtp.com (10.36.82.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Fri, 21 Feb 2020 06:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdD2CqsubZQT7CWOdjlmc/+YwtZ/cW14VRVVhl/2iBbw6A8D9bqZfOQCcgNMEB0XvNNoMuas5EHnll79lN56E44xqJi2o3C8QZNvJsGonM0IzygPiqb+o3C8E6DhDw/yZ9WmbqpCRxyOhunnApKv5lWH1J2gi527P4vqKtN5x1JwaWiTWpW8uMjs/3eYJsWeOxK9tbEXSTifSjbYDziK/O34V3pGodE/h7il2wy4HgrhiMhgYQWdogYGpcA4ti7qiPKus/r4t9RA4Bvs2g+BmfJpLoJ46kqn0WSPIPuZ0I/YjLgtSj3Fz66x0ppiHnsmtltnUT0XJ8pj1jYugnWRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMKfdn32fkLjkD/yOQa92iBeEJNPSnwYn+b+iQxC5+o=;
 b=md8rb3Zft0plHp5GxAXPVXO4q8OgcqpADgEx+toV238f10bSOehmm0a8NAXNobARBAhmNRsy797QywRSvzmDRJkhufo0ypxl/aIR18pvLKFZU9kovrp56bfeDzpJhtTGTBLMVxKOXBoMaWVRealIPwc/a2BqCDVEKiHJ0LUv7yAyOvZUIOOln0U6t+elJsvMmxIVn8jgeoFrisDO6Fn1vH3w8mkmy5X7MU/uPLHFmx5zgoT83ydAwFjk2zd72lfuK2+V7FS7fSs9ku8Z/ZBHi77y/VINFFwGFAz1LQbaBMtP65t1pEHmjetHoLpBUObbfhIyWQTwV7rwH7D9iTuk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMKfdn32fkLjkD/yOQa92iBeEJNPSnwYn+b+iQxC5+o=;
 b=RFxjgM+x3edapUJ+02/pniqcczGzK2dBbNoviiyS6HgBqVJxvI1cm5/vJOcqeYNFRzAx9hTSW0Gy47z7LITNIjk7RSBr178yWiHFmBPXSH2pOfUWbec9uSeQqitCpV8osbvw7wraSRuxSLwm/32RjzeF9IFJuAsuM6ca86R7aWA=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB2382.GBRP123.PROD.OUTLOOK.COM (20.176.157.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 21 Feb 2020 06:50:27 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 06:50:27 +0000
Received: from localhost.localdomain (141.98.255.150) by
 AM6PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:20b:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 06:50:25 +0000
From: <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/ide: Remove status register read side effect
Thread-Topic: [PATCH] hw/ide: Remove status register read side effect
Thread-Index: AQHV6IMztk0nS91QXUSAhbuFxp1TiQ==
Date: Fri, 21 Feb 2020 06:50:27 +0000
Message-ID: <20200221065015.337915-1-jasper.lowell@bt.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0010.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::23) To LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:c2::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [141.98.255.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffefd2b7-67d7-4c2a-a2c9-08d7b69a558c
x-ms-traffictypediagnostic: LO2P123MB2382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <LO2P123MB2382C12A7D89400BF00F20F383120@LO2P123MB2382.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39850400004)(346002)(366004)(376002)(189003)(199004)(71200400001)(64756008)(1076003)(69590400006)(66446008)(86362001)(66946007)(66476007)(66556008)(956004)(2616005)(6916009)(478600001)(8676002)(6512007)(186003)(4326008)(81156014)(5660300002)(26005)(8936002)(6506007)(36756003)(81166006)(316002)(2906002)(52116002)(54906003)(16526019)(6486002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB2382;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahXqP3gdrslhPKOIQiSJtA05u6a6YOM4fyvP1edSfRMei2YHDFJSlehVWlZfBi6Idz7MUaZiwQHgYy5Vty69pgxDOF3icSO9iJQQVDZOI3PFqYTpLzW/6PBT7NNs4egB59iiwfLk7rAFF1/C7Gr3hueJnq62p/wpq3W9nbM05VYIpKwV983QFB9+agLoQpVvE46bjciTFz5cmTwdLNzUNN9YIBTyvyYvFJlPhLTHI3FyfMvUZgLWN4hqV7ZSAl2z5CMX9Qd3O7A6eBNG2pF7nDmC7l10pTY99+Djrqt4wL426u0cLygVEIJRrce4BZNj28qgEHzIpamwdiIljG6BUlMIrnDecCj8R5acijgZgbnPFS4X5/FIoXlr9/oq3zPaxnxUg22a+aOuBwr+GrWnLM/Z6Zs7QD3omItXhNoda5nOUfaG9v5hnOs3zj5r1NyZmCm6xYHlHttQri3jplipJfMj2rWRl4btrAOqk8p8Wql6oKF1NR+TKRsEASUrVN5sH3u5ccVffzndvRTuBtH1bLr+z1I6Gmsb5OAMpEricSA=
x-ms-exchange-antispam-messagedata: EiViXdShGc05N5diw1W/DWDRiDCcBqwMF4IOnMhnzFD9ipRYgjFrAv2BVYhHCfSquRO/Pa7R1U4VEh6mRqd9LYPMI+zVmvdDbNnbpak3AWKJfcAYzQvUFDH94OU7VO/zrXZZisgDDc73PzuVOSOOOA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffefd2b7-67d7-4c2a-a2c9-08d7b69a558c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 06:50:27.7160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XG2gIIS5u0FR9D2qi32/0nkrttSPgWTMSUcXJqLpSMnB4RetwBGvuuSxAZLeqUiNxHFd6OsZzuHDoi1XJ75fvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB2382
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.73
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
Cc: jsnow@redhat.com, jasper.lowell@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux libATA API documentation mentions that on some hardware,
reading the status register has the side effect of clearing the
interrupt condition. When emulating the generic Sun4u machine running
Solaris 10, the Solaris 10 CMD646 driver exits fatally because of this
emulated side effect. This side effect is likely to not exist on real
CMD646 hardware.

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 80000eb766..82fd0632ac 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2210,7 +2210,6 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
         } else {
             ret =3D s->status;
         }
-        qemu_irq_lower(bus->irq);
         break;
     }
=20
--=20
2.24.1


