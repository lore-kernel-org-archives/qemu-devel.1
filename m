Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D68A21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ndYln2Fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D68A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziDR-0003zS-Ca
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iziAl-0002Bf-Oo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iziAk-0003zx-4K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:30:27 -0500
Received: from mail-vi1eur04on0731.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::731]:21262
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iziAj-0003qL-0S; Thu, 06 Feb 2020 09:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dydE0JjeJtWguBNk6Jyyir2vI2t0xSdiDsca2Fn2HyXM/J9yZrRVFciTnvuzdQvn5MGI3Vz3M/H3IJesaMg7TmxhdCMKaxJ1xIdQARrwUbCFVDl7W50Sqoa4ZoVSMehHmcvK8rWJtht8GtZ82ZXDmfTNeZB2gtFSDF0S5VDrCu7APvigtdEW8qIzb9fUGgx+bFnvmBZK/mjWZTXPFcTMNNqdi5yoilx2NBD2l0/tCzGAqYkF/VZ5Fkh8RXtt9KC2h2pzG3fNBo1qO897IR60BdLcSTN8xOinQOtAudXy84zVOX5pwqBXZa2x34k5+Y7yfjXs30Z8b7CY0WqDtcdhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gqeRQqMoudxsPhPs43cK7bp6Oi6x9HqyO5u5FgttSE=;
 b=j/igl76SW/MwWMsBU8tplx5ZSbtnm6MNmSMa8ClOY4eNt9nXBP78wVLBWSauEcqheMzkfijVtJeajLA4TpzMlRSvpiM88OpNAoIunF3ACFzEK8tfDhSu33NIP7NwmrFJ7gLRTQCLz/mvHJLC8FnJR7T0HtkKu7vj7n1mu6qJy3HCWQK3yWP6ADkifH8cafESbgrVxYD+Gf7gLKgXSUYyxCRMne1FRaRwSbSpe4sWY2I5DUUCGi8CAqnfdJGs0+7qDbxKxZQLZu5RO97oKv/26iRcDctByEhWJ8RbYnCX/mYVWzRWImGUm/bx4U2GnNW0JUgquArUIovv+s88iOkx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gqeRQqMoudxsPhPs43cK7bp6Oi6x9HqyO5u5FgttSE=;
 b=ndYln2FkfIlgi1zCXNTX9/ctCjkQKGA8SumfVDnsWYp2VdG2EuEmpmZRBt2jtVwqeNOjB2zf1w8losXHhVdkgnZIfi/Cm7l4WivP+DGfllHQ0H240AvqtcsDNcKQ/JDcXERO4tmAYTTxvrWIWe/KVX/shE/MQ8k1eOHE6oQAnmk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3941.eurprd08.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Thu, 6 Feb 2020 14:30:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 14:30:21 +0000
Subject: Re: [PATCH v11 0/2] docs: qcow2: introduce compression type feature
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <e84b1805-c0c0-eb74-8768-e4f6876117e0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200206173019505
Message-ID: <e9ba9f1d-3f0c-b3e6-1ced-14c2dca94d67@virtuozzo.com>
Date: Thu, 6 Feb 2020 17:30:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e84b1805-c0c0-eb74-8768-e4f6876117e0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0802CA0004.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0802CA0004.eurprd08.prod.outlook.com (2603:10a6:3:bd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 14:30:20 +0000
X-Tagtoolbar-Keys: D20200206173019505
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c806bde-983d-4feb-f704-08d7ab1118a4
X-MS-TrafficTypeDiagnostic: AM6PR08MB3941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39410005E9062FD03363D8BEC11D0@AM6PR08MB3941.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(39850400004)(366004)(396003)(189003)(199004)(8936002)(31686004)(81166006)(6486002)(52116002)(16526019)(186003)(2906002)(53546011)(81156014)(26005)(8676002)(4744005)(66946007)(107886003)(66476007)(66556008)(316002)(36756003)(16576012)(86362001)(31696002)(4326008)(5660300002)(956004)(2616005)(478600001)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3941;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg2hKpv+kX8eTikrEmzpPWVqTSFdWPcHm/kSBZNCmao3WwnQkquN/9++Umq1MIlht1kJXZKoAmk2C7JQZuHwNHdprXWPVUtwK47vfmtdob1X3A1/jOqLcLL7S0Fu96MAQvaWFWZqA6mMeVskKiCALdQKKMHiGx8wW00XLJfHQtE/9bIjgSiibv3dNhg780xR8mLLPfS40RNX/Q9cgXpDiQzQ9FMLGc/k7fESGm5sHlMiVXESp7tnYxYIjTXdZnmgEpnoqbj2TpKx9xaR0h8rjDxCt60MiwJcMbuLvfHP8KYiTS57efNA8MYmb9vWb529kt0XzMPQhre58xis4W5LMHeYPiitCzOCQyEAIx7Y9IR9qlnAzLpDwM/pWxCByWn52zGSYc23fjhyBvfavurL8C9U+Vc8YmsD5gWxeWYWgHb1raovTvGrNRD7fJXJxHPnMbKuC6qTEUxGbW5HjscNjzFk98dWZSrQRK5Lt6hzDkA7zWxhGSM8+6A+PBvj4FL1Fm93yVb3RdFOVD7zBCT4kA==
X-MS-Exchange-AntiSpam-MessageData: 91fw5lB0qMBFNdk3zLLgkJJUYZOxoeDNq98m43GJlEqYyxUiYxQYy7h2Up/4Vpc2KUX7s2n13de+2J7RFY9tCvF84fYZfuSOAi7pUjNpMXOQC7Wf98ztSw1s/CIk6+Djd28eBFxv4Vv9brBAPdT+nA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c806bde-983d-4feb-f704-08d7ab1118a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 14:30:21.3442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2X9EwH1sNJfx1/SKjLTZwTikr2031whzIYrZXLvftZ4m5m5OOiDquy4taGE+jjHywObn9yU9vm+SVWHmNfex08rNyBtgitkJdOxX3gKI9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3941
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::731
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.02.2020 16:51, Max Reitz wrote:
> On 31.01.20 15:22, Vladimir Sementsov-Ogievskiy wrote:
>> v11:
>> 01: grammar/wording [Eric]
>>      add Eric's r-b
>> 02: empty lines between paragraphs [Eric]
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    docs: improve qcow2 spec about extending image header
>>    docs: qcow2: introduce compression type feature
>>
>>   docs/interop/qcow2.txt | 62 ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 59 insertions(+), 3 deletions(-)
>=20
> Thanks, I=92ve fixed patch 1=92s commit message and applied the series to=
 my
> block branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20

Thanks!


--=20
Best regards,
Vladimir

