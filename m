Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758C2206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X3ryQkBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758C2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalwE-0003YG-Ht
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jalkA-0001Wn-2s; Mon, 18 May 2020 15:48:10 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:49534 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaljz-0005jB-JJ; Mon, 18 May 2020 15:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3JG16PNo9opx9EbBuk7uKfBm4Fzncktl70ZmKm7+sMMy0U5N6gsvScGMLhi3Y9RUs75edpZufTA6WnGrARjjCOIqelMcB8yxuLTjEfrwA7iFU/wzh/medp8VPYVjoeAtAY5xFjnVj0CcuXOdoaYMKYWeLuE8mS3MIh3xjD9wMelM4eY9FgmV+I1/laVe7TxWIMLub8dgTD4gUS0S6PCU2KyBXE2b7C51OhFQlyaunOHRXm++y1rw3S1AUcUyINr8ATzSYbQF1opau/unD5IKG3JYmYy41puCNESadMn9cJzpnRhP2LNyRmWkJPMtLn3p34LDQifacS2JcSoZLG5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk6hMg2Ll51AUN1kRSIRJ0MkjeuW+45u0VTwWNWb7SU=;
 b=SYEJUYpDOhb5ULNGKkPF1i/O/qJPV+MA/wjNk3/ZnfqxUZ/4r+9dis1fyCvZftGYkNXspjYxt6OgG8cSzniQshJbYuBXU/OdoCdTsDpF9rEi0eeKf0FSaGl21nWkf6MYzN/uwpxJfEZn671rI4KfhFvB7n9XePh05Y/r5D17RC0NDTcNhKyFEuI2GnOOwpxv9xVKmZ4egWmpoe2Z9paVzCaNno+yJyMAmePyUnL2SvsqpkcAk/7ICq51VBppNXtNOBchYZecS3ptZIpWLaj+4jlHss+gsEtFW8lS4EC7PWFaofyBh18K7Ugj/tao5LxTZyim/K9D1QUml5WSi8I+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk6hMg2Ll51AUN1kRSIRJ0MkjeuW+45u0VTwWNWb7SU=;
 b=X3ryQkBMHdtNEwD2T7NvBSEsVy5TPF/rYEVM3TyOSwPNbgHu/MFC8duJCRoLF23I1svlHqr1SAd07zm2wwJ6EJcYRBTDPpB8X3ukW0EjydSO5CqeWo9mHj1n60gQ0Q1yDqiEfLzGyJuFLjG8BZXZw/WMiSYx3CbGsH5J5wWqqzg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 19:47:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 19:47:56 +0000
Subject: Re: [PATCH v4 7/9] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-8-eblake@redhat.com>
 <dcca62f0-3960-a9df-61d1-a6b9c2b1cf17@virtuozzo.com>
 <a61b5d9f-ecdd-d37a-4df9-727a5c105b41@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f25ae162-b3b2-3d40-7066-965c626d3da6@virtuozzo.com>
