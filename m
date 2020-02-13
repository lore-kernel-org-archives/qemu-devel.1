Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE316C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F65218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LaPBkDiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F65218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Dp9-00007V-QJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j2DoA-00082p-9v
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j2Do8-0005iM-Rk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:41:30 -0500
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:30689 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j2Do4-0005bc-LK; Thu, 13 Feb 2020 07:41:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvb+DH/ZiVoAXxzadsLPB7mq61l7lnENCChTP8PEUFcganx1xnUnvI4nB0VvY1aTaQ18+TGSwcOZDyHRzv2fl8WHNbSWVIR3DY78/W1xoVDoZexlocQ/SUQQIoiJaJhw1vW46LrNowQ7IIUIehEvaHBhirsZh/k1FfjVuD2abqmXprlJaT6SqTxj7KHSCqQIp46W8uHIdIrH339kBzl6Ru5KPPlOOXTCNVQvaNnyw3R6C5l823xNBUu3w0JE/4tf0jD4nxOzzuwHDS37eeTsMALSTtkhsR+3jYmkYgeM+s2C0lq/UkV/LeiEgj5723yloUn6uouInTdXxkgVMKBKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqEbSqTNkZspAaffdNEo6qu1VRYDBkz2jeyLO+HikpA=;
 b=i6GgWX489BD9yw5byRwLc03UnlIeN7h7WJfPUs5+gPPgNw51MBdzp8HrTjvqEh1sPG2ZHlUzOZjOensvHp+WEfmbyb81alQHRsXzP6GdGQY4GHI3Y9wcWn1iORtZnVZs545oBxaKFghxV0EClcAKB5y6MtrvQb0GzF+5vP0NjxEHY4C+iHj9QGi6lWiVdZfTxyOTvuH8msT4I49OqELqoDx7KWSwMFIkVgkzjFxIWfxaxXplNw689ZzeXPpT1LElhehi/PAEjuOjTtzUHgy2BVgo84PMqQZZuxOLH0JENcGZD1HYzkAfWXbqF4KqBwM1NqEolqktztKesc+Yrw9Uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqEbSqTNkZspAaffdNEo6qu1VRYDBkz2jeyLO+HikpA=;
 b=LaPBkDiHV/qWL5cPeQNOJNiFbYY00wEsh4aYT/fhyuqYXFq//uXr7HXx3lqfkcOZolbXJcXdmt1ZkLaKNKkqVIrBn1HrYOIybHoGVK80rzCvEue+ulBF1fl9ZCpLJ5dqgOW4ufO1+EqRnFeNn85Vdr80nUD3/9JttP0hSIsPPpY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4612.eurprd08.prod.outlook.com (20.178.23.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 12:41:22 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 12:41:21 +0000
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
 <20200212154337.GG432724@stefanha-x1.localdomain>
 <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
 <20200213090851.GA542404@stefanha-x1.localdomain>
 <859b35f2-b398-f744-36b4-eb604f46c8d9@virtuozzo.com>
 <20200213114535.GB544499@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <baaabc6d-e9a4-977f-56b5-bcaadfa5e2ec@virtuozzo.com>
Date: Thu, 13 Feb 2020 15:41:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200213114535.GB544499@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.162.46) by
 HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 12:41:20 +0000
