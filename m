Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E9C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EC921D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kNjajixC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EC921D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhyI-0003yf-Dt
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhwY-0003TC-1v; Thu, 22 Oct 2020 17:16:18 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com
 ([40.107.20.123]:55392 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhwV-0007dX-8B; Thu, 22 Oct 2020 17:16:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzIzw7LS5asvY3zCsf3qTJ4/MG5bwi44ZthNkDD8G9moNFDKZ98c2/zYSccFvYTvYpGL1vquGoMxIylQF9ZdXqJ2shl7MpHhcH7qpZAC3ejUBfjGcdd8dxq4nJNjfuRUw06Y3m1OWK6x5kd8XwFq519aqNkUHggSOr2g28E9Gxt2mRCSQbhu4ZhGh/f+Cyme9YIU5W3uLKGfzGtheiY2bwHldEczAiV8ZCwLQdUG7B/ZBYHZRPAcERItbJIpjFV58szdJkKE9hz6WSoI7HbedqoFJZr0/3MO69CEjgkBJN6rZ4K2V4HU7NGB7LghnOxisyEqhcez1njb8FphYbMnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqwTGg9fs/7jHCUZA9hngkAxnBhEbBngVMyG3glQb64=;
 b=oNZ8E3kSbNGUqJBSUVbzo2LhMf9tJAfhhP2I6eAWpXBQtnVUxQMU4D2EpsZIou/CR17MNKgA0qATkbGla7Nt5RvZ0s8odn94SiuuOB9zd0vDUZZuNo1kgtxY2Abzh/rNsg3yGWTYZrQnLGzdKYtLCmmW3QQG1Z4U+lbb+YJH8oNuGCzkcMtBuU8Zal4aGF/mvoTAXCinMbFz2wXK8Ov+/aWlNE8MEflychx2QRzTMD3KTpdosnktye4AOVCKJFRHLSvo6lKuMhROcQhHYz2b7FSpPfGmWkG6W6gfhA6T+QooH8a+44FFFsrKXU6R3fUMGspzqT/GxLAgfDBqpvQUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqwTGg9fs/7jHCUZA9hngkAxnBhEbBngVMyG3glQb64=;
 b=kNjajixCP3HSHmbz2IjyWuw8RsWWsze0m0CHvqtRP/xq03Vie/vM0HZ1E+DN1PswMDNvj1mU+RuwJI2/OoL5johKlwV6uv7wttw46fQA/bRJuc88jeQtSOc4PGdTotp7+V0fxwbwgn3Vg9oPoZ8mX8zg9eLyfJTwOw2W8BOJg98=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 22 Oct
 2020 21:16:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 21:16:11 +0000
Subject: Re: [PATCH v2 14/20] iotests: 185: prepare for backup over block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-15-vsementsov@virtuozzo.com>
 <9f8d6176-e110-42ee-a579-7c4dd12511d5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9e7d1fef-3321-a7fd-878c-6f11c17ac070@virtuozzo.com>
Date: Fri, 23 Oct 2020 00:16:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <9f8d6176-e110-42ee-a579-7c4dd12511d5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:208:1::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:208:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 21:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0eb9ee4-f534-4028-57ca-08d876cfb37d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5334B7844F9003556B64C1BFC11D0@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8IX8dYKajy3AKCTxM/o0kC61uB81u5/qIYimw0pMXMy6ApiuNVOhqDPVbhYOL/JNUHgzheaa528E4YPw/CRkP82azTvTZiQnCj+fMaXYM44HfDAoPt1KBlWsqFJwLaA5DBg2oCgWh8tZv/VntHC5+GP128nrenFFSIDBbmkXWqHrHoOGfdpIKzl2X63/SJ67eOQXQLiYrDZhUwRPI/zah2otXAJu+WmRAf9e43kXNTMKuqO8OpiqsKM/EQ94XXFOzr1Zaqoize9Z2CE5c1BH//uf1YAjIGU+83fKwmBSV0Ti/tyfq8OefHPWEqRy2Z6wLKgjd1dcEIFI7J9CBIZRXFbrRZrtTbVzWLqlAcDacIdx/IPpjgamcxkXQPe0i/i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(346002)(136003)(396003)(36756003)(186003)(31686004)(5660300002)(66556008)(52116002)(8676002)(26005)(8936002)(66476007)(16526019)(4326008)(66946007)(6486002)(107886003)(86362001)(316002)(31696002)(16576012)(53546011)(478600001)(2616005)(2906002)(956004)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MLX6tShaEE8fosFXXcnWReOeFDWVAkXj0GJ5/F8XKdH7MMan7Dl51SPVdWDMfLKdaaUhcadDif5ZrpFETrXhyqyfu9uc8r71f2I9VucZgD5H5Bbq8ZS6WxSBtRvjglDDKDk1xhvXsoxBieSCVVjPDIcyAYP68f5MLlFovzU2oArjsQahbacyprqgA+AOdi4d3OHsB188rFM7fU7/iQhGYcuwQg8epoHEOnUR6kF6jLbzkQjL5zMEwhktPThWPveG5kueMaIAmOJLo55d5qKm6CW8T1NJ/P47DWSFEdBv/hUToQKJ9yuh65WiGVB+zYh/RUQl0lTQ8C0jyB5o9THi1+Gm73cCBP8MLqWcRIlvf84sueNGO3m7nslt4me0vwheRcLUs3QM3G7RnKyeSxgbNCYae9khg8v5LRSdQ3GL5wJW+5Kwj75Dr5ThldAjKwoTd9O6RXsDLUN9HXiPPpisqlGumqNPJ5mFvfIS+BBS6X32bvDo8/ozhJBLyd7Rwkbw76lTzxubaNg5RYeKLtYPDRDEovb7zzIL4Ljgc0OhXd33JWayNKlS2iGmCaBpLEvWIdSzDtAphJL1Y0dA2ajmYpgs/9KR/9OHi+80ttVuOu3vUJzUPJH28/6yQuIHW8KV+1rXqsWZg/p8MdXxt1oFYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eb9ee4-f534-4028-57ca-08d876cfb37d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 21:16:11.6411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz5FWrQ6hPw55X/nAHzH8hc0PfQCDizaSIxOqEqhPpkRSh6jbnGGgMc0TbO1UEBMtJ6GQlWOWb7STkgXL4PANkJZ/mdkgBWj29n1lGwxO1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.20.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 17:16:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001,
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

23.07.2020 11:19, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> The further change of moving backup to be a on block-copy call will
> 
> -on?

one :)

