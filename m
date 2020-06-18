Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3143C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8600120899
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OUJx6f/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8600120899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpK7-00071S-O2
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlpIv-0005b7-Cv; Thu, 18 Jun 2020 03:49:45 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:23904 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlpIr-0002Oz-7i; Thu, 18 Jun 2020 03:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BODuFU9Fs14arPgOHepF72YRnc0ZalW/PFvYZxTkXW4yKJb7+vBjOxRSiqDNcInv6e12QQ8e1jEaZc/bemhidgonmupd6BEkbaJ9HI6ekYyGbf2nOQ6uhbbUx/d92hdrNE3M3yTKueoqSv4gyBqZCURBKLEYo2xVEn49gD4GRPxtZZ86xLKFIB+9cAo6G7EFQoWyEAYIoAmKrRpav4qrG5vhxA/ItC8zXsaC6nDWYAcrVU/2avD9D0S7jZZyLwDZ0BpGypiDZdyz22jY0CwJ5TiX90fd35J8uxian7awTIrJmq4uNCYmhVJfyQcyuQO0Om32j+7qwfdo9Ogyeg0f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZfDQG9IH2wfy8H3yqf3YsRzP8kfnW8Oj97LnwP9ZPk=;
 b=PIab+8GmGY/te6V7uLq6NQemJdvI0IiVp3V4xdEZrFcmEwMrbZFFBS01Ph8GKA512tbzDQXay8KICHpmPpYHfUjzH68EPhsjGEwqBsDsfzx5HRYi83W+2HImSXQxU6pgv2BpBv9yaRbbhMuZyG0IN0dRQqnygTCPmbc/EeIf8n7jkdx3/3nFONV37uGA8wzZlfrL4yc5W3y6AGSdLrP4pMN32/R+CivRVMGCYPho4ptj3hWdkKNjNCmoHLlJNFnu/z6Xrm5XCDfcgTUf+Lt7s95lkxEMc9Hs47AbxfEEBRdq7+58JJYXcI06vSjiEj2GCXsTQoytCtOZWHLcsRd6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZfDQG9IH2wfy8H3yqf3YsRzP8kfnW8Oj97LnwP9ZPk=;
 b=OUJx6f/Z/697skvZr4QBKA2zrHoZNUXSmWMTTTUOFQxPZOdBrsEixbdbk+oDUKe+Pm0IIoU0UD/YKfc4+N6eJH22k4Ku/beWU9I2MHN3WJyemQr8xdSeqQApNrTDQC5Ah+DOeoyXDFx/0TRw9bSo+9cqW4L0cpvx0eC8pT5o9PQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 07:49:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:49:36 +0000
Subject: Re: [PATCH v3] block: Factor out bdrv_run_co()
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200520144901.16589-1-vsementsov@virtuozzo.com>
 <20200528151707.GH158218@stefanha-x1.localdomain>
 <99f13039-ae61-fc5e-43fa-8cbc3f3e1bab@virtuozzo.com>
 <20200617134645.GE1728005@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <edd62b97-3b56-5964-b784-ee6969e8b55a@virtuozzo.com>
