Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7947C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18FD2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Duohyrjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18FD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5GQ-0001F0-QK
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH5FZ-0000g9-Dw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH5FY-0006HJ-5k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:35:13 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com
 ([40.107.3.114]:54869 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH5FQ-00069X-Kw; Wed, 25 Mar 2020 08:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc6CSOZk7s9KBHeFfeycwtI1VCjaVXeG1MzmUPqnUZfUkdznhILRJSKWmp0jI0ruwpOp1HjYgJiWCK9BEwhh3HUb2JW7AnBWWLDQwNSI1+MOfWy9Vc6aUMdvkmE2mvvR4Af5Yf9TrwccwW5rkgMi7hELzbEoKqUFDysLz+bv0SsGLqNzWsIrtCK9kbA1yCXa9ZJlEzoEvhuqp5tvw4kdknFy9+K1p6Vgg+KXh5ttqEH/16DuK8/NF1xxKXLXE4aoD2xSHlnYNUpUktVpTr2ym1oZZJPuU523YMlHlEw5ix5KV768dDQjmk6lYD5oUw7Q1X32lueTrz+WI93hxWzRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myWzcToWLH/ZgmkziGxLgN1S5EMfY4Dj/SLMmGUDLKk=;
 b=IfDcN6DINuxTc8JLSOPr5PVxjLTtVyVWFjhWkYQ+vFJjkiisA3ki8Eb9sKuczxAPjXDwuErGJvff6YhyAFDTEqxczXVzJ0n0lbYfWySi6ORuzlfMIkdfdzz2BJ6CID6Atnxh8iqvB14v0d2c7VpXeiUy0xE1SwgBe7+DRunJ7QfFMXxZv4n4jKA0a3h8Q8i8UiQlmPFS5y84BSd13+j5+ZhqX2TpHAg1XEGPlGBW9kU1mrW4FDI1W6pIvbXZqgNgAJtqTfdbLkCNPwuP8oQ5WHXH6ISdvJ7uq5tEfdUFZqPcCpRRh47KirHRARon5eFDtLhKkjChdbe80eGD1FNXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myWzcToWLH/ZgmkziGxLgN1S5EMfY4Dj/SLMmGUDLKk=;
 b=DuohyrjxJr4o75Jnx4uG0Hhv2Ufxdsu/R6rgm2nNGd8f0iCMBavhCqv24+T+UVOJCVACokVPH0IXPmEUlX3wyg/nJf9ZZuB6+dzW14zJ1WBdKZIE7TE4uPxvtm4bWoWucWtdcKoaL0HHDTCgJoZA45foiGsClq30hZx5vBohbNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5367.eurprd08.prod.outlook.com (10.141.175.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 12:35:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 12:35:02 +0000
Subject: Re: [PATCH v2 0/2] Rework iotests finding
To: qemu-devel@nongnu.org
References: <158513739843.20894.3765515992083292854@39012742ff91>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200325153500455
Message-ID: <9f443852-939c-b91a-4dba-398bfa65e67d@virtuozzo.com>
Date: Wed, 25 Mar 2020 15:35:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158513739843.20894.3765515992083292854@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 12:35:01 +0000
X-Tagtoolbar-Keys: D20200325153500455
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485501b0-7522-46f3-0e97-08d7d0b8f088
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536793BB72DD9ABE203CAAC9C1CE0@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(316002)(186003)(2616005)(16576012)(956004)(86362001)(52116002)(26005)(31696002)(107886003)(16526019)(4326008)(6916009)(6486002)(81156014)(81166006)(5660300002)(66946007)(31686004)(8936002)(966005)(2906002)(8676002)(478600001)(66476007)(66556008)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5367;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhjVBwN0NNxvhgdAAHfv+0wzXX4trVhKzxH20dRHhuGhUvFtuXyqCWraTFxcf2jjYRD0vlX46wtBAw2Fg13jyfWbkFUrae0Kdp+wo2xPUC8fFKbtLd4A9xuCDsqVoHRkPikx+oCGeiKkUtqp0lJTXG0gIBE+CVtB384s8TaRNraDK+arcnfHrbc6pt5wWB0jzGsgLo7NE6SjTdGzQtp7LMsejNxGell5mYQRN23IX/Duz23Hp4xWA6G+caupFsXGo3c2cmZf9ndvUz/TlWCJ8TjVWSSkVbaaKgfYBQyIQ2CywuAkS9rTgASGjYRWHLprSVujbwUpCDkWQSxnPvB8VejiflStLOVptChnEBqsg142iKFpX1RtDg0ygE+5L9sqV5UTz5+a/UmMhoA3CQ6MX/hpOJJ6UW+bIBeQs2Q237DXRmyyA9QE0bJpraJZirItImRR4mqTW8ctGZyKazwlZzZv5UDqwWQxaPKphWye485fjYEllYRe6c+iWtcN1E5barr4amAhNVVbeU9DvAmzCQ==
X-MS-Exchange-AntiSpam-MessageData: Bxarat6F9JPGQeP2IMvRo3FUp8L9bufF7xPROnan/s+j+INSlkD18Wu0DE2EbyvOSqqisbqf/pbvz8SE6BzQRaDer6KfgReEZWtIM38CgYzhZ9VrF/AoA7ick7E92lojqcU7PZCqdfF83uNyj2vhIA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485501b0-7522-46f3-0e97-08d7d0b8f088
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 12:35:02.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEiOKdLwnqJNRs8AlPUbuurfnnRRFUbWc5cYhyQcNKVuYpAFP40Cc5OJ279pgpbpGL9JUhLHhHz2HwECQICUvk3PT4yvsm2dgZPIYjO/SCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.114
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.03.2020 14:56, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200325102131.23270-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      s_eq128.o
> ./check: line 171: ./find_tests.py: No such file or directory


Hmm but my patches add find_tests.py in same directory as check script. What's wrong with it, who can help?

For me, "make check" works and "cd tests/qemu-iotests; ./check -qcow2" works too.

> Group "auto" is empty or not defined?
> make: *** [check-tests/check-block.sh] Error 1
> make: *** Waiting for unfinished jobs....
>    CC      s_le128.o
>    CC      s_lt128.o
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=ea762c961bed46aea47cd60fda18c0de', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-nf_7yydp/src/docker-src.2020-03-25-07.53.52.20951:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=ea762c961bed46aea47cd60fda18c0de
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-nf_7yydp/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    2m47.178s
> user    0m8.387s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200325102131.23270-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

