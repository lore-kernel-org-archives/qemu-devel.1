Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209092074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UopqBzEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209092074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jie8L-0000wJ-Dq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 09:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <feiphung@hotmail.com>)
 id 1jiTtU-0006D3-4K; Mon, 08 Jun 2020 22:21:40 -0400
Received: from mail-oln040092255053.outbound.protection.outlook.com
 ([40.92.255.53]:19288 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <feiphung@hotmail.com>)
 id 1jiTtS-0006b5-Md; Mon, 08 Jun 2020 22:21:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb/KxNalBYIAVLMD/8MhkCqkLt7NyeeVhGSlW5iA0KM8xCb16Q31XrTbv4Yxvk5s8y0wVEV2cRf1PnHb1kqXR+X8MF0y/spApfQInZcJQi48c9v3QCO4mYWXG4TLLVC+Xf1t4MIPOEHpUnxLuizeogjGFTIPz1g16YMTcORdoFoIcNOaARSVTgoCIfHiJ41ymPKwAmeo2HVZq/aj+q9mPAA9ChSIqHHITylf+LIrGsiVTLUNdypqNUTn+lHWTUPV5eNFdEYGgw3aXhgvYMwqhSxtgpKLjKXpdDvlwohY7HK6GzBwEWQ1FVJ0mSUKVnAhkO7+JUVSe/cuo4TGvrPV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzQ4gTPM/pRL5vhZGZEckV2y7Bd8S+LeQnYAGHnIgo0=;
 b=LEXu3Gu2lt0e9LGj1cql/UJJy3551jp75v2q1ZcbKr5GvmKQEaBuYgNr3l48uOYqzVl7WHXNLQQD7PwQByskLfVQIA1TYMHnx4QrmCQ31DVjeP0qkhZLRhYYcv6wfgV6B647qogj9mygS5HrgQdm7XDsC+bjszC7FmrbhZSlSw7B/+Irx2nkVcdQ5gxx6y+DCO7I1if20yaiK8vzjHzyRzuoEFkI/ZumS56W9mxWBOaVFoYofpznb02Dd+rDNPCDP0WUfCc/sjjS3MrC3TEKsXf68oqBoN88eJT7JCps6GQejBuBANWwo9ctLh0bOcM3/3QylrQykK0Y++FE+yPB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzQ4gTPM/pRL5vhZGZEckV2y7Bd8S+LeQnYAGHnIgo0=;
 b=UopqBzEZZTMwULv7A24HOMOnqS+a3B3a+5cIkCC7wj3hM5A0SwwDeFlUw2IXM8G9Hc+ZhRdLAMZdqqH9hBl1WJz/A5dTc1Zr2V/eG+rCyz4b50jv0s72Ybrqe9C/W6hU0pDvumd/D43LDHA2B8wM8RvVksKXJXrnREpWkPjvMh6VE6MiekgW3pbJdq/iOB77TCAtVAFT5Dd0OoLofwDmpGKe6fxbk6OWxFn3gKMKVTVEDjKOv5Yp2f7LlSFYe3kDbe/2SIwEq2ZmszAYzVmfcGK8/iNlExXmsBDWsMUQHKygvKtTFPhv4jyA7aNnGfsCzEKUwBr5Sc5/BYJof9jQvw==
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::4b) by
 PU1APC01HT216.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::422)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 02:21:33 +0000
Received: from SG2PR01MB2346.apcprd01.prod.exchangelabs.com
 (2a01:111:e400:7ebe::52) by PU1APC01FT018.mail.protection.outlook.com
 (2a01:111:e400:7ebe::445) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 9 Jun 2020 02:21:33 +0000
Received: from SG2PR01MB2346.apcprd01.prod.exchangelabs.com
 ([fe80::31cd:14e2:fd56:5333]) by SG2PR01MB2346.apcprd01.prod.exchangelabs.com
 ([fe80::31cd:14e2:fd56:5333%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 02:21:33 +0000
From: Cheng Fei Phung <feiphung@hotmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: adding netfilter_queue to kernel config for qemu
Thread-Topic: adding netfilter_queue to kernel config for qemu
Thread-Index: AQHWPbMWPJYA2r6UdkmRXAX1mLhRXajPjb5B
Date: Tue, 9 Jun 2020 02:21:33 +0000
Message-ID: <SG2PR01MB234644CA7B7DDCB2B8936E1FC1820@SG2PR01MB2346.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB23461DD322E88DD891E9DB2BC1850@SG2PR01MB2346.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SG2PR01MB23461DD322E88DD891E9DB2BC1850@SG2PR01MB2346.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:55BCF7AF3B498CB52BA5F58FC36C9B5624560C1A54C63BA38363A8C0CE0C3228;
 UpperCasedChecksum:C0A4E7A6A3F1FDE55AE81509C6286ECC1F67BF757671CFBF1F140BBD5C4B9449;
 SizeAsReceived:7020; Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [vPzPnFWg3j/E5IHmv2ptUYnYew1wW9rv]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f829a65f-c448-49fa-a174-08d80c1bd3f5
x-ms-traffictypediagnostic: PU1APC01HT216:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAVQfoxznGIl4p3ahoiaOlWFGTC7udEnmy5CLz9pjdahg5zl2clb9jwilLL3YnL8Xi3g6cRP5szA6cptkvfiCVvw7oK++S5XhILvtGz4k88bbcGJoBpM9inGRsLIT3wznUv5rU4lbD5jffob3ls3hojQIdx7QsrLWyn5XfmbPbpyjMahPaBHN9YqG5vj52yAd1c59T6uAbwyaYdWUnefDawj/LgCaj5G0UY9MJHEiaOyg3OyycEJzLCKfNo8oVqT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR01MB2346.apcprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE; SFTY:; SFS:; DIR:OUT; SFP:1901; 
x-ms-exchange-antispam-messagedata: qzFsr9naROuF/KUagzjzHle8Np8ZjElsKGS1sdgwN2hyjvUEtp24l9Q7wy1hbKJJj3375vQIc5FDE739M87WX4ODH2f223jNk0TeYoDSanrIzZdlpqhgrjK0UCqOkIN1oR4n4MB5ez9A7byDuz4fBA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_SG2PR01MB234644CA7B7DDCB2B8936E1FC1820SG2PR01MB2346apcp_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f829a65f-c448-49fa-a174-08d80c1bd3f5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 02:21:33.2475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT216
Received-SPF: pass client-ip=40.92.255.53; envelope-from=feiphung@hotmail.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 22:21:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2020 09:16:32 -0400
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_SG2PR01MB234644CA7B7DDCB2B8936E1FC1820SG2PR01MB2346apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

Could anyone help with https://github.com/OP-TEE/optee_os/issues/3902#issue=
comment-638151200 ?


--_000_SG2PR01MB234644CA7B7DDCB2B8936E1FC1820SG2PR01MB2346apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
Hi</div>
<div>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
Could anyone help with <a href=3D"https://github.com/OP-TEE/optee_os/issues=
/3902#issuecomment-638151200" id=3D"LPlnk770618">
https://github.com/OP-TEE/optee_os/issues/3902#issuecomment-638151200</a> ?=
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
</div>
</div>
</body>
</html>

--_000_SG2PR01MB234644CA7B7DDCB2B8936E1FC1820SG2PR01MB2346apcp_--

