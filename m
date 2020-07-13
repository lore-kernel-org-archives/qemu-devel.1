Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41BCC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2A7206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="muHSuy0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvnb-00040h-38
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juvmi-000383-C1; Mon, 13 Jul 2020 06:34:08 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com
 ([40.107.20.131]:15924 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juvmg-0008R6-JU; Mon, 13 Jul 2020 06:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0CrlnYYouXiwI/cBpxGMYJwbLaRWeToT3Teg4N7uZIZSBkdoiODFqgmYnn5OD9UJXFiFP9ONegTGiPJkzlpYJd2X3rKqxDIiPHLBE84Qw0CF0OBLoRNNvr4Dhi91ggF0+YoNg6c8u1AjPR8QrX7SWfCsGlOpN0V+sX2Ivtca2RjXhe+vTlj52PJ+i6jHTKXVCboof2GmioI+2fXlAXqvf+ou6x23LiQatbuWK77PvGEKF4SuKd5+/DlTulVCi8x/FpqtpiM9H7Rcmx7fSzznD46eYGH8QQ+VV2Ws4wzg7d+44zVrTVNOL+gsqO7P3gqQsWusqTLvnt5M9NQ6EnByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3pougKO8DTu+cjulPsp46EnDpjg9mF5O9bsMaAdAM4=;
 b=h/BTcHSrFPXyo7WkdBMuAuqToT+Eis9JjY16TfWe6QU85upE/sV6GRyAnrmLHoqvobm2eMks12SXPg6gabnSeqaKSfslf7iQJmb30rMXrvAxGqUWHSi4D/eyUESuPqhyIFx+3AOTImY6tQM0YCTbyexBvuYt1Yt0N/3vqHdZOwSmMuac4feLSuvii1u/OrUE2Dfp248WYkLr+IBcVhSexdxX3W/MUH7M5jN/YKG6+G5zz/9r0V17E693go3YT70iR1v4Zf9Uy2dnNYWkEN60ECYlbXX4F1dCqfCOGGCWwla4pjTKq77sIToFfgSCEVauscuZ4Fkg3cwHWx1xuH29pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3pougKO8DTu+cjulPsp46EnDpjg9mF5O9bsMaAdAM4=;
 b=muHSuy0NiPiv+Zp+D4FtZtGFvpTdWUT0u6ENaZQ/Vy6aNW2TJLaTzLakSQUOofpkTOU/v9ot75qcEcjX0VyiU4P2/q21uA7SOLN9Z6iHnzYQQSJ8Ym4TA0FiT5FPsXDxnYEPBJJjemQs3tTVA3W2bE9+tpnvV5OEnKnWd6awnWE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4407.eurprd08.prod.outlook.com (2603:10a6:20b:bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 10:34:03 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 10:34:03 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
 <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
 <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <a7323359-0786-85a2-c9a4-db24e70bc695@virtuozzo.com>
Date: Mon, 13 Jul 2020 13:33:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0062.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::15) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 10:34:01 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 555ee866-1c61-445a-009f-08d827184314
X-MS-TrafficTypeDiagnostic: AM6PR08MB4407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44074D6C1C9EE76B31BC88BDF4600@AM6PR08MB4407.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt3pIXYg6q+ElHQU0dj+RTS7NDPuVe7XH5eq+h0EMRgaZghweGwKUkTUKVQ8XQk9ki7WT/KEyegtqNo2ko6238WSD80g/6Zcb3nkkfvto1w5NNBvc2vX7yf19SoQqEf0vSAsgrG9S3pC07tClSCS6H7wF0FfpTr7AbYXORrpzdmUX0f/jIs6+8doxKJNptTRXQvC9mlY6LVSy3696wVrfNwWOPgI7800MRSNiatTJFdubdeU6Wb0hNFdcwCiwrdvmbtsY1m2tr9OZmUR260F5hG6Bsf329TfdaBwj8n6JLoFA8QsnvkjqxEPKLXsv1eRgcGZJlkfsc9+oI1zF1jiHLOQdCoZfJZAJMY4lOWMDwvKRB4Ojl6+Js1xPDn5EZni
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39840400004)(6512007)(8936002)(6486002)(26005)(4326008)(16526019)(186003)(53546011)(6506007)(44832011)(2906002)(478600001)(107886003)(66556008)(66476007)(66946007)(52116002)(86362001)(316002)(31686004)(6666004)(8676002)(31696002)(2616005)(83380400001)(36756003)(5660300002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: V8qM6GGv2s6Sqyf72phspjCn20viaVNzojPjBzw0Ax5UyH65e7vBYYhCHLMTCR2+uzrik062HcHvozJktmgTnUBqkl7q0JlybE5UAsSUrgfyxOd4NobOTqLdySCSEbwn5/CMKoKAkFlRM4cA3LK5tiXV3jVWC6KxGELKawSv/aKSwNT4pfLFLiSVKbHwQ/CjCiV+vniM+WdWOjATkkO/VMwhw++DoMAtFKsqQ4O90EZldFB0fzsaw1FpnRk1anJGom8r7eYy6saEJlN3SER7uFK5LpGYbVeTsJ+7AB+CEjl6C9LTPYdk7vJVm8ezJElCMJUt7DUhB32kEc0AHnSrso2CGslH+/3ZNDauGJtmuFvcirJ14F7pK6NrGpTsDdx17ElpeymJv4Bp+6wZAFpMyfB0qoXrs90degwnUSP9TJ5Zc8fVfhzGgbj2FqLjD6v2OdWlWW2xq8jirxocuSMOywPw3HLdmD74qnSgCtwkaC2aFDHwaJZVzIYweSAx8owU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ee866-1c61-445a-009f-08d827184314
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:34:03.2806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWZQ3gq84zt5/xQ3nNPDUO/7YOlPsB9jN0iZmPGIoFTfrqTPFc2f3W60Wjwg4mffKtAZIAzyhHbZozqtMuUlJ+8IlnpixX0AA3/13B1txRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4407
Received-SPF: pass client-ip=40.107.20.131;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:34:04
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

On 13.07.2020 11:43, Vladimir Sementsov-Ogievskiy wrote:
> 12.07.2020 19:07, Andrey Shinkevich wrote:
>> On 11.07.2020 16:05, Vladimir Sementsov-Ogievskiy wrote:
>>> 26.06.2020 17:31, Andrey Shinkevich wrote:
>>>> The script 'bench_write_req.py' allows comparing performances of write
>>>> request for two qemu-img binary files.
>>>> An example with (qemu-img binary 1) and without (qemu-img binary 2) 
>>>> the
>>>> applied patch "qcow2: skip writing zero buffers to empty COW areas"
>>>> (git commit ID: c8bb23cbdbe32f5)
>>>> The <unaligned> case does not involve the COW optimization.
>>>>
>>> Good, this proves that c8bb23cbdbe32f5 makes sense.
>>>
>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>> v2:
>>>>    01: Three more test cases added to the script:
>>>>        <simple case>
>>>>        <general case>
>>>>        <unaligned>
>>>>
>>>>   scripts/simplebench/bench_write_req.py | 201 
>>>> +++++++++++++++++++++++++++++++++
>>>>   1 file changed, 201 insertions(+)
>>>>   create mode 100755 scripts/simplebench/bench_write_req.py
>>>>
>>>> diff --git a/scripts/simplebench/bench_write_req.py 
>>>> b/scripts/simplebench/bench_write_req.py
>>>> new file mode 100755
>>>> index 0000000..fe92d01
>>>> --- /dev/null
>>>> +++ b/scripts/simplebench/bench_write_req.py
>>>> @@ -0,0 +1,201 @@
>>>
>>> Next, I don't understand, are you trying to fill qcow2 image by dd 
>>> directly? This is strange. Even if you don't break metadata, you 
>>> don't change it, so all cluster will remain empty.
>>>
>>>
>> I have tested and it works as designed.
>>
>
> But how is it designed? You just filled unallocated clusters with some 
> data. When you read from qcow2, you'll still read zeros, because L1/L2 
> tables are not filled. The random data will lay untouched.
>
>
>> This dd command doesn't hurt the metadata and fills the image with 
>> random data. The actual disk size becomes about 1G after the dd command.
>>
If patch 0001 is OK in v4, I can remove the patches 0002 and 0003 with 
the 'unaligned' test case as an unnecessary one.

Andrey


