Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F1C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128F720772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sc1yFK2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128F720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH54a-0004wS-7k
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH53v-0004Xq-Hn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH53s-0005tR-7q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:23:10 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:40175 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH53r-0005rr-ES
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHlHgT9RwB1V5hPIbDH2hUEb9gtrphRjIjnCuwKGDqsUdlm0bxiXVnT/R6FhLYatBw4+uzKG/zyBCWFbf2kkbc0JS84nbtdeqTA2KYMtG9/KlUHRp++LtVQ9S209qCWLEGdDzzgrJjSAf4PvJxXKMygpIZyNhn7EYJ4Y67FItmCSGydNVvJc+qFnHS26TZY3dY2Zyea+Kts44MHHPhS8ldWO0FuOa6kNEO+PjZ4/WC/9S8/8uhUXdzRgBKE034ukfFbweVX8Hx8Hv/ok8iB8eajpzCUkZIIySdzZd3UC9HCf8SJrHFwUVBMfZrWbof7UnDCHNzl11LOtss5o+hudKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aktlFIGJLmG4MPLICGCApCUwP2hiU+YthkiHak9R+XY=;
 b=nYeJBdGRThnX4SM3l+OxgRHPwVEmEPITjbUOnejDEbioFoLW8DdD2OQjnDRS5p7asNM848K5lIJGxoufu3D1+SkDk/ScBHvSosBop2BX2nfqfga4vAYtKL8HbteQscgMdLpsXKJ/KhkjCEXflhHpZBJ4GEZlVPz9p4ohZZr90/ivRC+FoOaJwgenPYZXbXzzUILS0MQVOKLVLxPlU3esf9tHhYk4qI3iGbX8WHI2pvQ0Qgh4NjRaU21VoIN4lxfhZNqAk1lTcsk2VPjRsPjihZQ8IjQ85MwVTyT8sC/HQwK+sgFfrUO0pLxylPmrb0oKReHQzJ6gItC+cUElC9OyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aktlFIGJLmG4MPLICGCApCUwP2hiU+YthkiHak9R+XY=;
 b=sc1yFK2cL++gcEyPD/9DALEhm8V+JUqvhKMzQdi/1FemLLRIS3C/THWkXuwMbcjN/NyZ19aCNsnDR3BSUjqBArcJiWq8aAVq5Ccvc8kzdZs7xb8Fws5DZe6Hl0LXesLtR5Rj1Z5Lx7HOxYubAFye1c+17UbBRNAfQmKxajXZnEc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 12:23:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 12:23:04 +0000
Subject: Re: backup transaction with io-thread core dumps
To: Stefan Reiter <s.reiter@proxmox.com>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
 <1187924316.77.1585068555273@webmail.proxmox.com>
 <e1a10c51-cf7f-0724-f61a-f6a82ebd9da2@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200325152302747
Message-ID: <76edbead-7ccf-833b-a3f2-15dff7f0748c@virtuozzo.com>
Date: Wed, 25 Mar 2020 15:23:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e1a10c51-cf7f-0724-f61a-f6a82ebd9da2@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 12:23:04 +0000
X-Tagtoolbar-Keys: D20200325152302747
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03fdc41-22c3-4923-2616-08d7d0b744b3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527F374861787B1967FE622C1CE0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(316002)(956004)(6916009)(2616005)(5660300002)(8936002)(16526019)(54906003)(53546011)(2906002)(186003)(52116002)(26005)(16576012)(31686004)(966005)(4326008)(478600001)(81166006)(81156014)(36756003)(6486002)(31696002)(8676002)(66556008)(86362001)(30864003)(66946007)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5527;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNsRkOAToTS2p+W4Gn523ls2sTmUz4moDDJ22yv7ED38qSdfSbSOEEYCeZXZN9CkOnM+r43lyNXaURTH0UyEARwE9vmy5c4pO4ChDIKt/nzmC+0nCIPbsrdU+Dw6qphoyxNnfcBhFWLtbNhEvtA3Ap8ebbOswcV4kPMR8xSvpEBw+FOlouD2g0UPsupiYsSDlUGJ/sjh21hwVf7fLbWs51AFGol26xZ4E0/VjHWsxUxoNA0j14OBRWKcszB4NiEIdnaYLHq9+qPFI6HVF022VrBpFvWY3EXy7hzjWPo2dB5bzgDifp0L0h7x2Sz74qHpx3mvsurfdgD0SAW8r/+R5Mme6+eaxKFEDSIlDvic1QEo+WYnkNl6uhljFnMOl14lrkv/6NJvDJ52ZfknhYCAyoD+hhuVrFgSBy+64jC5NBFJFAIkEfdA27PWGx2bJNEk06ryPByZ2CY/39X0h+KwtVKNHIaFzIdEfc/nATR0ud6pt3ppbnmqf8PAFDzEwfqGi36GCWklddfX7RBYYruRzw==
X-MS-Exchange-AntiSpam-MessageData: RMtmq08STlHq9j2VpDO+e/UOF/liGAJSbC9qz43DvNWQr2oiSIGoioDj7bdR09eX30kqKVUoOQtorLnnPidhdK7+hsAx59Nxv2ehocRL070tbmG6KGy0um243depL6zBpAQFqKCPpldpvNAQvx71bw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03fdc41-22c3-4923-2616-08d7d0b744b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 12:23:04.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYRUZcbAgfY9xaoZ7xKGyUgBQJiN1zMFoRcwCi/myBoomxYVbhYHzuR5+hjeEgRXRz0Lv0DNOzWVtlfTkk8eOGpOJFIpj95/4Ll7p7/h1xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.103
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.03.2020 14:40, Stefan Reiter wrote:
> On 24/03/2020 17:49, Dietmar Maurer wrote:
>> A more serious issue is that I also get a hang inside the poll loop
>> when the VM is under load. For example, running "stress -d 5" inside
>> the VM (Debian Buster).
>>
>> Then running a simply drive-backup like:
>>
>> { "execute": "drive-backup", "arguments": { "device": "drive-scsi0", "sy=
nc": "full", "target": "backup-scsi0.raw" } }
>>
>> At the end of the backup, VM hangs, gdb says:
>>
>> (gdb) bt
>> #0=C2=A0 0x00007ffff5cb3916 in __GI_ppoll (fds=3D0x7fff63d35c40, nfds=3D=
2, timeout=3D<optimized out>,
>> =C2=A0=C2=A0=C2=A0=C2=A0 timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D=
0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:39
>> #1=C2=A0 0x0000555555c5f2c9 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfd=
s=3D<optimized out>, __fds=3D<optimized out>)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at /usr/include/x86_64-linux-gnu/bits/poll2.h:7=
7
>> #2=C2=A0 0x0000555555c5f2c9 in qemu_poll_ns (fds=3D<optimized out>, nfds=
=3D<optimized out>, timeout=3Dtimeout@entry=3D-1)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at util/qemu-timer.c:335
>> #3=C2=A0 0x0000555555c61ab1 in fdmon_poll_wait (ctx=3D0x7fffe8905e80, re=
ady_list=3D0x7fffffffdc68, timeout=3D-1)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at util/fdmon-poll.c:79
>> #4=C2=A0 0x0000555555c61097 in aio_poll (ctx=3D0x7fffe8905e80, blocking=
=3Dblocking@entry=3Dtrue) at util/aio-posix.c:589
>> #5=C2=A0 0x0000555555bc2243 in bdrv_do_drained_begin
>> =C2=A0=C2=A0=C2=A0=C2=A0 (poll=3D<optimized out>, ignore_bds_parents=3Df=
alse, parent=3D0x0, recursive=3Dfalse, bs=3D0x7fff671c11c0) at block/io.c:4=
29
>> #6=C2=A0 0x0000555555bc2243 in bdrv_do_drained_begin
>> =C2=A0=C2=A0=C2=A0=C2=A0 (bs=3D0x7fff671c11c0, recursive=3D<optimized ou=
t>, parent=3D0x0, ignore_bds_parents=3D<optimized out>, poll=3D<optimized o=
ut>)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at block/io.c:395
>> #7=C2=A0 0x0000555555bdd132 in bdrv_backup_top_drop (bs=3D0x7fff671c11c0=
) at block/backup-top.c:273
>> #8=C2=A0 0x0000555555bd883c in backup_clean (job=3D0x7fffe5609a00) at bl=
ock/backup.c:114
>> #9=C2=A0 0x0000555555b6d46d in job_clean (job=3D0x7fffe5609a00) at job.c=
:657
>> #10 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at =
job.c:673
>> #11 0x0000555555b6d46d in job_finalize_single (job=3D0x7fffe5609a00) at =
job.c:661
>> #12 0x0000555555b6dedc in job_txn_apply (txn=3D<optimized out>, fn=3D0x5=
55555b6d420 <job_finalize_single>) at job.c:145
>> #13 0x0000555555b6dedc in job_do_finalize (job=3D0x7fffe5609a00) at job.=
c:782
>> #14 0x0000555555b6e131 in job_completed_txn_success (job=3D0x7fffe5609a0=
0) at job.c:832
>> #15 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c:=
845
>> #16 0x0000555555b6e131 in job_completed (job=3D0x7fffe5609a00) at job.c:=
836
>> #17 0x0000555555b6e190 in job_exit (opaque=3D0x7fffe5609a00) at job.c:86=
4
>> #18 0x0000555555c5d855 in aio_bh_call (bh=3D0x7fffe721a3c0) at util/asyn=
c.c:164
>> #19 0x0000555555c5d855 in aio_bh_poll (ctx=3Dctx@entry=3D0x7fffe8905e80)=
 at util/async.c:164
>> #20 0x0000555555c60ede in aio_dispatch (ctx=3D0x7fffe8905e80) at util/ai=
o-posix.c:380
>> #21 0x0000555555c5d73e in aio_ctx_dispatch (source=3D<optimized out>, ca=
llback=3D<optimized out>, user_data=3D<optimized out>)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at util/async.c:298
>> #22 0x00007ffff7c7ef2e in g_main_context_dispatch () at /usr/lib/x86_64-=
linux-gnu/libglib-2.0.so.0
>> #23 0x0000555555c60148 in glib_pollfds_poll () at util/main-loop.c:219
>> #24 0x0000555555c60148 in os_host_main_loop_wait (timeout=3D<optimized o=
ut>) at util/main-loop.c:242
>> #25 0x0000555555c60148 in main_loop_wait (nonblocking=3Dnonblocking@entr=
y=3D0) at util/main-loop.c:518
>> #26 0x00005555558fc579 in qemu_main_loop () at /home/dietmar/pve5-devel/=
mirror_qemu/softmmu/vl.c:1665
>> #27 0x0000555555800c2e in main (argc=3D<optimized out>, argv=3D<optimize=
d out>, envp=3D<optimized out>)
>> =C2=A0=C2=A0=C2=A0=C2=A0 at /home/dietmar/pve5-devel/mirror_qemu/softmmu=
/main.c:49
>>
>> The VM uses a similar hardware setup with io-threads as the previous
>> example.
>>
>> Is somebody able to reproduce that? And ideas whats wrong here?
>>
>=20
> Can't speak for the original issue, but this one I can reproduce exactly =
as you say: main thread hangs at the end of a backup job of a drive that us=
es IO threads, when said drive is under load. Single disk, raw-file backed.
>=20
> I've bisected the issue to commit 00e30f05de1d ("block/backup: use backup=
-top instead of write notifiers") - CC'ing Vladimir, since he wrote that on=
e. Before that patch, backup works fine.
>=20
>=20
> For completeness, here's the trace I get on my machine (latest master) wh=
en everything's stuck, Thread 1 is the main thread, 3 the IO thread for the=
 drive:
>=20
> Thread 1 (Thread 0x7ffff5d20680 (LWP 958009)):
> #0=C2=A0=C2=A0=C2=A0 0x00007ffff6cf2916 in __GI_ppoll (fds=3D0x7ffff4a0c2=
c0, nfds=3D0x2, timeout=3D<optimized out>, sigmask=3D0x0) at ../sysdeps/uni=
x/sysv/linux/ppoll.c:39
> #1=C2=A0=C2=A0=C2=A0 0x0000555555dba2dd in qemu_poll_ns (fds=3D0x7ffff4a0=
c2c0, nfds=3D0x2, timeout=3D0xffffffffffffffff) at util/qemu-timer.c:335
> #2=C2=A0=C2=A0=C2=A0 0x0000555555dbdb1d in fdmon_poll_wait (ctx=3D0x7ffff=
49e3380, ready_list=3D0x7fffffffdab0, timeout=3D0xffffffffffffffff) at util=
/fdmon-poll.c:79
> #3=C2=A0=C2=A0=C2=A0 0x0000555555dbd48d in aio_poll (ctx=3D0x7ffff49e3380=
, blocking=3D0x1) at util/aio-posix.c:589
> #4=C2=A0=C2=A0=C2=A0 0x0000555555cf5a83 in bdrv_do_drained_begin (bs=3D0x=
7fffd1577180, recursive=3D0x0, parent=3D0x0, ignore_bds_parents=3D0x0, poll=
=3D0x1) at block/io.c:429

So we wait for some request, as we want to drain... And we are in BDRV_POLL=
_WHILE loop, which should release aio context before aio_poll() call. So it=
's strange that thread 3 hangs.
Do we loop in BDRV_POLL_WHILE, or we are really hang here?

You may print bs->tracked_requests, to see which requests we are waiting fo=
r. Requests has co pointers to their coroutines, which may be examined by

gdb> source scripts/qemu-gdb.py
gdb> qemu coroutine <coroutine-pointer>


> #5=C2=A0=C2=A0=C2=A0 0x0000555555cf5aef in bdrv_drained_begin (bs=3D0x7ff=
fd1577180) at block/io.c:435
> #6=C2=A0=C2=A0=C2=A0 0x0000555555d1b135 in bdrv_backup_top_drop (bs=3D0x7=
fffd1577180) at block/backup-top.c:273
> #7=C2=A0=C2=A0=C2=A0 0x0000555555d14734 in backup_clean (job=3D0x7ffff49f=
ba00) at block/backup.c:132
> #8=C2=A0=C2=A0=C2=A0 0x0000555555c81be5 in job_clean (job=3D0x7ffff49fba0=
0) at job.c:656
> #9=C2=A0=C2=A0=C2=A0 0x0000555555c81c60 in job_finalize_single (job=3D0x7=
ffff49fba00) at job.c:672
> #10=C2=A0=C2=A0 0x0000555555c80830 in job_txn_apply (txn=3D0x7fffd1576a80=
, fn=3D0x555555c81be8 <job_finalize_single>) at job.c:145
> #11=C2=A0=C2=A0 0x0000555555c82017 in job_do_finalize (job=3D0x7ffff49fba=
00) at job.c:781
> #12=C2=A0=C2=A0 0x0000555555c821b4 in job_completed_txn_success (job=3D0x=
7ffff49fba00) at job.c:831
> #13=C2=A0=C2=A0 0x0000555555c82254 in job_completed (job=3D0x7ffff49fba00=
) at job.c:844
> #14=C2=A0=C2=A0 0x0000555555c822a3 in job_exit (opaque=3D0x7ffff49fba00) =
at job.c:863
> #15=C2=A0=C2=A0 0x0000555555db78a0 in aio_bh_call (bh=3D0x7ffff3c0d240) a=
t util/async.c:136
> #16=C2=A0=C2=A0 0x0000555555db79aa in aio_bh_poll (ctx=3D0x7ffff49e3380) =
at util/async.c:164
> #17=C2=A0=C2=A0 0x0000555555dbcdae in aio_dispatch (ctx=3D0x7ffff49e3380)=
 at util/aio-posix.c:380
> #18=C2=A0=C2=A0 0x0000555555db7dbc in aio_ctx_dispatch (source=3D0x7ffff4=
9e3380, callback=3D0x0, user_data=3D0x0) at util/async.c:298
> #19=C2=A0=C2=A0 0x00007ffff7c8ff2e in g_main_context_dispatch + 0x2ae () =
at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #20=C2=A0=C2=A0 0x0000555555dbb360 in glib_pollfds_poll () at util/main-l=
oop.c:219
> #21=C2=A0=C2=A0 0x0000555555dbb3da in os_host_main_loop_wait (timeout=3D0=
x3b9aca00) at util/main-loop.c:242
> #22=C2=A0=C2=A0 0x0000555555dbb4df in main_loop_wait (nonblocking=3D0x0) =
at util/main-loop.c:518
> #23=C2=A0=C2=A0 0x0000555555947478 in qemu_main_loop () at /root/qemu/sof=
tmmu/vl.c:1665
> #24=C2=A0=C2=A0 0x0000555555d58ddf in main (argc=3D0x15, argv=3D0x7ffffff=
fe058, envp=3D0x7fffffffe108) at /root/qemu/softmmu/main.c:49
>=20
> Thread 3 (Thread 0x7ffff497e700 (LWP 958039)):

Print the mutex content, to see who holds it.

> #0=C2=A0=C2=A0=C2=A0 0x00007ffff6dd629c in __lll_lock_wait + 0x1c () at .=
./sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
> #1=C2=A0=C2=A0=C2=A0 0x00007ffff6dcf7d1 in __GI___pthread_mutex_lock (mut=
ex=3D0x7ffff49e36e0) at ../nptl/pthread_mutex_lock.c:115
> #2=C2=A0=C2=A0=C2=A0 0x0000555555dc0ad7 in qemu_mutex_lock_impl (mutex=3D=
0x7ffff49e36e0, file=3D0x555555f66501 "util/async.c", line=3D0x254) at util=
/qemu-thread-posix.c:78
> #3=C2=A0=C2=A0=C2=A0 0x0000555555db872e in aio_context_acquire (ctx=3D0x7=
ffff49e3680) at util/async.c:596
> #4=C2=A0=C2=A0=C2=A0 0x0000555555db905e in thread_pool_completion_bh (opa=
que=3D0x7ffff3c0c000) at util/thread-pool.c:167
> #5=C2=A0=C2=A0=C2=A0 0x0000555555db78a0 in aio_bh_call (bh=3D0x7ffff49d7f=
20) at util/async.c:136
> #6=C2=A0=C2=A0=C2=A0 0x0000555555db79aa in aio_bh_poll (ctx=3D0x7ffff49e3=
680) at util/async.c:164
> #7=C2=A0=C2=A0=C2=A0 0x0000555555dbd673 in aio_poll (ctx=3D0x7ffff49e3680=
, blocking=3D0x1) at util/aio-posix.c:638
> #8=C2=A0=C2=A0=C2=A0 0x00005555559d7611 in iothread_run (opaque=3D0x7ffff=
49b1c80) at iothread.c:75
> #9=C2=A0=C2=A0=C2=A0 0x0000555555dc1650 in qemu_thread_start (args=3D0x7f=
fff58ea480) at util/qemu-thread-posix.c:519
> #10=C2=A0=C2=A0 0x00007ffff6dccfa3 in start_thread (arg=3D<optimized out>=
) at pthread_create.c:486
> #11=C2=A0=C2=A0 0x00007ffff6cfd4cf in clone + 0x3f () at ../sysdeps/unix/=
sysv/linux/x86_64/clone.S:95
>=20
>>> On March 24, 2020 2:47 PM Max Reitz <mreitz@redhat.com> wrote:
>>>
>>> Hi Dietmar,
>>>
>>> I assume this is with master and has popped up only recently?
>>>
>>> Maybe it has something to do with the recent mutex patches by Stefan, s=
o
>>> I=E2=80=99m Cc-ing him.
>>>
>>> Max
>>>
>>> On 24.03.20 14:33, Dietmar Maurer wrote:
>>>> spoke too soon - the error is still there, sigh
>>>>> This is fixed with this patch:
>>>>>
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07249.html
>>>>>
>>>>> thanks!
>>>>>
>>>>>> On March 24, 2020 12:13 PM Dietmar Maurer <dietmar@proxmox.com> wrot=
e:
>>>>>>
>>>>>> I get a core dump with backup transactions when using io-threads.
>>>>>>
>>>>>> To reproduce, create and start a VM with:
>>>>>>
>>>>>> # qemu-img create disk1.raw 100M
>>>>>> # qemu-img create disk2.raw 100M
>>>>>> #./x86_64-softmmu/qemu-system-x86_64 -chardev 'socket,id=3Dqmp,path=
=3D/var/run/qemu-test.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontrol=
' -pidfile /var/run/qemu-server/108.pid=C2=A0 -m 512 -object 'iothread,id=
=3Diothread-virtioscsi0' -object 'iothread,id=3Diothread-virtioscsi1'=C2=A0=
 -device 'virtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0'=
 -drive 'file=3Ddisk1.raw,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3Dn=
one,aio=3Dnative,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi0.0,c=
hannel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0,id=3Dscsi0' -device 'vir=
tio-scsi-pci,id=3Dvirtioscsi1,iothread=3Diothread-virtioscsi1' -drive 'file=
=3Ddisk2.raw,if=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3Dnone,aio=3Dnat=
ive,detect-zeroes=3Don' -device 'scsi-hd,bus=3Dvirtioscsi1.0,channel=3D0,sc=
si-id=3D0,lun=3D1,drive=3Ddrive-scsi1,id=3Dscsi1'
>>>>>>
>>>>>> Then open socat to the qmp socket
>>>>>> # socat /var/run/qemu-test.qmp -
>>>>>>
>>>>>> And run the following qmp command:
>>>>>>
>>>>>> { "execute": "qmp_capabilities", "arguments": {} }
>>>>>> { "execute": "transaction", "arguments":=C2=A0 { "actions": [{ "type=
": "drive-backup", "data": { "device": "drive-scsi0", "sync": "full", "targ=
et": "backup-sysi0.raw" }}, { "type": "drive-backup", "data": { "device": "=
drive-scsi1", "sync": "full", "target": "backup-scsi1.raw" }}], "properties=
": { "completion-mode": "grouped" } } }
>>>>>>
>>>>>> The VM will core dump:
>>>>>>
>>>>>> qemu: qemu_mutex_unlock_impl: Operation not permitted
>>>>>> Aborted (core dumped)
>>>>>> (gdb) bt
>>>>>> #0=C2=A0 0x00007f099d5037bb in __GI_raise (sig=3Dsig@entry=3D6) at .=
./sysdeps/unix/sysv/linux/raise.c:50
>>>>>> #1=C2=A0 0x00007f099d4ee535 in __GI_abort () at abort.c:79
>>>>>> #2=C2=A0 0x000055c04e39525e in error_exit (err=3D<optimized out>, ms=
g=3Dmsg@entry=3D0x55c04e5122e0 <__func__.16544> "qemu_mutex_unlock_impl") a=
t util/qemu-thread-posix.c:36
>>>>>> #3=C2=A0 0x000055c04e395813 in qemu_mutex_unlock_impl (mutex=3Dmutex=
@entry=3D0x7f09903154e0, file=3Dfile@entry=3D0x55c04e51129f "util/async.c",=
 line=3Dline@entry=3D601)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at util/qemu-thread-posix.c:108
>>>>>> #4=C2=A0 0x000055c04e38f8e5 in aio_context_release (ctx=3Dctx@entry=
=3D0x7f0990315480) at util/async.c:601
>>>>>> #5=C2=A0 0x000055c04e299073 in bdrv_set_aio_context_ignore (bs=3D0x7=
f0929a76500, new_context=3Dnew_context@entry=3D0x7f0990315000, ignore=3Dign=
ore@entry=3D0x7ffe08fa7400)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at block.c:6238
>>>>>> #6=C2=A0 0x000055c04e2990cc in bdrv_set_aio_context_ignore (bs=3Dbs@=
entry=3D0x7f092af47900, new_context=3Dnew_context@entry=3D0x7f0990315000, i=
gnore=3Dignore@entry=3D0x7ffe08fa7400)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at block.c:6211
>>>>>> #7=C2=A0 0x000055c04e299443 in bdrv_child_try_set_aio_context (bs=3D=
bs@entry=3D0x7f092af47900, ctx=3D0x7f0990315000, ignore_child=3Dignore_chil=
d@entry=3D0x0, errp=3Derrp@entry=3D0x0)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at block.c:6324
>>>>>> #8=C2=A0 0x000055c04e299576 in bdrv_try_set_aio_context (errp=3D0x0,=
 ctx=3D<optimized out>, bs=3D0x7f092af47900) at block.c:6333
>>>>>> #9=C2=A0 0x000055c04e299576 in bdrv_replace_child (child=3Dchild@ent=
ry=3D0x7f09902ef5e0, new_bs=3Dnew_bs@entry=3D0x0) at block.c:2551
>>>>>> #10 0x000055c04e2995ff in bdrv_detach_child (child=3D0x7f09902ef5e0)=
 at block.c:2666
>>>>>> #11 0x000055c04e299ec9 in bdrv_root_unref_child (child=3D<optimized =
out>) at block.c:2677
>>>>>> #12 0x000055c04e29f3fe in block_job_remove_all_bdrv (job=3Djob@entry=
=3D0x7f0927c18800) at blockjob.c:191
>>>>>> #13 0x000055c04e29f429 in block_job_free (job=3D0x7f0927c18800) at b=
lockjob.c:88
>>>>>> #14 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:=
359
>>>>>> #15 0x000055c04e2a0909 in job_unref (job=3D0x7f0927c18800) at job.c:=
351
>>>>>> #16 0x000055c04e2a0b68 in job_conclude (job=3D0x7f0927c18800) at job=
.c:620
>>>>>> #17 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800)=
 at job.c:688
>>>>>> #18 0x000055c04e2a0b68 in job_finalize_single (job=3D0x7f0927c18800)=
 at job.c:660
>>>>>> #19 0x000055c04e2a14fc in job_txn_apply (txn=3D<optimized out>, fn=
=3D0x55c04e2a0a50 <job_finalize_single>) at job.c:145
>>>>>> #20 0x000055c04e2a14fc in job_do_finalize (job=3D0x7f0927c1c200) at =
job.c:781
>>>>>> #21 0x000055c04e2a1751 in job_completed_txn_success (job=3D0x7f0927c=
1c200) at job.c:831
>>>>>> #22 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at jo=
b.c:844
>>>>>> #23 0x000055c04e2a1751 in job_completed (job=3D0x7f0927c1c200) at jo=
b.c:835
>>>>>> #24 0x000055c04e2a17b0 in job_exit (opaque=3D0x7f0927c1c200) at job.=
c:863
>>>>>> #25 0x000055c04e38ee75 in aio_bh_call (bh=3D0x7f098ec52000) at util/=
async.c:164
>>>>>> #26 0x000055c04e38ee75 in aio_bh_poll (ctx=3Dctx@entry=3D0x7f0990315=
000) at util/async.c:164
>>>>>> #27 0x000055c04e3924fe in aio_dispatch (ctx=3D0x7f0990315000) at uti=
l/aio-posix.c:380
>>>>>> #28 0x000055c04e38ed5e in aio_ctx_dispatch (source=3D<optimized out>=
, callback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:=
298
>>>>>> #29 0x00007f099f020f2e in g_main_context_dispatch () at /usr/lib/x86=
_64-linux-gnu/libglib-2.0.so.0
>>>>>> #30 0x000055c04e391768 in glib_pollfds_poll () at util/main-loop.c:2=
19
>>>>>> #31 0x000055c04e391768 in os_host_main_loop_wait (timeout=3D<optimiz=
ed out>) at util/main-loop.c:242
>>>>>> #32 0x000055c04e391768 in main_loop_wait (nonblocking=3Dnonblocking@=
entry=3D0) at util/main-loop.c:518
>>>>>> #33 0x000055c04e032329 in qemu_main_loop () at /home/dietmar/pve5-de=
vel/mirror_qemu/softmmu/vl.c:1665
>>>>>> #34 0x000055c04df36a8e in main (argc=3D<optimized out>, argv=3D<opti=
mized out>, envp=3D<optimized out>) at /home/dietmar/pve5-devel/mirror_qemu=
/softmmu/main.c:49
>=20


--=20
Best regards,
Vladimir

