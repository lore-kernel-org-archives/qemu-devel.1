Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC47C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0592071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s2Qfc0sI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0592071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnFO-0005qj-EK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDnEM-0004HM-HC; Thu, 03 Sep 2020 07:16:38 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:34530 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDnEJ-00070d-Dc; Thu, 03 Sep 2020 07:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZtbNkpu0njo+Zor5O8sVOwd+uzwCLvdambB6HBxNVgPDnP1+oiBbGWpU+Rzj5aseP6c4GBo+9ldyU3Q6BpsKyL5x8loq6RAvPxPp7384Xg3NsNkFa/g/5KEycy2PZKtLwvmLuVZaDvpCzavCVw9H5/sxXNODd16fzvV3Km9gngIaILAyV3AZPWLxa5iCTu11jsg1LomSqKt+VWibG/dpTK36Ucv8b1fJ54TvX8cPSR3zzTUArZ466IZCVUNXjfUfYAf1Iku3MD4EMBWs61ShCHfWi8InRVd4qGg2+lnnmK38fbkxXQhAnFtuP7JA/3QiOBQCMoaiHjwc97Q75ckhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29BMxhC4ClIQLlMdhiFf8y6nv1MFLc6/KwzbkxxRcNI=;
 b=OfCZpsFICC0nqTnk8r0/qaArS3tqZQjDaZqM/27wkdfDkS5D3u9/vhaV7S3Gc5hUO5xcJmo9y5kZ2pVVVTt4QM86437Ykg5QjEj9URd5+29wyX+HQjGOGol/9D2Em2y7ec302wtP94RwY4dDyrivmT8iURMQZZARC9CND7oOE9qFfZKtrgT48BAVjP4Il6Yzl7/WFB3HtuJWbdVedkjY6xrYeQq+YY4k8WahESlSCSh96eW80bc4QWo8USR9/pbxqIfbahgtSa6mYGiua0uZRyzj3eKKbpKlnTH/nsZbmTNKiuuqZELyXBe28lKwXsQo5yHcA1P/pypmp95BAQegiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29BMxhC4ClIQLlMdhiFf8y6nv1MFLc6/KwzbkxxRcNI=;
 b=s2Qfc0sIKcTTwAFRsh4hIXaPWhhoY75BvrRl1GK+qAgbdGKy4qpyfFKilkgU6piDPmtIN/PbP2gZoOyt/sG2xvmU5zzDkxk+wKGQkjo4f/wqj8ZcULaAFxcvQPGdFJU78sQhar2vmrNc0n41Ct5tnTiqkSCGisxo51J0gyyukbY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5206.eurprd08.prod.outlook.com (2603:10a6:20b:e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 11:16:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 11:16:31 +0000
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: flatview_write_continue global mutex deadlock
Message-ID: <3abe8579-3540-72fd-c452-3cc52d7fcf26@virtuozzo.com>
Date: Thu, 3 Sep 2020 14:16:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 11:16:30 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e40c8ab-65da-45b7-b95a-08d84ffacf39
X-MS-TrafficTypeDiagnostic: AM6PR08MB5206:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5206B003E5A979A78FE8D24BC12C0@AM6PR08MB5206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgHs1LECkftBH3s27rZrSwu5bpYgk0O+JV1zCF+M08w3lHE0uH5iFPcg2xY8SiZMz0lKQyd+SzNyqby+7D1U5L9JENodrj3i37RB0y5p8WB46m2M77JQGfAym5X8HeuJ1kx+cW6c4NiFwanSXGzve4NIjTwfOSLVsg1U0FrNTy5E8ZzHH80OVrcuA4f/36bmv066+t9VpVKMlbDo34yWathOlKJ4Uy0gCGIQRRWxkht4y9sAWrEQEi+kW0ke2raxYxUtdxUldLhx74BUj7X5pWWShVu9g8IKtUH8AZyk7RMZQBQHjGz57G5DcgNKGbXcSqkA5X1LnQV+HOj5e9+CW48eDDyEsFeLqGQraumRhgL95Wn9A2P0jNn5GfbcYZiVX4yaj1PR8cyPmhMH43yxSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(2906002)(5660300002)(8676002)(4326008)(31686004)(36756003)(83380400001)(478600001)(8936002)(186003)(66556008)(54906003)(66476007)(26005)(31696002)(316002)(956004)(6486002)(6916009)(16576012)(52116002)(86362001)(66946007)(2616005)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2OARoucGjQr6N4u0qgaPRNWjKmZDpnFfk6kXT7nh3prCDzq2/NTpeqnrlt0TNj1xd4a+2yEgQrG8g7zlU2fcYnofU3Vwij/rXZufFCBxh+qGU0sj/ZN8aC32AF8JTNrFM+ECPYtoIBxhOFZk/VRxFv+luMAu3JDofhgsIkbraXejIe2GuvIvSZ4hE5dZ7l8INkNSBpa59AgQIoCyNzDvJsHPw3Y2YDBrKS/k4zaQUjajG5ZHoQF468HRuKk2FZHMRrXHwgv0nb4PXkhj/ASzFRK51PpiLcQ8dDMJSMmTVxcuHATbJSikh0iW7XHlOZLQVIrosnUWJnDQVatF21nYO/yW/Iow6MECoiu0v5tnr+pG03XoLt1lPbqTfzfufaiAhL+XKqE2+HjuLbsSEFONkaHiXbdAv0QJ2Qd6zqSMzmI34WwihZ/xchzqBbHGEbt7m0Nb2VY7mwHjPJTBNbfqQSe2PsblLWHZvEdiV8tR3Aqv/8qHJXXZnsHUZLdUlPPphzjMg57DC2yRD4x95Gy5D9za3Lf0lHWTn9vQ4TsVAYNm3AhxJWe0NyFwG0u44CskvFRWIaKVXHaiHPsEVM8Bq22QvzJZqiBYg74joWGQCEiWQGbgGYQmYxc8qAWUfwMvXhSosCsJyEg91hiYwO/7gg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e40c8ab-65da-45b7-b95a-08d84ffacf39
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 11:16:31.1404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj/awYgLFH346+zn2YE5ZHX1uHqvrFy/Ytp9H1F9XjMK7hosXPq80SxHRHVCS2lzp1vtqYc/HzpbY2GjEMw4UnOx8DG1zId3zcHhF4aBUA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5206
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 07:16:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi all!

I can trigger long io request with help of nbd reconnect-delay option, which make the request wait for some time for the connection to establish again and retry (of course, this works if connection is already lost). So, the request itself may be long. And this triggers the deadlock, which seems unrelated to nbd itself.

So, what I do:

1. Create an image:
    qemu-img create -f qcow2 xx 100M

2. Start NBD server:
    qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

   ./build/x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive     file=/work/images/cent7.qcow2 -drive driver=nbd,server.type=inet,server.host=192.168.100.5,server.port=10809,reconnect-delay=60     -vnc :0 -m 2G -enable-kvm -vga std


4. Access the vm through vnc (or some other way?), and check that NBD
    drive works:

    dd if=/dev/sdb of=/dev/null bs=1M count=10

    - the command should succeed.

5. Now, kill the nbd server, and run dd in the guest again:

    dd if=/dev/sdb of=/dev/null bs=1M count=10

Now Qemu is trying to reconnect, and dd-generated requests are waiting for the connection (they will wait up to 60 seconds (see reconnect-delay option above) and than fail). But suddenly, vm may totally hang in the deadlock. You may need to increase reconnect-delay period to catch the dead-lock.

Guest os is Centos 7.3.1611, kernel 3.10.0-514.el7.x86_64

The dead lock looks as follows:

(gdb) bt
#0  0x00007fb9d784f54d in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007fb9d784ae9b in _L_lock_883 () from /lib64/libpthread.so.0
#2  0x00007fb9d784ad68 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x000056069bfb3b06 in qemu_mutex_lock_impl (mutex=0x56069c7a3fe0 <qemu_global_mutex>, file=0x56069c24c79b "../util/main-loop.c", line=238) at ../util/qemu-thread-posix.c:79
#4  0x000056069bd00056 in qemu_mutex_lock_iothread_impl (file=0x56069c24c79b "../util/main-loop.c", line=238) at ../softmmu/cpus.c:1782
#5  0x000056069bfcfd6f in os_host_main_loop_wait (timeout=151823947) at ../util/main-loop.c:238
#6  0x000056069bfcfe7a in main_loop_wait (nonblocking=0) at ../util/main-loop.c:516
#7  0x000056069bd7777b in qemu_main_loop () at ../softmmu/vl.c:1676
#8  0x000056069b95fec2 in main (argc=13, argv=0x7fffd42bff08, envp=0x7fffd42bff78) at ../softmmu/main.c:50
(gdb) p qemu_global_mutex
$1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 215121, __nusers = 1, __kind = 0, __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
     __size = "\002\000\000\000\000\000\000\000QH\003\000\001", '\000' <repeats 26 times>, __align = 2}, file = 0x56069c1d597d "../exec.c", line = 3139, initialized = true}

