Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BF3206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m/EjIhSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BF3206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0O0u-0006LJ-QO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0O09-0005Tp-AT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:42:33 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:39553 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0O06-00032A-Tg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZO9UZTglpaauO/1zJQs4moGgvHaywd4RWKuaAGxUD5q7H1VDZnN1ZiO3ZSb3UDKjJrDutcd0iqJOgd5kE9HPd+uXE0Ga9pQSjMHVV+1M5h+r+3SE3LkhflM6Hv1S6X6Xa2FlL6xCHP+eF1Scby3a4ROXl8l+vde9BZjuc+c45scaGC2PzW5XcvMPGMCN0BjqT1ojo18fI2gEMOTAkBlDKWyrv1B7FMlARrRESflpn/gOI5eOZatgeyN7MrpM8mX6XJAFa93hjIz7wRyqASeLmmXcgO92NosZntf/Afv1/NEe/ckBDyz7f8aRACw0aP5OqYIEu+vApw9GXi/U2wtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsuIKI0diViDaluceQ2DDPSyPU1S1phinCWLJbaKo4o=;
 b=Z4NR8SRpULVamYxqiMhDaiUCEoToXbnUAgHZ/hUYV+owCnTCf4q07XRP0wDMwmDeDwxRuO84pwxHYTN+L5YVU+iAMbu/coL0CI0RrTpIGgVI8rKiqv31yfSYVil+L4UehZxeAJfRBno+gDu+hxwc9LSHxCbRZY8wV/LpdA6s90U+b8my6KOCRQEH+FZejIuIcDJ9fB9gxn4CB/dKTi7/VM5S0lUaGbx4EcJ0CHLTBCTh1L5YiXM7C7v1NTBzxdc+zlDEsBZbM6QbQJJl6cSJH9Vu7RVfxkiveyNfsJTXbSzuNoyv0srLq7RBUv8G+aMCZNtvRO5i6oenWBzPzzcweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsuIKI0diViDaluceQ2DDPSyPU1S1phinCWLJbaKo4o=;
 b=m/EjIhSYtiBCRYTOstJpD1oC3JYCN529Oy5NoYdBZcslLFGpdj8kHAwvyAArJrnaBuQE6AekTVTfdVduHQhdzGWf7nx/nUrHK2Fc/cp6x9Hgu/XlUjRgl/Z1KKG6ZGKPtSknqkFz2ULHQvx1vqEGyN6miVntKspLVn3ybHkdIiw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 11:27:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:27:25 +0000
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Max Reitz <mreitz@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
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
 <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1d0dac87-0ea5-2ed5-9cb4-cc6d329fba35@virtuozzo.com>
Date: Tue, 28 Jul 2020 14:27:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 11:27:24 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759ccf33-be39-45af-5a44-08d832e933d3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383CF6498B2FD3E67F1A78EC1730@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ56tstfAUMo9ehUqTy6MT7iCQvs5du3QJ9nygYzcPdqGpRYonJEs66cdbmUThf10zsJA1askUy3uu5QtOi3CbSAx0HChaSG794nvBtOPNPxhLNNeMD7vA57wG8szAD8nSAW+2vilyvMmTWdTkqQaxPUOTDGPIUl3V38OQ5URkGh70KysxlGzbFFImd34nxj1a3kvKMjSDvAZFRtXLKi733B4w3aLpY1e/I3GlKHCIATDZgjwRxfPfxPVKRNbtBdr8V5SyJ2ycz6vWAzO1Gve7iNn0HdLxYOo4hpEPUa7Hhy6fQ7qFt0pMTkIzWR6i1iucJYq7aMI7THjFF3BdtZiIzg4+wxN6lwerMnwzcXx7b5jBgzXcTyUsVtZoP9hEZg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(52116002)(2616005)(36756003)(86362001)(6486002)(31696002)(186003)(8676002)(956004)(26005)(16526019)(53546011)(31686004)(316002)(110136005)(5660300002)(16576012)(54906003)(2906002)(8936002)(19627235002)(4326008)(66946007)(66476007)(478600001)(83380400001)(7416002)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sD18ECn6e6lAs3L1Yi/Az1lu7ILO54fdpYQnsUiYZYH3jiDClL9wxCcrB8SDa2LaUaTR3auAgYmH/SQfMZ4S870tCRJ+kr3i2Wj/nQDZ793zk7DSM2LWfW8bGavf8/BUKMs24aRKqip929GvN/pqzxy3/m5pjaglBlToWF95H9vGpQg+P8iUof2E6vC4FzXim9jO74ljYNqWFg8a0l+XM/BMx/5YumB2obeJJflF8+7Nh9AiMOo5w4IAkKrLD5n67+hB343uAKwQFZlUehiMioHdkQPvEAZ/b4DecAOLhwGz5FnTxt0AZdQ2uLyaAn/715UHwOuIIkX5OlbBVFBx2t3sgAqwhgRjDibb3kPKMPtlnoQT0HbtQ6j27iV+jEpT3G7RrL59HTebUDWbU5dA+tC7P/5Pdk5pa892G9mIoQ31S2xRJLJ5d93w8jF32740mvDRXWZs5TWJD7DkPZVE8YeenCMwj9BvmYR9dPC5BN0e0cKVspv1qu5/Aw6GpOil
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759ccf33-be39-45af-5a44-08d832e933d3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:27:25.2079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPhRLySH1UiwZRdoLK1tBc6c99PPi9OEpV/k32d8qR2S8xgkEUaFOO+F9bo8w6n79DLAZcDG0Qqj48UdnRbB5ei/Jwz9Yp34tCvN6Q5Hlss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.2.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 07:42:29
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

