Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6473C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72295204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eXVOKsce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72295204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcGTQ-0001yc-Mh
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 18:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcGSq-0001Cq-Cg; Fri, 22 May 2020 18:48:28 -0400
Received: from mail-eopbgr30123.outbound.protection.outlook.com
 ([40.107.3.123]:53157 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jcGSo-00062n-6b; Fri, 22 May 2020 18:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuVryojnqVRkJUB6kQN4UNkU4x9pHLfJTA5F0FNDlCTf+d6icBftk8GGuzt0BZWMAqf3HU4vQgJCyIEgGlsGPTzxEzU8mVzs9f2Zc0XjsdJDfkZWNTmQospuykRhLhGqrttoEb9nbandDkgeA9Oq8rmOrF+OSziB+XnTghk5Y/E31jmAiYWvV3W7tJt1y37gxOywjL21iO6knxslOXhx5Acq9jXCv6M2eEP/0puMq5GsEEe9RqICaHmRkUz3nOLtCQXbpPSgIZBaETLSRDWNOtEfIYidYKvTJY/EYdky0Mc9HKp+3eFPmeXPf+WVmSKVVgUrF4IuHwSACZxPB1otoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxvR6S8P2njJYRJivk3GGAb8gGDLEr5eqU5UVP+yjA=;
 b=K+tU61x7hkJB69BzkAyIzUCOVMebjiAO67Upv5Pirwop2uL3siFQRt9foUFHlgNLFPWCF3Bd+Ra0jh5BVdjhhxvFMFMxNNK691YaXh9d5rG4lVoRVNsUqvpulnhUkhnopjCCgtEDzX5bHPs0qd49EkRL04p2tkIM268uDspZSSRjd+GXAiDm3ReFFHdIs59vIEI6m6JqP9yrBM1BIiJyZm31uh9vLX05FZ9VocNmsmVd19z8AFUfAgE0MOV2htzoo9eJzuA/353K9rO3RmKJ7UJhF9fd55Zz3wVFvl7M2BFwh2lJCUYHTdiTr08SW+WMPpm3Kjs1W9jFvfjs1s9k/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxvR6S8P2njJYRJivk3GGAb8gGDLEr5eqU5UVP+yjA=;
 b=eXVOKscezcTsVHhmMEupdlvz3h6CcdfXYyhk7OTKQWh2uE28NXYjTe2Ag5qIeLGQwOFXfQo5+n1h7yh85Hy+0A5vIpp2T3Qh6xVKXAi1VA3JjRr6df86ZJONuL8OoVvV1xdroFbWM3/jgidbLO8Xx/p9hD3Lm+vjiqR52KljlpY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 22:48:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 22:48:23 +0000
Subject: Re: [PATCH v3 1/3] block/io: refactor coroutine wrappers
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200522161950.2839-1-vsementsov@virtuozzo.com>
 <20200522161950.2839-2-vsementsov@virtuozzo.com>
 <d3e7dbc9-ba3b-965d-726b-8a99007a8e08@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c241405c-1c9b-17e7-0028-c9ac3cae815d@virtuozzo.com>
Date: Sat, 23 May 2020 01:48:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <d3e7dbc9-ba3b-965d-726b-8a99007a8e08@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR06CA0125.eurprd06.prod.outlook.com (2603:10a6:208:ab::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 22:48:22 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb438f0-f218-458e-5619-08d7fea23b2e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462B370BDED56A9A217EC0EC1B40@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Adjr0+ATbR9bDPPiNQamnryxQKRIQ+ci66BjwgTxm/xFaPO92i7ZPEfDJsOjNM6Z/02dmELgF8vhU9MN2+jHPQ/pqMN6AaD1oU1Vui3wyVJ4AJq66T7OKseicz+zJwiSHufSwC1X3zfmE/l2quYL353sohe67zw/4us6JW97G0htJs+Leerj7dTZp1yeNS5lehW8zWQiDwRWThXAQy6hA6qYWFtKN/ayexvi1PaB9c7tv/shILpiwCppmraQe2mV7MsewWxUys2hyu8B+mhYvMjnLUtXBgwyH/uiscqLJcu808u6wiQhAj7IIrye8tfKNxUi4KAMnEVASavyvx3SX+dNhvNBBDvkhcKhpopsRf5CoT73dKav5/7ku2dSFIwf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(53546011)(2616005)(2906002)(66476007)(186003)(16526019)(52116002)(26005)(66946007)(956004)(8676002)(66556008)(86362001)(478600001)(6486002)(31686004)(8936002)(16576012)(316002)(4326008)(5660300002)(36756003)(31696002)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iVhXmG9xQoCdLDZQLn2ulDVvnNh34K0zLaGU+XatFqRZueZr4gqyrksydvAGQaN/VfXTVN8CwmMsMfdvB1kVTAmIBvQVcpeW/KfPGLZpyh5y4mle77og8xXyuX1O4zOa+VG59HJeiZRmqHS0ojrGdhgBojXX/ZrJoykHot+wd4Euq5MDQX5KrKcOmR9RuT5oi+3n54esA66Vunll5794pucjE2sK+ifqVzm5n/tgIZbxNiaSy5bauMBzDOMrErASmi2+9f4JBA++A449cHQYtr3Yj4y06zBj+8RoLFnOaIV40lGxETQHFDI9SSR7L2uXgaBPvNBWbOdPGIWCGJo0rUYlC2PTJnWu1BKoacgKyq/LxQq/I3GFn2CK9qPzUoQmGvOrzyqNE0NzxwPoWHnPIwyw5qBjy/fSza3MBA5PemxfcXfnIwVzX14DAcFguQfGUH7USCwUfzqUV62+n+qLclqf0uFzyqCka0axgtwU/sbtc+zvU8UM/Olg/j1krLvJ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb438f0-f218-458e-5619-08d7fea23b2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 22:48:22.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqzbRmGg8wpCUofkbYyMjLbJEZ75yQK0UjiMeGLwi178rGE/wUVcbWJ/lvyeiwRAwr8feotDKCccjzq5JSFAmTBEu38p8rBpbfaGVbJfnkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.3.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 18:48:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.05.2020 00:33, Eric Blake wrote:
> On 5/22/20 11:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Most of coroutine wrappers already follow this notation:
> 
> s/of/of our/
> s/notation/convention/
> 
>>
>> We have coroutine_fn bdrv_co_<something>(<normal argument list>), which
>> is the core functions, and wrapper, which does polling loope is called
>> bdrv_<something>(<same argument list>).
> 
> We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as the core function, and a wrapper 'bdrv_<something>(<same argument list>)' which does a polling loop.
> 
>>
>> The only outsiders are bdrv_prwv_co and bdrv_common_block_status_above
> 
> s/are/are the/
> 
>> wrappers. Let's refactor the to behave as the others, it simplifies
> 
> s/the/them/
> 
>> further conversion of coroutine wrappers.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 61 +++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 33 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 121ce17a49..bd00a70b47 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -900,28 +900,32 @@ typedef struct RwCo {
>>       BdrvRequestFlags flags;
>>   } RwCo;
>> +static int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
>> +                                     QEMUIOVector *qiov, bool is_write,
>> +                                     BdrvRequestFlags flags)
>> +{
>> +    if (is_write) {
>> +        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
>> +    } else {
>> +        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
>> +    }
>> +}
>> +
> 
> If we're trying to avoid needless indirection, wouldn't it be simpler to quit trying to slam reads and writes through a single prwv function that then has to split back out, and instead make two separate coroutine wrappers, one for just reads, and the other for just writes, without having to mess with a 'bool is_write' parameter?

Yes, and it's simpler after the transformation than before. I even wanted to do it but forget.. Will do as a follow-up, or with next version.

> 
>>   static void coroutine_fn bdrv_rw_co_entry(void *opaque)
>>   {
> 
> That is, should we have bdrv_co_preadv_entry and bdrv_co_pwritev_entry instead of just one bdrv_rw_co_entry?
> 
> At any rate, the renames done here are mechanical enough that if we make further changes, it could be a separate commit.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


-- 
Best regards,
Vladimir