Date: Thu, 18 Jun 2020 10:49:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200617134645.GE1728005@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0136.eurprd05.prod.outlook.com
 (2603:10a6:207:3::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 AM3PR05CA0136.eurprd05.prod.outlook.com (2603:10a6:207:3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 07:49:35 +0000
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d673a3-1cd8-49f3-0ca5-08d8135c25a7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383E36C863E9D7ACE4CAAD0C19B0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVduGzWsLQSHG4obPHGJUo7Y5dsgXkC7NUyVSCiGMBXaHXz0FyjsVUWcSWhUXnHqf5fpyncGHz0O/eDMFq47iHDePmOvyFofVDcLVpvmfkB3HYkR6Y4G3n7/A8ROaXv9PvpRrTT4qo9AwKakqIWfaIk+E2cX+cUCj33BsfDe68wRaw+Avh/4+N+E4gRlS3ZbMCeOJfLF3qfkfCyeDNC+TffY0Ngzs2GWkXF08UHpJUeDGYCShcnQsf6+PaQ3noOQKSfJqKe254i5N9bY2ZNfWWO9acaBWXgjWrE/21oRlbz8LW0MlletaR09aU4+hwjLKfeVAUgLHmqOOmhLOwSKBGITgvcj4072wdcvJh8UoKwvbiJJBAuJKtpRxGm8iNkrz05I64yMYx+NKP50Vp/iizVkLCG5VScK7SzP+et2LPyxopnQkEkREmlv1NLklF67TCbO2jbMLEu6vkrlsl2hgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39840400004)(136003)(956004)(2616005)(186003)(16526019)(83380400001)(86362001)(31696002)(107886003)(478600001)(66556008)(26005)(8676002)(2906002)(66476007)(8936002)(66946007)(31686004)(6486002)(5660300002)(966005)(6916009)(52116002)(4326008)(36756003)(16576012)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FaYIDA+ko9QloQGTurNQe/X2MLXLXpNeyf7lE6GurYUtljYrCf6f49vCA/4NOmZJLB0wSmFar9xZXaQW1HJUwgfd2vAN/iA4kSMdB8k6eZK7jIiIfmYISGnKG7OZDnpGwV/j8760lezYG8vzwmFqlOU/Z7TfNWCCYJGrgPFhw6yyxZ8320bnJaCkD4X6hL2/wzA1vGyf1B2oKAc/0vstp9iZV2NMLc0WE9PjX/rXmkU6CKPRMic+P9iRauefMFZGe6a9IoV6TD16lD0YVq3sHiILZnZLJEpXmX4emLA+ls2RiE+tIj3v+VwgtcxJfeHftwir8p4vmgoTF85makdM5MVaV4p7SV89/0365OibcpiLcKB4nR/G4+x8jgrgQee9iRGFGudDFWtVS4cUvqmsYNwUGlM65c9mn++DSYPjnBxkQc+2a+pun0LOaaec390bX3Q6LkloGDnLGFGfcdjJdms0ahtmxjvV6Q6w9io3Vao=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d673a3-1cd8-49f3-0ca5-08d8135c25a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 07:49:36.3574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB+tuvmx33uMcRl4YH+dK87jdDUUddm3Kzrl1OKMCJO/U9y6GRx9muCY2jTZj5STIcKPDcSUt5mpfILM8Id4vlLi3h/fhNLpQfbcZjlnt60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.20.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 03:49:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, den@openvz.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.06.2020 16:46, Stefan Hajnoczi wrote:
> On Thu, May 28, 2020 at 08:38:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 28.05.2020 18:17, Stefan Hajnoczi wrote:
>>> On Wed, May 20, 2020 at 05:49:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> We have a few bdrv_*() functions that can either spawn a new coroutine
>>>> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
>>>> alreeady running in a coroutine. All of them duplicate basically the
>>>> same code.
>>>>
>>>> Factor the common code into a new function bdrv_run_co().
>>>>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>      [Factor out bdrv_run_co_entry too]
>>>> ---
>>>>
>>>> v3: keep created coroutine in BdrvRunCo struct for debugging [Kevin]
>>>>
>>>>    block/io.c | 193 ++++++++++++++++++++---------------------------------
>>>>    1 file changed, 72 insertions(+), 121 deletions(-)
>>>
>>> Thanks, applied to my block tree:
>>> https://github.com/stefanha/qemu/commits/block
>>>
>>> Stefan
>>>
>>
>> Actually, [PATCH v5 0/7] coroutines: generate wrapper code
>> substites this patch.. What do you think of it, could we take it instead?
> 
> This patch has already been merged but the "coroutines: generate wrapper
> code" series can be reviewed and merged separately.
> 

Yes, thanks. "[PATCH v7 0/7] coroutines: generate wrapper code" is already based on master with bdrv_run_co().


-- 
Best regards,
Vladimir

