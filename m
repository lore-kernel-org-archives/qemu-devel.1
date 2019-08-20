Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834A622CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="u2eSsFBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A622CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03c5-0004td-LX
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i03aN-0004Fy-GE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i03aM-0002XY-3C
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:50:03 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com
 ([40.107.68.128]:52359 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i03aL-0002XE-RW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuhruaPBD8YN8vs1+9lKLTwWAyeJjhn3OVx389qGWsKel5yI1k/d1qKoOS4sWwMmrrZO1vXAosZ5pW5lslRfAt9XU5PITILlXq3wn6R0C0LlshqGRSAvbcyT/DA7G9A5H7H8yeSUnJbCwqzzHiBBrF6kr0lfwBy/NxU0iCiKa36d5srN5CnLBowuXXR95kI0sLvlVwvjBWpnqj0VSE95F5qnTNOvgaeDMEhkt1MhRs/VwAIfDy3m7lOjwD2aQNxeGMkpqmvpd+XkZQr/otxUct0hwRNSrQVHFG/DLl8+PwcvckJ5k3Ip4Tgnn8MflipvqlXnJ8G6PrOit/h1L9bq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg7GY2ePYudAdUhs1R0WaQqAsuHl8bYDNE0oXzXNB28=;
 b=BCGZIeMa6C3bcDLRNHDLXYYhNoBLVD3H4DMFSaZHgNq0ch65YMx+G15jW8MSV4rSM9DjvE+Bt8daLEkzG/EXrjMiRXkilKVuXh12waFIO7LF8LwsiM5IJ/v/WLg9TLI01If6zFXJeXWf4+a0DjiEX1J0IEFXoV7mLZN2sXnQWfM6jnDaQ5B69Qz1vmrHi+vY6BskEsixxXE2S3SlphIdC9J+T0d1pFRJSemv9nQzvvyW/Zse6/VOY0YfsFR00OWaGmbvLEWMW0A2S3LY40HpafqbVIY0lYf7eBRSTJVl9vIhVqWrY1y6t+x4ks7yy2D4JGgXpL7qF3CltPZBPIn3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg7GY2ePYudAdUhs1R0WaQqAsuHl8bYDNE0oXzXNB28=;
 b=u2eSsFBHsUd3g/ZHp58syOjg68vmOi+GrDFKpoYTLwPKkYDuUesbpZDu/SVDkAIuhmtY3Kf6eSVWDSOeerbiBAxv+ZwMkskoHlRuBDZCDjFulVX/+zTe7WplsqyHdUpOi0nMQ0J6vCagOASVgAGijHU+GjJJ4e6dliJ22eNNxZE=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1348.namprd22.prod.outlook.com (10.174.80.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 12:49:58 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Tue, 20 Aug
 2019 12:49:58 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: Proposal for amending TCG interface naming scheme
Thread-Index: AQHVV1XFWW/0Wa1HQESTSd2lS0WjRg==
Date: Tue, 20 Aug 2019 12:49:57 +0000
Message-ID: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f2c326e-4815-462d-cd6e-08d7256ce858
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1348; 
x-ms-traffictypediagnostic: BN6PR2201MB1348:
x-microsoft-antispam-prvs: <BN6PR2201MB134812DC1CBF1264C237C044C6AB0@BN6PR2201MB1348.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(5660300002)(66556008)(66476007)(8936002)(7736002)(14454004)(81166006)(33656002)(7696005)(478600001)(186003)(305945005)(2351001)(55016002)(102836004)(5640700003)(55236004)(6506007)(25786009)(26005)(9686003)(476003)(7416002)(4326008)(486006)(74316002)(86362001)(6916009)(66066001)(256004)(66946007)(99286004)(91956017)(64756008)(6436002)(6116002)(53936002)(316002)(3846002)(8676002)(81156014)(54906003)(2906002)(76116006)(2501003)(66446008)(52536014)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1348;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UM1wB7YAFjPpnH+zjrZXdafnkf51jrrQreVrVf6NRVPph+a5gUAwxMJaGZ57oMdt4gBGwKTEUX9RoyK1yp37hDxbaYOxCmerqi7iBV1v06Qm22zxzeilUUO92tyoVOZF9xWVWEjUaslZilPX/XiHKRlFB98XessgqjAIaSP2WX8lFPNeM0V6zqdtaSjZfOtk0AkFN96is8HYAI3SIBwPcOd31ni677NtuBSt/10hrrkWe4NxDrp1SH1lvmLaXM8ivgLJTk0wB/BG81QvvA+E03qTzTbiSK0r7KWn7z6fyDjz8L+mIabnFiORUVT/jzDn5Caf7Nsmlg3pywjykkIiuPZtuvmrgNIpl3joiE3dc22V/EBvrSXU+PdwBfuLf1DbXcG/Ew/8zfLEDdGLgPEft2Pv9uVnaiFhMM22mBsc0L8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2c326e-4815-462d-cd6e-08d7256ce858
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 12:49:57.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEtmZKLhbnUKS01L1iD3PRWpRfwvuQeI8GCnHWWIxyf12ZIimvisc1gW8rr/27StRMVcfd60F4Eatdk6+4kVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1348
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.128
Subject: [Qemu-devel] Proposal for amending TCG interface naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, all.

I noticed certain barrier and difficulties wrt learning TCG interface by ne=
wcomers and to some extent oldcomers too. At least some of them can be attr=
ibuted to not best choice of names for functions TCG exposes, especially in=
 the area of extract and sextract. I have a quick idea on how to improve it=
 using the following renaming scheme:

tcg_gen_extract_i32
tcg_gen_extract_i64
tcg_gen_extract_tl
tcg_gen_sextract_i32
tcg_gen_sextract_i64
tcg_gen_sextract_tl
tcg_gen_extract2_i32
tcg_gen_extract2_i64
tcg_gen_extract2_tl
tcg_gen_extrl_i64_i32
tcg_gen_extrh_i64_i32
tcg_gen_ext_i32_i64
tcg_gen_extu_i32_i64

could become:

tcg_gen_select_i32
tcg_gen_select_i64
tcg_gen_select_tl
tcg_gen_select_s_i32
tcg_gen_select_s_i64
tcg_gen_select_s_tl
tcg_gen_gather_i32
tcg_gen_gather_i64
tcg_gen_gather_tl
tcg_gen_extract_l_i64_i32
tcg_gen_extract_h_i64_i32
tcg_gen_extend_s_i32_i64
tcg_gen_extend_0_i32_i64

The idea is to provide significant "lexicographic" distance between those g=
roups of functions, rather than having the similar name (wiht common root "=
ext) for all of them.

What do you think?

Sincerely,
Aleksandar