Date: Mon, 18 May 2020 22:47:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <a61b5d9f-ecdd-d37a-4df9-727a5c105b41@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:208:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Mon, 18 May 2020 19:47:55 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ccf7559-595f-4633-5a4d-08d7fb645c3a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-Microsoft-Antispam-PRVS: <AM7PR08MB530198B0630F331DC355173FC1B80@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exb07aQZfCfBftXFXXkTj+hHzxFqG9Bgp9nnj1+3bSd9pMtFySJcK6fGRuZljjwOTRJZtd2PsxWshIzgj/8XGDODuz3JHC9iDLbu+OHrrn1/noy+2LZwuVHdDD14pDjtZtFTAabH3KU+92C38TLx+5IPtTnBmRlh2S9z1z9qYpm1ha5PKqi3vnnH8gILjeaQfAgGMMwcWv22oHrPCKimdwiMwAGVX1eFDmOILx/dDE5TMjGd0vKCEOzbxTJVcYGo3Xu7iG+4batAql1viq8KSq/2Vp0Y7N5G9tCbTTl6pzXDRgwipneaBu3Aa1lWiQPoPT83AkCoRHIijlocQsbcpDN3GDbymFHggpOMMwKEllA1L1aNoAk8hDEi92z4/ioyD5s/+IAgyeQF3hFqDlZAwmILjCLQN/zELDbxI3Q6UWMW29Nj7g5syc9qDGkf1qrYJZ4zIeGXTRy/rGN0mdknvtoY9VMVXZymQTCGrO2xVPCDIhXIFUSD7z7pU00VQsnZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39840400004)(66556008)(4326008)(31696002)(66476007)(6486002)(2906002)(36756003)(52116002)(86362001)(8676002)(53546011)(8936002)(956004)(2616005)(16526019)(316002)(66946007)(5660300002)(186003)(16576012)(31686004)(26005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wEzeMB8ujCfR+TRRYPi2NJPtEP6/ycdn8rplxOuwAl9OfII/OsbZNDkxUmbVf97Q9NgScUbA5bn3UAQgPq5FQe/gbee6eoygHXo6nmYgWv2lhzdzs4c76iIWu9hxrvpILJmaJsMtde0jMrVpxKsI3ZQ5HOd2D0w80MHSXxPtr9kipZ2c3acl/zt5IaZg8eEbzNRLCQf6oundvCiScGyg5cQxJQ80nf442d2IpvWf/Gd65Aen5TFrw/PnVbkHE/z/nTZ2cHzHkY48EvCWmXIe+4vsoR8Tzt3xxkmSFPA2/6Z6CpaXRY0srykB+J6nIa1cUti72pwhBfGAWB2IbBTv+yF1wsxPk5XBSEvXvtrUtziooLZpGPvsP9m5kZYGurTmoPT3/DygQnCzjtH1nyI4NWrVqW/g4qIOag9pvonnd/PhY4ziWCym00kp4tpDG911vPtCJ8vn+imlQ/m4qyahhYJCwf4ZSxPWGUAeuQncgEtiEx3UfCJl1XNWxvD3Zgl7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccf7559-595f-4633-5a4d-08d7fb645c3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 19:47:56.0118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdGCGaDUm/xHKkfwr5hDbTB4qYmHgA9HzJzpgYa6q9bkpdf7zl/og4+AOSGymmRN15mJytFPOFuqX3KK6xLSAQYFquj9HPTm2qb/ueF6qr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 15:47:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 22:17, Eric Blake wrote:
> On 5/18/20 8:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 13.05.2020 04:16, Eric Blake wrote:
>>> It's useful to know how much space can be occupied by qcow2 persistent
>>> bitmaps, even though such metadata is unrelated to the guest-visible
>>> data.  Report this value as an additional QMP field, present when
>>> measuring an existing image and output format that both support
>>> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
>>> coverage in 190 demonstrating non-zero values made possible with the
>>> recently-added qemu-img bitmap command.
>>>
> 
>>> @@ -616,6 +616,7 @@ Command description:
>>>
>>>       required size: 524288
>>>       fully allocated size: 1074069504
>>> +    bitmaps: 0
>>>
>>>     The ``required size`` is the file size of the new image.  It may be smaller
>>>     than the virtual disk size if the image format supports compact representation.
>>> @@ -625,6 +626,13 @@ Command description:
>>>     occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
>>>     and other advanced image format features.
>>>
>>> +  The ``bitmaps size`` is the additional size required if the
>>
>> you called it "bitmaps" in example output above. Should it be consistent? Either "``bitmaps``" here, or "bitmaps size: 0" above?
> 
> "bitmaps size: 0" is better. Will fix the description above.
> 
>>> +++ b/qapi/block-core.json
>>> @@ -633,18 +633,23 @@
>>>   # efficiently so file size may be smaller than virtual disk size.
>>>   #
>>>   # The values are upper bounds that are guaranteed to fit the new image file.
>>> -# Subsequent modification, such as internal snapshot or bitmap creation, may
>>> -# require additional space and is not covered here.
>>> +# Subsequent modification, such as internal snapshot or further bitmap
>>> +# creation, may require additional space and is not covered here.
>>>   #
>>> -# @required: Size required for a new image file, in bytes.
>>> +# @required: Size required for a new image file, in bytes, when copying just
>>> +#            guest-visible contents.
>>>   #
>>>   # @fully-allocated: Image file size, in bytes, once data has been written
>>> -#                   to all sectors.
>>> +#                   to all sectors, when copying just guest-visible contents.
>>
>> "copying just guest-visible" sounds like something less than "all fully-allocated sectors"..
>> But I don't have better suggestion.. Just, "not including bitmaps" sounds weird too.
> 
> If we ever add support for copying internal snapshots, that would not be included either.  Maybe "copying just allocated guest-visible contents" for @required, and no change to the wording for @fully-allocated.

Not sure is it better or not, so, I'm OK with any variant.

> 
> 
>>> @@ -4796,13 +4797,38 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> 
>>>
>>> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
>>> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
>>> +                const char *name = bdrv_dirty_bitmap_name(bm);
>>> +                uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
>>> +                uint64_t bmbits = DIV_ROUND_UP(bdrv_dirty_bitmap_size(bm),
>>> +                                               granularity);
>>> +                uint64_t bmclusters = DIV_ROUND_UP(DIV_ROUND_UP(bmbits,
>>> + CHAR_BIT),
>>> +                                                   cluster_size);
>>> +
>>> +                /* Assume the entire bitmap is allocated */
>>> +                bitmaps_size += bmclusters * cluster_size;
>>> +                /* Also reserve space for the bitmap table entries */
>>> +                bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
>>> +                                         cluster_size);
>>> +                /* And space for contribution to bitmap directory size */
>>> +                bitmap_dir_size += ROUND_UP(strlen(name) + 24,
>>> +                                            sizeof(uint64_t));
>>
>> Could we instead reuse code from qcow2_co_can_store_new_dirty_bitmap(), which calls calc_dir_entry_size() for this thing?
>> Possibly, make a function qcow2_measure_bitmaps in block/qcow2-bitmaps.c with this FOR_EACH? All details about qcow2 bitmap structures sounds better in block/qcow2-bitmaps.c
> 
> Could do.  Sounds like I'm better off submitting a v5 for this patch, although I'll go ahead and stage 1-6 for pull request today to minimize future rebase churn.