> 
>> make copying chunk-size and cluster-size a separate things. So, even
> 
> s/a/two/
> 
>> with 64k cluster sized qcow2 image, default chunk would be 1M.
>> 185 test however assumes, that with speed limited to 64K, one iteration
>> would result in offset=64K. It will change, as first iteration would
>> result in offset=1M independently of speed.
>>
>> So, let's explicitly specify, what test wants: set max-chunk to 64K, so
>> that one iteration is 64K. Note, that we don't need to limit
>> max-workers, as block-copy rate limitator will handle the situation and
> 
> *limitator
> 
>> wouldn't start new workers when speed limit is obviously reached.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/185     | 3 ++-
>>   tests/qemu-iotests/185.out | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
>> index fd5e6ebe11..6afb3fc82f 100755
>> --- a/tests/qemu-iotests/185
>> +++ b/tests/qemu-iotests/185
>> @@ -182,7 +182,8 @@ _send_qemu_cmd $h \
>>                         'target': '$TEST_IMG.copy',
>>                         'format': '$IMGFMT',
>>                         'sync': 'full',
>> -                      'speed': 65536 } }" \
>> +                      'speed': 65536,
>> +                      'x-max-chunk': 65536 } }" \
> 
> Out of curiosity, would it also suffice to disable copy offloading?

Note that x-max-chunk works even with copy offloading enabled, it sets maximum only for background copying, not for all operations.

> 
> But anyway:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>>       "return"
>>   
>>   # If we don't sleep here 'quit' command races with disk I/O
>> diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
>> index ac5ab16bc8..5232647972 100644
>> --- a/tests/qemu-iotests/185.out
>> +++ b/tests/qemu-iotests/185.out
>> @@ -61,7 +61,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
>>   
>>   { 'execute': 'qmp_capabilities' }
>>   {"return": {}}
>> -{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
>> +{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536, 'x-max-chunk': 65536 } }
>>   Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
>>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
>>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
>>
> 
> 


-- 
Best regards,
Vladimir

