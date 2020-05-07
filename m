Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1AC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B17A208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mHDsxsPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B17A208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWabd-0000T9-59
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 03:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWaap-0008IH-7u; Thu, 07 May 2020 03:05:15 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:49891 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWaam-0006g8-FN; Thu, 07 May 2020 03:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yufo6BzG0hw1F0oOVo/9wCdwo11YcQ9mrbrh/HSkVKlTtrZAs2jjw62+eCyOyWCLVwDfK3DdViJgUmVBLDDSub1trwGHeo3oW5oE/f/bXhKhBvz1ypMZQfFyDg7EIXFCCWgI8P8ASb0qGsH/EjzbND44TE/Qzmy4g63Su21Biug4keqpHqihZFpNhv+g4uZZcOso7ex644/r7nDbb3cHJE8hsWoX9Zaru724naAEuIh3Ipxf4T3A0+iMUXjdZdBNEFMI5CmrODFAYphQZB6X3HmICg1YU45ts4jENnAcluG8Cyy0OUF4NHTlQDYpBarGzlDaT40bTOLPFS49vXrKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ayJ1VRjH9mPvPkJnKjtt+msUAqwsopcYYIgp406QY8=;
 b=hLVvTAnjS1haVVhco0/fUwLjrZHYsl5kIakwXQVAPAin2dKAhAXcozi3qIXRxLRaoMyhWHb2IbWy5SoMi0kIYWDXjsE55QSOpctsx9LAX4BMGtCDykAayBmSElVSGNekrvx6kG7e5RR/JGy8tiXAreDkxNWYbmF76LM6ff2ALDl94pccseDksYvbrJOudTL0Am/2AYT1/sObpKZgBgT3Qc5WbJ8zst7qUYozGww0abSuaIoFy3tx8q1I+CIe49agT5Y87DCjDP2Rwqv4+fR4oJIrIGgx64jTBr/jUSZr2AVThAaHuq8Jye52pVbetn+LkBDBUzU8/83U7l6rtS9lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ayJ1VRjH9mPvPkJnKjtt+msUAqwsopcYYIgp406QY8=;
 b=mHDsxsPHzcpdO+QZrP3Nkv/08KoHICbMiW9VovJFcVerXqK/hve36kWHr7EiPzk1uT+wEXpc+MteRxDTtvZ//6qov4vld3kaVjgAVsnoa/zZnMEYddnZA/HbZLCJddBTaDbcSVBqLFfnB5FGOiSZEgK+UcGwaMXYZoO7K1bQeA8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5413.eurprd08.prod.outlook.com (2603:10a6:20b:10a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Thu, 7 May
 2020 07:05:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 07:05:03 +0000
Subject: Re: [PATCH 8/8] block: drop unallocated_blocks_are_zero
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-9-vsementsov@virtuozzo.com>
 <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507100501347
