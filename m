Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A864C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2429D20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dDkDCHaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2429D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCLR-0006os-DK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixCKg-0005tm-Gr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixCKf-0003Ta-C8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:06:18 -0500
Received: from mail-eopbgr130137.outbound.protection.outlook.com
 ([40.107.13.137]:54404 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixCKc-0003Q7-CL; Thu, 30 Jan 2020 11:06:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI0r1ppQwUEKiHQnst2/0fGTZGNeutdLDrsJTy0o7BSbzukjUZCRgu1w7CpxXXqjGLO0+yAhqb2hfVjywqncu102zuIELvLBH+mDrSKSpiTwVqY5c7YSRp4mBGbfzy6ThSrXYlnPTr2i5rH8b0gZuKb/En9Cud8iCPGFi81g5sF/07kpAbwEMmWAa5yAPsv0uIpp5g9tnEfNvJh0w/gjoAZwOpiaQbUEkubDCVJ4aRtBaoHeTD0s+xmyT4MYD51zm/ngZ+myOhF7Opqf9CEtQIDlpoZRN4oqy1J5Qu/U/frNeOZ5bQAz6jJYkj7zNaADJTOjZBneI0p0oDgJK9KrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOFoYblj3QPMXqNIhQbpKn36suqY2nCj1PJhgA+wApo=;
 b=U3xXYPLV2jUeSs0uAfZuo54zQFVTS58rnz/csUuSNjq3/sxJue/UZx4LbydcjXnxEwl4TqVG+psilm+RW9AdD2cNIykoi8LdRtpO4SwyobGPK9DgL6WBIgm+LvJnFoLGKjFO5UV8gkixiYoXGW92gTu9+2gFuuztlhW/Vhp33dO7LysWP33YkZYzxY1hi14vAnxxuce58PMV1yw/rf1DDc/rvBaygbniEK1t3US6cvTiJih//LzN0JSpsMdDKBZBS9CKIkM+BDfZPdxXqY9pnuGMlWF+4HJedX05PvbPSCYCfp22sr4DwUt0GOi87mXzUA7Cb5oWqf8izMhUGRHeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOFoYblj3QPMXqNIhQbpKn36suqY2nCj1PJhgA+wApo=;
 b=dDkDCHawsHKAkiaxxd2oJdf8F+9VWo5WIiv7O2bzjhDm3vYK86uF8vCUtKoLeW29+jTwncXfUdE41+KrKjj/6lNUWYgMuvdo+iUq2Jbj2S3moXYPjn7TO+4eO3xkmIGBKfsKiP1ws/JgKORkQsqwLe4Y6oLOU4+qsc3XLJuqg74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4086.eurprd08.prod.outlook.com (20.179.1.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 16:06:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 16:06:12 +0000
Subject: Re: [PATCH 0/3] request_alignment vs file size
To: qemu-devel@nongnu.org
References: <158039955610.7663.15744177791698349678@a1bbccc8075a>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130190610336
Message-ID: <6796646c-e69a-877e-9814-cd6e6edaeef3@virtuozzo.com>
Date: Thu, 30 Jan 2020 19:06:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158039955610.7663.15744177791698349678@a1bbccc8075a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::11)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 16:06:11 +0000
X-Tagtoolbar-Keys: D20200130190610336
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c98330-9e92-435e-b63c-08d7a59e53a2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB408691ED06A555B3A4A1B851C1040@AM6PR08MB4086.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(189003)(199004)(186003)(8676002)(956004)(81156014)(81166006)(66476007)(2616005)(66556008)(16526019)(2906002)(66946007)(52116002)(31686004)(86362001)(6486002)(4326008)(31696002)(478600001)(966005)(36756003)(6916009)(5660300002)(8936002)(316002)(26005)(16576012);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4086;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13mS5q0W02tkdInsRvG6t9zoPPuTUiCldWzD49Ucrx8Bem9vhFRmeGKv+CUqagvYOvR+gQwhDLwwM9/Ae5LT4t9vmiQk2+gi1EUoffTJBX08ZreLJYB/oTEaQcVnzRz3QVG5jYmNSOmaO7Z6RP4oMxRni1dDg3TsK59CXl3CZxUxdZJwVSHQ21fGDehMx9N+D/l+JPkeWCl6CVtSrZoXnej1WgdI6VQjBrJC4G5PCBYcsd2OKtRBVCY9CR1JmrRW5AIFtSXaD5CHdeIx+gO3iku/1nD0dIoEJROxXSxooIBrQ3culQvCWDYtVZPff0M9xYJmKQ0mZvpDJAEHvSzQNYCkUUxUYTHlMizHoycq/2P76yfzc/2yHzaQAbBHLVRMjb+6byreIrvZ2/Cjg4hDVfLu0eSUKVPGdQc/ut39zQr7BPIfdyA7xeYPpoSdKy47Aduu1w2QwAwhohkOMaHKL6Fcl+xNNSNiegPKdY71rKsn3rcphZsr0B6gv2pdKqb2Gy2+vVBprntQl8w+wJYUtg==
X-MS-Exchange-AntiSpam-MessageData: IsUlhZpwuvwlY2CRDIOBK+r8OK+BFw5wvRTe4aUCqGXaNqHrR2lGbwYb5upY8e6hKiMvt+GzAmwhtDlQy/nkMwhHYEFnEdeKkLclAQjyDP3BM3LVyXlfu6ljnNwq9l3x/q/pOojBdza0KWXduB200g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c98330-9e92-435e-b63c-08d7a59e53a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 16:06:12.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8Fc0H33oV/38d8g5WdnY/OHVyHADjYByq8RNHg6IcrvNypq7kAHv0QS2ahKRUcps3KMTjBpDyZGYzZP+NcRRW9nt5KicmmpbeftoB/1tGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4086
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.137
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.01.2020 18:52, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200130152218.7600-1-vsementsov@virtuozzo.com/
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
>   *** done
> Failures: 268
> Failed 1 of 108 iotests
> make: *** [check-tests/check-block.sh] Error 1
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 662, in <module>
>      sys.exit(main())
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=393f106d3cef4268a1d74151451d2a08', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-rrfmlftz/src/docker-src.2020-01-30-10.43.08.18508:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=393f106d3cef4268a1d74151451d2a08
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-rrfmlftz/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    9m28.931s
> user    0m9.285s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200130152218.7600-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


It's unrelated I think.

-- 
Best regards,
Vladimir

