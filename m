Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0A1C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E76921741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fh+N7dZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E76921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLptd-0006A9-1k
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLpi6-0003pa-1l; Fri, 25 Sep 2020 11:32:35 -0400
Received: from mail-vi1eur05on2129.outbound.protection.outlook.com
 ([40.107.21.129]:14432 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLpi2-0006fa-RP; Fri, 25 Sep 2020 11:32:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktgKx2NNlVpVxGLIj/YYk8+F6Xu8lsCcbme6SMIzSIMBmsdCfOVfcggjONO6HGrRPo4y2xgcxKgrLGZnheB8KDxjANR6T3r4hpAdXahLLupYhm3dC/H0lVxXZq91QmNHP9ah2t77xuE/GWlFgK4x6NRnBftLqYpXgwXh1H9NDubmcOWG82sPuSnoxvJI9G7cRCxou8/8uvhPR/8avL/cDQErsUkxD6Ym8wyIfJZEuPkVrgovVrJZTriA1k5OtkR8FMNbvhdKXaAL+f2GOAawLcWAw8M8L5w/rvDDBmTUYatY4v09Y9hI7+alWKBYybYncqp9kW5K6d8Azp/eeV+cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLIXcVMRlnwDMP0t+ILLedA5TGrpKFL13tKO/Ep+7rA=;
 b=Zahh/VQnZQue38h16awmq+W/PL0JUeln2Ig09CDO7fjOkl0ticYqblujTbhnKtiihban5v2aLECIWPyKF/LgZ+rVTF6+0kabiC0RRJuhYv6yMextRjNn/bDcSf0cuUQ+q6T6bsD13AqbhDgkE9kXxqxSbIMOuq9AoEtGdg1xX3dKilLsWeEDJkb3bhIkhvBbVks4FBugpC+fNah3vKWGzUy8IlOaKYn/HPZnGLFunq+GrHVT/6JtRrqGgyr2n8mjhGZ10Oqx13C79lsDChp5obZVZuEX5IQ33jh2wLdBuy661z+XEWSEwnApEXMuuQ0oVulvpSsl/WYtv3euL35u9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLIXcVMRlnwDMP0t+ILLedA5TGrpKFL13tKO/Ep+7rA=;
 b=Fh+N7dZpykliNU6gr2OepLkiK0yBJMmKu6VSCrn5E/DZ4Y7u4+YAAWFMfySd8gWlzk75OkCaj60AHmcruC65/K1gsKdhtMbYPRuoJwIVWtX/+FkyqD2eXD9hKWD4IebkWXVzpzLqnIuHAOpJyvnWglj3w0ern2miFuofeT1knrU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 15:32:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 15:32:27 +0000
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
 <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
 <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
 <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
Message-ID: <09045b49-f4e8-8989-09b5-aa3538b507fc@virtuozzo.com>
Date: Fri, 25 Sep 2020 18:32:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0082.eurprd02.prod.outlook.com
 (2603:10a6:208:154::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR02CA0082.eurprd02.prod.outlook.com (2603:10a6:208:154::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 15:32:26 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af0dd8c-76eb-4694-4278-08d86168357d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538435FDE98E5DA3F31DE8E2C1360@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIbVQXcykA+COwaHBOl+DnSeaWWBpRYi1oR1aESEDaPdZGf/C5ASzwIgNQdYLOJzBSvfmSLqrZ7kSnX3QHBnXOWwc9jSo0ireiJY3r5713ZDVYfWWlyEf3wNA9Jm0I6a21nb04Bsn80LrG25DICVfAXTccc5NEtB/n+3yF3ldmGFm2l3AX74Soj4h3JKMoc1RanSp/YAJcHI4rHyg9pClh3HahVVbDWeQ9SDUYL7db+wB5VBN5yY2mODuiejyRTWe7VHBFMaOeFjNEif74MNt+6cLYX4jpqShJO1JboaeYGn5oVn+Hb/t4rlg2zm/IOVkxIB377TbKLlX6aYsmLcQ2Uxv0zH1Wy3C0L167rk3bM9Kb3Ec2/BDwYqWuh6WnJlTLz9qg3KW9xOEHaWsXHi93yGCosZAw3ZgIDetQK1DFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(53546011)(186003)(52116002)(16576012)(107886003)(316002)(31696002)(83380400001)(2616005)(6486002)(956004)(478600001)(16526019)(26005)(31686004)(86362001)(4326008)(5660300002)(2906002)(66476007)(66556008)(36756003)(8936002)(66946007)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qNWUveQnwJOq+RFdJYNXW/osT2LIBFc8AfRZfYzf6Zo7kkAb03Gx0ygKbLeHk40ElnoZPimk5c1AE4Fz2nhb2PXa8R/tiKk7A9kO1m64wNx+BU1Vqk06B/IpJTDrMpNsTTmLpaxl1vTCJ7rads2DNFTVlBXHRUKrSeLL1gQ9W963u76NKTT15D6bUfhgP0H7tjSs2KO2EIQ9vM1XSvH7486xndfgDWYSq/UNDAVV+YmZwjZAoHq3etleUeviUtbPse/M3G9xVK6NVoIP1rI53uwFiULjzvuAAkixMi910DKWMBaGKVqzedL7w3aiM4zQza3bp+K5aD2Fp/RdwMSOdrT1+18rRt/hmO7TI8XD4r2pjmvvild2bvDrwIPp5OnQGaItcoIV+FBHqRYkuCSiLM4/X1DYgAJNhEe/bvtw5A4XHY14Vb1/89H7MYOiOLlTL/gXjuAiuO2qF9Aek0HkVdoiDfgrHXRtwX0+97nN/FQX7CN/obZP5Q6GJ9NFbZedISZwc0zTlLJxdxoCMFnIn6vp8BkgfvzWvS7LLVbhLrTJAYcaEsAfxdbax02y7tzA6EEKmlSL5X+sN04dqqb3yfhVdVSlOAwI2i+zxJQwmBOhVBlEuOoXyrt4yb/KQRjPjmDlyUrffT0BBGn8tetXOQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af0dd8c-76eb-4694-4278-08d86168357d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 15:32:27.6422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gFQeRUADpq37gyT2ZuC2MjC7oFEolP97TxMTKVBiwpxKL3odm523uMuPKnRi+E7nBi9p4gdk6GbjnhymBsN8SYVk2f97oKLf7UKPNGE/SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.21.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 11:32:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_LOW=-0.7,
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

25.09.2020 18:11, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 12:11, Max Reitz wrote:
>> On 25.09.20 10:49, Vladimir Sementsov-Ogievskiy wrote:
>>> 25.09.2020 11:26, Max Reitz wrote:
>>>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> ---
>>>>>    tests/qemu-iotests/298     | 186 +++++++++++++++++++++++++++++++++++++
>>>>>    tests/qemu-iotests/298.out |   5 +
>>>>>    tests/qemu-iotests/group   |   1 +
>>>>>    3 files changed, 192 insertions(+)
>>>>>    create mode 100644 tests/qemu-iotests/298
>>>>>    create mode 100644 tests/qemu-iotests/298.out
>>
>> [...]
>>
>>>>> +class TestTruncate(iotests.QMPTestCase):
>>>>
>>>> The same decorator could be placed here, although this class doesn’t
>>>> start a VM, and so is unaffected by the allowlist.  Still may be
>>>> relevant in case of block modules, I don’t know.
>>>
>>> Or just global test skip at file top
>>
>> Hm.  Like verify_quorum()?  Is there a generic function for that already?
>>
>> [...]
>>
>>>>> +        # Probably we'll want preallocate filter to keep align to
>>>>> cluster when
>>>>> +        # shrink preallocation, so, ignore small differece
>>>>> +        self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
>>>>> +
>>>>> +        # Preallocate filter may leak some internal clusters (for
>>>>> example, if
>>>>> +        # guest write far over EOF, skipping some clusters - they
>>>>> will remain
>>>>> +        # fallocated, preallocate filter don't care about such
>>>>> leaks, it drops
>>>>> +        # only trailing preallocation.
>>>>
>>>> True, but that isn’t what’s happening here.  (We only write 10M at 0, so
>>>> there are no gaps.)  Why do we need this 1M margin?
>>>
>>> We write 10M, but qcow2 also writes metadata as it wants
>>
>> Ah, yes, sure.  Shouldn’t result in 1M, but why not.
>>
>>>>> +        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) * 512,
>>>>> +                        1024 * 1024)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>>> index ff59cfd2d4..15d5f9619b 100644
>>>>> --- a/tests/qemu-iotests/group
>>>>> +++ b/tests/qemu-iotests/group
>>>>> @@ -307,6 +307,7 @@
>>>>>    295 rw
>>>>>    296 rw
>>>>>    297 meta
>>>>> +298 auto quick
>>>>
>>>> I wouldn’t mark it as quick, there is at least one preallocate=full of
>>>> 140M, and one of 40M, plus multiple 10M data writes and falloc
>>>> preallocations.
>>>>
>>>> Also, since you mark it as “auto”, have you run this test on all
>>>> CI-relevant hosts?  (Among other things I can’t predict) I wonder how
>>>> preallocation behaves on macOS.  Just because that one was always a bit
>>>> weird about not-really-data areas.
>>>>
>>>
>>> Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this..

Sorry, I see now that it sounds rude.

>>
>> Well, someone has to do it.  The background story is that tests are
>> added to auto all the time (because “why not”), and then they fail on
>> BSD or macOS.  We have BSD docker test build targets at least, so they
>> can be easily tested.  (Well, it takes like half an hour, but you know.)
>>
>> (We don’t have macOS builds, as far as I can tell, but I personally
>> don’t even know why we run the iotests on macOS at all.  (Well, I also
>> wonder about the BSDs, but given the test build targets, I shouldn’t
>> complain, I suppose.))
>>
>> (Though macOS isn’t part of the gating CI, is it?  I seem to remember
>> macOS errors are generally only reported to me half a week after the
>> pull request is merged, which is even worse.)
>>
>> Anyway.  I just ran the test for OpenBSD
>> (EXTRA_CONFIGURE_OPTS='--target-list=x86_64-softmmu' \
>>     make vm-build-openbsd)
> 
> Oh, I didn't know that it's so simple. What another things you are running before sending a PULL?
> 
>> and got some failures:
>>
>> --- /home/qemu/qemu-test.PGo2ls/src/tests/qemu-iotests/298.out  Fri Sep
>> 25 07:10:31 2020
>> +++ /home/qemu/qemu-test.PGo2ls/build/tests/qemu-iotests/298.out.bad
>> Fri Sep 25 08:57:56 2020
>> @@ -1,5 +1,67 @@
>> -.............
>> +qemu-io: Failed to resize underlying file: Unsupported preallocation
>> mode: falloc

[..]

>> -OK
>> +FAILED (failures=6)
>>
>>> If I don't put new test in "auto", is there any chance that test would
>>> be automatically run somewhere?
>>
>> I run all tests before pull requests at least.
>>

OK, so it doesn't work on BSD at all. I don't really want to investigate, but seems it's because of absence of fallocate. So let's drop "auto" group.

Another thing: maybe, add auto-linux test group for running only in linux-build? So, new tests will be added to it because why not, and we will not bother with BSD and MacOS?

-- 
Best regards,
Vladimir

