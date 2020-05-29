Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4402F20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="R5P8i+ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4402F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeexC-0000lK-8r
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hakangurbuz.hg@hotmail.com>)
 id 1jeeZa-0001Wq-ET
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:57:18 -0400
Received: from mail-db8eur05olkn2058.outbound.protection.outlook.com
 ([40.92.89.58]:52065 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hakangurbuz.hg@hotmail.com>)
 id 1jeeZZ-0007n6-00
 for qemu-devel@nongnu.org; Fri, 29 May 2020 08:57:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFWrIuULV6PnNjH5wDd3xOwaRWneWxqDhV4z3VttTbRcRO6BHHeftvi0JuL0anvAohc/oNld8ECd99Oc1JB1ovdgZAiCAoJANIjX8+ZNJYLmXuzS/qZ9lnnSje4v4Z/b3Yjyt3yfjU/DSmFSbLYJfQDAM8bEz3VjUZbdfm26JjMl8KXx046Q7o5lyl/r+FLKauwrBPhxD5jDPg15A9YWBYUM/9fJh4q8tNMYS6F09lNUrikUmmuiwG0nBvNphq381LHcprw+0ZMIkXrdx99urwKCJme+7PNlR1nDvckGc+C93Q6fGzFGl8ErQKwZ2MYhD2SSlYutXeocFI991k0gTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vioOKn4YM8PuoygmAUyRiKj2p8KemXhB6/1/Lsdw6LI=;
 b=j9VOZHBnki522gX7emVEBv/Ujv49kaWP9b6g1Y+RGsDNnL8XeB1P1q7mZvcPMeBiOLmM3wrke7UFf1FCubFHvKlZLbgv7vPkXkP3glI91+RY5wfH8vYHI48iaOwcRosYru3223tYUErH2AgetGUZsRt3D1mCV8S1vuCMxLacee63Fuv0ps8lNu1v9RoU7vjOPhkpYED1MhV+Pv8EcvSZ9V5WFKxe19BU3XXr5JEGr7NWkvdCaLwwtN6Py+WITDKYWxmmoxqrD3go8WGPfr/ubgJbYP9Ou4K1JkHqv1JQNZTa8EqT1JZw+7Uy6uC0zNhfxmaChxMVBfwYz2XVeqGExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vioOKn4YM8PuoygmAUyRiKj2p8KemXhB6/1/Lsdw6LI=;
 b=R5P8i+STKVN69WKg1ch2bFqrNcffr4P1Y3EoT7Ndc7hYxVuIPjaUAgMOhmD8L1t1i6TT4qLuLFk6VgF9jEYg7srdTAh31R8yGOSLL1qID8vSG6xi3Aw8Sr8ijycJk9pRsleXgmVMG6nIhf5DlRxrHrLNoRWEyFgPI3S3dKRZK/qcEntWv64zoiz6U6pgYr7JXX9+smZJ8n6VLVIptPINMXwnE41JNfq1lJ7nrFHMM1ToYpZ1xS8xpCbjIhL2bwf513R0BQnWImq9JDHhh2tEdErUCGbmbUx3memZer6tQ0DdIiqWT/CAdIitl4+rUf+Lz0JHY0ik4Lg+gQD+1EGL1A==
Received: from AM6EUR05FT024.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::42) by
 AM6EUR05HT026.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::291)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 12:42:12 +0000
Received: from AM0PR06MB4514.eurprd06.prod.outlook.com
 (2a01:111:e400:fc11::41) by AM6EUR05FT024.mail.protection.outlook.com
 (2a01:111:e400:fc11::90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Fri, 29 May 2020 12:42:12 +0000
Received: from AM0PR06MB4514.eurprd06.prod.outlook.com
 ([fe80::98ea:ee00:4973:d472]) by AM0PR06MB4514.eurprd06.prod.outlook.com
 ([fe80::98ea:ee00:4973:d472%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 12:42:11 +0000
From: =?iso-8859-9?Q?Hakan_G=DCRB=DCZ?= <hakangurbuz.hg@hotmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Qemu Help
Thread-Topic: Qemu Help
Thread-Index: AQHWNbY7zGGTz2lcakuufE+tV0lq5A==
Date: Fri, 29 May 2020 12:42:11 +0000
Message-ID: <AM0PR06MB4514F5FD24459E9E2740A0078E8F0@AM0PR06MB4514.eurprd06.prod.outlook.com>
Accept-Language: tr-TR, en-US
Content-Language: tr-TR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:39DA2334B7BDE9F8A00BAA320A9A17CCB1B11959AB2CC9A695DB6ABBEF8B24B3;
 UpperCasedChecksum:D78EC92B90ABAF83D2E8859FC9C03194BE7C6BDCFEA4D0679951098C85B82555;
 SizeAsReceived:6663; Count:42
x-tmn: [NgNfsaWj2x+9ErsUgV2GjPBW5Y1z6hlG]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1a762e33-b5ae-4de7-e2d7-08d803cdb55a
x-ms-traffictypediagnostic: AM6EUR05HT026:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EXg7+XDCy8wu4oFzAJ81r9g0pMGVwqzKNOPBBAieCHKiihm+P6ezchWkhvdX9GQ14oiQvlBarqZE9gm7EWUKXGbxz/H9EDzlNHP7yjWd81ASizTKo+6NmiKAFOmdKZ5ftwiwpziwabwMsyOlarW0BrHRi9k/91u864VGwrhask28OmobhjCd6qA/3aDPWUcGudd0Zsv+CVo46viE1mnYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR06MB4514.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
x-ms-exchange-antispam-messagedata: Ju0Ga4pYnTdjS+JKqXeOuqMhtag/Bqa4eq2zzjUbHIUp2IrF5d76WszN611uToTDR8U0E6+AQZKEMsBh1vBNrKqOfvnmY0PNe3BD8QkNpjwruZ8cW37qWIHyTmRXc42YqgKxTpGZBA0FkDuClpyb5A==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM0PR06MB4514F5FD24459E9E2740A0078E8F0AM0PR06MB4514eurp_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a762e33-b5ae-4de7-e2d7-08d803cdb55a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 12:42:11.7857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT026
Received-SPF: pass client-ip=40.92.89.58;
 envelope-from=hakangurbuz.hg@hotmail.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 08:57:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 May 2020 09:20:11 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM0PR06MB4514F5FD24459E9E2740A0078E8F0AM0PR06MB4514eurp_
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

Is it possible to run the .elf file produced from non-Linux operating syste=
m kernel in Qemu?
I could not find a solution anywhere, please I am waiting for your help. Th=
e information you provide is very valuable for me.

--_000_AM0PR06MB4514F5FD24459E9E2740A0078E8F0AM0PR06MB4514eurp_
Content-Type: text/html; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
9">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>Is it possible to run the .elf file produced from non-Linux operating=
 system kernel in Qemu?<br>
</span><span>I could not find a solution anywhere, please I am waiting for =
your help. The information you provide is very valuable for me.</span><br>
</div>
</body>
</html>

--_000_AM0PR06MB4514F5FD24459E9E2740A0078E8F0AM0PR06MB4514eurp_--

