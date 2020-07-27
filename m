Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4826C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CED120663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v/dyjfbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01IK-00014d-SX
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k01HX-0008PI-Ca; Mon, 27 Jul 2020 07:26:59 -0400
Received: from mail-eopbgr70129.outbound.protection.outlook.com
 ([40.107.7.129]:33856 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k01HL-0007gn-NW; Mon, 27 Jul 2020 07:26:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B20QcNPeH9N6I/ezK93Y9AdnGpjzmm8nP+lDDXyNiCI6R2EGjNB6UlVN3SZ1tC/KVe93K+vhabQkg0s+gNW9ScA/o7+kP73U+z0HiwBW+tMUZ/CxGkLR8K+V5Efdq51lPuf9kh4rLx5NJ6yPkynj815sdJJV3eFyMNmx2lNXmCHTRkWALHB0MrEyc6Jz2VQFa7XgqDW6jzgDLDdNa6Vi4WKIhJPaIhVHmf3y++5Bm+LuNgBxodZAT7y2y03sKbvTzRQAfqL0opgj5G4NDr3dq0JC743bP7T9AGKf7C7Zwp/x3KHBmGckgsX0alHFaL278QtzCt2M6WJvrOtIcGswSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00BT+FUGA1PeoZUQ38O/B5VbET9v6uLNIEGsyoA9NbA=;
 b=LytSBFualsevoEqsjOtf71U8XWeGn5yoOII1Tcyya7LTF4jG4R7iM+NuHAbnULikwp4ynQF+HsocYC38s5umaaKV644hbDTAQ3RUYgj18vnowqdIQYK0qhI7yWnAiqEBWooYgmqq1xRwqbxYn+Hzo+PCOMVTFwyxPYw0dC9zpqeJ/CKK42NJ8KyYvldS9z7GeCd+npAJF+ThFKqhEXWSofqQIiMS5ZaC93XMNorMyBBqIX6wYr290YjkXzc8eCKUb7NPG0+13jTa1gulaPPowOewrmlSMJUdIra34oIfG1vUMRZec9PNk27WVt6lZhopktqblIy8tpUN0InqsAiSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00BT+FUGA1PeoZUQ38O/B5VbET9v6uLNIEGsyoA9NbA=;
 b=v/dyjfbupTDJyWVoNbpOpAg5UFFXJLbdFJtp3Wc1yKgPSIIzDWURSqF2oO8fJ3jw7pwoeBTZV828W6SjwwYRrV3zxbZYsarUatWltejXUUdsfS45NGCgQamv9ylOLxIn1Ml9UqjCBb503wfg0etx+4bKbo3h7oKMnviXpoxrcO0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3030.eurprd08.prod.outlook.com (2603:10a6:209:46::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 11:26:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:26:39 +0000
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
 <35252620-8a4e-9440-f647-6b15d697365f@redhat.com>
 <685495bd-83a6-6a2a-7ae6-9632e432e771@virtuozzo.com>
 <20200727111636.GJ3040@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <654166d6-126e-adbb-41f8-53d8022fb257@virtuozzo.com>
Date: Mon, 27 Jul 2020 14:26:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727111636.GJ3040@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0090.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR06CA0090.eurprd06.prod.outlook.com (2603:10a6:208:fa::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 11:26:38 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e486c5b8-f25c-4309-c1ca-08d8321fee29
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303032B4569328FA8754463EC1720@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QWB17HiW+KVeQm5syNyPl/+0XoLfoWzdaKjAjZRDTZ40nyFhkiEBpBG4iXeo9dFld9ht2/PM3WJiJOpzgZkj9QoHdxKTsT6ZoSuS3GGFDhJYy4RteM7whBdSBNMahGxivn+M3ECYiPq2V6wC3u7MXs8sC7oR0WAXyXFQT4KjCFsy1BcDe4BMc14hm2J+pCBax+RpCPUXroHyZVDjo+LDi7eWBewS0aAeT4ALIl8BkssNeOdp3UfYOEQRJ38ITZ8m0ApMV12yqSsumBVn8eMEFyfGXQy4UVEiEM7LVwZsFYW8WiqYxZ36p/ekBq84uWU5fuBOPNwuKjDx6gC74c3sfxIunfeYROK0ErFeKqjhGi9dV5iNcqhnRCuGvYQ4J6vnasoOpzt7rP9FrHalB/Ogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:cy; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(6486002)(478600001)(6916009)(2906002)(186003)(316002)(16576012)(16526019)(2616005)(26005)(956004)(107886003)(8676002)(8936002)(4326008)(86362001)(36756003)(53546011)(66476007)(66556008)(31696002)(31686004)(83380400001)(52116002)(7416002)(5660300002)(66946007)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EOyXyTohXeh+i2v6Iu07kpOE5OmSzM7VvZ8bN57+IepuPQ3mTOnxW6eif4t4bdi6gq2U/DbxGVmVWMNBP+Lc2KW36N6amovJA3JQ45NMYiwMYJIkO5SBCa7412fpKmR7Rp3vjF1An5BvTcbKNuiJJML+lVT9WcOQQl/iOZxDMqXMjy2Qjt1BC9zckSFJCFY9ipKlU7I+9fommjjZo+eLuZaKpsc6WJcgqT+ZCeq4e1dRvEtnkgmQgOBGVMTwvEDg3Mf726RUks8aD3M+BgQJRPKZa7Ism2EhtdWonlQ9wm1lLntp1/c1HsaCK2+W+HpRDKgvan5MxmEasRPdqTQuIPMVFsyAvGPlkP7i9DRiYQtfntJOzZEQ1oAxbhJz4f/7zmKGDN8oA916el1sfiF+VSlYWYovf4QkzAxJutLyxw8sz3LPN09n/ws7AalFFpx/3f9jrcNc4xzdJ1cxSeuUwpaX1q8FNcF2oakKVqhWfgw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e486c5b8-f25c-4309-c1ca-08d8321fee29
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:26:39.5527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc2bDpHJoJCi7di7WjOKOlGRxtmi0BbohHsA6H5ydV5lPUY2PgR7jLmkcFHwcWADCiXgxI7maOxfqW8onRvFuMP1r77YWZQFtWB82+D08TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
Received-SPF: pass client-ip=40.107.7.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 07:26:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 14:16, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> 24.07.2020 20:35, Eric Blake wrote:
>>> On 7/24/20 3:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Bitmaps data is not critical, and we should not fail the migration (or
>>>> use postcopy recovering) because of dirty-bitmaps migration failure.
>>>> Instead we should just lose unfinished bitmaps.
>>>>
>>>> Still we have to report io stream violation errors, as they affect the
>>>> whole migration stream.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> Â  migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
>>>> Â  1 file changed, 117 insertions(+), 35 deletions(-)
>>>>
>>>
>>>> @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>>>> Â Â Â Â Â  if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>>> Â Â Â Â Â Â Â Â Â  trace_dirty_bitmap_load_bits_zeroes();
>>>> -Â Â Â Â Â Â Â  bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  false);
>>>> +Â Â Â Â Â Â Â  if (!s->cancelled) {
>>>> +Â Â Â Â Â Â Â Â Â Â Â  bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  nr_bytes, false);
>>>> +Â Â Â Â Â Â Â  }
>>>> Â Â Â Â Â  } else {
>>>> Â Â Â Â Â Â Â Â Â  size_t ret;
>>>> Â Â Â Â Â Â Â Â Â  uint8_t *buf;
>>>> Â Â Â Â Â Â Â Â Â  uint64_t buf_size = qemu_get_be64(f);
>>>
>>> Pre-existing, but if I understand, we are reading a value from the migration stream...
>>
>> Hmm, actually, this becomes worse after patch, as before patch we had the check, that the size at least corresponds to the bitmap.. But we want to relax things in cancelled mode (and we may not have any bitmap). Most correct thing is to use read in a loop to just skip the data from stream if we are in cancelled mode (something like nbd_drop()).
>>
>> I can fix this with a follow-up patch.
> 
> If the size is bogus, it's probably not worth trying to skip anything
> because it could be just a broken/misaligned stream.
> 

The problem is that, when we are already in "skipping" mode, we don't have actual bitmap to understand, is size look reasonable or not. We can probably just invent some heuristic constant (100M for example?), so that any size less will be silently skipped, and any size above will be considered as stream violation and cancel postcopy process.


> 
>>>
>>>> -Â Â Â Â Â Â Â  uint64_t needed_size =
>>>> -Â Â Â Â Â Â Â Â Â Â Â  bdrv_dirty_bitmap_serialization_size(s->bitmap,
>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  first_byte, nr_bytes);
>>>> +Â Â Â Â Â Â Â  uint64_t needed_size;
>>>> +
>>>> +Â Â Â Â Â Â Â  buf = g_malloc(buf_size);
>>>> +Â Â Â Â Â Â Â  ret = qemu_get_buffer(f, buf, buf_size);
>>>
>>> ...and using it to malloc memory.Â  Is that a potential risk of a malicious stream causing us to allocate too much memory in relation to the guest's normal size?Â  If so, fixing that should be done separately.
>>>
>>> I'm not a migration expert, but the patch looks reasonable to me.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>
>>
>> -- 
>> Best regards,
>> Vladimir
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Best regards,
Vladimir

