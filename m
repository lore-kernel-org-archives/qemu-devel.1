Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394E2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="D3ZYUjVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hduh4-0004Zf-6W
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 06:53:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hdueo-00027V-17
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hduZH-0006f4-9k
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:45:24 -0400
Received: from mail-eopbgr680136.outbound.protection.outlook.com
 ([40.107.68.136]:4419 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hduGE-0007Us-Hn
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KbisYqQmOtWuyvIQp/4NN8DbscakzwRqXAoNKV2XL0=;
 b=D3ZYUjVMZzATXqZtOZA9g04GjrU+NFT7znF2RUAB0P8SSrHsJFDmbSYoV36Fs/yz5u+R2/WDiYGzY/YZjy+gYqPFyPBZMS1ov7DIwHEUg//dMh/DCZAaIl+xqH/Eb9D7HwYUatpduP3uDXo5WmmR8s8NkP5WRPxMjthxYzeA9Is=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0795.namprd22.prod.outlook.com (10.171.158.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 10:25:30 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 10:25:30 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/4] target/mips: Fix some issues of MSA emulation on big
 endian hosts
Thread-Index: AQHVJ0ZLOZ/20n/9h0uUP4GNGKTZ2qakVj9d
Date: Thu, 20 Jun 2019 10:25:30 +0000
Message-ID: <DM5PR22MB165839850139289047AFCFCDD2E40@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561021082-15383-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561021082-15383-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b57042-d263-4447-f0e6-08d6f5699eb3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0795; 
x-ms-traffictypediagnostic: DM5PR22MB0795:
x-microsoft-antispam-prvs: <DM5PR22MB07951E1EF03341F5E72300C2D2E40@DM5PR22MB0795.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(136003)(346002)(376002)(396003)(189003)(199004)(6246003)(52536014)(71190400001)(71200400001)(107886003)(4326008)(66066001)(53546011)(53936002)(2906002)(6506007)(5660300002)(229853002)(478600001)(66446008)(64756008)(66556008)(66476007)(8936002)(91956017)(76116006)(66946007)(73956011)(2501003)(68736007)(256004)(316002)(110136005)(14454004)(4744005)(86362001)(6606003)(99286004)(74316002)(486006)(76176011)(7696005)(476003)(19627405001)(55016002)(7736002)(54896002)(26005)(3846002)(6116002)(102836004)(446003)(55236004)(186003)(25786009)(33656002)(81156014)(81166006)(11346002)(8676002)(9686003)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0795;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RYUz6QYpxPu5MeeHE7U/xsagunkb33duAAycDiFsK9NzMBevlmWFqYYArJyU9o3B3O8AMH09YLB4CIK+ZPG85llpoj9yBv0hTKfHxEIFk4xZDdNZ4Qq3+T5aUXSxGSyzfH8udvIeDneG8k/PhcDAAH07m9caXDrGyL3+a2yPaNBltyNR0SX3wvkROrYDWIl+5jmI7frfYIuQFQ4I6XuqlziPHxDQzuk6YL03fiI8LUwQQ9a71JebGu/Mmg20nu4QsYbhOwXIa/pK4ir09byWVc7K9/6pPBXwie3M9h1BICPmANUQSwEOn21vev1rrq0YPEwMeur6SwWQbJvDokgu3HigIxxBSFXhwx6zwJoh9Uz7lJ9uHCufD3jUWO7PA7tJq1DGPioqlsW4VtgmiFqLpp8FyaS7lL47tskyPi0sm3w=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b57042-d263-4447-f0e6-08d6f5699eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 10:25:30.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0795
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.136
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/4] target/mips: Fix some issues of MSA
 emulation on big endian hosts
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Thursday, June 20, 2019 10:57 AM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 0/4] target/mips: Fix some issues of MSA emulation on big=
 endian hosts
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix some issues of MSA emulation on big endian hosts.
>
> Aleksandar Markovic (4):
>   target/mips: Fix emulation of ILVEV.<B|H|W> on big endian host
>   target/mips: Fix emulation of ILVOD.<B|H|W> on big endian host
>   target/mips: Fix emulation of ILVL.<B|H|W> on big endian host
>   target/mips: Fix emulation of ILVR.<B|H|W> on big endian host
>
>  target/mips/msa_helper.c | 148 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 148 insertions(+)
>
> --
> 2.7.4

For the whole series.
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