Thanks!

> 
> 
>>> +    info->has_bitmaps = version >= 3 && in_bs &&
>>> +        bdrv_supports_persistent_dirty_bitmap(in_bs);
>>> +    info->bitmaps = bitmaps_size;
>>
>> AFAIK, in QAPI, if has_<something> field is false, than <something> must be zero. Maybe, it's only about nested structured fields, not about simple numbers, but I think it's better keep bitmaps 0 in case when has_bitmaps is false.
> 
> During creation (including when parsing QMP from the user over the monitor), everything is indeed guaranteed to be zero-initialized.  But we don't have any requirement that things remain zero-initialized even when has_FOO is false; at the same time, it's easy enough to make this code conditional.
> 
>>
>> Also, it seems a bit better to check version earlier, and don't do all the calculations, if we are not going to use them.. But it's a rare backward-compatibility case, I don't care.
> 
> I'll see how easy or hard it is for my v5 patch.
> 
> 
>>> @@ -5275,9 +5285,24 @@ static int img_measure(int argc, char **argv)
>>>           goto out;
>>>       }
>>>
>>> +    if (bitmaps) {
>>> +        if (!info->has_bitmaps) {
>>> +            error_report("no bitmaps measured, either source or destination "
>>> +                         "format lacks bitmap support");
>>> +            goto out;
>>> +        } else {
>>> +            info->required += info->bitmaps;
>>> +            info->fully_allocated += info->bitmaps;
>>> +            info->has_bitmaps = false;
>>
>> And here, I think better to zero info->bitmaps as well.
> 
> Here, the object is going to be subsequently freed; I'm less worried about wasting time doing local cleanups than I am about the earlier case about letting an object escape immediate scope in a different state than the usual preconditions.
> 
> 
>>> +$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
>>> +$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
>>> +
>>> +# No bitmap without a source
>>> +$QEMU_IMG measure --bitmaps -O qcow2 --size 10M
>>
>> should this be ored to  'echo "unexpected success"' as following failures?
>>
> 
> Can't hurt.
> 
> 
>>> +# Compute expected output:
>>> +echo
>>> +val2T=$((2*1024*1024*1024*1024))
>>> +cluster=$((64*1024))
>>> +b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
>>> +b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
>>
>> comment on the following calculations won't hurt, at least something like
>>   "bitmap clusters + bitmap tables + bitmaps directory"
> 
> Sure.
> 
>>
>>> +echo expected bitmap $((b1clusters * cluster +
>>> +            (b1clusters * 8 + cluster - 1) / cluster * cluster +
>>> +            b2clusters * cluster +
>>> +            (b2clusters * 8 + cluster - 1) / cluster * cluster +
>>> +            cluster))
>>> +$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
>>> +$QEMU_IMG measure --bitmaps -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
>>> +
> 


-- 
Best regards,
Vladimir

