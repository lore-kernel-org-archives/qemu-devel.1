Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE15C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7EB204FD
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LufHRgvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7EB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEC5O-0000Bf-9e
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kEC4d-0007DK-VY; Fri, 04 Sep 2020 09:48:16 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:24332 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kEC4a-0006yc-0i; Fri, 04 Sep 2020 09:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/a19MVjHrtAADhXbS/NZHZbMEVLaWznogusbljv7DbIV5ZGkml3/eGm3ogxN8QqI7n9gb/FjcrKD5e/qJWiDrSks87mNsmGQ0GQkqMqYKk5pNmkw8wCpYgQ9S+jzObyiW0A53EJ7ANXUhrJjpBrHg42td312RSSpWa8EIAztIETd6NO3FgeHA2jkk0UNuFIOsKcBH4yUyAYw5KNFo7JacIQ4d2Bk4iV6eBy0iVrHzq33gDf1qQdY8kkuqPtqTTT+C+9Pmk464AZY/486lYhao6aHX1bLXTkuL3v/vBtEjuMYe8tu3uTS4qEK64jcgYeQlv+f+npHOxXaBsMXkyQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR45clhdX7Qc2y5qnm4lszsWmbHYrbctP8QT066rUPk=;
 b=mmoT8spTMo0QskkAzhISubqCFHryjmSlRcwFXB8+7ZSuOypFCMUpnjFVORYTMR988xGXgLZuRgtQaf53EbFH9cEQy6z+oIUnOxewJgTJXTRDQ/K3BDGSi9kgcrCJfhxXspb2DzSa7IiVvVxPyrMCS9aUnqDzUp6lUpf//BF06P+sYqNxSNhO5oRpsYXFehItWo6xGV2EJR1ojEwwahE0/qRrL1btm3WfmUy0xxUFrPFJYYzWMsZ/kucMe+JXX9vRLcE+k/YbGx97vxNNsCuV2Ijlm6LcXQprR8rVl0a4gQu8UR3HnYbaDwGFdudjU+xJ9OzYSwc/mzBdOTev7t0wZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR45clhdX7Qc2y5qnm4lszsWmbHYrbctP8QT066rUPk=;
 b=LufHRgvIF36Q48g4mxOSEro96cZGtjp/V/FZ7NsRlNRbZkCAm20eYV4ZLcuds2gj6uX4fRkXKFxgAUS/YCtmTr4c7kY4wdAv/dCDD39E17YJq2onqTqFp3c0JSVaD4z3sdMobUcdScrtETuG1Y9P+Sn9qMvPMqDChDhw4FaWqs4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 4 Sep
 2020 13:48:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 13:48:08 +0000
Subject: Re: [PATCH v8 6/7] block-stream: freeze link to base node during
 stream job
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9739719d-0681-d839-cf8d-398b78b6d323@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a52e54e-22fe-6eee-439a-dc1db0a1bf63@virtuozzo.com>
Date: Fri, 4 Sep 2020 16:48:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <9739719d-0681-d839-cf8d-398b78b6d323@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.143) by
 AM0PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:208:ac::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.9 via Frontend Transport; Fri, 4 Sep 2020 13:48:07 +0000
