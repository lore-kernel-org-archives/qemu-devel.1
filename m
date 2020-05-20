Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A792F207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gQPOubJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A792F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMgq-0005Sr-UW
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbMg6-0004yq-Pj; Wed, 20 May 2020 07:14:26 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com
 ([40.107.5.114]:10368 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbMg4-0001B6-5q; Wed, 20 May 2020 07:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnzJvraM00AbgpqWz5bzpOcCbH63JCM0IwS5WVpSOuBG+5T8vFGOqCu6Fl+2e3/+daAokA4d95svgCcCAWYeP1VhESXVMIRIruw6VYGumhRUZLLYQYHroVgiOh8qWpQsBix2BZfudHoRVOvYqncXUIv92G6auFw3N+Z4mGjE+NQi8g+dMdglqj/4dhbjZ9jguCZyM1oHZGEVBev5tEgjQ5HxP1XIIxh+7FQEHZaLgwHQKDoYWpeiVJ4+m5gbpZ6NptXlGuhPWZuqSFu4rnFV6/8cQK29XsL32CmEsoYPpXriXM+q8MM3mAH/VaWT4ezGp6C9Rtl9gmv58Tb7ZWuYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP2XBYbqzKD6S7b3CvVvnv4wwPfQEmTVB/xzA0xvnik=;
 b=DqeUPMf/a5VSS9L+6s4x7Ub1hp82Rn96C3Np4AduaUDvdYR1m2Onwpqwxsww1L7XsRVre5aAtgAsQ/j7EnfJ2eY+H8RswDojtZPXTb47QBfscduL5o4ujKbyjEOWTCuistQyd/yY5c5KYZgaf16XVIq5SZjVjiQBZ9H/kPtvxSeTr6YCgSzxR5TP0BQtRbLaHht68Uf/e6KBLc/QGyG2fcIiAKlDCitd65Gfq4FZ7pNvHNa4xI9hQmOvtc5iyXcP8RvDzsitaTIiOCZo96pa9nYbKJEUyir3lGUHrh1Qed5ZDFvygVocZVpfdLoiElLA1cSIteGVNDCYwIHM9lhjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP2XBYbqzKD6S7b3CvVvnv4wwPfQEmTVB/xzA0xvnik=;
 b=gQPOubJhxL4aMlQg0Gd2gJYUq6ejxTlsRfA/0+WrwWSwJv+djGOQdbVooP8KvvByeIhJf70r2bNFgJegWSulRvPiVERp5JgWI63dequGf5xyGpl9wd4axzh/ze1JNG+95JrKAsc2+WwweeaKWGFJNB2rkAOjPCb/ObR2gPn2chU=
Authentication-Results: proxmox.com; dkim=none (message not signed)
 header.d=none;proxmox.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 11:14:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 11:14:21 +0000
Subject: Re: [RFC PATCH 1/3] block: Factor out bdrv_run_co()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-2-kwolf@redhat.com>
 <5f019ab2-076f-4537-9138-9ed93484a727@redhat.com>
 <bb50696f-4680-ca07-4e4f-bcbe1e5c2468@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a5122def-a68a-0ea0-582b-14c6f82249f1@virtuozzo.com>
Date: Wed, 20 May 2020 14:14:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <bb50696f-4680-ca07-4e4f-bcbe1e5c2468@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM0PR01CA0101.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Wed, 20 May 2020 11:14:20 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3b0887-5d74-4308-8a8a-08d7fcaef1d8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53997AF040F76AA34C293655C1B60@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PxGmAoK29zp1XNIWd0ypscpJ77egCDNs2150Tpkb0GuEyvqV1/61r0goFHlU9+Iuh5Iecy6FK4bj4ugfDvUbVWNZ6A//sSyPdXC+1+3LuUkbB5q5MBCiL3+3VGLG754mgXO0zKPbmhoHem3V+J5aMKuwiCN+y1F+/Tn2rwd90YYv8w0rmCLkrsNeCMe8v6EUQox0JLCs3G+Chbr/v0gVEXdMFWKqbAbWvEFItr4LGsTvLLXWHImKYeTYt2DROA7hZ6hNYsR+m/I8Wwl5JMHgZjIIxLCUMnPpX28BiICcdK6J5fy/IyXLuJoC+CQh0o8WI8ep9oVBecPkgoZ5/DjzQoo8Q9hhCHEj6iJI9rNpiKTHfkZSck1MvXB+kNRaWX04VUeSUQYlMfk46McUPUbeqP/KVw67Fo5u5Rz5CyL5A1OBvFM/KzPliwvEZpqlYqNL3eNV4vshMc8V+UxSCjt2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39840400004)(366004)(6486002)(31686004)(31696002)(7416002)(86362001)(5660300002)(52116002)(186003)(16526019)(16576012)(53546011)(26005)(316002)(8676002)(110136005)(8936002)(36756003)(2616005)(956004)(4326008)(966005)(66946007)(478600001)(66476007)(66556008)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GWttfZcRihxWkCJYIgcN/8dlRpFEzZJxjPIesbWhZuQ7AUuEtvymYldxn+sb+D4tFYyqBHfGRy6d7nlF2nvCfxVsnfHi9vBB7AvbmGhpi2G0/0vPI58PbLp2Unu46CzoxJoD1pBRC16FcAF3VwIBJ3wGyNZPi4esRWQYEknsGVAcPFfJAmVHOCrvn3XcZlRS7qhwmbFq1GR9Wab2mbbqjsObTUa6LNOVI3mixAfkwCWD6tveRrF9fchGWFSYgzYcXSWZj4JtvGGY9vP6gYcoa3dE7qZM/4d0uYmdTjd0ncDArcO5TLnWLpmdWq/0XjxgQEcP8g7ltlS+NrTEoSbjdSrrZUxR9/Bmk8ujhaVpEgFdlpUqkMkfzmZFNGlysTmSn9BIVz2TPbRXa3Ou71/5rnh0ZlLHbB3cHjFyXbzkD5ZkXs8t7hddJv1l0XQExDb6qQG7NVwIo1HJlK/VR8cocpyGyQQLgRM5w9utXJzdBNEtdq/bAdcAsgbwPur4zxUj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3b0887-5d74-4308-8a8a-08d7fcaef1d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 11:14:21.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EervirvtaA8agZ8FjvQ5EdlCKm87dS6utXpaPjSowh1/UL+U4AOFppGEfwfiZLz6QgBJs5kJJvT2uYIvFsUt+qLTqClR91UprARY73dN0I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.5.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 07:14:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, s.reiter@proxmox.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.05.2020 12:09, Philippe Mathieu-Daudé wrote:
> On 5/12/20 5:37 PM, Eric Blake wrote:
>> On 5/12/20 9:43 AM, Kevin Wolf wrote:
>>> We have a few bdrv_*() functions that can either spawn a new coroutine
>>> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
>>> alreeady running in a coroutine. All of them duplicate basically the
>>
>> already
>>
>>> same code.
>>>
>>> Factor the common code into a new function bdrv_run_co().
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>   block/io.c | 104 +++++++++++++++--------------------------------------
>>>   1 file changed, 28 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index 7d30e61edc..c1badaadc9 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -891,6 +891,22 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>>>       return 0;
>>>   }
>>> +static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
>>> +                       void *opaque, int *ret)
>>> +{
>>> +    if (qemu_in_coroutine()) {
>>> +        /* Fast-path if already in coroutine context */
>>> +        entry(opaque);
>>> +    } else {
>>> +        Coroutine *co = qemu_coroutine_create(entry, opaque);
>>> +        *ret = NOT_DONE;
>>> +        bdrv_coroutine_enter(bs, co);
>>> +        BDRV_POLL_WHILE(bs, *ret == NOT_DONE);
>>
>> For my reference, NOT_DONE is defined as INT_MAX, which does not seem to be used as a return value in other situations.
>>
>>> @@ -923,25 +939,15 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
>>>                           QEMUIOVector *qiov, bool is_write,
>>>                           BdrvRequestFlags flags)
>>>   {
>>> -    Coroutine *co;
>>>       RwCo rwco = {
>>>           .child = child,
>>>           .offset = offset,
>>>           .qiov = qiov,
>>>           .is_write = is_write,
>>> -        .ret = NOT_DONE,
>>>           .flags = flags,
>>>       };
>>> -    if (qemu_in_coroutine()) {
>>> -        /* Fast-path if already in coroutine context */
>>> -        bdrv_rw_co_entry(&rwco);
>>> -    } else {
>>> -        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
>>> -        bdrv_coroutine_enter(child->bs, co);
>>> -        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
>>> -    }
>>> -    return rwco.ret;
>>> +    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco, &rwco.ret);
>>
>> So code that previously looped on NOT_DONE is obviously safe, while...
>>
>>>   }
>>>   int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
>>> @@ -2230,7 +2236,6 @@ typedef struct BdrvCoBlockStatusData {
>>>       int64_t *map;
>>>       BlockDriverState **file;
>>>       int ret;
>>> -    bool done;
>>>   } BdrvCoBlockStatusData;
>>>   int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
>>> @@ -2492,7 +2497,6 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
>>>                                              data->want_zero,
>>>                                              data->offset, data->bytes,
>>>                                              data->pnum, data->map, data->file);
>>> -    data->done = true;
>>>       aio_wait_kick();
>>
>> ...code that looped on something else now has to be checked that data->ret is still being set to something useful.  Fortunately that is true here.
>>
>>> @@ -2669,22 +2663,13 @@ static inline int
>>>   bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>>>                   bool is_read)
>>>   {
>>> -    if (qemu_in_coroutine()) {
>>> -        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
>>> -    } else {
>>> -        BdrvVmstateCo data = {
>>> -            .bs         = bs,
>>> -            .qiov       = qiov,
>>> -            .pos        = pos,
>>> -            .is_read    = is_read,
>>> -            .ret        = -EINPROGRESS,
>>> -        };
>>> -        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
>>> -
>>> -        bdrv_coroutine_enter(bs, co);
>>> -        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
>>> -        return data.ret;
>>
>> It's a little harder to see whether -EINPROGRESS might ever be returned by a driver, but again this looks safe.
> 
> Maybe add a comment regarding -EINPROGRESS before calling bdrv_run_co() in bdrv_rw_vmstate()?
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Hi!

Actually, I've sent a v2 of this patch:
"[PATCH v2] block: Factor out bdrv_run_co()"
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05437.html


-- 
Best regards,
Vladimir

