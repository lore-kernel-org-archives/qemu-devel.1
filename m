Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E6C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8EE20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MaSwJKuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8EE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPyU-0007TO-Uq
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 14:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOPxR-0006x8-NB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOPxQ-00006J-Lt
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:06:49 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:47201 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOPxM-0008Fg-Dv; Tue, 14 Apr 2020 14:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRbTBeD5Z2QAMOwl7ouDUpdFUQ877BFM9HcaHg0lSlHtSrr5uNvpUHvbSeW/5StSgqWfxuCe9F0x7mJXU8dXkd145t1Yt2U0+SJ7N8qQxS099jzE2cBpruZEe+Cyl+GLjDSLu5UV23CE4HY2tKbkFuBkGpdEJBRQ7FhlPSv//cJ2N0oYM4LBTfgyImZhRamFc35GdmwCln8rOz8yiMxUKiEZlemNN/BxA5fEkuXncRq+5/L04ewRVWUDfhK2XpGnEzLuh8ckm+seSyCI4kxGZhzqpQuhgnyY1dcWEwZB7Ltv3EkL85eg8uVFP6FBOw/lrIazuSKcXkAxIVEQtGZvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWl3IODnEYqNL0GEHm+nZcRNfLUpKZQugMaUcVi3qZM=;
 b=c5m9/gTj/ZC9JXnCfRDsfrCjAgjiYUAllk1tcPa5Od1r3i2AwKKrQj8dYeUIc6GiJqZM+C/V3jg5kfCGFCasyELd8YsY/v+S8YGDxyV7q6nkWne/lTFlRgJawwXD+83QrOU2L4jxhxWEZT2rsCY61hg3TYrNcuubzaD8hP3cwQDiPjEw4vH9tU0OyxxMdDHQxdQXorg1qwbxGQy3LqdlQGT0OBWCnYHgTW2duOfW1cxP6xd5y/WhgnEW+cJ0FxhF0Rv4xE8TmENhNopzYMA8M5oMAb10XOImhs2JZS9CwGN2MiLIVWdhJcGQkgChX6cFhmnjm3MLLTxPIPVmhxZRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWl3IODnEYqNL0GEHm+nZcRNfLUpKZQugMaUcVi3qZM=;
 b=MaSwJKuUMwaGC5S7kJ3QFGYQBfTql/alQvsxMIA4Qz/USoT37P67gaArvoOwN0TmZQHRfED8OKeB/WgF4Qs0lo/tOfrf6WoDmRenOb0XiwhjCmz46Op8kQ1BxCN7RLdVWRpuvzYuhgTcrKB3r92mqLYylfE2gP7TdphoRZKPID8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 18:06:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 18:06:40 +0000
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
 <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
 <w51o8ru5dg2.fsf@maestria.local.igalia.com>
 <83922517-b5f5-2d4a-6518-c1912942ad27@virtuozzo.com>
 <w51lfmyrpvq.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414210638593
Message-ID: <094350fe-736a-d566-7dd7-716fd87eee81@virtuozzo.com>
Date: Tue, 14 Apr 2020 21:06:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51lfmyrpvq.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0103.eurprd07.prod.outlook.com
 (2603:10a6:207:7::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM3PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:207:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Tue, 14 Apr 2020 18:06:39 +0000
X-Tagtoolbar-Keys: D20200414210638593
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6465b7b2-fa3c-401d-a2bd-08d7e09e94f2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB543047FF4F963B177EC6349CC1DA0@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(39840400004)(136003)(376002)(396003)(346002)(956004)(54906003)(31696002)(26005)(2906002)(2616005)(186003)(31686004)(478600001)(110136005)(16526019)(86362001)(66476007)(8936002)(52116002)(16576012)(4326008)(66946007)(316002)(81156014)(36756003)(8676002)(66556008)(5660300002)(107886003)(6486002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqJhkSKWjz7lgrAqIMqJcPHDm7UYt3Zfu27vYzIQlEFfIxxSpB+YpRUesjoolheKyAI5ZHvYLwvoqKur9MnU74HxmQ3mVMedocFyDAHfU8l/zDSLv+zzhKSK7UeCRnNv+NTX/kZ0qauxb05gRUKx1Kdus+NVDTGUS4KHRaeZ7Goav95p6g+JjAf+4m/D12EovPwBe5KmCtAuXqWkrkUCYCtdMaMcEseU3KgxKNJ9pXnToin/ZVf8HOsLAhcmbJStx1H2RY/xmXsjr5lwFuLjjRrBtjZCzQTxcVG6to/eOb0VFvoevPe9R/ailDDQPDsH2KuNDvVa19LaTpW3kpa6F59TkWlLOb0ycBcF58IKSj+CvYwft+g3Kqabtctbmtfo9C3M0y6TYqqokvQai6UjvibeSzGxq8GuY19SnWcbtQj6eJ09Ec3iZWGBatU0zgqB
X-MS-Exchange-AntiSpam-MessageData: PxYJJo0RzgNCOEpgLaJLUttHqAGSKwLkL3YaeMH4H+CYuZAmHyzMbgG1nWLLY7FHqglNIjMSN6WSwl7okP4I//ZfMJ0+z5f9F8FCAwYaeW4tf7b+U03P5jXldANv0Eg9M3066/5qhyoSziXv/zp80g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6465b7b2-fa3c-401d-a2bd-08d7e09e94f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 18:06:40.5793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THIo4GKZXtXEYL7VN6STw9Y0BQdacGJdgw+yVGvbnsnYENXaF5SDUtpnXhKM2vydKF+rOSoueZWYRr4YVdCTAzgTgFcDmylA8zyvC8D12Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.118
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.04.2020 19:30, Alberto Garcia wrote:
> On Tue 14 Apr 2020 06:19:18 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>> It still may cache information about zeroed subclusters: gives more
>>>> detailed block-status. But we should mention somehow external
>>>> files. Hm. not only for raw external files, but it is documented that
>>>> cluster can't be unallocated when an external data file is used.
>>>
>>> What do you mean by "cluster can't be unallocated" ?
>>
>> I mean this sentence from qcow2.txt:
>>
>>                      "The offset may only be 0 with
>>                       bit 63 set (indicating a host cluster offset of 0) when an
>>                       external data file is used."
>>
>> In other words, cluster can't be unallocated with data file in use.
> 
> I still don't follow... clusters can be unallocated, and when you create
> a new image they are indeed unallocated.

with external data file? Than we probably need to fix spec..

unallocated mean that offset is 0, and bit 63 is unset. But this can't be when and exernal data file is used, accordingly to the spec.

Or what am I missing?

-- 
Best regards,
Vladimir

