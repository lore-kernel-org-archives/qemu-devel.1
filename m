Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F91B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iCcg6e3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F91B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1Co-0006kX-Hi
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jc1C7-000698-Hp; Fri, 22 May 2020 02:30:11 -0400
Received: from mail-eopbgr50100.outbound.protection.outlook.com
 ([40.107.5.100]:17063 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jc1C4-0006PX-PY; Fri, 22 May 2020 02:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM1fHEN1G+zHxhmOTHkeM4diSFuSL/uU5PQnu0c7s4BUGNWeMX6iPbFT0XYV4QqGM6gfNemDi+y4fFYQdGzoZmUCCS7uqtyf16plZZKfKYIEkT8H2EHOLQRjsfcMRb4kYF2Xj/qH7RoF3ueem4SQEiquH+34PlucECpUcqgw/XVY0NWf4N/C11iamQo0roPO9UknqrT0STSn/z2uu6Z+f64JsveNdywcLwARTAt7i0rN48Nh0XHJZVipsVsBIZlCWrVMgci+dsbLGxJCJnt2MdKIGwws0x7EWNkeGXh7mlWfou952LYuuu/iVP6Ku/lctxRV8FyqSTwpsnpamTFxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa451ZO5Isoq31HOf/jARoEYpEbuWpbqPK5wKutlAAU=;
 b=A5EYPCN25LfbwfsZiJ7EheEGzbP3lj2fnFibQRBB4Q3p5HJR2zr/MLKlGm7kKuW3KllOKzyWzDOw8i+VZoxaxSxezJM0zkqKbrn1v5VubLkadDjMcA7y2BDVIeyGFj8Cp0f8A3MHjyRtLeosgOL6hHIjppYW/gCpQYIhVZ/29tSc4Hzhw6f114pCgFDFsRhTZAaP31rqHT7G5PS71W2Gj/iY0vF27a9zTQgrLIS33PLs+PSfTWiTIkstCH2iQ0QMsyUFXnmMyzULLEk51SvQ0nN8lEGmj4y67U7p7zpmy1I8MzRv6TTxYv/HoxBbT85FVjxs1b4CZ8FWXovz3vgBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa451ZO5Isoq31HOf/jARoEYpEbuWpbqPK5wKutlAAU=;
 b=iCcg6e3gWKMHN6DVwhjRY/LTR7bmsXdlmwPx5H2mDDhwIoptERh6cvp3fR2VASxpPzEPlh/5An3Wg7N4Y9dTIoWXVkiN+kPjtpODGJ2hPubpfEi5jm/dXPCJjQ2fug2iwPS6wtexYxxMonFK1Y73vGGhDzqIIB6IX4Ww5NyD7YE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2638.eurprd08.prod.outlook.com (2603:10a6:802:1f::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 22 May
 2020 06:30:04 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%6]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 06:30:04 +0000
Subject: Re: [PATCH v3 07/17] block/io: support int64_t bytes in
 bdrv_co_do_copy_on_readv()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-8-vsementsov@virtuozzo.com>
 <918dca07-00f2-af0f-b410-54537524e5ef@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c89426e8-acc5-b2b3-2c4a-dd051ea07779@virtuozzo.com>
Date: Fri, 22 May 2020 09:30:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <918dca07-00f2-af0f-b410-54537524e5ef@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::36) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR01CA0131.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 06:30:02 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 500f8d60-8c38-4191-700f-08d7fe199006
X-MS-TrafficTypeDiagnostic: VI1PR08MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB26381732DA1B3B0EAEF8A649C1B40@VI1PR08MB2638.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7CzSKblEirrsadzhvq4/ZnTGeHusP3Uft4D3oUpwrj+TkSJm43TrRXqvp7vgc/0T/K6ipa1Hdsny6p9zWLiuezQLxfPRY8GAx/qVFoaUVZxTGIVIMpYhmqd6ZS3z0n6I90N7AZ3chwblYyWEwN2oqsEsEW5NWb4KzQoUVAgVmbvRkYdcNs32h1uj/EBdqpACRJxZMqDZeKm0jAAypzY5FMN01XrT/pI1Hic+/F5athEU41EvuuFhwJI8AP424kjf7XCcwbqUuIyFAiypLoaondsItiPk7VULLyh6PgJEJUqrJ8Z8z5R5IWzIgygdoOqWkt6BMSP8Iy1URibStH8+V7+8FKGUA9MCZBNrtNIPKlfWuf9OBkaf/rPb31kiNr3VJVHgs/Lbn95tmF4f7v3LFiEJFhiXc7M9p3K6ZoM5JKcCco/ippgpWedZ6zj4Tf5FRDlT3Qmt5TZ+OLlgCXzyWffMZogu9EsAXtd0hWvsTgCdmfGIV0M1MmTaa3GHk06
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(136003)(396003)(7416002)(4326008)(478600001)(186003)(956004)(8676002)(2616005)(53546011)(8936002)(26005)(86362001)(66556008)(6486002)(16526019)(66476007)(316002)(31686004)(2906002)(52116002)(31696002)(66946007)(5660300002)(16576012)(107886003)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OUuuoWOVtX/JoJU2LV83OXLOdcmZli3Nmn2t3DBQf90UfKhHQeLk91O1AIyYH5+wOzwVTHmI1C/LD3FAjWag6xFl8/J965i3vQ/1CsAaXBbk8VrDVJEMy5flTWfnv2pdGT28CJRBQkZGNczV8/+as8+1YC1yInpnfIuoTbMYxugKyrNZCr02Ff+FXDrMGW5fA1nl+lflrsqQyjmaYj3QqOgpHWSUTRr8q0I4xv1UBOAEkBvMWKUedpaiGctw04AvEdSFq6SI+N4wF0pPwcdpQKqL/U0blx6l7Af3fmsA4YdLu8oS2c0/KpJS/p1eQzzT0KqAu1u7IbDTy2YsM3L7EMTNYiPVBLb1/km5//hr6aouBQA3nmoUgN4VqlLhfjK/wyFD9Jc6pe+Zzpe0khQ6o3n5YH/nuhjHhhnpl71HtE7tmjXcNlQcgXjMtM7BGtQyvqtSvVzp54H8JEL/L4hRCgXnBdz5FIDnfqu1fxrzrd9gurGDTDCqLz4hdhcJrwlX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500f8d60-8c38-4191-700f-08d7fe199006
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 06:30:04.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDIsZJz10i7YbSpjFmZ5MWK/V3FNt/jTKSbNm4rhMNgbwq33Yt/MFPb7Zudoh2jQjIAO12Y4CAhl3jgZkFqLwqJC/sNKqAmkg5zLiE0EaTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2638
Received-SPF: pass client-ip=40.107.5.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:30:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.05.2020 01:29, Eric Blake wrote:
> On 4/30/20 6:10 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths.
>>
>> Main motivation is realization of 64-bit write_zeroes operation for
>> fast zeroing large disk chunks, up to the whole disk.
>>
>> We chose signed type, to be consistent with off_t (which is signed) and
>> with possibility for signed return type (where negative value means
>> error).
>>
>> So, prepare bdrv_co_do_copy_on_readv() now.
>>
>> Series: 64bit-block-status
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c         | 6 +++---
>>   block/trace-events | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 8bb4ea6285..6990d8cabe 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1088,7 +1088,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
>>   }
>>   static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>> -        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
>> +        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
>>           size_t qiov_offset, int flags)
> 
> Widens from 32-bit to 63-bit.  One caller:
> 
> bdrv_aligned_preadv() passes unsigned int (for now) - safe
> 
>>   {
>>       BlockDriverState *bs = child->bs;
>> @@ -1103,11 +1103,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>>       BlockDriver *drv = bs->drv;
>>       int64_t cluster_offset;
>>       int64_t cluster_bytes;
>> -    size_t skip_bytes;
>> +    int64_t skip_bytes;
>>       int ret;
>>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
>>                                       BDRV_REQUEST_MAX_BYTES);
>> -    unsigned int progress = 0;
>> +    int64_t progress = 0;
>>       bool skip_write;
> 
> Use of 'bytes', 'sskip_bytes', and 'progress' within the function:
>      bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
>   - safe, takes int64_t. Pre-patch, cluster_bytes could be 33 bits (a misaligned request just under UINT_MAX can expand to > UINT_MAX when aligned to clusters), but only if bytes could be larger than our <2G cap that we use elsewhere.  But even if we relax that 2G cap in later patches, we should be okay even if 'bytes' starts at larger than 32 bits, because we don't allow images that would overflow INT64_MAX when rounded up to cluster boundaries
> 
>      skip_bytes = offset - cluster_offset;
>   - actually oversized - the difference is never going to be larger than a cluster (which is capped at 2M for qcow2, for example), but doesn't hurt that it is now a 64-bit value
> 
>      trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
>   - safe, tweaked in this patch
> 
>                  assert(progress >= bytes);
>   - safe: progress never exceeds pnum, and both variables are same type pre- and post-patch
> 
>              assert(skip_bytes < pnum);
>   - safe
> 
>                  qemu_iovec_from_buf(qiov, qiov_offset + progress,
>                                      bounce_buffer + skip_bytes,
>                                      MIN(pnum - skip_bytes, bytes - progress));
>   - tricky - pre-patch, pnum was int64_t, post-patch, we have three more int64_t entities.  Either way, we're passing int64_t to a size_t parameter, which narrows on 64-bit.  However, we're safe: this call is in a loop where pnum is clamped at MAX_BOUNCE_BUFFER which is less than 32 bits, and the MIN() here means we never overflow
> 
>              ret = bdrv_driver_preadv(bs, offset + progress,
>                                       MIN(pnum - skip_bytes, bytes - progress),
>                                       qiov, qiov_offset + progress, 0);
>   - safe - takes int64_t (earlier in this series), and same analysis about the MIN() picking something clamped at MAX_BOUNCE_BUFFER
> 
>          progress += pnum - skip_bytes;
>          skip_bytes = 0;
>   - safe
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks! Hmm. I'm afraid that I'll rebase this back to master, postponing "[PATCH v2 0/9] block/io: safer inc/dec in_flight sections", as I doubt that it is needed..

-- 
Best regards,
Vladimir

