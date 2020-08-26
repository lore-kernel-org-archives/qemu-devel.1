Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB4D2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UsmAgoPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB4D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kApWE-0000rX-UO
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kApVe-0000Mn-Nf; Wed, 26 Aug 2020 03:06:14 -0400
Received: from mail-he1eur02on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::70e]:64517
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kApVb-0005U9-8m; Wed, 26 Aug 2020 03:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6lwn/BBlcNdytHLtRb9/UVLJcdpxv5KfX5FuExkmZMXXQoG56FSg1AJFVAOLwVu5EkE3p3VXtq6C0qhF6Bh6TWcM/lX8KrqgiVMrqzijiOPecArRrkZa50+ykcU8YUPxcB2WtIdfxygOFZroTLMhGt+ciFAy7qcNrLBz+AW8rTNaW0IkQQf8bKZr5kBMqnp4AcPfijZbOLbbR7gEpr6TmuKoS7qxKVzlmEBWtk7S8oBu72GSOOssVbRLsG+ymNAiMaFsGNMX8+3fPqd+m1C/ksK9YWFqP8h7BuQ6JDjyA0SCnZPz/u2UeChLPyCY4Vs34a6kq9HEiIYggACegPaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icjkp8Jg+WjQAlMYhP4YbXAZwfNyP6o70tFAGKH0zek=;
 b=QbCvNHvCOsCQUJ3YaeA/+182Pf0uanOCfU7iPB3kLBt2/xf2wjhoHJVXBrrPc9+bxdZZ+X5Pkj/1cLBuNOw5MJZfkRkcbtMSZ+kKbLrnxT43omTCJynr8xUXZQihcKdJd9byvv4xVJffvbo7+HfUUQZu4F8X7Xdh0n6ROM8Z29DIAwFQFOQl+X4LRkL5byVOl+YjSnvxw+nekgpEzOidkpSc1ByXjL9ROTAO8OITeDl9XGehregdVvwytWWkSi3Q9YnecIdpSdzkORWAGQaXF3FI/tiMGEa7E/cXilktkJl7BJqREBDfxlS5teAMR57SXfOzioTrIFS047o+1UmG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icjkp8Jg+WjQAlMYhP4YbXAZwfNyP6o70tFAGKH0zek=;
 b=UsmAgoPALA09Z96fegYkDyOTiGPl7FolLJY8HOjDVztHd4nZwZuMnsHwAMyROl7VK/9xqYCSIU73m34dtJzVyIItGr8KVZe2/zGy5xZjnGg0db7pRw8xwdqmIL3uybo/Sjufbtx6XClS511BJrXt6vWuwzYZG4ajn6uI7TQvv0U=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4469.eurprd08.prod.outlook.com (2603:10a6:20b:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 07:06:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 07:06:06 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <4e72d12f-0824-cc2c-4f20-be1491d69069@virtuozzo.com>
Message-ID: <4000e3f3-1150-5538-7c1a-4df2d278bd8b@virtuozzo.com>
Date: Wed, 26 Aug 2020 10:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <4e72d12f-0824-cc2c-4f20-be1491d69069@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 07:06:05 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc63816-9dc7-44bb-1744-08d8498e80a4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44697573FCC1329D048EB93CC1540@AM6PR08MB4469.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtG6u2B0R/4PvPiZfwzoXKhOLxQyJDU9780fStsJlHJATr8tGfrcLXLyIYlQSnupOOKrXVC+EHjlyID6lr706MP5hWYdaRHqJSMOaL6SSXWM8/JjqrbP8k9UJW4PgEdTfU69IlOusEnyVM5uZiR2Zd1VpbVUmRxuuTBeYQN/J1EM0otEzLC5O7RgVSumJyq9efNvgm2KDRohAY9ddHlQ7iAGpmAIqtTrd5kp1rKgiBx39RvjtP2Knqoa1oJspUecD+AEXfkvkOvny6xMm8ACOEzskVYis4as11g0UXZUPGiyF2nNuTwxduJB4ZT81KzuVHKcwdxJ59K4j17md01qpcmw62Acoeu6QDTF9eV+Ef7r0jpV37gePgY3gQrOO/Qb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39840400004)(346002)(366004)(4326008)(16576012)(6486002)(86362001)(478600001)(2616005)(956004)(316002)(5660300002)(31696002)(52116002)(66556008)(66476007)(66946007)(16526019)(36756003)(186003)(83380400001)(31686004)(2906002)(8936002)(26005)(8676002)(6916009)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TbDiBdBJ8O4kftBhqSRMw9R+94PZtMZ9CX9Ejp3zBfe5vUrn2fgHzmV2sb5Ci683ZQkGmfbUCJsuOaERmNwA48x/F+OnhlVhOizvUKMbIeCFPInzoCcj4a/spcMEbQDeCWzngDpWRkcGw43BjAYPTojbWiIgXSQN5LRls/tBx2TxT7l0QNyvK3L3F4bu8u35/rAZdl2gRutZv1jfPMW1HaLwP/lSJYFZTxLtuioxBydysLInZsqnHdgO6/IIMBVTuspa5Smf9ZOXf/2gWMRIiMTWvMY6O2RiewDRsVb1Vi24AcIGVLXhyAfgR+WP2yHKf4WWHuwYp5elNvTs5aqQ0JupYeo63sQfjw0mRnoXs3MhpNBKR40QwLdk88gIbnJA20U9c0ievIF8nQ0J481GqFvD+QnOJHcW4DE1mRVM/Qp3azNELZehftj+krsrJCd01OF3mRfg5wEZpCMM82D/hHjbjeoLIekeIqhiKptl3JKVfSn682ungjgEWW2rRqb5yn+3Eit14rC8bfJD9ZPA83KkIIjZmzeJfTdMkldvGT03phimb3bns8zCkBYV7UagSS5vlHfGVVaFQPEkZy+dVWSaIOSHBZaZvqjTz+zkREgRC3eBPVlgTPBti2t9z2YOaclyNRnU5kk4Iy93FnlVZg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc63816-9dc7-44bb-1744-08d8498e80a4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 07:06:06.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KAB16FAxx2BCMaTGlLlqo5o6QgWRwwWyLxAlqyybObYCVOyfeYEkJSr29X7+G0nQm6Pa70W+WWGTxbnhxvcmi2ArIVEXn62f4Kr3vmMsXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4469
Received-SPF: pass client-ip=2a01:111:f400:fe05::70e;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602, SPF_HELO_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.08.2020 20:52, Vladimir Sementsov-Ogievskiy wrote:
> 21.08.2020 17:11, Vladimir Sementsov-Ogievskiy wrote:
>> It's intended to be inserted between format and protocol nodes to
>> preallocate additional space (expanding protocol file) on writes
>> crossing EOF. It improves performance for file-systems with slow
>> allocation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/system/qemu-block-drivers.rst.inc |  26 +++
>>   qapi/block-core.json                   |  20 +-
>>   block/preallocate.c                    | 291 +++++++++++++++++++++++++
>>   block/Makefile.objs                    |   1 +
>>   4 files changed, 337 insertions(+), 1 deletion(-)
>>   create mode 100644 block/preallocate.c
>>
>> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
>> index b052a6d14e..5e8a35c571 100644
>> --- a/docs/system/qemu-block-drivers.rst.inc
>> +++ b/docs/system/qemu-block-drivers.rst.inc
>> @@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU process on the image file.
>>   More than one byte could be locked by the QEMU instance, each byte of which
>>   reflects a particular permission that is acquired or protected by the running
>>   block driver.
>> +
> 
> [..]
> 
>> +
>> +static coroutine_fn int preallocate_co_preadv_part(
>> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
>> +{
>> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                               flags);
>> +}
>> +
>> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
>> +                                               int64_t offset, int bytes)
>> +{
>> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
>> +}
>> +
>> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t offset,
>> +                                       int64_t bytes, bool write_zero)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +    int64_t len, start, end;
> 
> int64_t old_data_end = s->data_end;
> 
>> +
>> +    if (!s->active) {
>> +        return false;
>> +    }
>> +
>> +    if (s->data_end >= 0) {
>> +        s->data_end = MAX(s->data_end,
>> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
>> +    }
>> +
>> +    len = bdrv_getlength(bs->file->bs);
>> +    if (len < 0) {
>> +        return false;
> 
> return old_data_end >= 0 && offset >= old_data_end;
> 
> 
> And with this small improvement we make the following test 20% faster (ssd, ext4):
> 
> ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 150000 -d 64 -f qcow2  -s 16k -t none -n -w $img;
> 
> (assume additional patch which inserts the filter).
> 
> Great! So, preallocation is generally good idea, not only for vstorage.
> 
> What about inserting the filter by default?
> 
> I'll come tomorrow with more complete test results.
> 

Some results:

the two commands to compare:
img=/ssd/x.qcow2; for i in {1..5}; do ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 150000 -d 64 -s 16k -t none -n -w --image-opts driver=qcow2,file.filename=$img; done
img=/ssd/x.qcow2; for i in {1..5}; do ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 150000 -d 64 -s 16k -t none -n -w --image-opts driver=qcow2,file.driver=preallocate,file.file.filename=$img; done


       no-filter  with-filter
ssd
   ext4: 6.94s      5.53s (-20%)
   xfs:  6.9s       25s (+262%)
hdd (with -c 45000)
   ext4: 8.23s      12.75s (+55%)
   xfs:  7.79s      25.4s (+226%)

vstorage (some custom distributed fs), with -c 4000 over ext4 over ssd: 42.9s ~> 0.27s, more than 150 times faster with filter!
same, with -c 2000 over ext4 over hdd: 22.8s ~> 0.53s, ~43 times faster.


So, we do have large improvement for the vstorage (some custom distributed fs), which is our main target. And there is a significant improvement for ext4 over ssd. And (a lot more) significant degradation in other cases. For sure, we can't insert the filter by default, but it is useful.


-- 
Best regards,
Vladimir

