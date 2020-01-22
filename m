Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13848C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D224124685
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nZZcBJ9i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u5GUXj0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D224124685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEGy-0000c3-J9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDk-0006GW-8k
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDj-0005X3-5j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDg-0005V5-Sm; Wed, 22 Jan 2020 06:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579692648; x=1611228648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QUdjXHvZYGhIxcPmCCCSRo13/+yzfwhSXZJiKKQ1ehU=;
 b=nZZcBJ9icwT7Nh/la5VMd0BamiahCAv2UGF13OHghRy2SN7NjAO36ZHu
 UtIO7Z+ziBbcQnb6W26tVDlz96jmUAE0mtNkSjUbpTifDbeFNmDoTRBm6
 t9l2dpLh6efdkSaiFjyDj0F8Yd+z3vjcumBRJyKs3jE3x1YPMOCtoyLm4
 DTmXu4P8Zropr3Qq946X2dNMoHAmC1mLkXn9DkcYYt43Vd8Yp2OozfATG
 d35lY/DafWb39HWQ16WcdX6REIO68L1/xL3bMfjAS+iueDFKHFik4clOt
 a+6a1gtfHeBx/86Rp/Dzj4fou4M6LVvWO4DX6/g4gvWLilRRiwJU10AHa A==;
IronPort-SDR: +rGC3Kn2Aljyzthi7RQ24wSRFCCxfY+8eK3+RnjLKIvfe24lCpoXeKMOm/OMfwXZ5Ow0KaprNu
 wLyMgB4tRVQvyyKKWc0xdS1mplfM+OVHKqCw8FXI2NC4P96pwqnrNXFchEJ7LxJPsmbNcKp5xU
 iCnTY1SDX14McbLYfKNOQpFuXJL3jFrOrDkwZ3BHMUuqoJ8DZUXrm0GmRtHfYApxzq3B4J1PAN
 2/SXnBzFVPmtqdlSnqiREELVYu8ZiefU6f5Zd847ec7R0tNEsHQijKtZuRLJM4deLkJ89/dqkC
 dTA=