28.07.2020 14:10, Max Reitz wrote:
> On 28.07.20 01:09, Bruce Rogers wrote:
>> On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
>>> On 7/20/20 8:24 PM, Claudio Fontana wrote:
>>>> I have now been able to reproduce this on X86 as well.
>>>>
>>>> It happens much more rarely, about once every 10 times.
>>>>
>>>> I will sort out the data and try to make it even more reproducible,
>>>> then post my findings in detail.
>>>>
>>>> Overall I proceeded as follows:
>>>>
>>>> 1) hooked the savevm code to skip all fields with the exception of
>>>> "s390-skeys". So only s390-skeys are actually saved.
>>>>
>>>> 2) reimplemented "s390-skeys" in a common implementation in cpus.c,
>>>> used on both x86 and s390, modeling the behaviour of save/load from
>>>> hw/s390
>>>>
>>>> 3) ran ./check -qcow2 267 on both x86 and s390.
>>>>
>>>> In the case of s390, failure seems to be reproducible 100% of the
>>>> times.
>>>> On X86, it is as mentioned failing about 10% of the times.
>>>>
>>>> Ciao,
>>>>
>>>> Claudio
>>>
>>> And here is a small series of two patches that can be used to
>>> reproduce the problem.
>>>
>>> Clearly, this is not directly related to s390 or to skeys or to
>>> icount in particular, it is just an issue that happened to be more
>>> visible there.
>>>
>>> If you could help with this, please apply the attached patches.
>>>
>>> Patch 1 just adds a new "300" iotest. It is way easier to extract the
>>> relevant part out of test 267, which does a bit too much in the same
>>> file.
>>> Also this allows easier use of valgrind, since it does not "require"
>>> anything.
>>>
>>> Patch 2 hooks the savevm code to skip all fields during the snapshot
>>> with the exception of "s390-skeys", a new artificial field
>>> implemented to
>>> model what the real s390-skeys is doing.
>>>
>>> After applying patch 1 and patch 2, you can test (also on X86), with:
>>>
>>> ./check -qcow2 300
>>>
>>> On X86 many runs will be successful, but a certain % of them will
>>> instead fail like this:
>>>
>>>
>>> claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests>
>>> ./check -qcow2 300
>>> QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>>> -nodefaults -display none -accel qtest
>>> QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-img"
>>> QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
>>> threads -f qcow2
>>> QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/../../qemu-nbd"
>>> IMGFMT        -- qcow2 (compat=1.1)
>>> IMGPROTO      -- file
>>> PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
>>> TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/scratch
>>> SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
>>> SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
>>> build/tests/qemu-iotests/socket_scm_helper
>>>
>>> 300      fail       [10:14:05] [10:14:06]      (last: 0s)    output
>>> mismatch (see 300.out.bad)
>>> --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
>>> iotests/300.out     2020-07-21 10:03:54.468104764 +0200
>>> +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
>>> iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
>>> @@ -12,6 +12,9 @@
>>>   ID        TAG                 VM SIZE                DATE       VM
>>> CLOCK
>>>   --        snap0                  SIZE yyyy-mm-dd
>>> hh:mm:ss   00:00:00.000
>>>   (qemu) loadvm snap0
>>> +Unexpected storage key data: 0
>>> +error while loading state for instance 0x0 of device 's390-skeys'
>>> +Error: Error -22 while loading VM state
>>>   (qemu) quit
>>>   
>>>   *** done
>>> Failures: 300
>>> Failed 1 of 1 iotests
>>>
>>>
>>> At this point somebody more knowledgeable about QCOW2, coroutines and
>>> backing files could chime in?
>>>
>> <trim>
>>
>> I used the reproducer you provide here to do a git bisect as I assume
>> whatever is now broken wasn't always broken, and it pointed to the
>> following commit:
>>
>> commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
>> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Date:   Tue Jun 4 19:15:13 2019 +0300
>>
>>      block/qcow2: implement .bdrv_co_preadv_part
>>
>> Indeed, I am currently able to reliable reproduce the issue with this
>> commit applied, and not reproduce it without it.
>>
>> That said, I've not been able to identify exactly what is going wrong.
>> I'm fairly confident the savevm data is correctly written out, but on
>> the loadvm side, somehow the last part of the s390 data is not
>> correctly read in the data (it's in the second pass through the while
>> loop in qcow2_co_preadv_part() where that happens.)
>>
>> If anyone familiar with this code can have a look or provide some
>> pointers, it would be much appreciated.
> 
> Thanks for both your investigation.  Does the attached patch help?
> 
> Max
> 

Oh, I'm stupid. Great bug!

So (at least what you fix, not sure about reported bug, but it seems very close),
it's a degradation in

commit 65cd4424b9df03bb5195351c33e04cbbecc0705c
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Tue Jun 4 19:15:09 2019 +0300

     block/io: bdrv_aligned_preadv: use and support qiov_offset

And broken since 4.2...


-- 
Best regards,
Vladimir