exec.c:3139 is in prepare_mmio_access(), called from flatview_write_continue(). Let's check qemu_global_mutex owner thread:

(gdb) info thr
   Id   Target Id                                            Frame
* 1    Thread 0x7fb9f0f39e00 (LWP 215115) "qemu-system-x86" 0x00007fb9d784f54d in __lll_lock_wait () from /lib64/libpthread.so.0
   2    Thread 0x7fb9ca20e700 (LWP 215116) "qemu-system-x86" 0x00007fb9d756bbf9 in syscall () from /lib64/libc.so.6
   3    Thread 0x7fb9481ff700 (LWP 215121) "qemu-system-x86" 0x00007fb9d7566cff in ppoll () from /lib64/libc.so.6
   4    Thread 0x7fb9461ff700 (LWP 215123) "qemu-system-x86" 0x00007fb9d784ca35 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
(gdb) thr 3
[Switching to thread 3 (Thread 0x7fb9481ff700 (LWP 215121))]
#0  0x00007fb9d7566cff in ppoll () from /lib64/libc.so.6
(gdb) bt
#0  0x00007fb9d7566cff in ppoll () from /lib64/libc.so.6
#1  0x000056069bfbd3f1 in qemu_poll_ns (fds=0x7fb9401dcdf0, nfds=1, timeout=542076652475) at ../util/qemu-timer.c:347
#2  0x000056069bfd949f in fdmon_poll_wait (ctx=0x56069e6864c0, ready_list=0x7fb9481fc200, timeout=542076652475) at ../util/fdmon-poll.c:79
#3  0x000056069bfcdf4c in aio_poll (ctx=0x56069e6864c0, blocking=true) at ../util/aio-posix.c:601
#4  0x000056069be80cf3 in bdrv_do_drained_begin (bs=0x56069e6c0950, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at ../block/io.c:427
#5  0x000056069be80ddb in bdrv_drained_begin (bs=0x56069e6c0950) at ../block/io.c:433
#6  0x000056069bf1e5b4 in blk_drain (blk=0x56069e6adb50) at ../block/block-backend.c:1718
#7  0x000056069ba40fb5 in ide_cancel_dma_sync (s=0x56069f0d1548) at ../hw/ide/core.c:723
#8  0x000056069bb90d29 in bmdma_cmd_writeb (bm=0x56069f0d22d0, val=8) at ../hw/ide/pci.c:298
#9  0x000056069b9fa529 in bmdma_write (opaque=0x56069f0d22d0, addr=0, val=8, size=1) at ../hw/ide/piix.c:75
#10 0x000056069bd5d9d5 in memory_region_write_accessor (mr=0x56069f0d2420, addr=0, value=0x7fb9481fc4d8, size=1, shift=0, mask=255, attrs=...) at ../softmmu/memory.c:483
#11 0x000056069bd5dbf3 in access_with_adjusted_size (addr=0, value=0x7fb9481fc4d8, size=1, access_size_min=1, access_size_max=4, access_fn=0x56069bd5d8f6 <memory_region_write_accessor>, mr=0x56069f0d2420,
     attrs=...) at ../softmmu/memory.c:544
#12 0x000056069bd60bda in memory_region_dispatch_write (mr=0x56069f0d2420, addr=0, data=8, op=MO_8, attrs=...) at ../softmmu/memory.c:1465
#13 0x000056069bd965e2 in flatview_write_continue (fv=0x7fb9401ce100, addr=49152, attrs=..., ptr=0x7fb9f0f87000, len=1, addr1=0, l=1, mr=0x56069f0d2420) at ../exec.c:3176
#14 0x000056069bd9673a in flatview_write (fv=0x7fb9401ce100, addr=49152, attrs=..., buf=0x7fb9f0f87000, len=1) at ../exec.c:3216
#15 0x000056069bd96aae in address_space_write (as=0x56069c7a5940 <address_space_io>, addr=49152, attrs=..., buf=0x7fb9f0f87000, len=1) at ../exec.c:3307
#16 0x000056069bd96b20 in address_space_rw (as=0x56069c7a5940 <address_space_io>, addr=49152, attrs=..., buf=0x7fb9f0f87000, len=1, is_write=true) at ../exec.c:3317
#17 0x000056069bd07f06 in kvm_handle_io (port=49152, attrs=..., data=0x7fb9f0f87000, direction=1, size=1, count=1) at ../accel/kvm/kvm-all.c:2262
#18 0x000056069bd086db in kvm_cpu_exec (cpu=0x56069e6cdb30) at ../accel/kvm/kvm-all.c:2508
#19 0x000056069bcfef84 in qemu_kvm_cpu_thread_fn (arg=0x56069e6cdb30) at ../softmmu/cpus.c:1188
#20 0x000056069bfb4681 in qemu_thread_start (args=0x56069e6f4860) at ../util/qemu-thread-posix.c:521
#21 0x00007fb9d7848ea5 in start_thread () from /lib64/libpthread.so.0
#22 0x00007fb9d75718dd in clone () from /lib64/libc.so.6