X-Originating-IP: [178.34.162.46]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98bc57c-6949-46db-431e-08d7b082079d
X-MS-TrafficTypeDiagnostic: AM0PR08MB4612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4612F1EBBFE973D70A08EC06CF1A0@AM0PR08MB4612.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39850400004)(189003)(199004)(53546011)(5660300002)(31696002)(8676002)(8936002)(86362001)(26005)(81156014)(16526019)(186003)(81166006)(31686004)(6486002)(52116002)(7416002)(316002)(16576012)(6916009)(966005)(956004)(478600001)(4326008)(107886003)(2906002)(66946007)(66476007)(66556008)(2616005)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4612;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfkCEeotWR3yPHPUFmOIq51ms8SpcKmAiCvw4N15Hpad28CF57zLh436mAj1l/wgA+13TyDHSCloOeB88R75oWWEButaa9TCG2YmSp0Zaj+AKkSEfFDAzXgoEi9qYX3HF9vnJaYwaku5uOu8JEWjpC9bzHjEw+fi1OVLibpUfbNsFLuQJUXbJ7IHbd17VIcJ/aGhjbCm/Qv0LyrQKAkDjb9S/qDRVb6qMOi9nTJazX6IjJWIAL3zBCC0YkhY5JMUd7jFa403TB1yMVJB6KXsUFal4BTtxHGADV5mPeBLAW6HbP/S5vMjIn2pYiv+lMqIW3nlQWP70GxugQYx+D2Dd9oaTE2hCq82mpjzBgNCuPpMuyRYYWyat63FYtMi4aKTI785QuZ943aG13CxIxWqFwnFDwuzcDnEvnnQZshMliS6fs19fum1BQYMfcdnVi2rAmqI9dDCYTbtJQ6yVB+z0aQj7RzDkqAlCiPL7eM7zIQPKewVTXbmRPya0dQxlPsuU4M9GOo2a7f8F2oZpzm5Pw==
X-MS-Exchange-AntiSpam-MessageData: 8hKC+Zkmu+L9yZCQIkfRvtrA3nZ01i2xJJ50HG3ZLBlhW76yfwt6UEgj1ExsxueYmhjgfjeEjnS5SSvFVQ41G1n3EP4PZM+CHz8/DmJ2lWZYgPtfPlM8ctx7NIB45Rkf91zuPlGWfuy4Z/a0GtvnZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98bc57c-6949-46db-431e-08d7b082079d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 12:41:21.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUcZZBGL4uAV78wPo3Mn7PjiqTUaD7zVazbFDjbryN6P7oh8PvNg6/iM4mrhH1uvSJPkdTsIxfgYwD2qtBodQrju0mtOEV8eBnt99FlWwts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4612
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.121
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13.02.2020 14:45, Stefan Hajnoczi wrote:
> On Thu, Feb 13, 2020 at 12:28:25PM +0300, Denis Plotnikov wrote:
>>
>> On 13.02.2020 12:08, Stefan Hajnoczi wrote:
>>> On Thu, Feb 13, 2020 at 11:08:35AM +0300, Denis Plotnikov wrote:
>>>> On 12.02.2020 18:43, Stefan Hajnoczi wrote:
>>>>> On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
>>>>>> The goal is to reduce the amount of requests issued by a guest on
>>>>>> 1M reads/writes. This rises the performance up to 4% on that kind of
>>>>>> disk access pattern.
>>>>>>
>>>>>> The maximum chunk size to be used for the guest disk accessing is
>>>>>> limited with seg_max parameter, which represents the max amount of
>>>>>> pices in the scatter-geather list in one guest disk request.
>>>>>>
>>>>>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>>>>>> size increases seg_max, which, in turn, increases the maximum size
>>>>>> of data to be read/write from a guest disk.
>>>>>>
>>>>>> More details in the original problem statment:
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>>>>>
>>>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>> ---
>>>>>>     hw/block/virtio-blk.c | 4 ++--
>>>>>>     hw/core/machine.c     | 2 ++
>>>>>>     hw/scsi/virtio-scsi.c | 4 ++--
>>>>>>     3 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>>>>> index 09f46ed85f..6df3a7a6df 100644
>>>>>> --- a/hw/block/virtio-blk.c
>>>>>> +++ b/hw/block/virtio-blk.c
>>>>>> @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>>>>>         memset(&blkcfg, 0, sizeof(blkcfg));
>>>>>>         virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>>>>>         virtio_stl_p(vdev, &blkcfg.seg_max,
>>>>>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>>>>>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 256 - 2);
>>>>> This value must not change on older machine types.
>>>> Yes, that's true, but ..
>>>>> So does this patch
>>>>> need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machine
>>>>> types get 126 instead of 254?
>>>> If we set seg-max-adjust "on" in older machine types, the setups using them
>>>> and having queue_sizes set , for example, 1024 will also set seg_max to 1024
>>>> - 2 which isn't the expected behavior: older mt didn't change seg_max in
>>>> that case and stuck with 128 - 2.
>>>> So, should we, instead, leave the default 128 - 2, for seg_max?
>>> Argh!  Good point :-).
>>>
>>> How about a seg_max_default property that is initialized to 254 for
>>> modern machines and 126 to old machines?
>> Hmm, but we'll achieve the same but with more code changes, don't we?
>> 254 is because the queue-size is 256. We gonna leave 128-2 for older machine
>> types
>> just for not breaking anything. All other seg_max adjustment is provided by
>> seg_max_adjust which is "on" by default in modern machine types.
>>
>> to summarize:
>>
>> modern mt defaults:
>> seg_max_adjust = on
>> queue_size = 256
>>
>> => default seg_max = 254
>> => changing queue-size will change seg_max = queue_size - 2
>>
>> old mt defaults:
>> seg_max_adjust = off
>> queue_size = 128
>>
>> => default seg_max = 126
>> => changing queue-size won't change seg_max, it's always = 126 like it was
>> before
> You're right!  The only strange case is a modern machine type with
> seg_max_adjust=off, where queue_size will be 256 but seg_max will be
> 126.  But no user would want to disable seg_max_adjust, so it's okay.
>
> I agree with you that the line of code can remain unchanged:
>
>    /*
>     * Only old machine types use seg_max_adjust=off and there the default
>     * value of queue_size is 128.
>     */
>    virtio_stl_p(vdev, &blkcfg.seg_max,
>                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>
> Stefan
Ok, I'll resend the patch sortly
Thanks!

Denis

