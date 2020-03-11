Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14046C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F5220727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E7NMBRvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzvc-0006IU-1R
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBzux-0005tk-0b
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBzuv-0000Ui-6L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:52:54 -0400
Received: from mail-eopbgr60117.outbound.protection.outlook.com
 ([40.107.6.117]:25930 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBzuu-0000TD-KH; Wed, 11 Mar 2020 07:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPUYkpovPTH/qKfDm8JeKGRsZrpL0aWtFKrugtmRltz1TXfSJtTmQlVfYd/H7aZj3HO4NVH3A31xS/YtjBZ19PiYqjfFrIOP94gmfm3aIcibSix0IEGPhjBCLBYfmtDlQR0RmR2/T0JzrBcshwKQxd3ueqPVfmg/vpgrdB/e7ekqoSvJklfwz1UpOgmAoRh1WOAR7HgYASHH9+pqd0dk//Kd51h1bDIrWYQoR4XHfLheEvTCb+JvWwhiycoJRpiIGc+/xgNfGn2GpNOEK7Wk3CSvPUtOmWJ7aZ8uapj8F+5qKuDT0xM3XUwM9rJhBTrjMSFQV6JbelT6SFVIfKEIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHB6PfWGJVly+WkkNnGFna37wqumW5iA9QGovo+/FMs=;
 b=BLu6Fb1F5wJHEuxZEg0Acqmjnz7M245jFtgHUFMSwKW73BpcNWAWS2ckkKBVpSc6hXQf2ngLfPPZr+lBry716jkyH0dRyLLqLbiQL9SsFMPuxalAX5YetCYD0uQzpYURzlMD/wSfwSGOuyBQuu6diASReFPzvffJe7h6P30cKDdDKhUQU8jcVjFCCoutMX7w6FJmV45stFWvq1XODrQLLjYyQnQ0l1Z6MJGwCM8gVWV9ze2yMQnK7Yg00f0GOY//RsoE/WPJ6YWj/OoQ38y7NjW3HtkU2I7VxDcwHf2hLFq4fyTo/3bwfwa0S2h5SXqs04Qkp2vtZ1GwOu9RBIMgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHB6PfWGJVly+WkkNnGFna37wqumW5iA9QGovo+/FMs=;
 b=E7NMBRvSzB7lsuoCE+h52TlXwthc6tRv7lYoDc18ApoLQq1IpRL/XZifARAZhwASEI2FY+eFVQu6EKUbrHtURZ2ICjcQUclSpC6KUE4TZf1OeDMUasnp9YSwQxU8H4dUYXotgDPMwc8SkUaClC+btU6X0M/i0EbFB57cQSnJIkw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4021.eurprd08.prod.outlook.com (20.179.2.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 11:52:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 11:52:50 +0000
Subject: Re: [PATCH v4 0/9] block-copy improvements: part I
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200311103004.7649-1-vsementsov@virtuozzo.com>
 <ef8eb81d-32be-1360-11f4-743438b4b3e3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311145246189
Message-ID: <4fb7e11c-fbb5-13b8-03e2-e04f80c52cc3@virtuozzo.com>
Date: Wed, 11 Mar 2020 14:52:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ef8eb81d-32be-1360-11f4-743438b4b3e3@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::16)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 11:52:49 +0000
X-Tagtoolbar-Keys: D20200311145246189
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e0f28f-5280-49cd-019c-08d7c5b2b92f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4021558492B7AE1F1B7CE940C1FC0@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(5660300002)(16526019)(2616005)(956004)(66556008)(31696002)(316002)(8676002)(31686004)(186003)(478600001)(81166006)(36756003)(8936002)(16576012)(66946007)(86362001)(81156014)(66476007)(26005)(966005)(53546011)(6486002)(107886003)(4326008)(2906002)(6666004)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4021;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCCf+O/QDiymS6W8VF/hP0xUU/TgxW2Z7MGcRRmG02ZZq2yfF6pFY5IWKKhWTXTEF/u73sJHYVY3YPVpOMx8+mqFvqFAys2Asxk36quUcw39Xx7w2EkQHd/WcJpe/SgWki02dMa6jy4EcBitUw6rYVC/centP33if+7Ry86udT/l6NNXpu/xw5qHzTMStLW55W16A/PyOTJRZXYaOoijx/efLN3mnBLXeHaSQErpoE5/AThbJpnv0c38YYVF2u7eKq4UPKAg5h/lYmhQeCtU199BBQxvuTbOGyGMbvtI2GI6iAHhouIzooR39TfJ6eTiZjLSjqIs2ITAJ6g8LhVs+2NKOK5FpHm7vZ+zDjd81M2H5JgH6cgQR+Ly9NrjRCOgUaGyN1ZO30ndjhUf2D5UKsPUSLH2IwX6NlqHug7aCZrzZqz3xEQLf3v47EeOOXbi/iKBV3BKUFmWOal7ArT5HUkoerYz5ILm97IKAN0f7fvkjWTK+6ingiKhD58jY+utVw5WmL+kz5KUbaoq/7ZuGA==
X-MS-Exchange-AntiSpam-MessageData: MB+GXzofWw0bdh1/fYMjFct+SwKidCdGPvUvYz8gHROMrte8w/JgHltSpoJQu5G/UG5Gn1VxZ9KcWF2Y7iKrttB53Ziea2pL7l7/ms20OFT0iEc/nqQ4ISQOSE7VF6+beu5GNLYTGnsw8ax7vXeEEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e0f28f-5280-49cd-019c-08d7c5b2b92f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 11:52:49.8940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yfy9enxirig5wHaA/g8mDNVqzWNterFT5O9ijQdSWbNxqKDj9swfARK7xii9x6zxLiEfvYDq5tyS6Tr6Cwrt9D/rr7r6c5up4fJX3He/0og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.117
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 14:37, Max Reitz wrote:
> On 11.03.20 11:29, Vladimir Sementsov-Ogievskiy wrote:
>> v4:
>>
>> 01: add Max's r-b
>> 02: rm ProgressResetCallbackFunc typedef
>> 03-06: add Max's r-b
>> 07: fix indentation
>> 08: update in_flight_bytes in block_copy_inflight_req_shrink
>>      improve comment above block_copy() definition
>> 09: add Andrey's and Max's r-b
>>      drop hunk fixing indentation (merged to 07)
>>
>> Vladimir Sementsov-Ogievskiy (9):
>>    job: refactor progress to separate object
>>    block/block-copy: fix progress calculation
>>    block/block-copy: specialcase first copy_range request
>>    block/block-copy: use block_status
>>    block/block-copy: factor out find_conflicting_inflight_req
>>    block/block-copy: refactor interfaces to use bytes instead of end
>>    block/block-copy: rename start to offset in interfaces
>>    block/block-copy: reduce intersecting request lock
>>    block/block-copy: hide structure definitions
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 

Thanks you!


-- 
Best regards,
Vladimir

