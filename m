Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E42C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 16:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C254D206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mV/2jJMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C254D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juelF-0004Uk-Ub
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 12:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juekR-000441-UO; Sun, 12 Jul 2020 12:22:40 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com
 ([40.107.7.130]:5830 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juekP-0007jq-Ig; Sun, 12 Jul 2020 12:22:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMaugN0ueW+JTu/7JQDzzlLFd6wPRFMEgEUmhrNJpQFYPIWgKi0hkCuTVa1HMXOh/tpymKpx8gbEEtt8IQzPQXpsHBwXNIuxoI6jv/+zjtf2w90viHqTI7RmnDh/ZQdUZS4M5rCIh8o4O9si/pJkPCkF5Jms4NSf1eeJC2h3vvyfI/4bB/M4qT3aN5+vF1fdAf9RTC6Folz6Y7dFLg49uwppsfW614AGo/WrfbRvi/3s1UVMnIWzhorIDIqmolLcDta1B3CD9T5a1h4V7wt6VPEp6mO4Ys09nHqcboanHis1zagnsFgBo/Byej00vR1y3ctaeNJm2dAM+x6CeAZ9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC/4uTJdowER+CYlnYWnz9aOmJd0XsbGYxbE8Zd1MRw=;
 b=TeXGRlDs7l8ohNBxZB3z8pJbvDLgs3LEn9J38dpX0zu5UFvLu6fMnGGfnQDT70J8r6UnUsYefxLzlNEVoomze2QXhiLMG7Z1t8P5ELPBDVZbvjfhMv8YmYGBvNQgTzk4no+yeqKHMV0Bjs4Tg8IF4BmZUWPZZlJLh0OSAv+uHJeph2y36PT3Ht5+laHFLgj8tH7byALv4jtWO32VF0Jq31DYdMTLr+1G1yUVMbRC3dmFqjcPDLW5p5gqLP01l5/LWG66E8Icm8v18hp/vckcx04HsetCS+poazVUC5AIzedPUwqvITb3oQGMm0bXEDFtfXiQaPKRlkt7lRLCYYZo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC/4uTJdowER+CYlnYWnz9aOmJd0XsbGYxbE8Zd1MRw=;
 b=mV/2jJMHKufm1odeoIX8Djc1mGxUGIwOu/qQO2pJy1M/6Zq0nv3zaXFIWqm+UcpG1eB796IqNBpTVD2B3oEzc2RnUDGPrA6GQJ9ZLNP5Dy2ekFCd29x9InxdtuQpjI7aP8pdk3knl//Pa+byUaBnYvKKbl45MmZLDUHXBjvGawI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Sun, 12 Jul
 2020 16:07:30 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Sun, 12 Jul 2020
 16:07:30 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
Date: Sun, 12 Jul 2020 19:07:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0105.eurprd05.prod.outlook.com
 (2603:10a6:207:1::31) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR05CA0105.eurprd05.prod.outlook.com (2603:10a6:207:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Sun, 12 Jul 2020 16:07:28 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2f9517-78e3-46be-b911-08d8267daddd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5445B9E83BA3341924E0B7B9F4630@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FXCUyOxKiIBMOEntuxMLCAXvCBYGOwDHL1rfN5v34TuEHLrmkiUQTQskOAbcnv47Qa+zJGNZTHR7ySx1XJxRCZyKQQfw45N1tOMInrq8lsZvi6CVyBZNR+n9simgsmiAiaaXEauvjDQ4mbMFp0ilUtUeavSNMa8J6+yqQEotkKfZmhRefa4M09pdM1hSekz++zP1ArMQYb4NIfA9E0N9BNo8CwY0N/wknt0qjLkoAV+j59syG/PaYpoOuOTrqdoT5Qw9vbzGdiyJgLiJsAHqWge8fuSu+qKdxtWeMPh0DlrHFBsU80VFKvOV6l1Naj94UudivNYMEKsWeoH0kqy8sV/MfuweHMg1VZuudYdrp6NGoIlSmAG4UbChKVhMYf9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(136003)(376002)(366004)(346002)(83380400001)(31686004)(478600001)(4326008)(31696002)(26005)(186003)(16526019)(36756003)(5660300002)(316002)(2616005)(6512007)(6506007)(2906002)(44832011)(86362001)(956004)(53546011)(8676002)(107886003)(66556008)(52116002)(6486002)(8936002)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ri+VOsserbptUtgHbxgl/C61VIASQazp6knmSb0+Z4xFQEKonhg+CktuV6TpbykapD9vwETggZi3ifJHeKjao6qJZOw+uw7AGKHJW95+UyvE5lP5bEpIy4DKiZy79Mp3aENUWtuAvETR31Wp3qlJzx4K4GAPRwxsYtnCvn5Tx7fYMh1lNQAMGbwjIEzu3tesxRSIe4i6xut687Fi2y/ThziR8GimPg7CQ92KMySYOXOsaF+tgi+l/WBK+0UH9i1DcaRI+2MJcQWEWKm1lLIsry1MzInAHhHQXnlU1x4mbLdaYafUpd/GJlCNHLOGRwneiArhx6i0xKS/zYmyquRHu5INkEiLDlnkVYvFkMIFVSGOzgahpvh1tR4A30W/tqYFKZx3mPfO1vq+6fl4JXVsea5ADSbM7Jv7ph16EQfB0HSmKB61+tzWgvN3uTyw3/Vz+qbEbpQEzOmlRGel8YGjAo3BvB5BvIu/GCZ4fF9WeaU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2f9517-78e3-46be-b911-08d8267daddd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2020 16:07:30.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AN4NxAKQXYj4epprbXydqlNgObOUvvwcDZHNBcqAAGWZagjm4uAuMQIAMDzZSekvRt1JcALxPNfu96xfnVjR86UEEwV9BJ/Mu3rxiaBnwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
Received-SPF: pass client-ip=40.107.7.130;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 12:22:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.07.2020 16:05, Vladimir Sementsov-Ogievskiy wrote:
> 26.06.2020 17:31, Andrey Shinkevich wrote:
>> The script 'bench_write_req.py' allows comparing performances of write
>> request for two qemu-img binary files.
>> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
>> applied patch "qcow2: skip writing zero buffers to empty COW areas"
>> (git commit ID: c8bb23cbdbe32f5)
>> The <unaligned> case does not involve the COW optimization.
>>
> Good, this proves that c8bb23cbdbe32f5 makes sense.
>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>> v2:
>>    01: Three more test cases added to the script:
>>        <simple case>
>>        <general case>
>>        <unaligned>
>>
>>   scripts/simplebench/bench_write_req.py | 201 
>> +++++++++++++++++++++++++++++++++
>>   1 file changed, 201 insertions(+)
>>   create mode 100755 scripts/simplebench/bench_write_req.py
>>
>> diff --git a/scripts/simplebench/bench_write_req.py 
>> b/scripts/simplebench/bench_write_req.py
>> new file mode 100755
>> index 0000000..fe92d01
>> --- /dev/null
>> +++ b/scripts/simplebench/bench_write_req.py
>> @@ -0,0 +1,201 @@
>
> Next, I don't understand, are you trying to fill qcow2 image by dd 
> directly? This is strange. Even if you don't break metadata, you don't 
> change it, so all cluster will remain empty.
>
>
I have tested and it works as designed.

This dd command doesn't hurt the metadata and fills the image with 
random data. The actual disk size becomes about 1G after the dd command.

Andrey


