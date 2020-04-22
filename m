Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB30C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F018F20882
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ONEx79xM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJWZ-0001OF-5P
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRJRs-0006BJ-TF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRJRd-0001cF-Gy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:46:11 -0400
Received: from mail-eopbgr30108.outbound.protection.outlook.com
 ([40.107.3.108]:30273 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRJRc-0001Uu-JF; Wed, 22 Apr 2020 13:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks6Bpi3t3wRZAS7dFra5GG5bTsadE5hI50ebPaHXC6jACQNfdec2jbyqDdVock9FHOk1LPUWmP5HgaMSt860itrgracAc+OLsaPNrEQN/uyQb9YUogQGhA4d6JuD5suq3Sm7Xc31rfsUlNlFyDSza289qOHm/IggGmDUztBF11UJKsZ51b7Eon/D8fyXtDqBWh2GMMs1eH2zQBgHx0bQwUk/V5/Vr3RatYTJqGtJDYec7zyEu4uhyCcLEodkCtRM2HHgbjZS0mCyq+56Be7X4rY5sWuB1sJ7MPEE3pRVdRp30jq5gbWTvivguzNmdn5dV0/VwK9EDlrfXua0sCwFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzseyZuNtySWjOeBlxaJDF3cNg8RZE21TS3z8hVECo=;
 b=jhgrQA0extxmzap3n9kz+sjmBRQ99aUhUZb7JkQ2rqvNYNhr2Fe21xuN2usaQQSY/vkcTAWY3C6JZ9S1ColWf1PMzKmvsEdttl8vsqn+RxUx95TOFm5//kB0EO7uy6j9snANs0iLJ885r46jMu4K9PcEX7mshbASbxa1ZOCnkblW0UdGwy0lCMgPXtIrI0kqhwoFDCOMdCQ8IyvbkBaJZLoR6NSSLBmaRxo/I9WMxif7O3DOLbDXiIlOJZ+iEbEkYePHAqu2dfzohVtZMGcq7kOpMhhm4wg1u61WM+hW6DikeXLNYZeGGTFiLRY8iQi5bo6vk73axzbw7j4a1wpXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzseyZuNtySWjOeBlxaJDF3cNg8RZE21TS3z8hVECo=;
 b=ONEx79xMqNlCQdxYkEmaunZ015f1xsPiPB/tgo06HcMKjaybibZBX7JJ7VG4yDwioIecL+2NF2tdG0mysuShaiurLWxiHUuSpp3WKPPcX6k7pxpx2dwlFLTWhICsrfsSxEdAKsp90Fj7P64+g2XM8TQiw4jOe7NjEI2Zi0INRiw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 17:45:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 17:45:53 +0000
Subject: Re: [PATCH 2/3] block/io: convert generic io path to use int64_t
 parameters
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <20200330141818.31294-3-vsementsov@virtuozzo.com>
 <20200422155003.GE47385@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422204550845
Message-ID: <efcc7865-45a8-5a8b-25f3-301fbc6dab08@virtuozzo.com>
Date: Wed, 22 Apr 2020 20:45:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200422155003.GE47385@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:200:89::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM4PR0202CA0007.eurprd02.prod.outlook.com (2603:10a6:200:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 17:45:52 +0000
X-Tagtoolbar-Keys: D20200422204550845
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3acbd90c-afb9-48ae-0d23-08d7e6e500d6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5526EE329137E0D7132E784BC1D20@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(366004)(39840400004)(376002)(136003)(478600001)(86362001)(5660300002)(7416002)(31696002)(2906002)(6916009)(81156014)(36756003)(8676002)(8936002)(16526019)(16576012)(6486002)(66476007)(66946007)(66556008)(4326008)(31686004)(26005)(956004)(2616005)(186003)(52116002)(316002)(41533002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnqYYllDA3+/jM2qpfAkYP32DzxtJNLNVQiAJJ/8eurKvOtPgRYcTrJcib7keQrZ+O1MWb+SJRbbPMxguJaYb632aCJMvnsMoVyFEpQN+myrICGV8yQZX6wQu8dK8YK9lTe72QyfooPL4WP1Dbs55mGbMD2av4gvQrSteWqkiMFMBYyWZEaSnmnvZ48I91Sh2ru+PIWZgbkfzl1YUkzgsEHl7ZbzKbJgRLZkcXZ7mHNIAWYwwJcH2J0CVluIIdlZBXLCt17+2ooNAlC0YnOtlSnRT7H+L5gD4LLkNcMZXW/RR4HU3Crq+15R1sT+Y5oxD8XIrI36Kz5Uru0ZtRXBAidAyRVYEAoTR6n3VmcBtwb9qtNYjssYnPlwc0vcw0GeBEix6bVOsBf7A+IJUBaNOMhlOvEVL2FaqqC3KD4lqAKfKh6UC/z8wYcoC25JBLhyNmLsHTAYy//+9+6CeJvQgl8L1OeJclkKAGAn5iIbbZ0gJOdtiS5YWSOKIJnr617x
X-MS-Exchange-AntiSpam-MessageData: s+mCmjtX249fJBuPuHUzw88/bc74C8ahcGO8EpxV+zJaAeo4xXdu0/epShcdcJmDzA9/tL/XJiQA3H6SWWav/mF/+Vs5XredTWHq/2T8iYxzKPVJt/RwrzUcBhaLvPwijHMiIU2+gQtbvZGcfO9hIw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acbd90c-afb9-48ae-0d23-08d7e6e500d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 17:45:53.3804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uut3RK58e8nt4QbI1rcnoheQM8uqBoLJFzcIAjYdibLx6u50Di+4r/Xsz5XHYmCrNLSoeqIB8Ie9g3IfrGKPd9zs6SWyOnXLBMxv4uGi/ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.3.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 13:45:54
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.108
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org, dillaman@redhat.com,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 ari@tuxera.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 jsnow@redhat.com, ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.04.2020 18:50, Stefan Hajnoczi wrote:
> On Mon, Mar 30, 2020 at 05:18:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> @@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
>>   }
>>   
>>   static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>> -                                   size_t size)
>> +                                   int64_t bytes)
>>   {
>> -    if (size > BDRV_REQUEST_MAX_BYTES) {
>> +    if (offset < 0 || bytes < 0 || bytes > BDRV_REQUEST_MAX_BYTES) {
>>           return -EIO;
>>       }
>>   
>> @@ -885,10 +885,6 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>>           return -ENOMEDIUM;
>>       }
>>   
>> -    if (offset < 0) {
>> -        return -EIO;
>> -    }
>> -
>>       return 0;
>>   }
> 
> Moving this if statement was unnecessary.  I'm not sure if there are
> cases where callers will now see EIO instead of ENOMEDIUM and change
> their behavior :(.
> 
> More conservative code changes are easier to review and merge because
> they are less risky.

Hmm, would be a bit strange to just add "bytes < 0" to the first "if" keeping "offset < 0" in the third.
And strange to keep "bytes > BDRV_REQUEST_MAX_BYTES" in the first, if add "bytes < 0" to the third..

> 
>> @@ -1743,7 +1740,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
>>   }
>>   
>>   static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>> -    int64_t offset, int bytes, BdrvRequestFlags flags)
>> +    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
>>   {
>>       BlockDriver *drv = bs->drv;
>>       QEMUIOVector qiov;
>> @@ -1773,7 +1770,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>>       assert(max_write_zeroes >= bs->bl.request_alignment);
>>   
>>       while (bytes > 0 && !ret) {
>> -        int num = bytes;
>> +        int64_t num = bytes;
>>   
>>           /* Align request.  Block drivers can expect the "bulk" of the request
>>            * to be aligned, and that unaligned requests do not cross cluster
>> @@ -1799,6 +1796,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>>           ret = -ENOTSUP;
>>           /* First try the efficient write zeroes operation */
>>           if (drv->bdrv_co_pwrite_zeroes) {
>> +            assert(num <= INT_MAX);
> 
> max_write_zeroes already enforces this, so the assertion is always
> false:
> 
>    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
>    ...
>          /* limit request size */
>          if (num > max_write_zeroes) {
>              num = max_write_zeroes;
>          }
> 

You are right, I'll drop it.

-- 
Best regards,
Vladimir

