Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA7C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0CC2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZR6Wdd6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0CC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8JJ-0003nB-17
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:29:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8HF-0001TC-Fp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU87f-0006es-05
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:21:50 -0400
Received: from mail-eopbgr130105.outbound.protection.outlook.com
 ([40.107.13.105]:47170 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU87e-0006Ga-5V; Thu, 30 Apr 2020 08:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBvvhlG1w+GpZ42k1e+KHxbksSGsiEYQqx85gI2fmFmOKFCkUHscxcwadjGAetVt98cVBxoz1JxGYUQGIC/y6O4FVdSOlMjHv5n1xNMOrrSdO6QA8oKLwUSWkWpc6MM+z9s73E7YVOn+NQgJfWwBWzkaNj45uqI9s/o5uDpW/erOuz3t2eXNvwDq62m5Y2a8L/7haaaQrVT8KaDdlnZ2+bCkrI4JvFlHi286flH6YDVHVdsZgTL3kpdct0aDIziSAlZSXJVsyR5rW4caJRwlUbvreYSGy1ITVVJ0LEKlnvlFIHie2Bu+tLSKhssKxlAtw2Dq6TRStDDz0G+7iCZpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqoi8qVLxB5egucv05vYahGB/Vvqghj3bOorwCETi6Q=;
 b=TxsJel332xtR1YbvlUJ/2OqzF+I6UX9y5MLUZlkHxymN/OhsjFNcUok9gdWb6LJu4MAzJ4xE17lSeeRAP2FwYb78+Z1vpimJngZOc/U5AsKPDCiyvGNSXoACGWj2Q1ag9piLyDxAv8FZaR4RePWsWp8KduKk1z3xznPmU9DgDFIDxWjd8U5FKfYbyezreta919wG+kVaWIsBwVc34R9zjotl14QJdEvIzbUotc/5QcC5nvP/AwFPZpun+SQ+dl82P9ECCfpLHbrmS6DoymZKLXhjmtHbf0HS3OIbK8w39InnjZ31Bpg+CtRL9qpSdQHz8wgOpn07zdXwVov6K1CG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqoi8qVLxB5egucv05vYahGB/Vvqghj3bOorwCETi6Q=;
 b=ZR6Wdd6wxAHqb135eOHmqmgHrjCRUWERZvSaep10D8C92sJpz7vTKPGeAe0eZgPt8HXfajMI6quxlDhTw6jLSgWd4fAJp7K5YgzvtNDvJcBSTHVKOXXXjBsItd5o1EAqfMDd9YdAED3fdDXjCnxkdSJaYXq6BRDRCB1UCD4Eq9g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:16:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:16:54 +0000
Subject: Re: [PATCH 3/3] iotests: Backup with different source/target size
To: Kevin Wolf <kwolf@redhat.com>
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-4-kwolf@redhat.com>
 <c43b4e88-848c-4ffa-151d-beecbe2863a8@virtuozzo.com>
 <20200430114141.GB6578@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430151652543
Message-ID: <792f2f5a-7a69-a7f8-079f-f199e5592b36@virtuozzo.com>
Date: Thu, 30 Apr 2020 15:16:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200430114141.GB6578@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 12:16:53 +0000
X-Tagtoolbar-Keys: D20200430151652543
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 553daad5-0372-4387-bfbe-08d7ed005ebf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53509B2646E55C904C211406C1AA0@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXJiZMbD7tNstL0Mz5epZfE1jRdTVCPF8fo6gXbyhJV9wBLJwITB7RU2ZUo7Y6AYwzJMjnC2mpCvFGrBIYfQorKS5OoZx0gXvjW/Lg03PuPzq1smw5iD5hDS/1rArRpyUY4Xhw0m/l/fkoM5iVfaBujuNLQhmUFycdMNoZNlK1++EFjCX4iBxcdKlUgXVfl5p5btHpCIXPUxO45la97xWuwsJKKA/Yq6HYrjXDqaDQNZ0wDkkOaqQ6xlrkEcDEIVyjnTuomR3s+dJHgCaCYCm5IMG6+vHCBtuSiLjBcUSHVWNJvioIBmp+VpMq0Nm0h07T2SSJ8Ik5dLjlrU8m9XWEnpd5u/Ove88QYoqFcV7CnrOaxsEBDftCCcao9weuCfTKX9oUft8hMH1oRlMxbgNVcWVVQ6Mglwt/Mj0s+bxzT6/yT+jbUoCyQV59QnVE9K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(366004)(5660300002)(8936002)(4326008)(31686004)(8676002)(66946007)(2906002)(66556008)(66476007)(6486002)(478600001)(86362001)(31696002)(2616005)(956004)(16576012)(16526019)(36756003)(26005)(52116002)(186003)(6916009)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zj9l0cr55FjcpnKFkjXc7ofzYgClVVJRjv+pS9IBc9ZB4zKQTe6rbQf99sZbdzNj0xgrRjj/RoYaiimsLdE8YR4dus+ytoKierUgqWWmq/+MDZ/C5VDQ3PueLd9EUhX5z/lAOsvd5nyljWR0Pb9BBtEodZ3WXIMREm7eyOgNtWqhgdkXLu/Vkyn8oFsXKTqNrxTbidFQEy2HOudqUI2n/vfnN+NuyxHUWzmajk3+6/VPMr3MRuNfdPNJleijsRbPajTKhdVMRdwrN0jprhPfyjkAEi1utLQl02kCq2DtzIr4nAUC7FYkAgxNDRUR7avAySU4UApEiw2F4uENA0nDRbWEzvGlhEHu/DiIjmMcZ/hD2DJTuDaR83EL82qlPl1RS0bujddXSnsVrmkR1r1mSsmAKEkEn6EUY997sIcp65yb45IuIp2i2Z+5b1M3mp84xWU3hYYEuiFEDrJJeLm3AwwTHo0glUiZXqiBFcXkKaFKHM+ehTJl4gLci+CUp7fKPzhW7+h2kZvctvcAn8SJDpum93UWBNVuOWrTt5cqH3+i4CZlKCIRk+31QJ3FMSdwYM9ZSYVNH21K5im6O3EkgJpvoPxAH9TUsZOIz2ni9Sm5CHDiY9rx0Z3DwKzxl5X7upXzrqDijDI4KbK4Bd7MtFggey7AuL07fqG8I7Lqe+X2y13HnooP4NGAeAp57Ac0INAAeqO9xp60K3mxIN0ktEr4KFZvy/nqj4v1mCfSd96Xiyp7E11nf6WKXSHmKkOxIR7ak/CXg/t+uez+afVuq3pCH1V3h2lsow9Abt7LSYw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553daad5-0372-4387-bfbe-08d7ed005ebf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:16:54.2996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KuHuxh8qYuZlB+DzE25zbVEXdOl/FREL48PVWByVDjLDWSg5geOoMywpzwDzNNIwUAqCeXImESfzI1Wb7YIGLoRNf2iY6uRiilK94S/Z/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.13.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:16:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.13.105
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 14:41, Kevin Wolf wrote:
> Am 29.04.2020 um 14:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 29.04.2020 14:15, Kevin Wolf wrote:
>>> This tests that the backup jobs catches situations where the target node
>>> has a different size than the source node. It must also forbid resize
>>> operations when the job is already running.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    tests/qemu-iotests/055     | 60 ++++++++++++++++++++++++++++++++++++--
>>>    tests/qemu-iotests/055.out |  4 +--
> 
> One general remark and question that came up while I was running 055 a
> lot and really got annonyed by the long time it takes:
> 
> TestDriveCompression is quite unconventional in that 055 is raw/qcow2
> only per se, but some of the test cases always test qcow2 and vmdk.

Yes, that's bad. Oh, seems I have a patch for it not still sent. Will do soon.

> The
> slow one is vmdk.
> 
> I found out that zero writes in vmdk are completely broken (I'll send
> patches), but even after fixing this, it's still slow. I think this is
> the combination of VMDK not having writeback metadata caching and
> backup serving lots of tiny 64k zero writes.
> 
> Has anyone ever looked into making backup use more reasonable request
> sizes for the background copy like mirror does?

I am :)

