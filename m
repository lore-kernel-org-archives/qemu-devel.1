Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40087C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0437A2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FypyB24w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0437A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1g4-0007uA-5K
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1fM-0006tQ-2H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1dV-0003Wv-2J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:23:19 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:16209 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU1Xg-0003oP-Tx; Thu, 30 Apr 2020 01:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLoFO67h+3MAa88qGIXKT8JV6qgukN9k76fXsj2UHb/S8YIkyIlAHuWksG23Jsbt+8TVL6lF5Boqeuh687JEWm1emi2PVww/wtTWhU0qEOdFKMcqshhZ/R4j5s3Qpk0AkKzuMGTOw7Ugq1dfPOBievxUS86IHLkImC+9cffxA/vjRDAYnhAkj+TvoXKDSPupqDBEEYra6hJpoNm6PovyO2MGrPd0oea/bm5n7xI+UA9VqqHqbhrar7232E4YbltafXd2yPRxcBCrq8eDHBzNOH9+Q/sHVqIsGPplxn8G9OQV04TqhExYMsKKggcbgq8RZAeA5nvWxWeqyLe2qjeclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovg/bbdN1K2SuMtilNopsBlZTMYfT09IKiE0+LHN8t4=;
 b=Puht3EMEaThGqKHiLij9f/41U3N1q+g9ojLGEnzkZ/dwbMbC7ukj1rZsw94Nq/i4vNLM32NpTlcyPtnM91XSR3sBp+cElBBvnoomBeBrSlq0mTnPxKC/BBRzSe66jpeC3UBEQCHEn36OOIedK8iZxxmP3eEFNej8UWqhskBXdzeaYDa6Fafo06uHJ4cwLtwCniXZ7VBah+pgtq/xQvfd8kVrG75xhLuGfJKHVOsQmMP2Xv7U74Wgj7rE5uQD42LFbq0H4rEYxVYLNw0+6E+xACCK9a0CebEBklZ1JqySldkZUtvRQnN7GacPtOHaAbMKwtsI+PGxbxRj3raA8SJryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovg/bbdN1K2SuMtilNopsBlZTMYfT09IKiE0+LHN8t4=;
 b=FypyB24wPVn6qG5D+ySavuNRug17cl4E9qiHGK4C/+TYKupU+DscaXHpeYOatp7IXrgImkB7Zp4XxxYYCIYUtkYdVdTsfrlBQ+j5xDSNp5ZbEAGBxoPdMTLp0yKZ2JXKTQnRquQ2qa8N3fa9VOajeT9AJH5KEvUEQ7lzOU8ZwdI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 05:15:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 05:15:20 +0000
Subject: Re: [PATCH v2 03/17] block/io: use int64_t bytes parameter in
 bdrv_check_byte_request()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-4-vsementsov@virtuozzo.com>
 <e75e6fd2-67c8-16eb-2736-06f2fcca2b24@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430081518367
