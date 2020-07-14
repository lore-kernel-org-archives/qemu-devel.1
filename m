Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F75C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAFE2255F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l0rqkRcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAFE2255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOId-00030C-HY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvOHY-0002Gy-DX; Tue, 14 Jul 2020 12:59:52 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
 ([40.107.15.128]:52302 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvOHU-0001FA-AT; Tue, 14 Jul 2020 12:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0d0AlfRr6DtAaLhq6oBdK/2koeiSfJnxNtxol5O3mr5JOFzrS/cxKmH/Xhb+IcapxvLc6JpKPalaC/vEAcR5r0ESqxcQEKcfuVRrfuHaV1TGiQeTBHGLtm//OUMfsFJJgBl7XrRL4PTpJEc9y2/JyH46kHloaefnQkdJh9uUR6vK39oMja5oJSCO0QeIac+Wy8+5I3liYjK6JRB6ABs0fSxtKwvZvWayOClQ1Vr0fY2OUbuTY7hRulvLSrLs1WEHd1WlgWpKYKU9uflejos9zxfLZWqJZPGYSBTPl1uIZIPR/VTEn/A2QUOoKI62ZQKMG5Zlnk8mQ+b6ukWS70BQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5dGM/SHtfOehhQ33t6s2i/x2EEoAB/btCzGLkYEQGI=;
 b=gCpR2gpNBnzkC/6FV8lCJ11Hsf+jqSHfj7cWI5ZysmTkMTkr4x2k1KQnSEmCW1eUaa440icOdP+XgOiRrFHGy3DRE+2jfKX4VHURVwwhWp6BZOfuVtv0JluSA/TOQKUzXkx3pyCbWWXcWxT1LIbDhEy2J61ccx23UPgDb+rRZwYK+CCk1kjC0hf8YSe3eft/+i/3nYL+1nCbt91l03WmgbVKhKWG5ugqF8tFf7CfTu5e8vUOTM5XE3+LSm3tYunN8pmvkR++XvKoS1PmuQdNLCiAwurbl5mjGpDILPfbYBpzcdp46Vo7+sW8sUp1j+dN2oBNCU3QdXVzwCPpcYlvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5dGM/SHtfOehhQ33t6s2i/x2EEoAB/btCzGLkYEQGI=;
 b=l0rqkRcQSmzzk0hFywNJXth9qYJUHTVvyyhWrRlrGe492tVNxxRq1CAggL0qXzWHl6v89cFL61R6E3y3MDvuGl7Y8VEzdyosCrjTRZFYJB+2M6Jdp9LZPChuBduIuqQJkrQXWCQ/xOeQt1wuw4tYefGd/0A/YaBfXcOzMmNFtvY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1651.eurprd08.prod.outlook.com (2603:10a6:203:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Tue, 14 Jul
 2020 16:59:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 16:59:44 +0000
Subject: Re: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
To: qemu-devel@nongnu.org
References: <159474538053.11884.16567641221376136360@07a7f0d89f7d>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f7f50f73-9182-77a7-1baa-b4b6a2c57175@virtuozzo.com>
Date: Tue, 14 Jul 2020 19:59:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159474538053.11884.16567641221376136360@07a7f0d89f7d>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR08CA0005.eurprd08.prod.outlook.com (2603:10a6:208:d2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 16:59:43 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93dbef4b-e4c3-40ea-5781-08d828174e9e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1651F91BE237E9E132EDCA05C1610@AM5PR0801MB1651.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXoEx1QGJxznk37bzvohtYBZxa7WxKR98cAnoFb0u3jQRzTfFUDBiBkc/5j6EGdpCFx4ztEdwwweAaVGrSSfqa3FcC5Y7OozjQbwAZ7Ga7vSyM836haBDpEf65rFoqwBxL+4BC+h1D5f2957+7+/t0LFgsrfAr63/AR5ZU7EkB6ycbAqIA2I0EGgepEY5E9XHvF86SjWYgoXZS7gC5Ax42rrFzOy+souAbXDmyk/YUO2ASuDM9nSpxJySBKVUa60eW+uVZw4al/ZGiDHiADc7cWWkYFKgpDjIZEYeCXA/33x42/rKYGVrDGtKcBnN9CSo4cdQ2JTrleWHWboX3NPKQs1ecQny376tuf+giXHcfIw0lwLe+uEAVkeY4YqPOOWcdtwd2ObfRHl4XXUXxN968JfVg2XfZ2L2mlKr5bMOU26cHtL4nE/OwWIxnnb+ZSSYmnE3IKO3o7vZkB1gQvBaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39840400004)(107886003)(31696002)(6486002)(2906002)(26005)(36756003)(956004)(31686004)(5660300002)(2616005)(478600001)(966005)(4326008)(186003)(316002)(16526019)(66476007)(66946007)(83380400001)(66556008)(86362001)(8936002)(8676002)(6916009)(52116002)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +JerqUNA2f9FpJoYuTI+INWp5kDDFbRwC8Y/Es/q+ej13nu9nwENQhL62MsxkuOPf8Om8NS6vNaZtrqibaI3aB3eq9yNmLeBDTjWnJKD8vUqYyHPb1mHStv38d0mUq9aixyUG4qCPoh1HboN2pno0XX0lV9DLZMYVYQ4auzoDrAVGOSKfLVGZ08M8gpJts9vqImsc4Y8EjZvqyDKCIUlAKdrM7usspnzsy2uIatnju7R18clqwzeXd2q8sm+FJM/i6sj3NRiPglHVJ0PgjvsvQrmm6yzh0V4MLkAWiiWRz+hjUTgMTodW5BEKVcmMMhAUYnMa12II5X+5xnMcA49tyIk2pxXUeHdje30wOZ/9rOBRabvKXLS3B/zU5zllwR3Wxcs/YJLlHJimUBklq+NoQ8LrtXL8qx95DqlWppCpzHROwDIY0U18jqBS3yDCXMEgKAjAe1+rT13oXibIUEF+nn+8KmKv2V21IHuDlOUR8FjSDdUvNkKA9LsacOFRTgL
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dbef4b-e4c3-40ea-5781-08d828174e9e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:59:44.2548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hzIgXPHBSf/p2VB2Ymtxi2MsePWaDnheKyXLcBHDtYp14nooqPmbubTdIJXt3x7FC6zk5SlIvq900NDSWtGzS2Vt26M+W818tSWWNS91jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1651
Received-SPF: pass client-ip=40.107.15.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:59:44
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
Cc: kwolf@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.07.2020 19:49, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200714162234.13113-1-vsementsov@virtuozzo.com/
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
>    TEST    iotest-qcow2: 022
>    TEST    check-unit: tests/test-char
> **
> ERROR:/tmp/qemu-test/src/tests/test-char.c:1204:char_serial_test: 'chr' should not be NULL
> ERROR test-char - Bail out! ERROR:/tmp/qemu-test/src/tests/test-char.c:1204:char_serial_test: 'chr' should not be NULL
> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>    TEST    iotest-qcow2: 024
>    TEST    iotest-qcow2: 025
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=9dc2c7a6e3eb458c88fdd6be6a03c6eb', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-fzvixkio/src/docker-src.2020-07-14-12.32.53.19697:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=9dc2c7a6e3eb458c88fdd6be6a03c6eb
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-fzvixkio/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    16m48.396s
> user    0m8.741s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200714162234.13113-1-vsementsov@virtuozzo.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

something unrelated..

-- 
Best regards,
Vladimir

