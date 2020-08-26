Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C3CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F779206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="itlV/ltZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F779206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqiy-0004OK-Aj
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAqiH-0003U4-QS; Wed, 26 Aug 2020 04:23:21 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:23718 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAqiE-0006tb-NW; Wed, 26 Aug 2020 04:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzs4MZvkazbqrRhl2GiBWn5TcxUI+PnCDjb61Xz9PO0b4lM4CdBG8gxx8kW6O0n63SCuK8xhVA0iMAPnkieglLN0ApNRkoPcjPRo/REfDXMXc9V7rKZ3MKFXF7Cww994nh/HXt7d/a7Y36F0S77gEtzEOZJuzQ9bTKRbk5bvYHFyhsL4hBwXeTUsea4bJz5/5NFgOMWSgMaI4dlyOxB79Cmqn3mXxRcHJw7QuDOi12nLfA/CByhes4vpKuxFyZq49oz+mgmXbyn3KZy63QTsLNZMjuMeNP+klLr0ftxMyGAR8bz2wQeKKJKJLc31XTc8pAvyULgvreiAU1X6ijDM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr+3rE9T6/XyX9vbUjB0ZFxWiJqLGgjQ3Nc9ly/bhU0=;
 b=joiCBEk6qQ73mSzWwlcc26YShOHgwWbYJNrcumQdQ5hursp0xQbBgzWYHwpFoIN6qu/LIgWDiN9uasyYwjF+IwEwCICK1608RsaO3TbWrSLWkq+Nrv72qHmWc8avaZIa4KCXZ+oTtJIwC3hAZ8O6/67Q8lm5+gnc4JFV8w0b075Id/TC06emoM+5ahg4Bov0NH8HUbCrLaeWhRHTRNVCHmo7IaTJG0sjKf8KzM3WS0ZS+MZTmuPi/h54zIy4MLzaUZZb4w/uUrgq62ZcFVFtSZHryMaYEsppT/lRps4uPosmpcd7Wy4hpgaU2k+UNUgYA15m1CS0DRXyTwDEsvWu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr+3rE9T6/XyX9vbUjB0ZFxWiJqLGgjQ3Nc9ly/bhU0=;
 b=itlV/ltZFUg+pkKHn2V0wrpLyQF0O+mUoX5LUwOWMAxb9Xm6caG/9eEVhI+p5sfCgW1Hfoe1w/RqKjAhTKPZpQpXFYjBbSSXJT9SZqQaBBY71RWxhjfbN1HQP4F2GRAwtAbCoSQWNHCqiGsexybdkC5sW1LLAj1dgga4xp+Z344=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3157.eurprd08.prod.outlook.com (2603:10a6:209:48::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 08:23:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 08:23:14 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <d85c544c-70c0-6860-0b5c-a2d46d740d1c@virtuozzo.com>
 <de210b71-47e9-e119-3ab9-1dbf0812a4b6@virtuozzo.com>
Message-ID: <ea6e644b-2e02-9317-8eac-14ae404df0e6@virtuozzo.com>
Date: Wed, 26 Aug 2020 11:23:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <de210b71-47e9-e119-3ab9-1dbf0812a4b6@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR01CA0142.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Wed, 26 Aug 2020 08:23:13 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102ff800-c54e-4e7d-f76c-08d8499946ad
X-MS-TrafficTypeDiagnostic: AM6PR08MB3157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31570F686A8B54857657E2EBC1540@AM6PR08MB3157.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:195;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rqJn2g9xBft5R6HcfGVZiePcerWELJ8K+4bMBQk9OhD4di1jgofThVIAMLIjmVsNnBOAmxcpOrqANQ+IrKHLwV1/DtcRU56PjrTusR/+C+szc3wAhMv+HhvahIHqxer2tl77CDAnSlgJJp1F6iBzo0bDNuOkQBt0aCV7FhqXwNYPxwCeHqNLIsYhQ9bpis4q4D3L5aGVPxbUnA8HsZt2LNw9BWn1B8ewSfq8sXdSkInDUgC2q+LJfKWvllQ4GI/cWz530pzMS9qIW0tvY0NnDfeGvzA53DMZEuOhw9wY0GO4fLMBZvYEhHGGkOAV+gEaREYs5aqGXdEUVhkkTcQdahOoJAwFA7uuicVYISVr1pW7S7VJ1ybTlD+GKh0lz+X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39840400004)(366004)(86362001)(4326008)(26005)(66946007)(83380400001)(5660300002)(956004)(52116002)(54906003)(31686004)(6486002)(107886003)(478600001)(66476007)(66556008)(2906002)(8936002)(31696002)(2616005)(186003)(16576012)(8676002)(316002)(16526019)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WtqF0cZoQy9LfegBtT4NnpSylzNGEQ4kgkZ3soBSUh/j4E/M11mq3bEvzDqR1Gqe/+D+54sLyge0k2ewklKEi6Z14eFEfiILw9T5tO/WK4KSdJnlrKDXSzUxilD6nvtRImOCQelrgJuHKYaW5mOo0LrR8Sh/fdgBT01dkXgb1TY+iNa9Ff7VvdLtZK+Xa5L9jUqLvOe34xd9TujoHG5TpzvVbi5wZmm/SkNoLD28PnGsAZrXmTAwIapU1ZDcdexfI0zXUz2BhesS5mUuRTF3tD9dhwZFEcY+JxE1CYRIsxJY5fb/lAy7YW/HayiZZVygOukF9NR90HcGAJa2pzCxCB/BWaqodhaUm/Jc/7wjEU1+me1GkbXh688bwlFH11a5/t773TeMivI2wsUQiwUG/CmyyKcZpEgg+9owss+TsieOVezoH0g+ZccE6DvK3wafTaG4Pp7eLzInVByfcUOKqu8+qJYLV8f/+kFnY5l1TdzakEIxSWWznLYh7gGqnnBDJvmanVR+as/QH11fodt6k30J/+UF5oF8xsiSX3u3gIxx6Pwqe5WtfBmemcyzYfb5ryzRE51YoIqRCo6ac4EYkPk3J1OmOsq06xn+Y9XdObApqkrsURh3/L1x4Nx/CiyCXdPWTk/e1a4RMeZuLOBAZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102ff800-c54e-4e7d-f76c-08d8499946ad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 08:23:13.9148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjL7V+GSMTWTgQHF4ONz1mm6WQlGgUdauMcHtYlMe9CdAjuue/qoj+wQCPtywkQsPnfYYFMeac5vifWcSaJYBgxKZiKPiLYhVJTcAzSIccw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3157
Received-SPF: pass client-ip=40.107.14.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:23:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.08.2020 20:04, Vladimir Sementsov-Ogievskiy wrote:
> 22.08.2020 20:03, Vladimir Sementsov-Ogievskiy wrote:
>> 01.11.2019 18:25, Max Reitz wrote:
>>> The XFS kernel driver has a bug that may cause data corruption for qcow2
>>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>>> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
>>> in practice).
>>
>> Hi! I'm doing some investigation, and here is an interesting result:
>>
>> Consider the following test:
>>
>> img=/ssd/x.qcow2; ./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -w $img
>>
>>
>> Bisecting results changes between 2.12 and 5.1, I found the following:
>>
>> 2.12: ~20s
>>
>> ....
>>
>> c8bb23cbdbe32 "qcow2: skip writing zero buffers to empty COW areas"  -> becomes ~12s  [1]
>>
>> ....
>>
>>
>> 292d06b925b27 "block/file-posix: Let post-EOF fallocate serialize"   -> becomes ~9s  [2]
>>
>> ....
>>
>> v5.1 ~9s
>>
>>
>> And [1] is obvious, it is the main purpose of c8bb23cbdbe32. But [2] is a surprise for me.. Any ideas?
>>
>> ===
>>
>> just to check: staying at c8bb23cbdbe32 I revert c8bb23cbdbe32 and get again ~19.7s. So [2] doesn't substitute [1].
>>
> 
> Note, it's all ext4.
> 


Let's go further:

If I add -n, to use aio native:
./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 50000 -d 64 -f qcow2 -o 1k -s 64k -t none -n -w $img;

Then this patch doesn't have such effect..

But if consider the test without an offset on hdd, the effect is very significant:

./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 45000 -d 64 -f qcow2  -s 16k -t none -n -w $img;

v2.12 ~10.4s
c8bb23cbdbe32^ ~10.6s
c8bb23cbdbe32 qcow2: skip writing zero buffers to empty COW areas: ~16.7s : degradation!!!
292d06b925b27^ ~16.4s
292d06b925 block/file-posix: Let post-EOF fallocate serialize: ~7.6s: great improvement !

-- 
Best regards,
Vladimir

