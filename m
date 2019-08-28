Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A27022CF5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="vhfkh6jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A27022CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31L5-0008U7-TU
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1i315p-0000tQ-64
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1i315n-0003r7-BQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:46:44 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com
 ([40.107.72.120]:33856 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1i315m-0003nj-UX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:46:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXNNecucXW7mUiJcgrDo0Rl32jm51RqHY1E8vLvWzqpD+OeXk5Vak6rHeWGSl43N2w27tFaJBsefUXQrY1G3KOzOdoP2Xzgo6dXNdq+IjVIxlzkmSQebqe4bNfuNlAPuvpzf5oOWJ1+4/t8hjhXOIJFia3nrSP9rnzTxHsByHC0XWCMV8dCaGTwGf3qFkqZpU4Jkvf9OPBjkcodoU9HDxwfz9jHwhJKTFG2WbRh/PPGSFnlbx0mvjsvXBawBkP1S2Oc5cOtnlj3ETDUgmWhlWHS02ear7RN1H5cf9dmsp8cZWGuzOIS+e3BF0ZB4bexssj3HB94KFXEhfp1IYfp6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raNcOLxPIfSbLvnryjBgcbVx2m3YNsOc639D4D+Tz1k=;
 b=BIOloZdRWj0V2SEU/0ukkuNmLON+1UQTOyOilksgTNyWyZaL8rZ9j9rkHoLP4i6DCY+FBfTjzLW8aJp6w18WoQlFpAOJ9DWO7J48Arg+c72CqmNBgh5qZs0gmi7+SZ3InbyB1e5Sfk+3Dg52BZU9v4oc+9JoRiuD20dNr1zbElAXI374CblyBGYJKNlEpvfBdjLmF8eiOXWaQfmK28FEQdJ2cfyTQgGHr8DKC3Y+zDPt34zQnjC4YeqOOo1qnw/0TACNSp3d2ezSjEVj5EyfAaVR9Op0tc0r/WbCU8kjQfOxIO92cobeqxAn8PtPNRmsssgdAvGdloFH5IKbDlGuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raNcOLxPIfSbLvnryjBgcbVx2m3YNsOc639D4D+Tz1k=;
 b=vhfkh6jN+5/YNTLjEU61fxFW9O7ClKuh6BDYP/pCpm0MlSjjG4aEKyk/cfM70iZGdyNdZq7Qqdob8hx+MM/lXtRBNoxCjrHpCzqEDf5Meixj1A07ZlPeGvkD3XjIWRwpv6gVjitZLZgvKdOjBUIfvXFJnm82SqdRyIShckIwyro=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0700.namprd22.prod.outlook.com (10.172.186.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 16:46:35 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 16:46:35 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v2 00/30] Clean up handling of configuration
 register CP0
Thread-Index: AQHVXb1uBBZ0NJGkxEmgn57wg3SSPKcQxFaS
Date: Wed, 28 Aug 2019 16:46:35 +0000
Message-ID: <DM5PR22MB165855036863A267BCEFA2E4D2A30@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1252a4ac-a099-4a36-216a-08d72bd749d3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0700; 
x-ms-traffictypediagnostic: DM5PR22MB0700:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB07007B982E8CB3F2110C3475D2A30@DM5PR22MB0700.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(3846002)(71200400001)(71190400001)(2501003)(14454004)(8936002)(478600001)(66066001)(99286004)(2906002)(6116002)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(76116006)(446003)(11346002)(476003)(486006)(52536014)(256004)(6506007)(53546011)(55236004)(7696005)(76176011)(33656002)(186003)(102836004)(5660300002)(26005)(19627405001)(4326008)(6606003)(316002)(81156014)(81166006)(53936002)(8676002)(86362001)(6436002)(55016002)(25786009)(74316002)(54906003)(7736002)(229853002)(54896002)(6246003)(110136005)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0700;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lrk4pyIuw5mGYxqFacwhrwTTxzaKhQ2FaONnqmhIM7WHsHZ9b2eB9ZOSkNfBBo/kOWk0j02CVOJe/kqTkMP276KXoYjH6lY/WAOPrK73+BpeKBKAl5fB2sYWW50UPnaRnj3PYiBSQdPE+2qWb12gZWBvgojljhgoYEbzR6NFPlkTLpg4cWTKNCwiBSGU8/ce9uIPaadXiZeHYFjXGZPfF+llhMHJU//QF8czdrjBmvDAI/c1cNWeVnOd4Utdtl1xsSaWFtOCwzrzZrjwuumcH57N2GNVWgQBHia2lUDRQ9AT7ii1NHFaq5CtWhim0o/XuOasNswKOjsmdiYtoljH+WcHAGMUTi/jB5+ZY8y6yjs3vIDZQL3KYDY84j42p7duCVN3VPuf25txjEFELt8ZwrmtBCAG6P9L8MHB1RHMcoQ=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1252a4ac-a099-4a36-216a-08d72bd749d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 16:46:35.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/bGUZZe6aRmCtDqnejNMTulKltsYSFDrVnqBLUHa8mLXUj1V2DVCgKhRpRUSvQPOti0tvBk2UjrwDQPs5ybuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0700
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.120
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v2 00/30] Clean up handling of
 configuration register CP0
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
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, August 28, 2019 6:26 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>; Aleksandar Rikalo <arik=
alo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v2 00/30] Clean up handling of configuration re=
gister CP0
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> v1->v2:
>
>   - added cleanup of handling six more registers
>   - misc improvements
>
> This series is a spin-off of a former "Misc MIPS fixes for 4.2" series.
>
> The goal of the series is to clean up CP0-related code, and prepare
> it for (near) future extensions and amendments.
>
> The series is mostly of refactoring nature, however it may contain
> simple fixes (for example, fixes for obvious bugs, or additions of
> simple subregister handling). The more complex fixes and improvements
> (for example, additions of VPE-related functionalities) are, for now,
> outside the scope of this series.
>
> Aleksandar Markovic (30):
>   target/mips: Clean up handling of CP0 register 0
>   target/mips: Clean up handling of CP0 register 1
>   target/mips: Clean up handling of CP0 register 2
>   target/mips: Clean up handling of CP0 register 3
>   target/mips: Clean up handling of CP0 register 4
>   target/mips: Clean up handling of CP0 register 5
>   target/mips: Clean up handling of CP0 register 6
>   target/mips: Clean up handling of CP0 register 7
>   target/mips: Clean up handling of CP0 register 8
>   target/mips: Clean up handling of CP0 register 9
>   target/mips: Clean up handling of CP0 register 10
>   target/mips: Clean up handling of CP0 register 11
>   target/mips: Clean up handling of CP0 register 12
>   target/mips: Clean up handling of CP0 register 13
>   target/mips: Clean up handling of CP0 register 14
>   target/mips: Clean up handling of CP0 register 15
>   target/mips: Clean up handling of CP0 register 16
>   target/mips: Clean up handling of CP0 register 17
>   target/mips: Clean up handling of CP0 register 18
>   target/mips: Clean up handling of CP0 register 19
>   target/mips: Clean up handling of CP0 register 20
>   target/mips: Clean up handling of CP0 register 23
>   target/mips: Clean up handling of CP0 register 24
>   target/mips: Clean up handling of CP0 register 25
>   target/mips: Clean up handling of CP0 register 26
>   target/mips: Clean up handling of CP0 register 27
>   target/mips: Clean up handling of CP0 register 28
>   target/mips: Clean up handling of CP0 register 29
>   target/mips: Clean up handling of CP0 register 30
>   target/mips: Clean up handling of CP0 register 31
>
>  target/mips/cpu.h       |  113 ++++-
>  target/mips/translate.c | 1150 ++++++++++++++++++++++++-----------------=
------
>  2 files changed, 681 insertions(+), 582 deletions(-)
>
> --
> 2.7.4

The series looks good to me. It would be nice to include MTTP and MFTR hand=
ling in future cleanups.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


