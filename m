Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7736C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E319207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WgUz4B1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E319207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhSwT-0003EP-OC
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 03:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSvl-0002ki-Lb; Sat, 06 Jun 2020 03:07:49 -0400
Received: from mail-eopbgr20117.outbound.protection.outlook.com
 ([40.107.2.117]:55433 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSvk-0006Zo-PK; Sat, 06 Jun 2020 03:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJu5slDTDqu0uM4RzdHni8JT41cniNiCx47WD4rERCxbfoTbVwXR+6KbmOyOZRvCevdnAVPjiUZ8IdJ3Suvqlvj8JB9etAExi+0Cq6wh3KbTqBCuq4hQLuGEjEcNiwcoqq6qZl8Ymz0ocJB5oZcV2VaGUlTNH2SIj6r0Pkv4NpWZEjAVU45VJ3G7cUevr0VO/cnoVzzKRdHTGsYblm79cyqiNmeBDgPR1zhDujtrIjrj2j+ean350HHEfmlCDDS+nyT4JDO+l0hxcquO8Xe5xNE6NCSrp1n0/T/I8Pj9o9ybP7fxuGRzcAhSV2Uc1BxyS+uc+ifLfiFE1x3et9jDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ns2MxVccM/QsdLU7rMD6czkMMrr7aaFlZ2Nytkc6ls=;
 b=NM7taP9eF3gvYJkZyS8gsbD9pkl8NfdmnbTzYvkkHfWpXYcgi7NLWuG0Hh09oK59sH/5jm3y5e4W44uT/l02TOzEvI9IhDYOykHtUoj/5/p3jSz5PuKqgRFk7cab1NrekSrr9iWYi2JLAOFp+X13V0BBTro133mxMgjwok9OWy+VJnSzfy/uPVbQP8y02lze0fReDuDHf+X5/8IV6MtasqnGV9jMsfJkkRwN6gbJMeKIyXjfqG9w6bImLTuEI3RbVewrd+Myhrk83yIHwpoJT7gVCL/r6J2uWdg+l3yssKHd4J1EmJ2xwQLW3ixibHnrrrc4ew8Y/F/E4hIeXoPuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ns2MxVccM/QsdLU7rMD6czkMMrr7aaFlZ2Nytkc6ls=;
 b=WgUz4B1FYTe17bxhLlnk/CKgzkSIge9zFbFtQ/3eM7Os9wj6ITRVTrar0zh3cz0mvapRdJmjYbn1k5bfvGgtJ/6YguxuodHw8BqqeLApV4YkoUV+hJ3ie49LNgf4Xx1dNKZMZAyq3Uiy9vcPQXK3WtMiiVPtWEMHqP7v7JFbu9g=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 07:07:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 07:07:46 +0000
Subject: Re: [PATCH v4 04/12] qcow2_format.py: use tuples instead of lists for
 fields
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-5-vsementsov@virtuozzo.com>
 <c08a2d3b-563d-57ab-4bfd-497c033e4c53@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <039b24b1-16ed-6346-c6e8-ac1da2be61a6@virtuozzo.com>
Date: Sat, 6 Jun 2020 10:07:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <c08a2d3b-563d-57ab-4bfd-497c033e4c53@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0501CA0065.eurprd05.prod.outlook.com
 (2603:10a6:200:68::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM4PR0501CA0065.eurprd05.prod.outlook.com (2603:10a6:200:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Sat, 6 Jun 2020 07:07:45 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8982f9cc-c9c8-48b8-467a-08d809e8504d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53664227A5D887F267F0DFC2C1870@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwAdNDE62nZEZnQQ3LzcDMeDIetTJd/5b2qS/KBMV4p7/4RNbfXMQyl+E7j8njOXWPJFayaySS1YTet3GP0Wtz4oAGaNc21u99ZjHi9+iU+1Pv/4z+2qWb7gUhz2KKPBPbkjjVQ3Ej7MDLW+CHqPh9Wdy0zq1sUtLLW9OPp8G8bJUgfjSPncG+yd4NcaNjSfM7NDkO5Bbv84VCg+/4ARE2QInBiJpBc4WYaAgpJfNeOkWRpMfSn6KBFy7fwfwr0vy2tClAwy2NrW1mHkTTZGJujiglkGJEUy56Ty9GfAakfuRVa+duAANEkYHW/BxBHVhnKm6mqm2RLvfFPWtC989R1I7SF+a9lQybNQY5/6rs6XhJgXN+lxQ6Lq1pbsz0SM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(4326008)(2616005)(6486002)(107886003)(956004)(478600001)(66556008)(52116002)(66476007)(316002)(8676002)(86362001)(66946007)(8936002)(31686004)(31696002)(186003)(53546011)(83380400001)(5660300002)(36756003)(16576012)(26005)(2906002)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1sdx6uMCdvtMuaRzvgMz+Q6JLV0DS7f4cwuA5IHWjJEhF68D2vOXZn0xqUJMt+6U9bUnEZYN1l/EdXEi7ThM3WS01FPCjkDdb8wialTFVwq8t2rMmN0VL1vBk6k31D3M2rO9XqerNCfcjZUhH64hsg3mkIXwZwEfwSQlvgziP7HdkhTBycbVKItOGqCXZjQdjfKaSKEHR0ZwrEQUgQo1DhRMruOJC3m3gXlQK6kImqxdqQrBQSUOiFSEQFJZMht0uctGrkjS8ydt3loQQeYi10l0vdes1eOfVLMQcijPK0yERTLZ/90fyU8cflxHLrkZ4bgI4L1FKPl6Ww5YF9KUKn2gOnReXx25+wZKHOC9IhZ1IcC9VixYtCIL64xEfQ3Re0V4+bsaBBl+w4I6r32GxYRvMUqYofVb/l4MFQ7G1zBELgkRNyi3OItKhZR3zzuuajiZG5jyuriuI8xjA3HnlKYKjlUHoptGySGNld5VbZm6Bffk412e0FIqSNvNrDiJ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982f9cc-c9c8-48b8-467a-08d809e8504d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 07:07:45.8483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMWRz3imEj7luvDsogwKhT2hSreJYjyUcH8XjiBm3wYxmqvJTsEXTbWVDGU0Eg3WzvQHb0Oa5skLESdkGSHr0zWgmEwNEaYskCSJiTUu+9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.2.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 03:07:46
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.06.2020 23:16, Eric Blake wrote:
> On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>> No need in lists: it's a constant variable.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 40 +++++++++++++++---------------
>>   1 file changed, 20 insertions(+), 20 deletions(-)
>>
> 
>>           # Version 3 header fields
>> -        [uint64_t, 'mask', 'incompatible_features'],
>> -        [uint64_t, 'mask', 'compatible_features'],
>> -        [uint64_t, 'mask', 'autoclear_features'],
>> -        [uint32_t, '%d',   'refcount_order'],
>> -        [uint32_t, '%d',   'header_length'],
>> -    ]
>> +        (uint64_t, 'mask', 'incompatible_features'),
>> +        (uint64_t, 'mask', 'compatible_features'),
>> +        (uint64_t, 'mask', 'autoclear_features'),
>> +        (uint32_t, '%d',   'refcount_order'),
>> +        (uint32_t, '%d',   'header_length'),
>> +    )
> 
> Not for this patch, but noticing it since we're here: should this be taught to list the optional compression_type field that we recently added after header_length?
> 

Good note. And we can use it in corresponding iotest about compression_type. We just should carefully check, how header_length field is handled and fix if needed. I think, Andrey or I will make an additional patch.

-- 
Best regards,
Vladimir