The whole series improving backup is
  "[RFC 00/24] backup performance: block_status + async"
First part is already merged, current chunk close to be finished:
  "[PATCH v4 0/5] block-copy: use aio-task-pool"

> 
>>>    2 files changed, 60 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
>>> index 82b9f5f47d..243d66a62e 100755
>>> --- a/tests/qemu-iotests/055
>>> +++ b/tests/qemu-iotests/055
>>> @@ -48,8 +48,10 @@ class TestSingleDrive(iotests.QMPTestCase):
>>>        def setUp(self):
>>>            qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
>>> -        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
>>> -        self.vm.add_drive(blockdev_target_img, interface="none")
>>> +        self.vm = iotests.VM()
>>> +        self.vm.add_drive('blkdebug::' + test_img, 'node-name=source')
>>> +        self.vm.add_drive(blockdev_target_img, 'node-name=target',
>>> +                          interface="none")
>>>            if iotests.qemu_default_machine == 'pc':
>>>                self.vm.add_drive(None, 'media=cdrom', 'ide')
>>>            self.vm.launch()
>>> @@ -112,6 +114,60 @@ class TestSingleDrive(iotests.QMPTestCase):
>>>        def test_pause_blockdev_backup(self):
>>>            self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_img)
>>> +    def test_source_resize_blockdev_backup(self):
>>> +        self.assert_no_active_block_jobs()
>>
>> this will never fire, as vm is created a moment before, I'd drop it.
> 
> This pattern exists all over the place in 055, but you're right, it's
> kind of pointless.
> 
>>> +
>>> +        def pre_finalize():
>>> +            result = self.vm.qmp('block_resize', device='drive0', size=65536)
>>> +            self.assert_qmp(result, 'error/class', 'GenericError')
>>> +
>>> +            result = self.vm.qmp('block_resize', node_name='source', size=65536)
>>> +            self.assert_qmp(result, 'error/class', 'GenericError')
>>> +
>>> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
>>> +                             target='drive1', sync='full', auto_finalize=False,
>>> +                             auto_dismiss=False)
>>> +        self.assert_qmp(result, 'return', {})
>>> +
>>> +        self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize,
>>> +                        use_log=False)
>>> +
>>> +    def test_target_resize_blockdev_backup(self):
>>> +        self.assert_no_active_block_jobs()
>>> +
>>> +        def pre_finalize():
>>> +            result = self.vm.qmp('block_resize', device='drive1', size=65536)
>>> +            self.assert_qmp(result, 'error/class', 'GenericError')
>>> +
>>> +            result = self.vm.qmp('block_resize', node_name='target', size=65536)
>>> +            self.assert_qmp(result, 'error/class', 'GenericError')
>>> +
>>> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
>>> +                             target='drive1', sync='full', auto_finalize=False,
>>> +                             auto_dismiss=False)
>>> +        self.assert_qmp(result, 'return', {})
>>> +
>>> +        self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize,
>>> +                        use_log=False)
>>
>> these two functions are almost identical.. worth refactoring to be use common helper?
> 
> Ok, I'll see what I can do.
> 
> Kevin
> 


-- 
Best regards,
Vladimir

