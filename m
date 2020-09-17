Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B775C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FBA20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sMMOC8Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FBA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxyJ-0001SQ-OB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIxx8-0000XB-H6; Thu, 17 Sep 2020 13:44:14 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com
 ([40.107.5.111]:40967 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIxx5-00031m-HW; Thu, 17 Sep 2020 13:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0dVs4x1JsHYiESZjY6uVFW6k1+bxxcxMuVMj8C2X8S3FQ7PlFKanyK0meDZldQeWbdEKAuF0XRJq1SLA1bVlnWt0SHbZqZl9ARzrP5oWIKt+7OOFLyEbiz1kDdVzTamWyHDHbBK0sFbjbSmG8/zuTCHsTyz2+kcczd+RTmX5EZaWDeGcBlM/fUyPrESbAhmeTqCae0+KLJRehpGC61Ipfcc6O6pU3WL6nJFyu+QrflPE3dV7vHp1DK8YdSkhPeeZc1yEe4rq9jROslG9M1icR1Ut9OgJbBrP2A7ey+rZUsJezgLcLvoR2Gjo3IXzgK8ecIwVMTLoqK1klZIvqsxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIoTNMPdIXEP0r/LPxyxr1peL9JaQWB0nMretqCu0Ww=;
 b=HXHwfC0PDloBBtYCtnxp9TwG2tolnU7TSKdE0KxTmPIoEuG81A1FQ/wgoTCcEb96LBY6/3apAFo/4F6WwXGhH7XQZZwzlCKt91HFBNn8418zmlk04qH/eCRS/ktcv+ZGNqQns59o6mtmpfS8HLJwnZj+Y2BBok6RPMbtruqYsXqmcht5TlqW/nAfjCntiC4ZT1eu6Q8hI1D5yNSZqyKY3F0hENKFpYIaqb/4gUiAOw8q5yL9UrNmq5PFGy3eBPSRm39/4Mz0LaqLtR07z5E/y8edycaLRG8UaelIPcjyzYW6df/L1T6U5FbvwQo2OaJZgB4XlZNLKSrKYblmg9/c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIoTNMPdIXEP0r/LPxyxr1peL9JaQWB0nMretqCu0Ww=;
 b=sMMOC8QbCpb1WzK4wFGF8JWNoaYPOgamaO1VOi4ReffHVOSfceOtqi9gIdnEpf52tmx32PDNW4QX3BDkcNfsAci9b2HxdYMWNzrGN5yjUcYjJqU4E5/NrnR7WRGU0UTOOsoezMcEINjxnespSv+/Y5U7IJ7NzD48qKR9Y4FvSeg=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 17 Sep
 2020 17:44:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 17:44:06 +0000
Subject: Re: [PATCH 13/14] block/qcow2: qcow2_do_open: deal with errp
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 pavel.dovgaluk@ispras.ru, ari@tuxera.com, mreitz@redhat.com,
 kwolf@redhat.com, groug@kaod.org
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-14-vsementsov@virtuozzo.com>
 <w517dsspe3e.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2c3af56c-e894-b677-3a5a-1111e04dedd9@virtuozzo.com>
Date: Thu, 17 Sep 2020 20:44:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w517dsspe3e.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM3PR05CA0137.eurprd05.prod.outlook.com (2603:10a6:207:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 17:44:05 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 902910ae-73e4-4f74-4291-08d85b31464b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-Microsoft-Antispam-PRVS: <AM7PR08MB544860DEEDA026E1C48A3B42C13E0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:195;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaTVxFihMuHNN4lhZxYfV8MqE+EaeGtoV/EnBOOEFmhz93EZo/PZ7TkNUburgYdF+nwoz1gu+Zpf30Jgtv0j4dRRtzzwL0z8vegm/9fsHPqK5u45jI7YcSdbH3l2fUnCTRM84MNdYghCjoJJEfROGw9w3e55FE5v1KX6nGQlPa5ELAH5JoUVVl0GSMKNtVHve5DbiiaomDEbxF/FEL7HW7G7j7NJtKrI78TTZ2pXBBLb5q7xRaAKwWNx13b09zy+mJzQFPCeiVYajR4STsNmjX+Y6WQpgg6xTIHzk9+2ZL9IOus5BjRhiQui/omf9gie178jSR3+7++wuNeUrC3jNTDAK34h1FhtwoHlSfYaV//EzL2r6NVP38Gn0zgs/7AS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39840400004)(136003)(346002)(376002)(7416002)(2906002)(66476007)(4326008)(66946007)(31686004)(6486002)(31696002)(66556008)(83380400001)(86362001)(8676002)(5660300002)(52116002)(956004)(16526019)(186003)(316002)(26005)(36756003)(2616005)(8936002)(478600001)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VMzDWML6mbzlOcQvVX4H5Ri9YLhuiTFfxXMTWqX8Q4Tn9+Xw0zX5HwRBVQ9BKssG7ACDRFqzFDk9xxla7nEJd8pa38oUqVOmkLTNiK8M79mBeevVfBg13xyI0cwluFkUYdquF4S5812yFgYpe/esEyD4YeNEIVsMwqemaKVfZ9UoCXgrVgcoW91+Mx83Q9AU6cxSYxxaM7fW+qrg12AzczSzj7A5+EGKMHLL1nECJFiV+lIot2M9Zy8SKeciAMXBOqOsp0tLzKjc8FmeOZkhQhDJ8GYEGpa9DF9GJ6Ca9XZyQyJwidlXJG4CGlhE5BWJKrx3zwFoAVrZWfYKbIbPBI3Cnt4gNBx3dxHzCCOar84aGY8+KNKDcSkJjN5mYRvrIw1EFJVktOQGF+R4LCJRDpk1g+UfzfQFWADUa/h4AsIHB4fpyi4RDAOKXHmMR4shocf/eyL83GUzJcVhfVTk8NdeeZc6f+pJltIj2qwxZGEqLTxBUOXr8GwwW3zXfFtICugywIr+bAYSm/e8zNLa9G7alipKlv1HJQ2y6oMFvARj6BBMl8zJfu/5w+gC/qSuDBVVXGWjTPhuA9g6aojZcKUGzTdZkZecSNOuUdEG5woXNi9jiDbM+3GrtXMrtP4oI5MPa9svp08CQvYhr8hEVA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902910ae-73e4-4f74-4291-08d85b31464b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 17:44:06.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YizHYcQNsXlIfpFWodgeSK2k+dNWJ3pnD98uapnS5+Ic4oJ+9QhaDNvg+tF8ZBM7st46kXMZ12SSaNdc0JGDZ/3nVi5MAtmLOj1x9gc8HH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.5.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 13:44:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

17.09.2020 19:23, Alberto Garcia wrote:
> On Wed 09 Sep 2020 08:59:29 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> 1. Drop extra error propagation
>>
>> 2. Set errp always on failure. Generic bdrv_open_driver supports driver
>> functions which can return negative value and forget to set errp.
>> That's a strange thing.. Let's improve qcow2_do_open to not behave this
>> way. This allows to simplify code in qcow2_co_invalidate_cache().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 31dd28d19e..cc4e7dd461 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1292,6 +1292,7 @@ static int validate_compression_type(BDRVQcow2State *s, Error **errp)
>>   static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>                                         int flags, Error **errp)
>>   {
>> +    ERRP_GUARD();
> 
> Why is this necessary?

Because error_append_hint() used in the function. Without ERRP_GUARD, error_append_hint won't work if errp = &error_fatal
Read more in include/qapi/error.h near ERRP_GUARD definition.

But yes, it's good to not it in commit message.

> 
>>       BDRVQcow2State *s = bs->opaque;
>>       unsigned int len, i;
>>       int ret = 0;
>> @@ -1426,6 +1427,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>           report_unsupported_feature(errp, feature_table,
>>                                      s->incompatible_features &
>>                                      ~QCOW2_INCOMPAT_MASK);
>> +        error_setg(errp,
>> +                   "qcow2 header contains unknown
>>       incompatible_feature bits");
> 
> I think that this is a mistake because the previous call to
> report_unsupported_feature() already calls error_setg();

Oops, you are right.

> 
>> @@ -2709,11 +2712,11 @@ static void qcow2_close(BlockDriverState *bs)
>>   static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>>                                                      Error **errp)
>>   {
>> +    ERRP_GUARD();
> 
> Again, why is this necessary?
> 

Because it uses error_prepend() after conversion (same reason as for error_append_hint()).

Thanks for review! I'll post v2 soon.

-- 
Best regards,
Vladimir

