Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1059CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18552073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bNN776NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18552073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCe28-0007Cj-2u
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCe1X-0006mR-Vp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCe1W-0000fj-VP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:42:23 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:6497 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCe1W-0000bn-O9; Fri, 13 Mar 2020 02:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6AgSuqnTavp0T5Qvq18h80oiaNbCEjXvk+1QdMyeITgHGn9xOEbpZKdhSFnb6vsgtrLEuLeGy6H8WgzzVI1p6PPQuN0DMtIn7Dw1/zdKnWN/5e/djoJjwa2JQfHcPjg8kE1OpD94FabspNyH3lHkLtvmTF2lZ8XViGp0N56qNR962E5cY3MGsanRH3vykVQlYhrOL9nKagKZVZJDHQal8iHcs+/LBZ4wGDnGLbgllpwvtPCsQd45bvnzvdjVg3c6p3UGpu9TX9+6C1YXWQKN9rUljQIsTtB1yv45N/ZONLkfeS8Bsx7UoI/1MZRselERlNHJu55yQTuVlF5UemFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/KKEde1MjlT9k/+J/OOnGVkyWT13BsWqOieKCghPAc=;
 b=cbklzFXsuBp+pWXGVjYC4DTyAi43dXtpoBhq0x1QXmToFnOKRUXTgAw/Nh6oqsp0p6ucqI9JUH8DHXd5K+eSbcCqofDRI8XWn1qvdfA+dvabWGj6Bl77SX39cwll9zNRoT39GlC8hcEpwYklAZneqYaHj+lcV8b5/EasDagAZDEEVHwUSR694lrIG4ig+gCSB7R+x0PHD7pYvVLdgxFnYiwNdzh2Fg/KbPI07XSPHqTb8bNJ01FOn7/fhJ/M+mog0tVWw69o0TnbwmmNLtFPjr2SSOLdPetCydsE6KP+AayswT6SGUBixkkSjekm8rXFatiJMG9Mmrekd5P4tplYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/KKEde1MjlT9k/+J/OOnGVkyWT13BsWqOieKCghPAc=;
 b=bNN776NHMWHrCsrul9P/FFhWpOMDEztsyQ+VOaUpQyzjv51Flerp5tQ8YnNW1P2m3nH9iDe1YyFwUoR8kXXMRZWXbegS9tyEu3fS4obsujiybhyJaFuMPddEf3cHxlOglTN6l8yIpyp22LFk5p5YFL666uh6bk0ttCQxEkopE2c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 06:42:20 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 06:42:20 +0000
Subject: Re: [PATCH] block/io: fix bdrv_co_do_copy_on_readv
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20200312081949.5350-1-vsementsov@virtuozzo.com>
 <ba1cdff0-3dba-36b5-9a55-1394e3800404@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313094217913
Message-ID: <b4cb7822-bcbe-15d8-3c45-c32a1a248b02@virtuozzo.com>
Date: Fri, 13 Mar 2020 09:42:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ba1cdff0-3dba-36b5-9a55-1394e3800404@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0292.eurprd05.prod.outlook.com
 (2603:10a6:7:93::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0292.eurprd05.prod.outlook.com (2603:10a6:7:93::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 06:42:19 +0000
X-Tagtoolbar-Keys: D20200313094217913
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d531833-10c4-4037-627d-08d7c719adcb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3797:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3797D810E4C9C3681D6D9738C1FA0@AM6PR08MB3797.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(52116002)(4326008)(16576012)(66476007)(66556008)(66946007)(36756003)(53546011)(2906002)(107886003)(86362001)(31696002)(316002)(26005)(6486002)(5660300002)(8936002)(16526019)(31686004)(186003)(81166006)(8676002)(81156014)(2616005)(478600001)(956004)(80283002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goe3vi10sAI8M32KH5hISZGpO2sZodJA9ObHacmu6dfUsB3IIelIOHmK27YK+xx9zJ85ABq16y3lh5QcbFo929rKy1IYGVyvBpVXIOBVCz+e8qC1bAQVExFT4z5h8xKoheuOtSqbnJDKvbaFDLH/vZysjF/ZslvQwJuCOfsS+XzVkEPAZx5ZOVkZzIldmnTEZvkoV1Ip/pSQ8XjwCCU7/au4ZUh1zwC53zMArUSjyzfXB6L128yCot42fSfo6s2P4HDT/jpE3Fd/5LrpWHSDuKwND+17ok9E8GvFpLJrDEYJbXWOPBp7ZNVt7cOVec18x22VfQj88Ytkrx3JiVzaqSdPQlWCKOPj2AKn0G6jqXFU3+VCy2c+X7lY8ImMkiPcX2/UNcdGHTG7myWNqOujbgVTUo8SK7JI9w30MxR+6yXcBHIIlTLIT2vsjYliDrGXJC8ywB3bF4ZeJxuokc7uef0D99ska4/V6WZtwe1MMCp4+O28c9+6ryqHC8Y9Esna
X-MS-Exchange-AntiSpam-MessageData: gkXYCQxxXpNyXuhFd0JOg3lByq9fYu9Nmmr3cHJeUzOyA9lMYMh6Cb+ys6YfxWtQw+q161/MdC6FDYF4pxCzUF15V3exvk5+ffTqLEALIXzmsecHlB6YtJZirLd4hpcuFLZ0wa7yGr+jt0Tbd7m/mg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d531833-10c4-4037-627d-08d7c719adcb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 06:42:20.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5J3nZtwV8eNDscxti3g+PCbBfIn499/OxVG998o11zBeGNUOfHRuM0cBwSC1Eytr6SKIDW10tko3rnoNmS4X9KIGrA6/YeqlWtOWR5BP6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.100
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.03.2020 2:09, John Snow wrote:
> 
> 
> On 3/12/20 4:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Prior to 1143ec5ebf4 it was OK to qemu_iovec_from_buf() from aligned-up
>> buffer to original qiov, as qemu_iovec_from_buf() will stop at qiov end
>> anyway.
>>
>> But after 1143ec5ebf4 we assume that bdrv_co_do_copy_on_readv works on
>> part of original qiov, defined by qiov_offset and bytes. So we must not
>> touch qiov behind qiov_offset+bytes bound. Fix it.
>>
> 
> For the purposes of the stable branch commit log, how does the bug
> manifest? Are there known cases? What's the impact?
> 
> (Do we have tests?)

Sorry, nothing of these things. I just saw it while working with this code.

> 
>> Cc: qemu-stable@nongnu.org # v4.2
>> Fixes: 1143ec5ebf4
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 7e4cb74cf4..aba67f66b9 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1399,7 +1399,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>>               if (!(flags & BDRV_REQ_PREFETCH)) {
>>                   qemu_iovec_from_buf(qiov, qiov_offset + progress,
>>                                       bounce_buffer + skip_bytes,
>> -                                    pnum - skip_bytes);
>> +                                    MIN(pnum - skip_bytes, bytes - progress));
>>               }
>>           } else if (!(flags & BDRV_REQ_PREFETCH)) {
>>               /* Read directly into the destination */
>>
> Even if I don't understand the bug, the tighter bound seems provably
> correct anyway, so...
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir

