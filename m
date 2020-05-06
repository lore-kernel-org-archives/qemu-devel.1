Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA6C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3045C208D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="du9Hn3hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3045C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLMv-0008K9-9R
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWLMF-0007jr-U2; Wed, 06 May 2020 10:49:11 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:17574 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWLMC-0001Qw-6N; Wed, 06 May 2020 10:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZiX802aeTopN50ki+A9oihQBqNPqEVa841DpBUHAuYuG7xjEISYj6+y9CyLp2pDrwlAYjpC3VjdCJmeO3ZbZYz99El5TQQgn1pGZb2VO/2VbsGKw3pRHhj1X+sIqbPgNlvQsqEIS1E5TtZ0gPDbcr9+ihySIve12dHXTQMNf+8jw1SMIPyb6RN43HhhTM39B76TXmWhlNeMmenoG30ROr3/+bS1D86LmPnWIVjbAwZwmcwvkdTvOzUm2JDZMYQRpLhJRL44kv8nXIMoRdzGVgf6+sz4Z50gXQEBmuVUBp0df5ScxzdRcEr1bJHLPjv/pw5vMlPVjd8sEhyCbI9aTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maPbzrXm1BYgWLaGxjScpl4gT0rwYvbwp5JqKAt7VHw=;
 b=LbaTpITD3cHEv/BH0EP/yhaBsQewrFITT3FoLtN1fB2hs7c4ALDEMTYGzIrmCBioV1Ge5ilRWd1w65A4laj8szhcZVOKC/Yk15r/ONeo9SxSwg+UXapo7kZmdj+9YcWkYDLPcVqTCkCzp/HSgUIDWStBA/9KaU5IZLslDMUX3AeiLvEVR1A3V4X0TK1IrRN6zJ2UG/nmmKgcAEPL7HZsnm79ARnnm1kIFOztTWxjPO2v0Kjw6uYO6JVLzLE0DZdUEAqcFj/SqkoFzRGJWRJgzg+HCg1jOpyyA4ijULoBsNG2rMARPpgFKQYqyVlMv6AxF5os0/UrUMtEfdZoyn+gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maPbzrXm1BYgWLaGxjScpl4gT0rwYvbwp5JqKAt7VHw=;
 b=du9Hn3hyXfJKMx75Eo33EYkOL2o9AVow8faBpT6gDm80P0NWKKy2Z2qpPyyMLRgzTFwC1d54H517FCuupYRsJaCrbiRiNODxMz0NsHU+Qpv8NndXJIzdN+FBBwyZUay2lUhhiLtFm4qO8S/76WOxpVp85L3cbHbyBDe4NGvD1Q4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 14:49:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 14:49:04 +0000
Subject: Re: [PATCH 1/8] block/vdi: return ZERO block-status when appropriate
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-2-vsementsov@virtuozzo.com>
 <496d65c2-ae7b-7456-532a-9acc90d1f926@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506174902149
