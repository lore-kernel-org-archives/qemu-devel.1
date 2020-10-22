Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8FFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC26D222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p7bQ6Ywb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC26D222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVTu-0005S6-Qd
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVVN3-0000Fh-Oq; Thu, 22 Oct 2020 03:50:49 -0400
Received: from mail-eopbgr50118.outbound.protection.outlook.com
 ([40.107.5.118]:16992 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVVN1-0001iT-0A; Thu, 22 Oct 2020 03:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipdNZ2UfRO8TT7UT6k+Aw5dV5SPBjw6FN4hB0ND4YLGhczR2VgCh+En9RvzRrrDL7JuEM25ljx5gmrcQBgN22rz7OWAXRFgvvW+zcd6bMSqnsf+h+FowwEIBZQ5l/4HL10J2hYrdot+xKvHn2tXx0a1v7oPWzT3w88nJqQVlpI2TuC+KQs+Ev0NQQSepbu6RCJhOT0lFVV4fIRf9BZxqEve5SzYEA1tFN8IQfc99q7h801dekJYSQREJoPBRT8fbMzF6K6CEQUZFkVcB09QKT4ZTcLV/cTMWvlK6ukA5TPQ6NaghVIcRHO8V9UXq1xkFMOTWoIugTgzFcU15tFfeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO7ryGqh9zysYM32qG3HvUVA3auNqtjyHwQT69R3QkU=;
 b=nZTzkXKnfzBLbE19qkj1GsAR62ixAD7S3/Y9yGzbFkPOIZK+JZyXpc1jdHiXL+XtxahZg5QNl1DIIwBUEJ4FbcsHoANumfdCj3Zm3m6o5dHXqVnxfFjZ/BIBk5wnx9eUbYzIFbqX8etHqPGdzmuVPJge+XVncmLuwjcwKNUd5qUEOQijuKQdl6mgE7aFZ4iahxN25zgxbgHRTpXWTbOknPhNgesJNyasNPuvRSSBtz2OQi3OjBi1U2ZkBCnhS+Wpr7+3oSIGZh9fSYw4uJD5n2LcCEw/6/3WK+an7QbdRlSJa7+CrP3Zp0agr3l3PbQ262eYYpMp1Xeslk685a24/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO7ryGqh9zysYM32qG3HvUVA3auNqtjyHwQT69R3QkU=;
 b=p7bQ6YwbstFI6WjOgZA1+PzjqFuAFUEUEEtC9qZRXWljmhoPjemjHB37D/hN4ygWQCTnXuRzLiDfk6KWOzDoDesQVV1afsZxBRzgxHsxVBoGa5fPtPiSbxEeiw9Zh39rSGOs5+5wejs2q0ABcMkSxpI4K/nOZFoN0eHOla5dplQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2219.eurprd08.prod.outlook.com (2603:10a6:3:c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 22 Oct
 2020 07:50:42 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 07:50:42 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
 <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
 <519fd52f-cb9e-0ab1-6d50-a9b3004d86fe@virtuozzo.com>
Message-ID: <4ae47559-af39-1dcc-5e22-f7259b55dfee@virtuozzo.com>
Date: Thu, 22 Oct 2020 10:50:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <519fd52f-cb9e-0ab1-6d50-a9b3004d86fe@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 07:50:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c51cb49-6b93-4fb3-f719-08d8765f2cec
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB221980EDA0406C4967C50A73F41D0@HE1PR0802MB2219.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJmk16T8dO1I69KQvIk+2nETs2+eUyUFD74CUVWIhMsPbEFDLKdJjupU91pcaOt2OXS03BsL44wHFQYmKhgogab64v2XZoG5PgBivBQGAWQZT0Nmq1d9d5nPJ7h1Nrbcs4HEPVR6reaV3Gg6LQwyLY9uiymMuW5KARWgE2/+nOHuq3idxo4ZxAG/kor4EHZFV43f5zRTT4w3dFicpmt0p54uXRB11AyGL/G123QrbB38cG3q4kt9PkaQ3WKn+PXkdpcfCMjY1YVhK0Zu1P212LzDj+t24ng0OkyH8WYk04Ok8P0wj4sPIxrVr7gYSMwKYyaCscZbCRFSucQSNTffQ7PWl7nNlMtNwrbWN69t4ScklZOaCGqw8cNBdNmIBeSA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(366004)(136003)(346002)(2906002)(6512007)(107886003)(186003)(31686004)(83380400001)(316002)(478600001)(36756003)(16526019)(52116002)(8676002)(53546011)(8936002)(6506007)(44832011)(6486002)(4326008)(66556008)(66476007)(956004)(5660300002)(66946007)(26005)(31696002)(7416002)(86362001)(2616005)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Gdf7E0pVrm7NA4Me3awCMr/iYcREF3nIvXOQOWkpuAAIic4MpvM0fOCSV3JbhbdSXjxcpTaHkSpg1p+xszRLVuGD+eOWu9xkSaBGR3yfyxnO2YCJ8TpXJzw1DV9si40xmYkf1KiqmnoeQmUpWMQ5T2dm2sIPQhBSyU93CL6vdUztLscjYmLNIVhaZuE6SFCw+VyIXBxVCCzVBxkFpfgm8LJUMs4NdtlHM8KqvLNyfko7OAMtNI+jE8gHj39Kmy26fe0PB9Giufqt9KGgj9K6EgS8pfvZybq+vo5jAI5a5xRmszu8dAV6srPh+r5V0l6a+gJmKTyj+q/oH2orqe50Fuo3wpbLtwXuG4OPdimYN/tfc5ihtdK5uh4ulXbwIRe3lHB5CPZDV9oFit9cLFmiea1sb2MYEgkD/ZOdxIf24QRHjK9yHT3eliQKWxsPtEyLBJqyLYPT6+0qDC/NsvAAI9RPVU0pxk6Fhegt0el+EobIt9Krfn2noiAQ+PvL0eYiOTvqGR1ve5yjSHvASuDUf15XGBRBO8e22Cnd7YUs764kfqbxqTUWATzfZNJ8SVVjKSEmamcrRh6nk3G4cpOPWwMF1azVp+wB3uxZBLe8l94RMFr/xX6NSSjC3o1IKDPnKm3mRHii9oeTiXrrtVKx7A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c51cb49-6b93-4fb3-f719-08d8765f2cec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 07:50:42.3691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/5k1h2Us1sw9cWWpSa4givj7NIwkH9cR2pUHO2Yn9Aqxe7vJMEKpLtL8SJKrSIzwYElV/PkmYMRtye7PiSPG6slC8gwCDa4DK6VRm+B1rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2219
Received-SPF: pass client-ip=40.107.5.118;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 03:50:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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


On 21.10.2020 23:43, Andrey Shinkevich wrote:
> On 14.10.2020 18:22, Vladimir Sementsov-Ogievskiy wrote:
>> 14.10.2020 15:51, Max Reitz wrote:
>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>>> COR-driver to skip unneeded reading. It can be taken into account for
>>>> the COR-algorithms optimization. That check is being made during the
>>>> block stream job by the moment.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---

[...]

>>>> diff --git a/block/io.c b/block/io.c
>>>> index 11df188..bff1808 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -1512,7 +1512,8 @@ static int coroutine_fn 
>>>> bdrv_aligned_preadv(BdrvChild *child,
>>>>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>>>       if (bytes <= max_bytes && bytes <= max_transfer) {
>>>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, 
>>>> qiov_offset, 0);
>>>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>>>> +                                 flags & bs->supported_read_flags);
>>
>>
>> When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should 
>> be) NULL. This means, that we can't just drop the flag when call the 
>> driver that doesn't support it.
>>
>> Actually, if driver doesn't support the PREFETCH flag we should do 
>> nothing.
>>
>>
>>>
>>> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
>>> why it isn’t.
>>>
>>
>>
>> Could it be part of patch 07? I mean introduce new field 
>> supported_read_flags and handle it in generic code in one patch, prior 
>> to implementing support for it in COR driver.
>>
>>
> 
> We have to add the supported flags for the COR driver in the same patch. 
> Or before handling the supported_read_flags at the generic layer 
> (handling zero does not make a sence). Otherwise, the test #216 (where 
> the COR-filter is applied) will not pass.
> 
> Andrey

I have found a workaround and am going to send all the related patches 
as a separate series.

Andrey