X-Originating-IP: [185.215.60.143]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5036884a-a040-418c-94e2-08d850d9282a
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984272B46012F818CC61F69C12D0@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZR3/RnYm93NQ2jGRJaNXfGUSdkc5f/tPFPa/t9jgrFV/68HAj1LnKSzDqd7ySq3a1sZlTCn36WG0cNgq5g0CbqQ2cf0pHlYZXQUNOvQoC7QFmRC0ucLIGWofBxQNIk+rt4ZRsDDVaQjlA624BzwiVURKRlgJgy6HAEZ9wXRW6Q6Vsmn74OvkMCkHFJsk/5v6Aw9rdsZvDzQw1xPvA2sqCjtnGM5118BESefenxDF4odbF9dT8tMJCAv5FabL9GuM6FqPu/zxg3gP4kR0uX0rWrxZt2qyV2UpNwIpwTSyrMoMK1Wr21xA1HNfK1vyu5Ukikh/kPtSz44TAIbbxC4/IGziV6kQJRxK9LapYawbPx/z+AVRwWWXSApc1oYLyjl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39840400004)(366004)(396003)(346002)(86362001)(26005)(66556008)(478600001)(31686004)(8676002)(83380400001)(36756003)(53546011)(16526019)(66476007)(8936002)(6486002)(186003)(2906002)(31696002)(316002)(16576012)(66946007)(956004)(110136005)(52116002)(6666004)(5660300002)(2616005)(4326008)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w1CBa6paGc5klBlsZi26+jfBK7DnighmMrjBu2NQKVIH1S4lW5LaLjiNOVdoj/QdV7MhmwO0MSaVMdWQUlPIRpRmdbbse60DymsyPrvl+OM2ZmRC9JhgJE0RgLzU0lAcEvaaUC+DZ50sHzyLN4h5U06qbfHuPqANnGf1wkDL+L1/Mu7QdkrQabKPb5565FL9odYRkiUXVtLboXcrdKrKajQoYX2BRmuijGYjOnBsC1AJlJVkOe7AA8A7WVAM0MAJvBrk8NckdTpuiAofHxuTYsNKRzibDjp0Q5kPYvunEyN3MFmSXmFlv1aWHb86h5O9uj1/b1KEtu9byjpYMfvbr4Mn9A+bTqjW3dFWOAbDXr6FpvGpSIwrQFiXruQrDeNkJ/e8QczccJg1KJN46H+Meo9AzhPFgyEt+Jo0kGjpGcels+SOl2ch9uNDR5paRYkaiaDNHRj+1VhCHunV5qZdGNBG12jWUWcFm42VHry6tWWlYEm5HkNz3diT77d969SKYUQ3twYx2IWduOp49yp57nEDGT6cW3uh1p6CTAU00DMN1oFV5ledcfqyw6x0hOQqofojAc7AuTZ3QGQo96zZpGM+ZirPnJ4TPQ6LMjvY0MczRPSgMWfAo51EcPfZvUZzkLseIGwI1CcpyEOy33Ziug==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5036884a-a040-418c-94e2-08d850d9282a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 13:48:08.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f/7Wogp8ZnBl0mn8xJSpIYOHyrNxU8tQXvnlF9Z4YR/iB8Jlcgc3mEYc84QAf8/1Qa2ItK07bC4yr03fhmWYg2r4dR63+lwAoOc1qo7MvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 09:48:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_LOW=-0.7,
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

04.09.2020 16:21, Max Reitz wrote:
> On 28.08.20 18:52, Andrey Shinkevich wrote:
>> To keep the base node unchanged during the block-stream operation,
>> freeze it as the other part of the backing chain with the intermediate
>> nodes related to the job.
>> This patch revers the change made with the commit c624b015bf as the
>> correct base file name and its format have to be written down to the
>> QCOW2 header on the disk when the backing file is being changed after
>> the stream job completes.
>> This reversion incurs changes in the tests 030, 245 and discards the
>> test 258 where concurrent stream/commit jobs are tested. When the link
>> to a base node is frozen, the concurrent job cannot change the common
>> backing chain.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c             |  29 ++------
>>   tests/qemu-iotests/030     |  10 +--
>>   tests/qemu-iotests/245     |   2 +-
>>   tests/qemu-iotests/258     | 161 ---------------------------------------------
>>   tests/qemu-iotests/258.out |  33 ----------
>>   5 files changed, 14 insertions(+), 221 deletions(-)
>>   delete mode 100755 tests/qemu-iotests/258
>>   delete mode 100644 tests/qemu-iotests/258.out
> 
> Does this need to be in this series?  (I’m not entirely sure, based on
> what I can see in patch 7.)
> 
> When doing this, should we introduce a @bottom-node option alongside, so
> that we can make all the tests that are deleted here pass still, just
> with changes?
> 

That's a question to discuss, and I asked Andrey to make this patch in this
simple way to see, how much damage we have with this change.

Honestly, I doubt that we need the new option. Previously, we decided that
we can make this change without a deprecation. If we still going to do it,
we shouldn't care about these use cases. So, if we freeze base again wituhout
a depreaction and:

1. add bottom-node

  - we keep the iotests
  - If (unlikely) someone will came and say: hey, you've broken my working scenario, we will say "use bottom-node option, sorry"
  - Most likely we'll have unused option and corresponding unused logic, making code more complex for nothing (and we'll have to say "sorry" anyway)

2. without option

  - we loose the iotests. this looks scary, but it is honest: we drop use-cases and corresponding iotests
  - If (unlikely) someone will came and say: hey, you've broken my working scenario, he will have to wait for next release / package version / or update the downstream himself
  - Most likely all will be OK.


Hmm. OK, and the hard-way:

3. Enable all the new logic (filter insertion, freezing base, etc.) only when filter-node-name option specified. And immediately deprecate not-specifying the option.
  [Note, that in way [3] we don't need bottom-node option]



-- 
Best regards,
Vladimir

