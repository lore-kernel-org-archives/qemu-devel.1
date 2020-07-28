Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1FC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2463D206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sz+OOhW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2463D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LDX-0005Yx-D1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0LCm-00058S-Ao
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:43:24 -0400
Received: from mail-eopbgr30113.outbound.protection.outlook.com
 ([40.107.3.113]:56548 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0LCj-00031e-2n
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc6stwQEnLWQZFZJg6idAbVlhFucfzm4gNOKhKGmafBzVxTEOQVUFgJchWmMNmYtIbL1HN3wxYyDzn0nb6+5rSdl5bDopPi0IDzugQ5KnIERRuS4PLlUE4z24uwHY2X8S2BGWcrbrlskCK5E0Vcwbdbjo+yCd8I0NF7g+1rglqxZraHyxdGoj09+PSokGdj9olnigWH0QXdDPRSs3w/qSLPwJKjxsiGqbMRfWgTBjXl5A5Lm5THrmB8QoskcU9NysSG5d+JQ4lPap/iwfzZfelXIBuIBIg+ncIFktoT8nPytb1YMEvMaLRVxAnYnjfF4cyoRswsG65itaOlsUGww2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1rOryD7Y+cKI7vZ4HFd748+e/iuVXzwPN8lsrqCSbk=;
 b=lbmhqcZfbz7PBzXwj6i84p3MtTMEdxpa8sQFS//tsoPYLSq6lBv5YIEhM+s+DvVPjcctlaTzSQy/KakKZzO2yHLy4fWnWObiJmY/CEfsQznTbd/IDAmnKDd7vSqST33NnMreMS76BUc9KlAIwsX67BifLQmKruKOXlXvjuv3YAxV12PkcOjWoWlLTrcXvtHvlVTezcHJkgegHscFPgOiAHWinZMBVF1IOyMtB3q/0kSjsu40pGPjcbuWYZyZc4GMD8dYX2NSPqEj4MsPvnxwuhgpcUAwyEPvdRNEwSrC6RtiDviKy10jqUQuzqyZkwv33rt3v1NO/s54lRkU+76EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1rOryD7Y+cKI7vZ4HFd748+e/iuVXzwPN8lsrqCSbk=;
 b=Sz+OOhW9XPS90NhFpQJ2RRkSqKaqwyhoT7cbo9CwpUhBkzdO1S+v/CDwrBhZi2xQ38dDE3xHvUpLmVi6OFaaGrl3WnMwdI/mzHCxxMBMQeJCNYNXTOrwRbSjMO0LKyKH6nMPrnrbnvwAtoHlr5KcjeVx7R+6sB0NwV2cm4ge1I8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1778.eurprd08.prod.outlook.com (2603:10a6:203:3b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 08:43:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:43:17 +0000
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Bruce Rogers <brogers@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <476f0f77-7676-f69b-99c8-a2bf16e69b94@virtuozzo.com>
Date: Tue, 28 Jul 2020 11:43:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:208:55::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR04CA0125.eurprd04.prod.outlook.com (2603:10a6:208:55::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:43:16 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e82b92a-7fde-4c66-8ea1-08d832d245c8
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1778:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17782A3F5E7F222C02E7ABFAC1730@AM5PR0801MB1778.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltcGrS2D3iNzKon0xn3po0Cnrd+Lgab0F6PT8f8xEIe9lNgXthoJVjTU+Tr4qXqMzWwOki68FAQOXFsMa+towypKcKmGnBGHmgL4YHFm/Y9ESThRMoTH0Gb3fsi2BNKvgE6Xct9dfqDFt8fWXdtJkHuDweTBYuyOHV3ALiBKAwlwy/3LVJio1W4muHNB2QYlyqrAJ/a/AyIOlmXyLWvVelhg52T5koxwsdEzwEWG1HVBKpbTwuuomRRjnhD0ztXK3TuRfA43O70cs2bxZyK1B1LmAj/kuiTJmtz3MA5dtRqGIlQgpT3MVr4KFZwJLql9HfSv9uNkHUY72ikckZl7PI760QwbCBYEY70J+R/yxSbHoD9gNvaCHgu/iyzrpjFu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39840400004)(8936002)(7416002)(53546011)(16576012)(478600001)(316002)(2906002)(6486002)(52116002)(8676002)(36756003)(4326008)(26005)(31686004)(19627235002)(86362001)(83380400001)(110136005)(5660300002)(66556008)(66476007)(66946007)(16526019)(186003)(2616005)(956004)(54906003)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T/uFw34ht0x5rcHDpnebs0EJa37WYBm+0+AcfuvOsXI8nFM8imrv9G3ilbL7uSwwYd+C5G9IhfuOkNtFnWGKzJybP5DOVbRWTj0/d7MbVRmMkci4miAlQP+lCPSJxsK3RWw87ERMFJWpXD/meqW8uG/FIXiR0xjxrNsbNdx30BcDSMQxkmPWQ6+h1PoEj7BoffZsz4WJbvc/WPMyZqkKYfCz8yl/oyZK9pimWM1PZPv0T7lBmaF5POKQti6PNtfxtMwd79MH43RThtg0LnA9mtkuSUkLyUL5uRQic2xstZ6dHY7oRz5/XrbY97SyZ5CRWs84MHnSFK2IQiB3HH53+dHj/XtOj517TQFF/zlnZhD/PiHi8gT4fiL0dT6nSKvFL3Ls9EJ+lH13hDTnQmWGIa718m13EyT3GMkepUGcXaCSjh/T3IVbAYt9tAKYbB1FEKnvZFngW/LqnVIvU37Wd7I3l41Ctlaxa2EKRwNQdtlOCxYl4qe3V/mvrjFvSmZ7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e82b92a-7fde-4c66-8ea1-08d832d245c8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:43:16.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x3b3HnPKVnjhPc3zpLpQt51qzvfS/4erzQ00OLnsVpPf5RRpJMOyFEugG3Pyl/ghX4qbTRDRrswSSO26mZR9PuAw6ZPIxzuWO5NNJDKMSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1778
Received-SPF: pass client-ip=40.107.3.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:43:18
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 02:09, Bruce Rogers wrote:
> On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
>> On 7/20/20 8:24 PM, Claudio Fontana wrote:
>>> I have now been able to reproduce this on X86 as well.
>>>
>>> It happens much more rarely, about once every 10 times.
>>>
>>> I will sort out the data and try to make it even more reproducible,
>>> then post my findings in detail.
>>>
>>> Overall I proceeded as follows:
>>>
>>> 1) hooked the savevm code to skip all fields with the exception of
>>> "s390-skeys". So only s390-skeys are actually saved.
>>>
>>> 2) reimplemented "s390-skeys" in a common implementation in cpus.c,
>>> used on both x86 and s390, modeling the behaviour of save/load from
>>> hw/s390
>>>
>>> 3) ran ./check -qcow2 267 on both x86 and s390.
>>>
>>> In the case of s390, failure seems to be reproducible 100% of the
>>> times.
>>> On X86, it is as mentioned failing about 10% of the times.
>>>
>>> Ciao,
>>>
>>> Claudio
>>
>> And here is a small series of two patches that can be used to
>> reproduce the problem.
>>
>> Clearly, this is not directly related to s390 or to skeys or to
>> icount in particular, it is just an issue that happened to be more
>> visible there.
>>
>> If you could help with this, please apply the attached patches.
>>
>> Patch 1 just adds a new "300" iotest. It is way easier to extract the
>> relevant part out of test 267, which does a bit too much in the same
>> file.
>> Also this allows easier use of valgrind, since it does not "require"
>> anything.
>>
>> Patch 2 hooks the savevm code to skip all fields during the snapshot
>> with the exception of "s390-skeys", a new artificial field
>> implemented to
>> model what the real s390-skeys is doing.
>>
>> After applying patch 1 and patch 2, you can test (also on X86), with:
>>
>> ./check -qcow2 300
>>
>> On X86 many runs will be successful, but a certain % of them will
>> instead fail like this:
>>
>>
>> claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests>
>> ./check -qcow2 300
>> QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>> -nodefaults -display none -accel qtest
>> QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
>> threads -f qcow2
>> QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
>> TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
>> SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/socket_scm_helper
>>
>> 300      fail       [10:14:05] [10:14:06]      (last: 0s)    output
>> mismatch (see 300.out.bad)
>> --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
>> iotests/300.out     2020-07-21 10:03:54.468104764 +0200
>> +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
>> iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
>> @@ -12,6 +12,9 @@
>>   ID        TAG                 VM SIZE                DATE       VM
>> CLOCK
>>   --        snap0                  SIZE yyyy-mm-dd
>> hh:mm:ss   00:00:00.000
>>   (qemu) loadvm snap0
>> +Unexpected storage key data: 0
>> +error while loading state for instance 0x0 of device 's390-skeys'
>> +Error: Error -22 while loading VM state
>>   (qemu) quit
>>   
>>   *** done
>> Failures: 300
>> Failed 1 of 1 iotests
>>
>>
>> At this point somebody more knowledgeable about QCOW2, coroutines and
>> backing files could chime in?
>>
> <trim>
> 
> I used the reproducer you provide here to do a git bisect as I assume
> whatever is now broken wasn't always broken, and it pointed to the
> following commit:
> 
> commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Tue Jun 4 19:15:13 2019 +0300
> 
>      block/qcow2: implement .bdrv_co_preadv_part
> 
> Indeed, I am currently able to reliable reproduce the issue with this
> commit applied, and not reproduce it without it.