(gdb) fr 13
#13 0x000056069bd965e2 in flatview_write_continue (fv=0x7fb9401ce100, addr=49152, attrs=..., ptr=0x7fb9f0f87000, len=1, addr1=0, l=1, mr=0x56069f0d2420) at ../exec.c:3176
3176                result |= memory_region_dispatch_write(mr, addr1, val,
(gdb) list
3171                release_lock |= prepare_mmio_access(mr);
3172                l = memory_access_size(mr, l, addr1);
3173                /* XXX: could force current_cpu to NULL to avoid
3174                   potential bugs */
3175                val = ldn_he_p(buf, l);
3176                result |= memory_region_dispatch_write(mr, addr1, val,
3177                                                       size_memop(l), attrs);
3178            } else {
3179                /* RAM case */
3180                ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
(gdb) p release_lock
$2 = true


So, global mutex is locked in flatview_write_continue, and on the path we have blk_drain and wait for some requests (actually nbd requests, waiting for connection, but this shouldn't matter). In the same time main thread waits on global mutex, so it's impossible to proceed with these nbd requests. Deadlock..

Paolo could you please help with it? Or who can? I know nothing about exec.c code :(

Side idea about nbd-reconnect feature: probably we should drop (finish with failure) all the requests waiting for reconnect in .bdrv_co_drain_begin handler of nbd driver. But I'm not sure: it will break reconnect feature if drain() is often event.

-- 
Best regards,
Vladimir