Message-ID: <903973be-6af6-edd3-3509-b7688e0bb8d5@virtuozzo.com>
Date: Thu, 7 May 2020 10:05:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0028.eurprd07.prod.outlook.com
 (2603:10a6:200:42::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM4PR0701CA0028.eurprd07.prod.outlook.com (2603:10a6:200:42::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.17 via Frontend
 Transport; Thu, 7 May 2020 07:05:02 +0000
X-Tagtoolbar-Keys: D20200507100501347
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedc6003-1e20-45de-2e8e-08d7f254f706
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB541331F48A0D03BB23D52761C1A50@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rwsDSpFLtvGBVy9H8ba3Ho0u4Mm/OmgU70w3bHakGd42E7vZiZ6hC4OTX2rHezuxKeja+kJuXOGjykkgPjFTijKhLLVFnRw5YkNFeHhOfyVIcnY9ERrY6PKq/Cjqh0E5EC5OHNXaWBmBO/PWfqoEJC2YwLpfLmCZnk1V/4Ru/yrmnCEhqyfljKXFZXePJC5sLNTRfrbki/8F/MDKzteLBnbGB3ZU7JWZWZYXL9Y2y9thzEOL54cD1ctqQAxNngy2FAvxnVdwdB0b2+diC0L7DHwv749yUCPXNWMokppKHupLk3J6nY+mpCg8eZkN0IWidQxpWSC3htyP9dQbgEmmaM9cegvTZuBEjDCR3wPeZTrT2TjnOW13I30xV5ZnhWml1BE46/GeTow4M9yfVtum+QYSmpAk/a+xdAqGysgl/Axst1Dy7sjgpV0NacOxcUA/ROzzwBp2VAfV72wpM1PozhBNwh6Viwa4XV4Oj9/o85Cinms9NiiHpl0SJ7zgEIMSXLYrKvcvi921kzuVfaQ0RUpqIp8JDFQEFFA1vONw6fB5CQ0M1pC5zacTUFiADHh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(33430700001)(8676002)(66556008)(66476007)(66946007)(16526019)(7416002)(36756003)(956004)(2616005)(83300400001)(83290400001)(83310400001)(83320400001)(83280400001)(8936002)(31696002)(2906002)(16576012)(478600001)(186003)(31686004)(26005)(52116002)(6486002)(5660300002)(33440700001)(316002)(4326008)(86362001)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GqibZ401vBv/z+XXLPclgS5vCIjhT3Wgrs8vt2p3Ni2hdnHCMJES3by3ci7t46vPWkRJXg5q9XKce7tOkJ1fnGXvcRfs370aCJeFyxbtPh16O9lQZ0B/mzCVAjhHYH6DmhQ1XL8li+lueJpQK0C29Ka8wfDLNjRAhs90stR9RJz1CHTN17fcEagPP5LXuHrGG/JsOY9/8prhRCyCXEFPPGUfHDXOpzcjboQHCU3Kdl7uew/zH9Bz2RCjTbDPKJslFNIy9SuyZ85LmwfNh7m2eZfBi6m9LmL4XBlFkKf0BDXme9N5hC8aX4fwO/yhTtELNzfM9LBX5u7Nkb9R+xSqu1yPfN2avk7P+zxVnXEOe7Lgli1TKTapOfSVKKGBsjshtI3oA4QLOEdhRHNmHPkSQhKURVTseeJdnn+5QJg3vZu44fMJVThjIsFePtXaduloDGmK63IaVEb+vLNZNBGjXwsPghrcJzOgE+QPdg4tzlUBH0Vr4PcBFXkOIMbzQlQOPy6vKY2vrZmgGxG8gF+2STs4cXtmJwIKTQKn1qxTFeHVzX1Lt3ldvhZqvUiC/PwvYCKmFxJu85jw415Pqs2f/VJ2M16rVjfskg+tt6vNftQYaOdUbpqzigk2/bHllhVIs3WoL55cWu8lhR4l2ISfbtm4n0V0KmVJ1oHbVDWjQlkbxQYlbuKZdzLzHPcNsmcOsP5i5UF5AjQMBh7r5Eq/VPGwVpn7tUHWw6o6TGQzbQ3L5jxmKos43mlLyZyk32osIgkvSFVn+t3j4PFKPdg54nYOrnFmWQCD7poJoKEDxD0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc6003-1e20-45de-2e8e-08d7f254f706
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 07:05:03.7571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFmMEOKEhQNS/IcDz3OQsXbYQH5Qiy3jP74H0hRgHKZRDBvzqubLX186+ZV/ssv3M5DF17+Wlu81CLERGRu6CbOT8xn1j9MEy+XA1DEBYrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
Received-SPF: pass client-ip=40.107.8.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:05:05
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

06.05.2020 18:14, Eric Blake wrote:
> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Currently this field only set by qed and qcow2.
> 
> Well, only after patches 1-6 (prior to then, it was also set in protocol drivers).  I think you might be able to hoist part of this patch earlier in the series, to make the changes to the protocol drivers easier to review, by rewording this sentence:
> 
> Currently, the only format drivers that set this field are qed and qcow2.
> 
>> But in fact, all
>> backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
>> this semantics: on unallocated blocks, if there is no backing file they
> 
> s/this/these/
> 
>> just memset the buffer with zeroes.
>>
>> So, document this behavior for .supports_backing and drop
>> .unallocated_blocks_are_zero
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block.h     |  6 ------
>>   include/block/block_int.h | 13 ++++++++++++-
>>   block.c                   | 15 ---------------
>>   block/io.c                |  8 ++++----
>>   block/qcow2.c             |  1 -
>>   block/qed.c               |  1 -
>>   6 files changed, 16 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 8b62429aa4..db1cb503ec 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
>>       /* offset at which the VM state can be saved (0 if not possible) */
>>       int64_t vm_state_offset;
>>       bool is_dirty;
>> -    /*
>> -     * True if unallocated blocks read back as zeroes. This is equivalent
>> -     * to the LBPRZ flag in the SCSI logical block provisioning page.
>> -     */
>> -    bool unallocated_blocks_are_zero;
> 
> You can't delete this field until all protocol drivers are cleaned up, so deferring this part of the change to the end of the series makes sense.
> 
>>       /*
>>        * True if this block driver only supports compressed writes
>>        */
>> @@ -431,7 +426,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>>   int bdrv_has_zero_init_1(BlockDriverState *bs);
>>   int bdrv_has_zero_init(BlockDriverState *bs);
>>   int bdrv_has_zero_init_truncate(BlockDriverState *bs);
>> -bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> 
> Doing this cleanup makes sense: there is only one caller of this function pre-patch, and 0 callers post-patch - but whether the cleanup should be at the same time as you fix the one caller, or deferred to when you also clean up the field, is less important.
> 
> If I were writing the series:
> 
> 1 - fix qemu-img.c to not use the field
> 2 - fix block_status to not use the function

Hmm stop. We still need patches 1,2 before modifying block_status, otherwise we'll still need to check unallocated_blocks_are_zero

> 3-n - fix protocol drivers that set the field to also return _ZERO
>   during block status (but not delete the field at that time)
> n+1 - delete unused function and field (from ALL drivers)
> 
>>   bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>>   int bdrv_block_status(BlockDriverState *bs, int64_t offset,
>>                         int64_t bytes, int64_t *pnum, int64_t *map,
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 92335f33c7..c156b22c6b 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -115,7 +115,18 @@ struct BlockDriver {
>>        */
>>       bool bdrv_needs_filename;
>> -    /* Set if a driver can support backing files */
>> +    /*
>> +     * Set if a driver can support backing files. This also implies the
>> +     * following semantics:
>> +     *
>> +     *  - Return status 0 of .bdrv_co_block_status means that corresponding
>> +     *    blocks are not allocated in this layer of backing-chain
>> +     *  - For such (unallocated) blocks, read will:
>> +     *    - read from backing file if there is one and big enough
> 
> s/and/and it is/
> 
>> +     *    - fill buffer with zeroes if there is no backing file
>> +     *    - space after EOF of the backing file considered as zero
>> +     *      (corresponding part of read-buffer must be zeroed by driver)
> 
> Does the driver actually have to do the zeroing?  Looking at qcow2.c, I see:
> static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
> ...
> 
>      case QCOW2_CLUSTER_UNALLOCATED:
>          assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
> 
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
>          return bdrv_co_preadv_part(bs->backing, offset, bytes,
>                                     qiov, qiov_offset, 0);
> 
> which just defers to the block layer to handle read-beyond-EOF, rather than an explicit memset in the driver.
> 
> So maybe you can simplify to:
> - For such (unallocated) blocks, read will:
>    - fill buffer with zeros if there is no backing file
>    - read from the backing file otherwise, where the block layer
>      takes care of reading zeros beyond EOF if backing file is short
> 
> But the effect is the same.
> 
>> +++ b/block/io.c
>> @@ -2385,16 +2385,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>           ret |= BDRV_BLOCK_ALLOCATED;
>> -    } else if (want_zero) {
>> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
>> -            ret |= BDRV_BLOCK_ZERO;
>> -        } else if (bs->backing) {
>> +    } else if (want_zero && bs->drv->supports_backing) {
>> +        if (bs->backing) {
>>               BlockDriverState *bs2 = bs->backing->bs;
>>               int64_t size2 = bdrv_getlength(bs2);
>>               if (size2 >= 0 && offset >= size2) {
>>                   ret |= BDRV_BLOCK_ZERO;
>>               }
>> +        } else {
>> +            ret |= BDRV_BLOCK_ZERO;
>>           }
> 
> I like this part of the change.  But if it is done first in the series, it _does_ have a semantic impact on protocol drivers (previously, protocol drivers that return 0 but set the field .unallocated_blocks_are_zero will be changed to report _ZERO; after this patch, protocol drivers do not do that, because they don't support backing files, and it is now only backing files that do the _ZERO magic).  So doing _just_ this change, along with a better analysis of how it changes the semantics of 'qemu-io -c map' on protocol drivers while mentioning why that is okay, would make a better start to the series, rather than here at the end.  Of course, if you defer it to the end, then none of the protocol drivers set .unallocated_blocks_are_zero anyway, but that cost more review work on each altered protocol driver.
> 


-- 
Best regards,
Vladimir

