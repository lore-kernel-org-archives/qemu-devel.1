Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC44C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64F9214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qKWzRUKG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i05S9Ys7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64F9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06eX-0007J1-Eu
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Dave.Martin@arm.com>) id 1i06YK-0001oC-8p
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1i06YG-0006E4-3r
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:00:06 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com
 ([40.107.6.46]:13998 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Dave.Martin@arm.com>)
 id 1i06YF-0006AH-Pp; Tue, 20 Aug 2019 12:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsCeDAVbIoKbmJDBpdZti2ph5SwkFPEKentqQFAdU+o=;
 b=qKWzRUKGRHJ5ybzBmNv/pqL6a74y+YlKj2FUQ1koCM1ZRM+gYLJ6iVXW3mu9J2md+BFrPMjbLnPCz9JtERAgHu54tGTU22HfmoQ+yl1+cT3v8zltSqhjooMtxGDIOOvGPuOZaeBHPEYWB0cXoD6Jb+BH83j0t6avUiJ3zqd7OHo=
Received: from VI1PR08CA0231.eurprd08.prod.outlook.com (2603:10a6:802:15::40)
 by AM5PR0802MB2593.eurprd08.prod.outlook.com (2603:10a6:203:94::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Tue, 20 Aug
 2019 15:59:59 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0231.outlook.office365.com
 (2603:10a6:802:15::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Tue, 20 Aug 2019 15:59:59 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; nongnu.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;nongnu.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Tue, 20 Aug 2019 15:59:58 +0000
Received: ("Tessian outbound 220137ab7b0b:v26");
 Tue, 20 Aug 2019 15:59:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 503f4617b5acf5aa
X-CR-MTA-TID: 64aa7808
Received: from 102d090bd368.1 (cr-mta-lb-1.cr-mta-net [104.47.9.51])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 4069AB46-BCFA-466B-B714-E8920F25550C.1; 
 Tue, 20 Aug 2019 15:59:52 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 102d090bd368.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
 Tue, 20 Aug 2019 15:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivFsd62YCWcibuufTWQGuQKOiUlzRDOn7gcmqPrD7JoMjRfP37/tZSig4HX0IAtrXfRNu98KwGG9eWY8oqaaUF1qFYx4etnFHmrPfjVjh7aooRzbjC1l8hhVUQA41N28JrbGyRGVqieK8le1zdMdikfMi90Ee7p9BGCivJij+g61Rdtbvcmtfx8Hvwj0SwlFbzSR+AG5XDXTU3bRQt+UqzTC++ZoUuTbmsL40mFRGONpjNEE1Z/U9S0+T5jRRK6iAwTIQ4hnDdgP3psQgBLtJdY34JlpqimPD5D0TlQMCgKIahqA4QRofXp4dJG4QKjGE/GjW+GPDR0KD8xn8MHoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEp9Y2eHjpiXugIbkgtahQsu0lSImHYnTTH2iJTPArE=;
 b=Cef57ARCcyjvC1s/qqPfe0BzojompdrhBQo1lu7QjUbsFGdqKk68ZdRMjYUByp8PAdn/uOEQ4AbMNtMKfoHkKmNp/Ft3BincXQ2FoU3/+00wx4tvmuVcH3T4WNXiprJDlIBLjwqOzE+SVCuUrRIqqsaUoLa9vHW7G8NgXnUpwilVvK9dcz1bUmGYCu5Rru/4PF3t86QqpSn7EQ4mofWf+OfLW/tM2SzdO4VdlGeWDRGpGHC+uCjphP6/N7pO7SJAU+wxhLh5ZHOVr9LZh5UKmO0gTTqkSXSMb27+6HmRW9OqbytvDs3scDewmTlxoRvj5rgziCrgvXdBf6lZimmzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEp9Y2eHjpiXugIbkgtahQsu0lSImHYnTTH2iJTPArE=;
 b=i05S9Ys7egecEJGr0twbhwsNXej3o7IP2JCmlyFmGnZPmBvq9fCbQzSH9OOHrxJh2a8d1dGnUXPosSh11Mw/XcaaF/Od6JzCuffTMoOkfVZz4rduXBUXhhoCY3sgyKklzqJ8VxldN7h9LmC6qI9CvH+ENWMXZg25PYpJ4GEyNR8=
Received: from AM0PR08MB5379.eurprd08.prod.outlook.com (52.132.213.13) by
 AM0PR08MB3556.eurprd08.prod.outlook.com (20.177.110.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:59:51 +0000
Received: from AM0PR08MB5379.eurprd08.prod.outlook.com
 ([fe80::54da:b409:a1af:2392]) by AM0PR08MB5379.eurprd08.prod.outlook.com
 ([fe80::54da:b409:a1af:2392%2]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 15:59:51 +0000
From: Dave P Martin <Dave.Martin@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [PATCH v7 4/6] include/elf: Add defines related to GNU property
 notes for AArch64
Thread-Index: AQHVSj+T+V3QkS1UA0Kt8m7gRHN496cERkeAgAAF0IA=
Date: Tue, 20 Aug 2019 15:59:51 +0000
Message-ID: <20190820155949.GB20949@e103592.cambridge.arm.com>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-5-richard.henderson@linaro.org>
 <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
In-Reply-To: <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::30) To AM0PR08MB5379.eurprd08.prod.outlook.com
 (2603:10a6:208:181::13)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 357ee966-219e-4a1f-c981-08d725877354
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3556; 
X-MS-TrafficTypeDiagnostic: AM0PR08MB3556:|AM5PR0802MB2593:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2593DDDC9826AAFA88387B47FEAB0@AM5PR0802MB2593.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 013568035E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(66066001)(71190400001)(71200400001)(478600001)(99286004)(6916009)(256004)(14454004)(52116002)(33656002)(966005)(1076003)(25786009)(54906003)(4326008)(5660300002)(229853002)(58126008)(4744005)(316002)(6436002)(86362001)(6486002)(81166006)(66556008)(66476007)(64756008)(66446008)(305945005)(53936002)(486006)(6306002)(2906002)(6506007)(76176011)(7736002)(102836004)(6512007)(66946007)(6246003)(386003)(8936002)(446003)(81156014)(186003)(8676002)(26005)(11346002)(476003)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR08MB3556;
 H:AM0PR08MB5379.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 8huHkHMwAv238V2RIOzYM69/N8K1MJ9/L/sF019JqPndBM94ccK3I6lLMr1KxtBbtYZKK6VBhBvvx4ZLbs+IqhT7WrZMRhOgnGohX6pDJnx/DzmmgNQgdswSYiR1FeudVhwNUqCoWeLbfBGyItsb1Os70k4lD0z/jckubw68L5bBdsk6BQoFXhM350nzlNqAoXjfYoDjPAB9eecC8AxfwM/UkZd3+28msOMPsMXWudkdAM9m2eriz0qOgLYZo3nDMQGc42CJlwPrJAlFClCr17O1HL3u8pPvaUNxBPbxTnW2DyBXvluvmjzGXU7L5otzH6voAPitYxI2Rp4Ll4MZnjDlBVtusbvt1DRKFFLNQl279lMcrBKS655v9u1RgaVGEmUDPjb8aV6t8T2hrL/dOL0neqoCHiYSVHPPiu1Cono=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <649227F448A7B24FAD63EB85A8165C9D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3556
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123; IPV:CAL; SCL:-1; CTRY:IE;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(40434004)(199004)(189003)(76130400001)(8676002)(356004)(81166006)(70586007)(229853002)(70206006)(81156014)(23756003)(86362001)(33656002)(6246003)(1076003)(107886003)(8746002)(66066001)(5660300002)(47776003)(8936002)(5024004)(14444005)(99286004)(6306002)(6486002)(6512007)(6862004)(11346002)(186003)(63370400001)(336012)(3846002)(450100002)(6116002)(446003)(316002)(126002)(26005)(386003)(54906003)(36906005)(63350400001)(26826003)(476003)(4326008)(305945005)(6506007)(486006)(2906002)(50466002)(14454004)(7736002)(76176011)(966005)(58126008)(22756006)(478600001)(25786009)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0802MB2593;
 H:64aa7808-outbound-1.mta.getcheckrecipient.com; FPR:; SPF:TempError; LANG:en;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; A:1; MX:1; 
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b7c4e86-333f-49b2-9dd8-08d725876f00
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM5PR0802MB2593; 
X-Forefront-PRVS: 013568035E
X-Microsoft-Antispam-Message-Info: JzPD8SnVH6qDQqmkSA9OioJgo353/17MWGhr16uwgrRYtZwqFr/2fca1Y6qCP3KGYlu6zBeUw7axfxCXJlkketzZv3LozxOj79dXU8B/S3c0mrbSG1sJsUnCahMKFgKOqHja3dj8yV6mVDt0uYWpTUxJmNgBLvq/Ac7x7MhtrJ2IceSlt6pYTSaQTl+mV1ffmMghqdZe6rIGNNdpAYkaA9mOfsP4md71PpTxlME/l/0dGtMsU6b9L5LixcJg5+hZz7szZJCD+y+/8GPlYb4Xse596r1tIYixYwGvOp6o1vcn9QtfT+FbiwnBkDh/8LW0IXAEUGKadngtRS5spSZrXryDBm7Xg6Pb/oZmHpsnhUz7inRcJwqLjPx6PWVuNsOpw6aghAt1mFEZOWM19fxvonqlJNwQt5NTLTUvL2l+i2A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2019 15:59:58.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ee966-219e-4a1f-c981-08d725877354
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2593
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.46
Subject: Re: [Qemu-devel] [PATCH v7 4/6] include/elf: Add defines related to
 GNU property notes for AArch64
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
Cc: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 04:39:01PM +0100, Peter Maydell wrote:
> On Sat, 3 Aug 2019 at 22:08, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > These are all of the defines required to parse
> > GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
> > Other missing defines related to other GNU program headers
> > and notes are elided for now.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> What's the authoritative source for these definitions? I
> tried looking in glibc, binutils and the kernel without
> any luck.

For the kernel, additions to the user elf.h are still under
discussion. [3]

For the relevant draft ELF/ABI specs, see [1], [2].

Cheers
---Dave


[1] https://github.com/hjl-tools/linux-abi/wiki/linux-abi-draft.pdf
[2] https://github.com/hjl-tools/x86-psABI/wiki/x86-64-psABI-draft.pdf

[3] [PATCH v8 22/27] binfmt_elf: Extract .note.gnu.property from an ELF fil=
e
https://lore.kernel.org/lkml/20190813205225.12032-23-yu-cheng.yu@intel.com/
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