X-IronPort-AV: E=Sophos;i="5.70,349,1574092800"; d="scan'208";a="128180892"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 19:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpLX/aTeYlkyqfoJFsXBpfovjbc7vAfQJuinOm0tQmmlxCbmKx9Gn673yysjhtjdOPoVO9NoWE6J1iwlMpxMeSfRWQ2TbKywLtBeCG1qSTSy9l7fD/YbBJX9Ars2iTIttVlJa+b4EYD50uKB1m8N6kl9q/VSwnpjCrMfB+l4clb8G6tA9p8of5MK5YUdskKpfeAmkGovbAsMqH85jh9FMdzhHOiK08v04YstHjVKncS+fb+0nP+4h0ws5TqEfdeLQiJSn1VClDbGDnzokdgyOZv3TI0QoAKQDQySNfYzfJsUKNnfyLzvMvASlGQAtE06uig+TMO2TQ3q8X1wp0UJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OR2RKPoBcM/yeZn0LSDHFMU/6WqlG7ys+EZ922rzU0=;
 b=REXMC7fx0j/3+JxVaFlrmfGcQCBJVI74zwDRJhXS4UZzKaWt9UXBlKyUh930SzOkBg/G1mm4wvbQNVYIrD99x6RqBfrPDdycoleBdtSrBSAXtbWd+ZZjTf1Uxvcl/Kagfqjq1CNJrGyILqKuSrZUTjPS4muPRzBxol2ZI0y5c86W/DOZSoP+VmzNcqYLCEofGwSaHhAtPG0DH1ECqKtaE3eLTSao2kPwYNeEs2qOG5PBOsTR1iNHMW6+/A14bBr9F2BbwuJkEiA9JxEe/N7Uk3hIc1PyWVzGYTWl3x1wddFKxskk1GoBL+IvJTqRLiSWvU3EOeEfzAFxsNLRveXxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OR2RKPoBcM/yeZn0LSDHFMU/6WqlG7ys+EZ922rzU0=;
 b=u5GUXj0Q5DhAHFU2RQeVv1CxQGWivvABVOAJh9uM28A381Uj6o7XU5V/yExkJ/2JkFcS25+zVCkLicjY57QGvTFqCebgriIEJOHlDAfRzqRCX1FOOX20VpfckDnw3Q9qpFEi/sN6P3LFeCDFLymIVJip7vVUocKM8js9aHPSXBs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6767.namprd04.prod.outlook.com (10.186.146.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 11:30:37 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 11:30:37 +0000
Received: from wdc.com (106.51.28.174) by
 MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 11:30:33 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
Thread-Topic: [PATCH v2 2/2] hw/riscv: Provide rdtime callback for TCG in
 CLINT emulation
Thread-Index: AQHV0Rdd+O8Iu3G4LkqEuMZYW+MuQQ==
Date: Wed, 22 Jan 2020 11:30:36 +0000
Message-ID: <20200122112952.94284-3-anup.patel@wdc.com>
References: <20200122112952.94284-1-anup.patel@wdc.com>
In-Reply-To: <20200122112952.94284-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.28.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3df0973a-0be5-4a30-fee0-08d79f2e8025
x-ms-traffictypediagnostic: MN2PR04MB6767:|MN2PR04MB6767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6767E1F7A4AA691810E650908D0C0@MN2PR04MB6767.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(478600001)(8886007)(36756003)(110136005)(4326008)(44832011)(54906003)(316002)(55016002)(2616005)(1006002)(86362001)(2906002)(186003)(71200400001)(16526019)(8676002)(81166006)(956004)(81156014)(66946007)(66556008)(66476007)(55236004)(66446008)(64756008)(26005)(1076003)(8936002)(5660300002)(52116002)(7696005)(4744005)(20680400001)(32040200004);
 DIR:OUT; SFP:1501; SCL:5; SRVR:MN2PR04MB6767;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjwo34Oxf5f9pL7+Rp1XvKEz1DS/KpnUd+XPBa6QfveRxO5+tNZDMhhrWPQY9eW+vRkbqXbfbnDxZMmiIr2tS++cHXKP6nx4oFWMtRtIrqYj17fe9hVzMyX7hBZNoj4pxBl9Jppcse6Y8IcSDNq6Bk6ytdT63AVPxssDGKRPPinzGGxhDj3wwTIJ9UMVIJOx4zKhN925bFJjbV26Yw6fWS7v1Q49Wfv80u/itOVfNTZmBekztkczI2J2mybfgJcxr8C0kw0+Vc9KDink1F5tWA13CKGvm5n68v2/6jE2A8h29N2OmFcGe3lGXzIyamHLW8CVxl5MGFixytyMjNg1YR0iPNchctq+nBGAJh3wf0nZLgcWjsD2u27lz3fBgbIx43TgvFIC2Cmiuls7IQ3NiyaWtLGNiBjfqMcjnyh4iIXM6bZsgA+7B5R66B5xMIeKh1yEh8DLYPE1AK6Cy0BrQpxgr0uAa6yyoY/zMC+fFnHApZ/ufCjR1ApAAaVpaTTw0GpvVCyWM6vfpOHZx8oFEgNyN0AGR0X78KUubKvowGNeF66AIN79A93v6x+ZoC5Vgo2GDxZsM5FWjNPT7fn5Oa0/j+eLy5hL0+4aiUyml8MAOZlKHGWD6xmQv4ulc1Dis9X099ZvqhV7sael36fq3+iBTbYAIHPTJxFt9u/Aqm07upB6AMxHwpD6hraSbI9XT1MV8KHviJ7sD8pTNgubeBj4fmMmmygyiciLiqu7b1eKIijkh/wL6y2prp+OSLNow2P0VHy3rTFUbivbhEMCel2bJhueJRY81SDmhLEUz+otLAbtT2C41AX0AgfG08fy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df0973a-0be5-4a30-fee0-08d79f2e8025
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 11:30:36.8077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkVjjdsnar43D0WsMEH6+hUr4sedg0Ddbuy6eHfYIoZBkeKf3bvqgOdd7tqs3qkKnL2E4pbANmKxiLFsAtu1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6767
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

This patch extends CLINT emulation to provide rdtime callback for
TCG. This rdtime callback will be called wheneven TIME CSRs are
read in privileged modes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e5a8f75cee..805503dc27 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -236,6 +236,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr si=
ze, uint32_t num_harts,
         if (!env) {
             continue;
         }
+        riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
         env->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
         env->timecmp =3D 0;
--=20
2.17.1