Message-ID: <4785498c-1ee9-d7ad-ca7b-71471a91c3d4@virtuozzo.com>
Date: Wed, 6 May 2020 17:49:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <496d65c2-ae7b-7456-532a-9acc90d1f926@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:208:3e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29 via Frontend Transport; Wed, 6 May 2020 14:49:03 +0000
X-Tagtoolbar-Keys: D20200506174902149
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c80eb1-449a-4200-9a09-08d7f1cc9f03
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538404BEE34D47BFFDBF9F30C1A40@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glFrjn3XMMAro+aw9IGuQU6j2AqU5MDzvAUFXEgjL5m0saPiM4n7SeFK4bsSZzpR9qSy2CFgXCDiDJZeHjd2x6/6mFieqOB6rxq0XrJxIMGWpby25N3frVimIT+MbGr1MaDmtUT2ZSvZfs5+1LVfzn5iVb6B1r2hw8NIsrGMSbjus8LZ2hiVdOvcNlUB6M4R3ycGTK5Oq7c+ihEwsAAhn7/hESBlZSpPMKLcIw613t/EDxiYrBu1iNF9R62bQ84eFlEcViyPZdZIRm0+HNKf7Un4v1SXdUkng/0tvlAbOq1Tu1Yo1OVs+GLUqlRupCOhMhF+8qJqEBFqDmp4pjZejPLkcIoGm3/vueu0hft68r8qP/y8pDB2WN1CMWAUCGbTH3ExLmHr8cM/1ETaE1GpWNmDxkM4RTD5TsP1MyLSZxQgjrDloVSOQ+OunMyXUmXlcpgw355XFgUyFxNrLvq2IFJjQr4hT1AouukzMRH14Rnw46YxVufFZESGSvNsmhJmyNqGMQ+kYdJ4Bm8MdgwCaRWT3OcDfXtwBKCgmJDrOWMIFmKovK3V8QJU48zc2R51M+7moZ1syUxzXefu2yd7Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39840400004)(366004)(346002)(33430700001)(66556008)(66476007)(53546011)(66946007)(316002)(4326008)(16576012)(36756003)(52116002)(7416002)(33440700001)(186003)(26005)(956004)(2616005)(2906002)(478600001)(31686004)(16526019)(5660300002)(8676002)(86362001)(6486002)(31696002)(8936002)(60764002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: U3H5O1wc52W9O20jNqzVSZtQSx9tkwTR6pevnnfNkr6kmsIBl3RnAxJBfGZXpE6u6b58vyzTkBV8OT2BRSwJMLZVpv/53lIPsWV6Z1n3c3XKWGYQqtU6WoAI1DXzgsOANjeAjPi91cwLHZgE2/mpFYlb5P2qHYb5LYo2WfSXNgdlIDjXLCeTfdYBFQR8KUW52WvvN3RVrNJZ+ay/pwOQnXFzMNnOBy8hFNXi2W6XHwUw7F8sj3pC/MMlaDyRUXdZk4mShrmGOtgcqlZbO767gX9mLV+K1pgFBCzLL2bC7avZR3UPsu0NQ9PdK7kyxB28BZslw52121QBX6eYcpA17HDAFrUmEv6edw5W9PXf6bl4RvaDYnY/emYSEXkJKQFFzkojoVvxOtBlNIk9Q6JInrkVurkjbPZdlImmqbTgKnILEbpPM9NMVqYrdhuiFeQ0ux/NvyduoL7jFfo5Ghi/nUJIyQNxFzZeOVGAQDwmuAifjD7xd1zltTGyEGoZ6SB/kYKnjpN80hi9MymJmTGelTgRpfNyv06L9wckHEXAzFn5HC9OPFWHaPGrdByz0y3UgUCmlCYAD9oghgL1d4BI4ICVvwVl7W+qJuPm8T/l5MXJdjAEFp3qh0EroVcSWxr4qmdIzjeNU+Vno9l9eUMoqAi7iL+kmP8fYXXzE7u0zMu5dXm1pq2aDdcluN1Iy59qyDAw3opIO/GoAiTE9Kp3EiG+9kNBrwBGfvOnVLHCK9eJbZX8tlC1fW13s7TMNR5dc7ziuS8/qEsNJXNqWHYX9WtFDoNven/W966T4L41QPs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c80eb1-449a-4200-9a09-08d7f1cc9f03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 14:49:04.2786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFiQJ0X+mOLxO0aMws0HDd3Wh12dIn6Dq4NfOzmbJYKOzOdpEYiK7p3E9J3zqsr9I2boy90VV8KqjxP0KFPKr1ZfN3KcgUBrSplt3ioLiLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.8.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 10:49:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.05.2020 16:57, Eric Blake wrote:
> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
>> of qiov. So, this should be reported as ZERO.
> 
> This part makes sense outright, since vdi does not allow backing files, so all reads of a VDI disk result in data rather than deferral to another layer, and we indeed read zero in this case.  However, it _is_ a behavior change: previously, 'qemu-io -c map' on a vdi image will show unallocated portions, but with this change, the entire image now shows as allocated.  You need to call out this fact in the commit message, documenting that it is intentional (it matches what we do for posix files: since neither files nor vdi support backing images, we guarantee that all read attempts will be satisfied by this layer rather than deferring to a backing layer, and thus can treat all data as allocated in this layer, regardless of whether it is sparse).
> 
> Do any existing iotests need an update to reflect change in output?  If not, should we have an iotest covering it?

all passed for me on tmpfs (with some skips)..

> 
>>
>> After block-status update, it never reports 0, so setting
>> unallocated_blocks_are_zero doesn't make sense. Drop it.
> 
> This is a harder claim. To prove it, we need to inspect all callers that use unallocated_blocks_are_zero, to see their intent.  Fortunately, the list is small - a mere 2 clients!
> 
> block/io.c:bdrv_co_block_status(): if .bdrv_co_block_status sets either _DATA or _ZERO, block status adds _ALLOCATED; but if the driver did not set either, we use bdrv_unallocated_blocks_are_zero() in order to set _ZERO but not _ALLOCATED.  This is the code that explains the behavior change mentioned above (now that vdi is reporting _ZERO instead of 0, block_status is appending _ALLOCATED instead of querying bdrv_unallocated_blocks_are_zero).  But you are correct that it does not change where _ZERO is reported.
> 
> qemu-img.c:img_convert(): calls bdrv_get_info() up front and caches what it learned from unallocated_blocks_are_zero about the target; later on, in convert_iteration_sectors(), it uses this information to optimize the case where the source reads as zero, but the target has a backing file and the range being written lies beyond the end of the backing file. That is, given the following scenario:
> 
> qemu-img convert input -B backing output
> input:   ABCD-0E
> backing: ACBD
> 
> the optimization lets us produce:
> output:  -BC---E
> 
> instead of the larger:
> output:  -BC--0E
> 
> Do we have any iotests that cover this particular scenario, to prove that our optimization does indeed result in a smaller image file without explicit zeros written in the tail?  Or put another way, if we were to disable the post_backing_zero optimization in convert_iteration_sectors(), would any iotests fail?  If not, we should really enhance our testsuite.
> 
> With that said, we could just as easily achieve the optimization of the conversion to the tail of a destination with short backing file by checking block_status to see whether the tail already reads as all zeroes, rather than relying on unallocated_blocks_are_zero.  Even if querying block_status is a slight pessimization in time, it would avoid regressing in the more important factor of artificially bloating the destination.  I would _really_ love to see a patch to qemu-img.c reworking the logic to avoid the use of unallocated_blocks_are_zero first, prior to removing the setting of that field in the various drivers.  Once bdrv_co_block_status() remains as the only client of the field, then I could accept this patch with a better commit message about the intentional change in block_status _ALLOCATION behavior.

Actually unallocated_blocks_are_zero doesn't influence on this thing, you should not check unallocated_blocks_are_zero to understand how to read unallocated area above short backing (after backing EOF). It's always reads as zeroes. So, patch 7 just use "true" instead. But yes, I'd better move patch 7 to be the first one.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/vdi.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/vdi.c b/block/vdi.c
>> index 0c7835ae70..83471528d2 100644
>> --- a/block/vdi.c
>> +++ b/block/vdi.c
>> @@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>>       logout("\n");
>>       bdi->cluster_size = s->block_size;
>>       bdi->vm_state_offset = 0;
>> -    bdi->unallocated_blocks_are_zero = true;
>>       return 0;
>>   }
>> @@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
>>       *pnum = MIN(s->block_size - index_in_block, bytes);
>>       result = VDI_IS_ALLOCATED(bmap_entry);
>>       if (!result) {
>> -        return 0;
>> +        return BDRV_BLOCK_ZERO;
>>       }
>>       *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
>>
> 


-- 
Best regards,
Vladimir

