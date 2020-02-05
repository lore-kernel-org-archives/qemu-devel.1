Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BBDC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146F020702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q8fX1lqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146F020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKyX-0000h1-A2
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izKxi-0008Rm-9k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izKxg-0007PX-Pq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:43:25 -0500
Received: from mail-eopbgr10120.outbound.protection.outlook.com
 ([40.107.1.120]:41036 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izKxg-0007I3-18; Wed, 05 Feb 2020 08:43:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcMphGt9XpxLGbpbmQfOINw+xjSQJdjfWQqTIxxs0uvq0Ehb03Xt0s5tJ+6sZi9ufrjUIbyiXOX06WVJTrA95XRufgewJL1/v90eVjRysqjrJjdd0EAh1NoynIKyW6KWUEHbyd4WVCUPsDDtCUsazPa0capFwEX+jF8kIYNexELQtLk7mz6ljtWL0DOYAsbRDzOX9/Ui/pp4Oyn7DUA7UzmgAY1FiXUYBZnvyL8jaxSHFyKUoTuTuIRZCCKI66hQOC/E/V+HbkZyuDuViyiYl8b0Km9j7QkDf7zW4QSbiV30FQONcakYJzRp/+/hzzhLNRd7ubl7XuTHgo3K0DJLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgOkP49fAIzdUVoznSM+edkYuZYNuCAreL3sM0Ardyc=;
 b=FYgSGj8cWvird2oJw4TyBSTCc7fp4wRlRvUKokcA3DLx93Nxu+xC2xKdwdBtDhczW2tYFxEqEOsRELuNkAIYQOEoVvywACoj+rzXhPSAV8Ackx7sLEKX3lr/SZoKfnpP8XGaT2tgZwiR83mQZ53DkE0KTWZsBTsf2ylxsYCbigqCYsDW2udx9MIYVVEMvE3gz58P6rdQHAFAfpB7ouoRPorzVBNpNL2JBPCIR8TAd1ZubbBj3LkLX1sK6HVSjXrkxHESqj5hXQCoj9qx69Z3gwNCXgI5GYQxgaxHWjZdaJrETjk8BM6pTUGjfOlHGz/SZazWtWt5nTcxxzSRhJxQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgOkP49fAIzdUVoznSM+edkYuZYNuCAreL3sM0Ardyc=;
 b=Q8fX1lqt5ckBZzJWvBp9c4+/lv3TzJ9N+eedOck7D0F3wxaM6Pi0mdwW3BS6+6DV9XdXDmReq5k77uuCTbfudug1DyVJT/PCwUGT+cZ9XYAERpeoV8NQiqUuD3aS6myABk62PcsG9Ff22hitQzR0JEQCGCZxGmTGRmdyT5ATJak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3789.eurprd08.prod.outlook.com (20.178.15.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 13:43:20 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 13:43:20 +0000
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191210174644.GC7103@linux.fritz.box>
 <eed0efba-aa38-4901-8f10-6ec3ee339437@virtuozzo.com>
 <20191219101312.GD5230@linux.fritz.box>
 <8a7cd617-6d34-8735-45a7-52431db1171c@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205164317167
Message-ID: <28b8f2b6-5520-10ce-cfb2-0ecdd7aee7aa@virtuozzo.com>
Date: Wed, 5 Feb 2020 16:43:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8a7cd617-6d34-8735-45a7-52431db1171c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::27) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 13:43:19 +0000
X-Tagtoolbar-Keys: D20200205164317167
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76809057-67ac-410e-93a3-08d7aa415c85
X-MS-TrafficTypeDiagnostic: VI1PR08MB3789:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3789F2C59ADDB83905D2944EC1020@VI1PR08MB3789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39850400004)(199004)(189003)(478600001)(6916009)(36756003)(8936002)(86362001)(31696002)(2616005)(956004)(81166006)(16526019)(4326008)(26005)(186003)(16576012)(316002)(54906003)(52116002)(31686004)(8676002)(81156014)(66946007)(6486002)(66476007)(66556008)(5660300002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3789;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvMpn5oIafbf4mJOpD0+g5eNs7DSHM6CEcP566RV6DtEYL1Dj7sJenRNVKr60DsQVczgGIEq1YXPrQTdov/mjmgOnaMceBaeg5FjEwz0pWcz3rMKf5fSaZa5xPnu9dOAw15JDhNbY3Yi7LaZsKViomYeGY07Xxab1yk5LOOiuccEd7TjNNrz4Th7+fbIayrkq0b6FMGr2wSfqlNvV42RFQU0ClIzEXzVvS+psKr1ueoYuNlT6m4zPxl0UkT+uEvmvSqyU8MjfdcT3BeEVyfGbF3ZCm+cxZV7yYMvK0keqL3E0/GvniFs6QCb3iOUS27Rsu9iH2Ri5VOpzOBpXUUjyi78B9FyNFxyuuJyXVRREYwZlS5f0wixwIN9nWOGqwyySC/Tk3w7XiaJrZSI86xEfd1wpKzNbjiGjEopoaxHRi4yjSyEeB4JPfti7+zWaus5
X-MS-Exchange-AntiSpam-MessageData: sAsWQ0JZ+jqWnCkggV41z1zO1bAkN+LgQC+6XFwoehtd5K+/Fru5wyG2HktDgv4F3bQUnJwGZYYUEzvwf2PcGzp25DBVGmo52dn+/w31wwldt967UzEf5WaK7nu6Xt0eLtdbrOndyiNsYRtBHpygSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76809057-67ac-410e-93a3-08d7aa415c85
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 13:43:20.1126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc6ihn8WNjfWAOwXFVNpU/0sq0ptdbtL3zqipSNfbKVtyncyWDX9Qni7ma21orrIZ8OvW7hy41OWHTaekD6UWRojKd2lsu3eh2dhPK4zR2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3789
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.12.2019 13:20, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2019 13:13, Kevin Wolf wrote:
>> Am 19.12.2019 um 10:24 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 10.12.2019 20:46, Kevin Wolf wrote:
>>>> Am 22.11.2019 um 17:05 hat Kevin Wolf geschrieben:
>>>>> See patch 4 for the description of the bug fixed.
>>>>
>>>> I'm applying patches 3 and 5-7 to the block branch because they make
>>>> sense on their own.
>>>>
>>>> The real fix will need another approach because the error handling is
>>>> broken in this one: If zeroing out fails (either because of NO_FALLBACK
>>>> or because of some other I/O error), bdrv_co_truncate() will return
>>>> failure, but the image size has already been increased, with potentially
>>>> incorrect data in the new area.
>>>>
>>>> To fix this, we need to make sure that zeros will be read before we
>>>> commit the new image size to the image file (e.g. qcow2 header) and to
>>>> bs->total_sectors. In other words, it must become the responsibility of
>>>> the block driver.
>>>>
>>>> To this effect, I'm planning to introduce a PREALLOC_MODE_ZERO_INIT flag
>>>> that can be or'ed to the preallocation mode. This will fail by default
>>>> because it looks like just another unimplemented preallocation mode to
>>>> block drivers. It will be requested explicitly by commit jobs and
>>>> automatically added by bdrv_co_truncate() if the backing file would
>>>> become visible (like in this series, but now for all preallocation
>>>> modes). I'm planning to implement it for qcow2 and file-posix for now,
>>>> which should cover most interesting cases.
>>>>
>>>> Does this make sense to you?
>>>
>>> This should work. Do you still have this plan in a timeline?
>>
>> Still planning to do this, but tomorrow is my last working day for this
>> year. So I guess I'll get to it sometime in January.
>>
> 
> Good. Have a nice holiday!
> 
> 

Hi, didn't you forget? I just going to ping (or resend) my related
"[PATCH 0/4] fix & merge block_status_above and is_allocated_above", so,
pinging these patches too...

-- 
Best regards,
Vladimir

