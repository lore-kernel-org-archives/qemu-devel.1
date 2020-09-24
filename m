Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E3C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6A3206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cPLVf+vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6A3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSgQ-00026u-V8
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLSel-0001DE-SB; Thu, 24 Sep 2020 10:55:35 -0400
Received: from mail-eopbgr130125.outbound.protection.outlook.com
 ([40.107.13.125]:60997 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLSeg-0007uB-Fv; Thu, 24 Sep 2020 10:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGcl0b1/nLUO1Tuwt8gbdwU3ZDuK+aiiYaUzyQT8Hpl8X6GnjBoJgg3y6Hy+BAtCIOcd58Zn0nfwaXhCYm8dUDbvfuwVVP1fqGKaZFufApar7KtDn/FgXdYpxHlWFh63J1Fuw1U0mkGvYNZ/LkDPor7xdpWJpnIgm8j/vP2GylWYWVL3yce2OEEPBzDK671IsgFIZtzS0SSc02N0mFt7uYgSE2bs6wgNEphbY4ZyP7LOJp5O5IL9myGFpPahyC/M0Rnl5woLxFnEIcu8xZUEgGSKVPmm4zBUvKL3QuRNCVj+3uq4C0suVSRku60qL1cHYTjMjZ9o3NKSQ9QGjUbwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViqAzra4R+5sGrrp0Zu9Q2AtU5l5Y0RNSZ0bhvuRyas=;
 b=HiAKfkiFEiuQngn3/ifgqdaqPIdtEK29xU6qixN0miHlqLROwaK6zSRG+nUxX5hw82zzEYWuZVZeH/bEpHu40pV9/h6GwgLEO9O6eUHC6tH+jd/t9/UWIwdIEYtPBtYAWt2Wi92zPDXoFzL+gk9lE4kyXOQDU6lz9fX7/ERrAItHcIyAh2OrhjkwAbse3HiSsHc+oq13BRm6rHWZUPqE+uRt4kisNvQi+0piCUGMH/oBdpQEdP2xIgRoHIX8JrKdplw95CtNP9ffVOm0/xNBxMMvtvpg4sBXTZeWkYgUX2qWGprTEDSfq6d4y8rH0zB6mkS/z73hfJQOAK2Z017mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViqAzra4R+5sGrrp0Zu9Q2AtU5l5Y0RNSZ0bhvuRyas=;
 b=cPLVf+vdVppWscJopGjm08jlN/E26YiR6CEl5m4M4of2eDEIldP57fm5eyBD+iQ7KS/VLyRgoqokxOSOqML76ZmZTKl9WZOHdYpoXgT3bgAPLWcH/3BQO8ype6MUHO5xvSPL0dwHodLoSEaevORc8dMctBBx/aMjnFspYjuVxIk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3094.eurprd08.prod.outlook.com (2603:10a6:209:48::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 14:55:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 14:55:26 +0000
Subject: Re: [PATCH v6 07/15] block: bdrv_check_perm(): process children anyway
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-8-vsementsov@virtuozzo.com>
 <b75e87f4-2db6-8c39-aa00-d5c77c9b5dcb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5e0f14b3-af47-0aa8-b315-7d211e9e0844@virtuozzo.com>
Date: Thu, 24 Sep 2020 17:55:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <b75e87f4-2db6-8c39-aa00-d5c77c9b5dcb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 14:55:25 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5dad18e-d6ac-4226-2d28-08d86099df49
X-MS-TrafficTypeDiagnostic: AM6PR08MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3094171AB42E4689FBCADF90C1390@AM6PR08MB3094.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcHNSea91p8G+F54O0WwVNQBDfzKxub41U9nGskK4XHFtdxGfaVsodsVsNkxxKCorH1u2Tu8SXsKlwNf+FN/Y6J0tvxg6HIMvLR7TfnfhxPGCH/xB/PNIQUGANKllFKiQxryo/Q5uTuOMy5kInWpXdB3WYumFCcALRM+wAsu3CcjGVxVNywHFaxOQ78kWqNHdljrzMmzNUOvCUKdjJa9287EftX2x8X2hBa9TRnL6/bKbD1lEbnVH9TWp9Rtd8U7al+xx26nCauEcWrsIBjhf59QEezRyM/uF2GBB47Em6MhRwPFPcYbesa4KRXYSi/AQUw7ZwAPEa67JgxEKdLpM1P0LfrcTUGr/7wULN3I0MZlMj3oJlDq+7/uvL+oJCTPn8F9vuSqFOw0dgPgMw7DbxC8SNjEYLn2WDhStCyGfzD8PMvJIY/nY4lQXUFFE4nr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(52116002)(8676002)(5660300002)(316002)(36756003)(4326008)(31696002)(16576012)(2906002)(2616005)(31686004)(956004)(6486002)(8936002)(16526019)(66556008)(186003)(478600001)(53546011)(83380400001)(107886003)(66946007)(26005)(66476007)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P+LKu09M/0dAx7R637AY3u1p0khNwtHTL/9XdC+8U4tznHm6RnZ4D1phOCj1pAB70wwV+4ti/jOeldiSmX/ojybiYgvwxWW8StnfxRd0//j6RN2IObrqIhVeuiWCeLhUW/6hJrUEXuQ9jdk+LkvEGF0NLObWRHkb05DE7GzJ+zAvVmGYXYg5dU3NUQBMHe5Nq58mTCgtWrlfPolIonojnR0QCQYisd17nxLsr6uixWQBJYOImFPYyxyMAEGm/o2mr/8aBYvpVTZUl1OJlJMhUl3dnOBcShQZBPOAYqwh8rLZ3+/9q9sgwDsTNrfVSQjthQOfde0x3EEXtVxW5vXlQEws1MOCyGqk6OzH8I1ojrf4+/TQKCgytL3GpEzF3nIyyE7BASoQ7bINsDOIKB/IEDafR9Bd9jWHcOg6H6pS5qIQCJnZMeNpvKCyyh/xuSX4J9QKd0ouWll+NcoLYyPLfcr08t09iTlDCHR+2FH1xcPaj6kVX/1vKTkfwPRQlTsl2wJ+GS4Y0XPqcvX0aqZ0FnEc8nnx+uiPdi6ZlSvs3NHL1oaerDDjU4NwoohKakcXqhbIuxB8358VX/8/KYppFBL9Km62rpcv0ckByEmjul5Wlyu1BoP5HiSwPz0H1urEFQCwR8WwnIn98mAPyV/wuA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dad18e-d6ac-4226-2d28-08d86099df49
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 14:55:26.7005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdM6Apg/JXcqWJWM5fDrP6ZD+skyXs9O06nyhShzmfx6ozW/3yXWHe3RJC1eat/vjNItu9golilZhWQE13T1PxXlkDUWCAPLoM3Z1qtPsz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3094
Received-SPF: pass client-ip=40.107.13.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:55:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_LOW=-0.7,
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

24.09.2020 17:25, Max Reitz wrote:
> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>> Do generic processing even for drivers which define .bdrv_check_perm
>> handler. It's needed for further preallocate filter: it will need to do
>> additional action on bdrv_check_perm, but don't want to reimplement
>> generic logic.
>>
>> The patch doesn't change existing behaviour: the only driver that
>> implements bdrv_check_perm is file-posix, but it never has any
>> children.
>>
>> Also, bdrv_set_perm() don't stop processing if driver has
>> .bdrv_set_perm handler as well.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 9538af4884..165c2d3cb2 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1964,8 +1964,7 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
>>   /*
>>    * Check whether permissions on this node can be changed in a way that
>>    * @cumulative_perms and @cumulative_shared_perms are the new cumulative
>> - * permissions of all its parents. This involves checking whether all necessary
>> - * permission changes to child nodes can be performed.
>> + * permissions of all its parents.
> 
> Why do you want to remove this sentence?

Really strange :) I don't know. I remember that I've modified some comment working on this series, and it was important... But this sentence become even more obviously correct with this patch.

> 
>>    *
>>    * Will set *tighten_restrictions to true if and only if new permissions have to
>>    * be taken or currently shared permissions are to be unshared.  Otherwise,
>> @@ -2047,8 +2046,11 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
>>       }
>>   
>>       if (drv->bdrv_check_perm) {
>> -        return drv->bdrv_check_perm(bs, cumulative_perms,
>> -                                    cumulative_shared_perms, errp);
>> +        ret = drv->bdrv_check_perm(bs, cumulative_perms,
>> +                                   cumulative_shared_perms, errp);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>       }
> 
> Sounds good.  It’s also consistent with how bdrv_abort_perm_update() and
> bdrv_set_perm() don’t return after calling the respective driver
> functions, but always recurse to the children.
> 
> Max
> 


-- 
Best regards,
Vladimir

