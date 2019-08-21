Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC1622DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="i8bYTt/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC1622DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tvp-0006bP-Kw
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i0ToF-0005pe-4m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i0ToE-0005f5-5V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:50:07 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com
 ([40.107.68.113]:59816 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i0ToE-0005d0-1p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRND/nLtsid2z1eTGd/kjZnPoSNayBJo168sX+rCkCGEs74xktfkGzYX/xuq2wjQj389a9YK3BN4zRuOwT6mWA186tz5g2+epHcGVT4DmuC+6bQETVOxcPOwZ5E9RDXA8TQCmn5CgVFEfetSsJcCEDYw0SXt9tN6ymZnq2fgp+HFejDB5aTs0/5sttxRpqDDVv7hcjXkkS1Fx8Ar73CSQ5gSp8rwXITnc3dlW3H/+8Z04NatWbflJH302caeHInVnQWTieLTccp8dL+/JSXf3gvZRHdlzzB7Rqi7ZWzwrsI6KxQ72UOHiDtYsNWpspevtaqMTO738JsYHHrie24bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ITBwMdmJWyLfSg1JrecnuETUcyD6GpbqR+OtRWQBI=;
 b=VtIUZPmT6YXc8/4O9cANIlyaJwIYZyWw76IKBowyIfgbTHUlC7jLJIUEsAlWbQ+abMEVfnE2e9hykf8/cO5p+NrA9ras0iOIn8JsvFof49mti8Og9QoxxHrm3Kmkg2OGg1lSxhXU2T5qUFNhERkyd7UOpliEtuDadCgekhvDn97a/MCbyCxAzQodPJ/Djr2LEpRw4JtQ4p2bMtNEDiGS/LArlEg3E/sgD6QMuZ5SHKBqJ4xaTd98cQw474Smtszp0yISuRCm6B80gOS2VleKAbrE+40ALkfpHqaKJbaF5+pP7BOAKgPKK0Udg46vL2uZaV8oCdEXse2jZ+dXRjcPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ITBwMdmJWyLfSg1JrecnuETUcyD6GpbqR+OtRWQBI=;
 b=i8bYTt/8h1rzi1A44qAltDx8poiBc19Wrnc03Jz1c8FKsoReALyw14UA9wCOGsJhx4mc1a/1xFWqtR26ZLyFGix8kIRehNQDixLKKy8KkcTpxEGucpEVhoDVkVR5NNvXPpY8PoM7GJwxXJWJdtnzY1NWYLg61yJOjIDsTTH3Rlg=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1171.namprd22.prod.outlook.com (10.174.90.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 16:50:03 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.020; Wed, 21 Aug
 2019 16:50:03 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Tony Nguyen <tony.nguyen.git@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][Qemu-devel] [PATCH v8 04/21] target/mips: Access
 MemoryRegion with MemOp
Thread-Index: AQHVWDJ93CsyrNivJEm55PRoPFIyEacF0D6W
Date: Wed, 21 Aug 2019 16:50:03 +0000
Message-ID: <BN6PR2201MB125109F18A87F157A6364016C6AA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>,
 <a46ceb7a57f6c762b3e5150da8b2ab7160f7ae12.1566397711.git.tony.nguyen.git@gmail.com>
In-Reply-To: <a46ceb7a57f6c762b3e5150da8b2ab7160f7ae12.1566397711.git.tony.nguyen.git@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 268bfe8e-9bfd-41c7-840c-08d726579d1c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1171; 
x-ms-traffictypediagnostic: BN6PR2201MB1171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB11717F47DC80E372A60CC521C6AA0@BN6PR2201MB1171.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(39850400004)(366004)(346002)(199004)(189003)(53936002)(4326008)(66946007)(66066001)(107886003)(66476007)(6246003)(66446008)(33656002)(2906002)(110136005)(64756008)(99286004)(7696005)(76176011)(316002)(25786009)(76116006)(54906003)(66556008)(55016002)(6436002)(86362001)(71200400001)(9686003)(71190400001)(229853002)(3846002)(6116002)(14454004)(256004)(476003)(81166006)(74316002)(6506007)(305945005)(102836004)(55236004)(7736002)(2501003)(11346002)(486006)(446003)(186003)(26005)(4744005)(478600001)(52536014)(8936002)(5660300002)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1171;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2X76cmIUpHqLsju2ngwK1pc5qlj5x8I3NSAvgt9ognfhW8WuN7vDZY2c+eWFURpnabaZuIeH0IwfcIbkO/oqo6zmG3V41iPFPZV7pIevhmI0TSoNpbId7v/BaaqQY1DrU8X5CeAvKoffdK0yMgLcOhvt49hD60Z4SD1Fd1OG9A2z4t48vEk4ReFpEqxbLUnUaEFP/vVOszjR5VjjwwksWq7N48roATstBM2NjPW2i/cst/XcHkKMzeyiwO67ndK/86o1n3tIITonW4xMcLqhrwzWvQrQho4ABBy1pNXL90pzLEZ38lEbODDCWkW0Z7OguxBgVayhdXkOJ7IiONPwfdoawjPvGboLhRfB/gvCRwsrFG9DL2fQ20dWC9qb2CA1UoCe+cP8GVT/uVgRldQOHVrFQVCVmK5iy9ib5GLSPrg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268bfe8e-9bfd-41c7-840c-08d726579d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:50:03.4627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8L5amhV13bYiryQ7wZz5Cr2OoXFpDCEsRcOVTAIwNsOIWf9w5UetHSUfvvfquXzkbZApsZjraGbfG1v3rjGpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1171
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.113
Subject: Re: [Qemu-devel] [EXTERNAL] [PATCH v8 04/21] target/mips: Access
 MemoryRegion with MemOp
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Tony Nguyen <tony.nguyen.git@gmail.com>
>=20
> The memory_region_dispatch_{read|write} operand "unsigned size" is
> being converted into a "MemOp op".
>=20
> Convert interfaces by using no-op size_memop.
>=20
> After all interfaces are converted, size_memop will be implemented
> and the memory_region_dispatch_{read|write} operand "unsigned size"
> will be converted into a "MemOp op".
>=20
> As size_memop is a no-op, this patch does not change any behaviour.
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

