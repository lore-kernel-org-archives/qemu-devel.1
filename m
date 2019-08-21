Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECEDC3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8EF22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="Anca+UNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8EF22DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TuB-0004QS-Pz
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i0Tn7-00058t-0Z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i0Tn5-0002yh-Dr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:48:56 -0400
Received: from mail-eopbgr810091.outbound.protection.outlook.com
 ([40.107.81.91]:39072 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i0Tn4-0002wl-UV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBXKIRbOv8TPpQPXPTrlLcurnuK/K+RU4UUIPdm1wQVv6QZKCqAvRtcbrBCD/QgB/iYUuLBQZ9BfhMBcu0xZFqxzZ3qXCmyHbmJu0p6WvTXg/8fHe3jzxic/bAfv5mnTTBoObrm1hMxNe/RFOS87ntQ8EPFbKOliSYlNQF3mUPBnhvZxAXs9pseEq/BTRF+iMbLbva73P2qgnY4fQ8QIT/5UMjoTby4y2EPXsAiAa5ZbYvapNbLfoEAkzfCLWwa3gUtKNQbljExRcOb6q2hFVKPTksuRFeyFKKwIB8AW/z39JU+fkyxWfmd+TbJHArKUOBoHY/MH0o8b1XiFf9VU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfCb4vSVcanQ9esnkoi64YxzH26a9yTQzbJD3UnzQgo=;
 b=lH0T2Jvv97gj3AM4r9DOdzUX2nJeUXjoCxNmyUTYVFwZNKNTh+sE++w8OOavIPuSFAq+gXOnZsUsOZ/NAQI8I/zH1+3Dza4BPpyqEJ52qYsmAUuqrwu2TVOKMt1U7lvZWY/gs5GMAlFITb7uxJPV9K81DRL4aaDM3xpx1WR6xOdfoJJLgGdzWPGxnImKUCwVTlfHLqkCOngF6QQijHuoAiA5hnVRc2R1dPWsvOawRiAscXenrV8RetrMlcaHfvGEC/cYf/Xnp0fv7VfHtd4zwwx5bOLPjVAxIe7h46s0Ai5QtrTLSuHuESNk4miXsgpBvNquk3+298cTel6JJtPTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfCb4vSVcanQ9esnkoi64YxzH26a9yTQzbJD3UnzQgo=;
 b=Anca+UNix/e2su3EplCqDL37dvRf6umaNauSe3PAfSpa9NBUaFL0YehtSZl/W713yn4d8cxWwlrJYNep3Q9+ZBR4IX/U2szpLGYiJDzSZtf6E3YUykv5ji1jvbaa1uMq/ejd63L7Qkt3y9SMH2vO+NuJYZvHdwVpsOkHzhO78D8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1457.namprd22.prod.outlook.com (10.174.91.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 16:48:50 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.020; Wed, 21 Aug
 2019 16:48:50 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Tony Nguyen <tony.nguyen.git@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][Qemu-devel] [PATCH v8 13/21] target/mips: Hard code
 size with MO_{8|16|32|64}
Thread-Index: AQHVWDKPiNmF/rpjc0+VJBU13ap8C6cFz9Dr
Date: Wed, 21 Aug 2019 16:48:50 +0000
Message-ID: <BN6PR2201MB1251E827136B587C32FCAF02C6AA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>,
 <9d992aa745964bd151b0e314a2e380b6612a090f.1566397711.git.tony.nguyen.git@gmail.com>
In-Reply-To: <9d992aa745964bd151b0e314a2e380b6612a090f.1566397711.git.tony.nguyen.git@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a36265fd-4c9d-4118-999f-08d7265771a0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1457; 
x-ms-traffictypediagnostic: BN6PR2201MB1457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB14576808ABAE4CD27CFC38AEC6AA0@BN6PR2201MB1457.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(376002)(39840400004)(346002)(189003)(199004)(14454004)(71190400001)(14444005)(86362001)(256004)(71200400001)(52536014)(4744005)(26005)(476003)(11346002)(76176011)(446003)(486006)(55016002)(7696005)(9686003)(3846002)(6116002)(25786009)(186003)(99286004)(107886003)(4326008)(305945005)(53936002)(316002)(478600001)(33656002)(55236004)(6506007)(74316002)(6436002)(81166006)(7736002)(81156014)(102836004)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(8676002)(66066001)(2501003)(2906002)(54906003)(8936002)(229853002)(6246003)(110136005)(83133001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1457;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vObpnduUQ2VaRFYmVWGdudxB2dENg2arOF8q7B2VkKcam9RPtSCDEQJARb2tBT/fdDXkdePJOkVPKjVX9O2iQEnyyxTVmC+Som2E3nMjTkFetkN4UpJYP5ulr8pdVdm+pGzBNsKfCDKMky94sN2xVucje/bxdeq/3J0vwqDhNJGw4VuIcFu40fegtPQcwUDUJFDx4JB/RiVUT4dUP8ZtbLqp0RuOyCkEdx6h28pgWyAQ92+L89Ur/k9uCBzKI/lkny5NGsP08SUNhmVRcLh11KQ2CHQpo009HYJzW/fJcqCJ1SZK+Y1nm0OxIJ3KdBZCrJOOrgsLxtmOLEOBeblU2u1fwUffzQOSV08tERxeeL/FUzUtdWf/C+maPZ+tCKR/f+VMAbPOpiK+36Ui3qzySkn+WFoUscPi2FkEVQByyIs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36265fd-4c9d-4118-999f-08d7265771a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:48:50.5175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dD/6vkCvyILj/GtCPKeMdvdZqsUWRmJR+x08QszDXFg1oESnhEXzmOMaMJxqpvToWfTV6nOlNp9fv5HakxG0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1457
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.91
Subject: Re: [Qemu-devel] [EXTERNAL] [PATCH v8 13/21] target/mips: Hard code
 size with MO_{8|16|32|64}
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
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Tony Nguyen <tony.nguyen.git@gmail.com>
>
> Temporarily no-op size_memop was introduced to aid the conversion of
> memory_region_dispatch_{read|write} operand "unsigned size" into
> "MemOp op".
>=20
> Now size_memop is implemented, again hard coded size but with
> MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

