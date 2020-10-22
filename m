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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7AAC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0C20874
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kvLjf3Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVht3-0001Ul-0K
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhra-0000nT-Hd; Thu, 22 Oct 2020 17:11:10 -0400
Received: from mail-am6eur05on2124.outbound.protection.outlook.com
 ([40.107.22.124]:6209 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhrU-0006u2-7Y; Thu, 22 Oct 2020 17:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghaayAlKCj5g+KJm05JrfgQAAggT+n80BgepPU8VB4Y5j9/CSSIrqkbs4icdk4YbCcCiz0iNUy2zNb8RjO7ebthPf8dZuaB0PCh0Lec/pJxULTSYxGystGo7X5QoBNEwSBU3QqVqk4tz5xs30v2DaQtLQ/TSkcFEfiRhbT0fOSfO8Zf1qGpUswOJQxZRQ2l3eL53EXXkr23Q9/6VYv9I4dn52rz0O1dmg9TfeaBDjMTpQa7sjSaiEgMWYgZFJKEa976muQCIjFkmlf+WflIkX+T0ul7dVTzo0p5mzM/3YTWapv8ntYSQO1CIfKcBPLZQ5zMZzQaOqxDbRLh39w7ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9ZpEdirH4Enxde0gpw485QHy9Y+obZRF5j4zYntew=;
 b=J9QUgw7zseujy+V3Eu2CCczPU5xLfKSLk4rVb5WXiZXIOqAJkbAUEhUBFwS6BPPIigPpmXQ9Nd1IsKfd5K5bCsx6ieWScfMN1YurHB/Ckg2YzhvHrOsFvpVz5oXhwAeuV6ACAVqd0t6qL+vmEG2NIV6Bv2Tukr+5cvhs7n5I0ihCjfZdAtJpbjNImfjm9z7qgdCTL06IOCr3Fhf2KhbY78KTBd2wdQTGoV8Xbctu8aICwunlHdEZKIURoJHlWs/PjMidmD7S0aDMpEUzL1F/q9IjqP6RETxSY69KUe/niupsHEI6C3b9u4n7RZEe/kCPXXTf0uuooBY8mC7wfNYylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9ZpEdirH4Enxde0gpw485QHy9Y+obZRF5j4zYntew=;
 b=kvLjf3TdaZaQiJXWtH+7yw28WtMmd4nlK8z7CythOkxASiJklmIl1lxurc8E6WzFUN7JTOmcVHsgfV6vZamVzL2P4VvTjOdV5NJd3kKuUVce7gTG8Izfpqp1FfloEZK1EaKih6O1C0+FRB60geLowCghu3F5G17BGU3/r3nQiYM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3446.eurprd08.prod.outlook.com (2603:10a6:20b:45::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 21:10:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 21:10:59 +0000
Subject: Re: [PATCH v2 13/20] iotests: 129: prepare for backup over block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-14-vsementsov@virtuozzo.com>
 <0293433f-7b37-f7bb-c4dc-3d64b2dbbc68@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <95c4411f-9b88-2fbb-1e36-2fda369e51a8@virtuozzo.com>
Date: Fri, 23 Oct 2020 00:10:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <0293433f-7b37-f7bb-c4dc-3d64b2dbbc68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:208:122::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0003.eurprd04.prod.outlook.com (2603:10a6:208:122::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 21:10:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e32bf0-8e69-455c-e91b-08d876cef93e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3446B7AD8ED701ADFA07804FC11D0@AM6PR08MB3446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hUrNJ7ep+MSyJ/9KDhjVAhwrr05mhcEJBaecRHKZZq3MuolAS8Hc6lJZMP/1lyxWxN2sIGFnd/rkntGsxr20yz6OsK7SwJ2p8LdPaWcQhxlBM0EBdiaillyN2E4ZRhSjnbCFuBx5W/MdjCotj/Xt9CRRQax0ZKRoCu67GE7Q6E67R02OAbF1/vPm7AtFnxGvIHReskKONB0j/8VZh3RCer0iFUCYDb694rzLOu76DlIstEVSbtpH7hx6U40n5tO4WcWq0GsbAWflCgzhey24jVmGaZ3rfNiaGYgjuc+tUJJJwWN0o2VFeibQp0gAMrZ5mkWD6AgwLw8YBbtHC9xMVPEvmPcFCAr+30MbZIjyT1yEYC8n/pRxn5EQQqeHYUU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39840400004)(136003)(366004)(4326008)(36756003)(31696002)(6486002)(8676002)(186003)(2616005)(956004)(16526019)(2906002)(26005)(478600001)(107886003)(52116002)(53546011)(8936002)(66946007)(31686004)(16576012)(66476007)(316002)(66556008)(86362001)(5660300002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VtZJk6zidAV+MqixZOMHDKDmaU2NyG8o9RLELpa/58YAk6EmCqIDbtO+cXGHaRMjahP8Vnhu5eHDIMgwIWuGvol1j3QddakEaGyXNGEgugo4wlJOLBFk8UbaFnEzLSAYmah8y7S8QPDzDm4SdTung3AbHRaF2GOtu8IitjHpgdIrIcKgabhcPZN1IgFNq5XFQeoATGi2v/VXcQ8I7hvdcUZZKjufa+NBTCpTX6iUhNfa0gdm/PXr0J29LM/mbYPpUhvZ/svxv6mYNqwiHo1NL3XKzfxhRA/ftd4bQ33Hhx8OFfZmj7hFcnso4YAGPTg41bO43rITLR6yyJpwS/HGl64015kl+uhCiOBKo7WLEFYohZJVrUX6qo1YJm6dltHfrxDiI20cNFLimmS+Cl76ubHCb+OMPRFSfKmB0v8LIk+FiOtkzfEZ67NlAEdmNTJpOYQYiyR/8iD2ZRXZ4rsnxv7ePEvsrNoLDdz2m/dmxLCqhXtJPZksN4KF4v1e+fcZCPvCHmm4MPXw05GhMD6GvOPKE89DB1N9E1qGIvPWy0tEE7l+KlZL6vkK9amJJtLsrGqpaCx6rWoEMdWePrPYHlgO0MRPYinRG4kYo9l3HNw9KPh9yBiRb6u5Wx83Y0KYuN19q3Ux/O+ETk04tH5T/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e32bf0-8e69-455c-e91b-08d876cef93e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 21:10:59.2285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMMwOsALlxNg3ZIP5lesnI8lk83GkGwkU2VqgWd6spFyUIzBbyBppclLfVIIa+fWArBAP7+S2U23xhVyDKjnCgPbjvyG5aTaRcDWl/6j2Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3446
Received-SPF: pass client-ip=40.107.22.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 17:11:00
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

23.07.2020 11:03, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> After introducing parallel async copy requests instead of plain
>> cluster-by-cluster copying loop, backup job may finish earlier than
>> final assertion in do_test_stop. Let's require slow backup explicitly
>> by specifying speed parameter.
> 
> Isn’t the problem really that block_set_io_throttle does absolutely
> nothing?  (Which is a long-standing problem with 129.  I personally just
> never run it, honestly.)

Hmm.. is it better to drop test_drive_backup() from here ?

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/129 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
>> index 4db5eca441..bca56b589d 100755
>> --- a/tests/qemu-iotests/129
>> +++ b/tests/qemu-iotests/129
>> @@ -76,7 +76,7 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
>>       def test_drive_backup(self):
>>           self.do_test_stop("drive-backup", device="drive0",
>>                             target=self.target_img,
>> -                          sync="full")
>> +                          sync="full", speed=1024)
>>   
>>       def test_block_commit(self):
>>           self.do_test_stop("block-commit", device="drive0")
>>
> 
> 


-- 
Best regards,
Vladimir