Do you have a reproducer on top of df893d25ceea? I tried to apply the patches on it, there are a lot of conflicts and after solving them, the test not work for me.

What do you mean by not reproduce without df893d25ceea3c0d? I also tried to do "git rebase df893d25ceea3c0d --onto df893d25ceea3c0d^", after applying the reproducing patches on master, but again, there are conflicts..

How did you applied

commit 88f468e54696cd9ffc28ecf96f18f04125402541
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Mon Sep 16 20:53:22 2019 +0300

     block/qcow2: refactor qcow2_co_preadv_part

and, which is more important further

commit d710cf575ad5fb3ab329204620de45bfe50caa53
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Mon Sep 16 20:53:24 2019 +0300

     block/qcow2: introduce parallel subrequest handling in read and write

without df893d25ceea3c0d ?


I can reproduce the bug on master with Claudio's two patches, but how to reproduce the relation with df893d25ceea3c0d?

> 
> That said, I've not been able to identify exactly what is going wrong.
> I'm fairly confident the savevm data is correctly written out, but on
> the loadvm side, somehow the last part of the s390 data is not
> correctly read in the data (it's in the second pass through the while
> loop in qcow2_co_preadv_part() where that happens.)
> 
> If anyone familiar with this code can have a look or provide some
> pointers, it would be much appreciated.
> 





-- 
Best regards,
Vladimir

