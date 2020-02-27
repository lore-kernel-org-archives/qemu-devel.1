Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EEC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D422469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QzbioZvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D422469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7J48-0003Vt-7P
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7J3L-0002xU-9h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7J3K-0001tu-4F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:18:11 -0500
Received: from mail-am5eur02on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::72a]:17643
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7J3G-0001op-Kq; Thu, 27 Feb 2020 08:18:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWFEtZuzA8OjzEOF7VcGZhJrQuMpWkF2VbQxmP/JBGMfb8Qxieuf3T6GqnMK5V4etj8ESmr8aJy6Ng34kNqCDUjtktgHIBv37AJav6ws31vbXTXGRM0dEI5BM5nHg82XnGomazZebZnkPLu1cLQSawbsLIyQDg4gfQlugylDf+tiqGChWU/HuAG0eMfljbxyt3lh6ouFiZaMLpI1Z4YZRX1SfXeeiu79r3wJrXtw/+Wnk2DGNOnxfSdF5OK6q7+qN+oo3LxSmHhnnoJUyAyWsQ8HnxCqLx+KVFsbPW2Z2IiQiKUkEbbBxYqEeeUTdczJ7nUQO+uY5jMjnDLcgXMDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74nszkwrkvnW69BKksAKMbtNjkghCOTDZukV8QSS3bI=;
 b=MFkcQ6nhwNCtxLy+kNqwtgpVhL6r29LTDSC98NK69RaBhcLuKetMGlgDQ3CZlMmyXQ15DJOiZdwQh50bloy2Hi3VUDX8JjLdkC/cj1NZDWtXAy064AzmTewKtr5YVKnHb2foexfN2vpKmuAYzOJfgpHnTrkNMZN5J/EfbJxe2x0P3wWor5pqo9+KZxV36bmopWiDgtIDHQLUkhgrybJC+THbQe4EtTPfNRiWCbByrqbMulGi+J3ETBelAhF0dWVGwo5jKjXomQB5J6gdVpVqEsPFL73FQdWYWXpmDhiyVt5rOYNSyirJrtLG2R5uLNlRMtuO4qHW1ZGuMScxY6UzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74nszkwrkvnW69BKksAKMbtNjkghCOTDZukV8QSS3bI=;
 b=QzbioZvzAACKYLCSA+oSVay6TAfYr3MADgU4nWC/XpS1KT94bLt7pbk9PauPT+Lzz8OPkj5SxkVAyhOHmebRUMRhXx8vabxGsRKi6KfujWzX/mNLsjQZSrP4nbHWQ9SpOxz1lrUYNWhZn5kbWieJF/sHZYoXQlC54AvjhNXkN0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3565.eurprd08.prod.outlook.com (20.177.61.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 13:18:04 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 13:18:03 +0000
Subject: Re: ping Re: [PATCH for-5.0 v2 0/3] benchmark util
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
 <e1efd3d2-b623-292b-67a9-e3cdd479f104@virtuozzo.com>
 <fca8ced2-b3c6-74db-0d70-11ac3304b273@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227161800346
Message-ID: <1ae79aad-5405-cf95-1401-e93191e94033@virtuozzo.com>
Date: Thu, 27 Feb 2020 16:18:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <fca8ced2-b3c6-74db-0d70-11ac3304b273@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0202CA0046.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::32) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0046.eurprd02.prod.outlook.com (2603:10a6:3:e4::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 13:18:02 +0000
X-Tagtoolbar-Keys: D20200227161800346
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a46aa595-1b0b-42dc-c6ed-08d7bb8779ca
X-MS-TrafficTypeDiagnostic: VI1PR08MB3565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB356518501017180FAC4FFB3AC1EB0@VI1PR08MB3565.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(52116002)(86362001)(66476007)(16526019)(6486002)(4326008)(31696002)(31686004)(66556008)(26005)(66946007)(186003)(5660300002)(956004)(8676002)(81156014)(81166006)(8936002)(2906002)(36756003)(2616005)(16576012)(478600001)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3565;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0m5gzb7CKv/y+vLl0QCqqEVOz9rE4lmkDEOuKFLYE+akq0gKBs1L0irAZWSK9CMYy57k+BDglxkWI0HtOQGH9K6lKoLHoqqiW4Diu0pR9Kv3NxFWnoZfPdZBtBzkvO7aBpswIuOPZSKPvbE3jXMuMBEAW02zjbphHtB4M32F+8g/wBQLQcz5GxtEG+XVBtfe2nH/OLuaC1M2GK6OdbC/WJX4ZemiDk0b19x8F89RVczFUU0PLy+2YUEDPQlBa1U/v3pii/ocZWZLLXRGOf/GNcVJ1gRWIkcZhgAXJQv8F3hBDDTNPbMK+K8xvq9giBN+SQbC1jquVkltGIWtPwW+aRwQQRNLavSfmZjWqoejtfGmImx/ReqwoAT2lLi1HKfTRAkG/5ma0EZ4wF/+Z3qx2T7HA5Z3YyteXOAnVY98OAm1EPVl7MTyRJp/Ilfjmkqu
X-MS-Exchange-AntiSpam-MessageData: zjz9qn7YP4RDvGq8CgkIK5rOhiUaXiBmP8XDK7/nAvsIDb2FO/TlotTcStCTCNvI0QKp845B6lBrbCd9xa3jhH08rHNVpZY1+1QOpem7oK/Z5pIO/SWnC1DNTnsHyviPs9RPRcoymUSdDR9pYRX0Lg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46aa595-1b0b-42dc-c6ed-08d7bb8779ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 13:18:03.6274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHkHWB2RxMCajUr0PB3sWgDfN2GXGLlos038osKK9wSICO6w65e3qPUwD6QccH619xYPD4pmm51ez6p+zkzm+DwYyXZ3Rst89O1b9r6z0q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3565
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::72a
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, stefanha@gmail.com,
 mreitz@redhat.com, crosa@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Is problem in "S: Odd fixes" in Python section of MAINTAINERS?

Will it be correct, if I send a patch to MAINTAINERS, proposing
myself as maintainer of Python scripts and s/Odd fixes/Maintained/ ?

And then just send pull request with this series, as "nobody minds"?

08.02.2020 13:36, Vladimir Sementsov-Ogievskiy wrote:
> pingg..
>=20
> Hi! Could it be merged at all?
>=20
> 20.01.2020 12:10, Vladimir Sementsov-Ogievskiy wrote:
>> ping
>>
>> 26.11.2019 18:48, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here is simple benchmarking utility, to generate performance
>>> comparison tables, like the following:
>>>
>>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 -------------
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 backup-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup-2=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mirror
>>> ssd -> ssd=C2=A0 0.43 +- 0.00=C2=A0=C2=A0 4.48 +- 0.06=C2=A0=C2=A0 4.38=
 +- 0.02
>>> ssd -> hdd=C2=A0 10.60 +- 0.08=C2=A0 10.69 +- 0.18=C2=A0 10.57 +- 0.05
>>> ssd -> nbd=C2=A0 33.81 +- 0.37=C2=A0 10.67 +- 0.17=C2=A0 10.07 +- 0.07
>>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 -------------
>>>
>>> This is a v2, as v1 was inside
>>> =C2=A0 "[RFC 00/24] backup performance: block_status + async"
>>>
>>> I'll use this benchmark in other series, hope someone
>>> will like it.
>>>
>>> Vladimir Sementsov-Ogievskiy (3):
>>> =C2=A0=C2=A0 python: add simplebench.py
>>> =C2=A0=C2=A0 python: add qemu/bench_block_job.py
>>> =C2=A0=C2=A0 python: add example usage of simplebench
>>>
>>> =C2=A0 python/bench-example.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 80 +++++++++++++++++++++
>>> =C2=A0 python/qemu/bench_block_job.py | 115 +++++++++++++++++++++++++++=
++
>>> =C2=A0 python/simplebench.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 128 +++++++++++++++++++++++++++++++++
>>> =C2=A0 3 files changed, 323 insertions(+)
>>> =C2=A0 create mode 100644 python/bench-example.py
>>> =C2=A0 create mode 100755 python/qemu/bench_block_job.py
>>> =C2=A0 create mode 100644 python/simplebench.py
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

