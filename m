Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F72C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AEA2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HooSWEs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AEA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlqX-0002mB-6e
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlpo-0002Hz-I4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlph-0000e9-83
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:29:03 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:25313 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTlpG-0000XR-Mr; Wed, 29 Apr 2020 08:28:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibrXSxPtiZOl1fUJFmQwarzGPWxkWNue7H704SB8fay90vJyoZ7kaZ1W1YbE4MdB0+pwlwFawAghHbiplWkSubCKJmJ1EvDCKBMUL/XtO+cJ8M2sSd88cE4/7mIbx0sozMLPwHTVTFfwOhHcR8nXld5ZY7hDK9810E3Kpdjd/aoxn1u+1R3xgZUs0QGNdR2vM2W7h8qQ1TBt7XQm+MeaVZNCrTW7QLotRjOcqn8gViimWiOD+62fMRknV5GIHmMMhls2cqE4LrMSKTRZIGzq2pznoQX00wEMGoc7xQreXtKKeS15rzpT9cGTkkauBh0uH5qb6L9jkIgVyAj7xzsb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2gVFkvu3zX4rvHphpkbKFNwnKjchOEor9bC/J/Eqko=;
 b=c/p4fwrRYmASv5IakgnnT1NbMG65n1Xhi7VALlfoJKccSpsHZTttu+pM5jgjDPPS/XuNEAdfkQNO9qHc/o9WulYMFr8MiKzNxbexbU2YW813mmFVUreoFHRFGo1IY7A/oN+vzwGywCv3nkNBXbclF6wNiX/prjaIuIM4rxw40wey5S94pYwqjIncBMFo/P8moksI2kb9KyDalmAR4t9r7YX6huFMJa4p4qET7eoroz5pooiTXAgAp3kndR/pLgqqGRhHmopyY6lIsb4dcmusLCCXajAM5xDJ4JW1M+by/Nw+D6sgscXIiQLdzBIaD9usLXHot1By7tEXkwtwVePWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2gVFkvu3zX4rvHphpkbKFNwnKjchOEor9bC/J/Eqko=;
 b=HooSWEs9a+FKeAgR7GM0OqsEOtsd/ae3Aevr8JOFpzUB/9UTO7/tzik9YFWlYynBijhCGOgzM7mkbuOUHj65wKeY+QqyaeadB1ClhUpGbDnU79eBJL/c9+xqmJX8t+ZKuTPNn7ibJOGeGRsK/v9Pkhgz69vzMYrjxNghKnzbtn4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 12:28:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 12:28:27 +0000
Subject: Re: [PATCH 3/3] iotests: Backup with different source/target size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429152825538
Message-ID: <c43b4e88-848c-4ffa-151d-beecbe2863a8@virtuozzo.com>
Date: Wed, 29 Apr 2020 15:28:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200429111539.42103-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 12:28:26 +0000
X-Tagtoolbar-Keys: D20200429152825538
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b62cce1-55d7-4ce9-7ae2-08d7ec38d140
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55277023B6AAB5C144AD8993C1AD0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(376002)(346002)(366004)(396003)(86362001)(31696002)(8936002)(8676002)(26005)(2906002)(16526019)(4326008)(956004)(186003)(2616005)(66946007)(66556008)(16576012)(316002)(36756003)(66476007)(478600001)(5660300002)(31686004)(52116002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Knc7RuyI3EQw5b1V7K8wYcH+PLFYX0ekQI9f73fZ656+qS0uatL7KzH3uPYyEcSnImTCm3DneQrQUPmwBdfWjtDd0p+LHbbyJqqXrNgW9YUn+sxn/RqOAW+9n5Qfh/dC1ajseaxVwEKNR3waDniyW+62T9XQmSXvjBOld5V6MNcAbaET8VnNfxt4J0TkiZK0cm/5PEpDuKuAQPC46Ub2lQ9LbDjy7FEGAwH92gPiykO421GraKUF8m84VlWN57gyHRlWGLDTLOIBajnRzO/kr9+Evxm6swzw+rquj1Z//vq/JfNidbIQjp3hstDfkpbU/PUP/hO21v3T8YalMPm95HxKvvr6a+y/BHQ5mgFHSca/jxsr6REoEnjZBorf7B4a40eAc59l1jpVD9TrRGu2JMq3mKV5rF/+w0ualHYiAv2IxNxE6HiNIUkboQqNXM3k
X-MS-Exchange-AntiSpam-MessageData: vYzOiBgn03reK3h0nSe6Ei3XE1h+zuFQ6cyvTIYPhLpr1bfXi2b5VQTHJKghUbub89hLZmCvsIIbnd25shIvULIMFTGynng2kvHGO990LCYOJPS6t9qrvjJUi13CfMk97qO1SztYTFnRPvjagy9wbcIK/TNNfjVjH0CCrVoAnxQa1QnywYpTENNKrbwnGejwLR+NAIvI0tyiFpLQNTx68lv10f1CX4chAp8F2hyPEso/WCqJUyvvI0b6M2zBEWMSNU214rCHA5gSrSF50eWYZ+q85KYiL3pKFRzTJXVrTFR/Any4uTvqR4x821t/P6H8q01OttD9YyBIvQXEqPrudkFo8Atgd+6ldyVN2dLK+M7EXIHrKWcSCALhQ8TVgPXxgu6fGuOihzprF2R8Je5q7RNjzYIjJF3hYsDOd1wxS8rxsGbsAPrTzNpqvtXXWgSxQ2+AOx/6+ijVIJctWKgf/adFUoZrZYxYr/1ixpq/SXSuZPVmEew6jvjXjKtv9heslyihy9MNb65E/L3UQWZftOPYY0iuCUfZDaH81tSDSc5GKVgAh1b6EcDxUgyB9ilhtsb+T7IJ5yENjDAzqpygcCXjoEot8nyIX+PIY3+2vPG4ESs70QZFr+aYFjK1sA7CO4Zo6JdUlKswxmMffRPoLddjSVpfSbhpJZKlwfrH8Hy0mdeHaK9/vil28Q+bSvl6h2wzUW6R4MSttM/uDseDrGXIV72WF436/pxKMO4QFhqpBFr9u11S4VLeMKgFVDE7cIK1gLqAw9ZaK0lJ7tlD5ofdHXdqfNAuy/414hSvKkw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b62cce1-55d7-4ce9-7ae2-08d7ec38d140
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 12:28:27.0486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYDFtgqA+0WBrF9U7LUhq+OAKeTF57mjS81MkaRNALOYlI10fqbjQRQzmlDSDKJLHAKMrHkHZAuErP3RewuexidZqIMQOisPUASOyCvIlC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.20.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:28:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.110
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 14:15, Kevin Wolf wrote:
> This tests that the backup jobs catches situations where the target node
> has a different size than the source node. It must also forbid resize
> operations when the job is already running.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/055     | 60 ++++++++++++++++++++++++++++++++++++--
>   tests/qemu-iotests/055.out |  4 +--
>   2 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> index 82b9f5f47d..243d66a62e 100755
> --- a/tests/qemu-iotests/055
> +++ b/tests/qemu-iotests/055
> @@ -48,8 +48,10 @@ class TestSingleDrive(iotests.QMPTestCase):
>       def setUp(self):
>           qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
>   
> -        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
> -        self.vm.add_drive(blockdev_target_img, interface="none")
> +        self.vm = iotests.VM()
> +        self.vm.add_drive('blkdebug::' + test_img, 'node-name=source')
> +        self.vm.add_drive(blockdev_target_img, 'node-name=target',
> +                          interface="none")
>           if iotests.qemu_default_machine == 'pc':
>               self.vm.add_drive(None, 'media=cdrom', 'ide')
>           self.vm.launch()
> @@ -112,6 +114,60 @@ class TestSingleDrive(iotests.QMPTestCase):
>       def test_pause_blockdev_backup(self):
>           self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_img)
>   
> +    def test_source_resize_blockdev_backup(self):
> +        self.assert_no_active_block_jobs()

