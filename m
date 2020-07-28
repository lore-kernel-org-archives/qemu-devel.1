Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C6820672
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tOHxANHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C6820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Kms-0000AL-JJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Kll-0007kC-1Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:15:29 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:32001 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Klh-0007wp-II
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:15:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSLS/4utKj81wjF9E+r3dC1jwc3zSFu/zWEVc1k+wd2Cr85iHVNx0M18VlSHj2VF12TVdrcPzNStTk867hjhaW26IoJoPMLGuhSnQTWteD34CCGmrNjLqqVbBDeyPn+YmN8PcmuQqlPd7/8ieRVt1UvGzPysKua9FItHUfCepvQSzI+xq8nxVcUbhbk6HyVGm25kdonlQ8bYqkIuV/RwNbaNAuEqp+t9ClbbbB14R2TO5LiQZf5gKZ53civySFPfRWvlySKatxWHUb+FMaijCVcaadyNgxzjo+nmDeOhiqqebVpykqTHwoRInzVY+WYfA0iPgVtEzTHnvyTS+fN1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbW8snwqPOhLZBdTwu4PaplIrgAkmXfivGTQ5ulX4dw=;
 b=S1w9i44yh6KvWPSPxaMzlr4j5vxFOoXsiOLU2RUcTQeOY3iTQY77NS8cBss4bs1eztWxlQ0XhD8IicaLAPjIQ6ng/L9t2JhLxnPk9aL3o6XRP57NfmKlYAY/JVYgN48DLDjG7bieTzlOmO+8Sf1PlI+RKBon4nAXwekiXLeOeWk44YEgi3KbEhDQXm+p8khUBH3o4KAxLhMhMD0LltznWXVqF+4BN7vq/O/KQS4VluuOWnnrbYMle4XE26dXGuIqxnqMyVHbvrI+s06xwldC4S+dDR6HpKkGQYZwwcI09WPToDC1cFI9mmjYkd5G5DlYWR4VZZv48oBufDdYzN1siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbW8snwqPOhLZBdTwu4PaplIrgAkmXfivGTQ5ulX4dw=;
 b=tOHxANHXj0Vjky+ov0VojDjSAyQBrRqUCWDZhV2oSGJrXM0rJGoxM1yMNpy/XDHWrjMPSdNAcdoVuC+kkNOClX5Vn03R1MOaQIWGSu/Lq1ni7kntmZVDdye3MDVD0SQwxfFf5geG4DRuYHEOhRYqRjZQLTOBNjiJtEWemuX0NIk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5206.eurprd08.prod.outlook.com (2603:10a6:20b:e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 08:15:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:15:21 +0000
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
Message-ID: <a6d1196b-8236-fbe8-75f4-47137241e10a@virtuozzo.com>
Date: Tue, 28 Jul 2020 11:15:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.33 via Frontend Transport; Tue, 28 Jul 2020 08:15:19 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0854a987-3c2b-48a5-86aa-08d832ce5e4a
X-MS-TrafficTypeDiagnostic: AM6PR08MB5206:
X-Microsoft-Antispam-PRVS: <AM6PR08MB520695346976B4906CF84EB7C1730@AM6PR08MB5206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LDls5b8NC6HRCyDZtnPXPKS+jXHgJbNV79x/66yEDga5gAo6so5dtjh13kUYrl8kCzWxrrLrwZd7R1XcYpx/jBipuwep8fvnLvY3V9bFPue1mBsCWkqBa1niVQniccbTtSzRFdLPF5Wb2KOso3rDKVIA2gymDVjhxRWH+G3stHSe16cx78r8UjE/c/5h3KCphnOtOEA6N1ywidOGn6FiuUsCdYBavBDrhtoWYfVbJPoIh451uGq1kk1qq354pKdCuf8QguviOCdzjKCMDJPx/aXF7YI3PYlCSyfQYdJogGG1hzOVuulSVGQIc+oV3bAgz8+2EOn6mIHe15sIyz20xF9uhgoFuCWQtcpdzlPGXCTTNndpg5UVz3CA5f1s+as
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39840400004)(366004)(346002)(136003)(2906002)(66946007)(4326008)(36756003)(66476007)(66556008)(8676002)(5660300002)(31686004)(8936002)(956004)(2616005)(31696002)(53546011)(7416002)(83380400001)(26005)(478600001)(54906003)(16526019)(110136005)(186003)(6486002)(316002)(86362001)(19627235002)(16576012)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ziUC3ti8ze+RotcgxbIYEy9uhqtiH+wsALExkeSthZco3r9O2jpcqCcKAbAaG6TZPUWUxOaHf3SdpzwG2/j3lzDKvE3nGndRTz1IXUfmBvWLRcVl1CjJveejm1mrUc9XwIDZRaF7RqVHsJc8ulIQdfOVitmV6gYdd5b9IvhboOMlKik0rxjd6n2igiOLFlZ8Oq1YjFPh7u7UKsG3KeTH6k3ES3CCvjSzt2fqV7icAhWTG9rVYhjtNB0E3ERRzyq4mSAQXgUQzTL8DMuSbT8u6cBI8w4uOB4nsYlNHd5okpEUpjhrhWAmu3CUllBFyAXwvyLwr8BrzgmLDiNdgHPZIiGzdIS7e8xheRiy1hBBbJMp5/Jl3h7LCnszBsNf/kACWxAxHZjUaC0r04A8lywJ8KaOeL6EX0szHXA3qgTOKYeqFhK5TCy6fRGn+WCycNcA2CJRNR5gaMaezkpPVpMJ3csvH4l6ABQRMTlYW/uxrli3fsLNnVYeOcyUhwWGRZyL
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0854a987-3c2b-48a5-86aa-08d832ce5e4a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:15:21.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRj3IVpisw4/5UEQB7X+H6oqJ/LnuU969L/NnNsPJAVU5lBS+8Hwl7KqioDd/Mw2nG8M96YRFq0qNpW0r2k6XIPt+pRLIYS1LGcGRxtahvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5206
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:15:23
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
> Adding commit author to CC.

Ooops :) I'll look at it of course.


-- 
Best regards,
Vladimir