Message-ID: <a2f0cd94-a8e7-5ae1-aa73-ee65f42fab98@virtuozzo.com>
Date: Thu, 30 Apr 2020 08:15:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e75e6fd2-67c8-16eb-2736-06f2fcca2b24@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0055.eurprd07.prod.outlook.com
 (2603:10a6:207:4::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM3PR07CA0055.eurprd07.prod.outlook.com (2603:10a6:207:4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.16 via Frontend Transport; Thu, 30 Apr 2020 05:15:19 +0000
X-Tagtoolbar-Keys: D20200430081518367
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de2eb54-2175-4717-99d7-08d7ecc57a91
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383EFB88425A9225D7C3B40C1AA0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trc7UWts2L3CMVHD56bjSsvWVBU2Zr0ECU67c2aCidcMqSA1PAAIsrrKHNBPSv4Wb1ywMyXqstOLS/ZzXjE6rG9VvzQNj+j98mgU7b+dErLTxoaEjvJDArsI0N4wRyBh8fHElhmA9LIE8cRkcHLnDeWz/qffliZFRHIgez+V2CFZW9q9d5ZKsygIXwcAN+QNkm+M6F6qxyuzik72sc4FV/2fbUjqL7aIv07ag2IAv5nvAU8C6s8rIlC8f9aHGWctUQkrPQ6f+HH875rFHZBey3TxRfNIFyIL7BRFIaf2dsOtMS4lVsZ6KILz2RfbfFH0YPO/qWfnaG7Fc+g8sFvStR/SJZiQazUJ+irSTO7tjAVDDgdeRI0l/V5TtyERardRMxlWGhdXFvLbw2RCI6hGfpJMyu9dSwARX0CXM272WrijPrA0l5VygtHjvfgkJ2xc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(396003)(346002)(376002)(186003)(66946007)(7416002)(66556008)(52116002)(66476007)(36756003)(6486002)(478600001)(16576012)(316002)(5660300002)(53546011)(2906002)(956004)(86362001)(107886003)(31686004)(16526019)(2616005)(26005)(31696002)(8676002)(4326008)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YxkblKrSaXVSgvJIgxrUGeS/Y7DU/JQHG4nxcsM0+mS4piPQ7Ge7zVUWJ4D9MlBwHDTqMPQoBMYCYNw619NYXFdhU8qDjR1X6p5QG0vBXre+sAhV05PMg4UILowTI1GV0NHDfvOKzeKQvF7JzKtY/DYY9v8Guo0/MyKn43R+oq2s1QZxuBFe66tR3UQ/4tnxM84ER7yY9vW6vMDDoz9dIj9slIylDW9vSGwPzT4wHo04HDQ6q+D0ubIBrki6J02vXiNxF3ztHncS2zJMRz++VP+ZVBpIBCFweeaLJ0OSogiBqMwN1alH1MLFHWa9MWtvD6fR+wfw+m2DCPvYxH3mnjr6otSMsmBctC6GADxpovcw/YO4ttyCi0mvfisnBUr2oEMeIuTBu/cne61OSY1aKgQKV9gyvUK9SBOTrQE99mCme4JDNV8mqugcEKuVFdRWuCPm/N5G6WALif+4fMHUHGW+LTaSOTUA7El78gzf8BmiunMDHvW7qlTVgHWS4Hx75vvn9aFgIUp2t5beLXaK85qfVLH6B5QBIkTO7bB9g6o3NWx13RBoSvnvsJnCHOIZC7ZOFog99fMi6F/L06ZmK+A+j+v1+Ey/Dx1LP4mmqb6dLjOldGJlSrdik0bgSmLvGTZoCjCyu648l6U8gC9zFBwp20JLysUXgIcsrQl1fzzn79fOSTgwHJDw0yNJcmpP446EJgiXdXzuOezlNeJmLSIm8NDstQcpPQKMaAXZ8duJ2klUZOUzgUC4+p3mEHWSRIVGmXuvRsGWwtUlvCGQRBOsbBdS/oBPazNylHemeSI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de2eb54-2175-4717-99d7-08d7ecc57a91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 05:15:20.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKUYJErIB1ea794uu79JcEHZX07SxEGdeuBd4MBSEnT/aiMfTDtTMlsJY7iW+GxSzE2P1uDrDbS6aaUQ7I9aEC/MErIrXzFZDMAFQ/gUF8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:15:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.92
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 22:27, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths. Convert bdrv_check_byte_request() now.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 7cbb80bd24..1267918def 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
>>   }
>>   static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>> -                                   size_t size)
>> +                                   int64_t bytes)
>>   {
> 
> This changes an unsigned to signed value on 64-bit machines, and additionally widens the parameter on 32-bit machines.  Existing callers:
> 
> bdrv_co_preadv_part() with 'unsigned int' - no impact
> bdrv_co_pwritev_part() with 'unsigned int' - no impact
> bdrv_co_copy_range_internal() with 'uint64_t' - potentially fixes a latent bug on 32-bit machines. Requires a larger audit to see how bdrv_co_copy_range() and friends are used:
> 
> block/block-backend.c:blk_co_copy_range() - passes 'int', thus < 2G
> block/block-copy.c:block_copy_do_copy() - passes 'int64_t', but only after assert(nbytes < INT_MAX); also it has a BLOCK_COPY_MAX_COPY_RANGE set to 16M that factors into its calculations on how much to do per iteration
> 
> So it looks like at present we are safe, but the commit message should definitely call out the fix for an unreachable latent bug.
> 
> I will also point out that on Linux, copy_file_range() is capped by a size_t len parameter, so even if we DO have a 32-bit caller passing > 2G, it will encounter further truncation bugs if the block layer does not fragment the request internally.  I don't see any fragmentation logic in the public bdrv_co_copy_range() or in bdrv_co_copy_range_internal() - I suspect that needs to be added (probably as a separate patch); maybe by moving the fragmentation loop currently in block-copy.c to instead live in io.c?

fragmentation loop in io.c should have larger granularity than in block-copy.c, isn't it? Fragmentation loop in block-copy will be async for performance reasons, based on aio-task-pool. And it should cover both copy_range and simple copy and write-zeroes cases.. So, I think it's simpler to keep separate fragmentation loop in io.c. Still it's not really needed until block-copy is the only user of the interface.

> 
>> -    if (size > BDRV_REQUEST_MAX_BYTES) {
>> +    if (bytes > BDRV_REQUEST_MAX_BYTES) {
>>           return -EIO;
>>       }
>> @@ -885,7 +885,7 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>>           return -ENOMEDIUM;
>>       }
>> -    if (offset < 0) {
>> +    if (offset < 0 || bytes < 0) {
>>           return -EIO;
>>       }
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I don't know if we have any iotest coverage of copy_range with a 5G image to prove that it doesn't misbehave on a 32-bit machine.  That seems like it will eventually be useful, but doesn't necessarily have to be at the same time as this patch.
> 


-- 
Best regards,
Vladimir