this will never fire, as vm is created a moment before, I'd drop it.

> +
> +        def pre_finalize():
> +            result = self.vm.qmp('block_resize', device='drive0', size=65536)
> +            self.assert_qmp(result, 'error/class', 'GenericError')
> +
> +            result = self.vm.qmp('block_resize', node_name='source', size=65536)
> +            self.assert_qmp(result, 'error/class', 'GenericError')
> +
> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
> +                             target='drive1', sync='full', auto_finalize=False,
> +                             auto_dismiss=False)
> +        self.assert_qmp(result, 'return', {})
> +
> +        self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize,
> +                        use_log=False)
> +
> +    def test_target_resize_blockdev_backup(self):
> +        self.assert_no_active_block_jobs()
> +
> +        def pre_finalize():
> +            result = self.vm.qmp('block_resize', device='drive1', size=65536)
> +            self.assert_qmp(result, 'error/class', 'GenericError')
> +
> +            result = self.vm.qmp('block_resize', node_name='target', size=65536)
> +            self.assert_qmp(result, 'error/class', 'GenericError')
> +
> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
> +                             target='drive1', sync='full', auto_finalize=False,
> +                             auto_dismiss=False)
> +        self.assert_qmp(result, 'return', {})
> +
> +        self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize,
> +                        use_log=False)

these two functions are almost identical.. worth refactoring to be use common helper?

> +
> +    def test_small_target(self):
> +        short_len = image_len // 2
> +        result = self.vm.qmp('block_resize', device='drive1', size=short_len)
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
> +                             target='drive1', sync='full')
> +        self.assert_qmp(result, 'error/class', 'GenericError')
> +
> +    def test_large_target(self):
> +        short_len = image_len * 2
> +        result = self.vm.qmp('block_resize', device='drive1', size=short_len)
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
> +                             target='drive1', sync='full')
> +        self.assert_qmp(result, 'error/class', 'GenericError')

these are identical too, still they are smaller and hardly needs refactoring

> +
>       def test_medium_not_found(self):
>           if iotests.qemu_default_machine != 'pc':
>               return
> diff --git a/tests/qemu-iotests/055.out b/tests/qemu-iotests/055.out
> index 5ce2f9a2ed..88bf7fa73a 100644
> --- a/tests/qemu-iotests/055.out
> +++ b/tests/qemu-iotests/055.out
> @@ -1,5 +1,5 @@
> -..............................
> +..................................
>   ----------------------------------------------------------------------
> -Ran 30 tests
> +Ran 34 tests
>   
>   OK
> 


-- 
Best regards,
Vladimir

