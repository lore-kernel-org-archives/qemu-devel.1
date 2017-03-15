Received: from eggs.gnu.org ([2001:4830:134:3::10]:48918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coBbH-0000Jf-Aj
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coBbD-0004yK-KB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:34631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coBbD-0004xp-9s
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coBbB-00017z-Uh
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 16:16:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E653D2E80CA
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 16:16:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Mar 2017 16:08:26 -0000
From: Mohammed Gamal <m.gamal005@gmail.com>
Reply-To: Bug 1673130 <1673130@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170315160255.23768.27906.malonedeb@gac.canonical.com>
Message-Id: <20170315160826.23332.31258.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673130] Re: qemu 2.7.0 receives SIGABRT in
 qemu_coroutine_enter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Third stack trace:

--------------------------------------------------------------------------
#0  0x00007f4d5ad6a067 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007f4d5ad6b448 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x0000562a4c582b6c in qemu_coroutine_enter (co=3D0x7f4b1bf0a900) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
#3  0x0000562a4c582e55 in qemu_co_queue_run_restart (co=3D0x7f4b1bf0a830) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#4  0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1bf0a830) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#5  0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b1bf0f4c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#6  0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1bf0f4c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#7  0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e07c40) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#8  0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e07c40) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#9  0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e11420) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#10 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e11420) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#11 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e18c30) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#12 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e18c30) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#13 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b1bf07ea0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#14 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1bf07ea0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#15 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b1000c0c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#16 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1000c0c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#17 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e11b10) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#18 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e11b10) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#19 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e10500) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#20 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e10500) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#21 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b1bf0a610) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#22 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1bf0a610) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#23 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e12820) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#24 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e12820) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#25 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b10002b10) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#26 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b10002b10) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#27 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b1000bfb0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#28 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1000bfb0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#29 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e103f0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#30 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e103f0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#31 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e078b0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#32 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e078b0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#33 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4adfe02b00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#34 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4adfe02b00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#35 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b15701ae0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#36 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b15701ae0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#37 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e162f0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#38 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e162f0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#39 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b10009fe0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#40 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b10009fe0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#41 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0b860) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#42 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0b860) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#43 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b23f035c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#44 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b23f035c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#45 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b19e030c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#46 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b19e030c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#47 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b100051b0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#48 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b100051b0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#49 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4adfe03970) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#50 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4adfe03970) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#51 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e11a00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#52 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e11a00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#53 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0e0a0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#54 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0e0a0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#55 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0ede0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#56 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0ede0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#57 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4aeff00860) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#58 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4aeff00860) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
---Type <return> to continue, or q <return> to quit---
#59 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0d6f0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#60 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0d6f0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#61 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0e490) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#62 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0e490) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#63 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e17370) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#64 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e17370) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#65 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e15c40) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#66 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e15c40) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#67 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b07f00a80) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#68 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b07f00a80) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#69 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b15703250) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#70 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b15703250) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#71 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e17870) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#72 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e17870) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#73 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b15703140) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#74 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b15703140) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#75 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e0c210) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#76 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e0c210) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#77 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e08650) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#78 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e08650) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#79 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e07470) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#80 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e07470) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#81 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b15e03a10) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#82 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b15e03a10) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#83 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e11d90) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#84 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e11d90) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#85 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4b17e13d00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#86 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b17e13d00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#87 0x0000562a4c582e74 in qemu_co_queue_run_restart (co=3D0x7f4afbe02b00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#88 0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4afbe02b00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#89 0x0000562a4c582fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x562a4=
d8e65e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:=
106
#90 0x0000562a4c521060 in timer_cb (blk=3D0x562a4d8e6590, is_write=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c:4=
00
#91 0x0000562a4c4de615 in timerlist_run_timers (timer_list=3D0x562a4d952d40=
) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
#92 0x0000562a4c4de679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x56=
2a4ecd0758) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
#93 0x0000562a4c4def47 in aio_dispatch (ctx=3Dctx@entry=3D0x562a4ecd0610) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
#94 0x0000562a4c4df0e8 in aio_poll (ctx=3D0x562a4ecd0610, blocking=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
#95 0x0000562a4c340c79 in iothread_run (opaque=3D0x562a4ecd03c0) at /build/=
pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
#96 0x00007f4d5b0e80a4 in start_thread () from /lib/x86_64-linux-gnu/libpth=
read.so.0
#97 0x00007f4d5ae1d62d in clone () from /lib/x86_64-linux-gnu/libc.so.6
--------------------------------------------------------------------------

Looking at the data:
--------------------------------------------------------------------------
(gdb) frame 2
#2  0x0000562a4c582b6c in qemu_coroutine_enter (co=3D0x7f4b1bf0a900) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
113    /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c: No such f=
ile or directory.
(gdb) print *co
$1 =3D {entry =3D 0x7f4d23f20198, entry_arg =3D 0x1, caller =3D 0x7f4d23f20=
178, pool_next =3D {sle_next =3D 0x10}, co_queue_wakeup =3D {sqh_first =3D =
0x7f4c605fb000, sqh_last =3D 0x1000}, co_queue_next =3D {
    sqe_next =3D 0x7f4c584f5000}}
(gdb) print *co->caller
$2 =3D {entry =3D 0x400400000001, entry_arg =3D 0x5000ac0, caller =3D 0x0, =
pool_next =3D {sle_next =3D 0x0}, co_queue_wakeup =3D {sqh_first =3D 0x0, s=
qh_last =3D 0xffffea0005b1fec0}, co_queue_next =3D {sqe_next =3D 0x10000000=
0000}}
(gdb) frame 4
#4  0x0000562a4c5829a9 in qemu_coroutine_enter (co=3D0x7f4b1bf0a830) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
119    in /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c
(gdb) print *co
$5 =3D {entry =3D 0x7f4b180001d8, entry_arg =3D 0x7f4b180001d8, caller =3D =
0x7f4b1bf0a8d8, pool_next =3D {sle_next =3D 0x7f4b1bf0a8e0}, co_queue_wakeu=
p =3D {sqh_first =3D 0x7f4c584f5000, sqh_last =3D 0x7f4b1bf0a910}, =

  co_queue_next =3D {sqe_next =3D 0x5000ac0}}
(gdb) print *co->caller
$6 =3D {entry =3D 0x230120198, entry_arg =3D 0x230120178, caller =3D 0x16c7=
fb000, pool_next =3D {sle_next =3D 0x1646f5000}, co_queue_wakeup =3D {sqh_f=
irst =3D 0x1718c2000, sqh_last =3D 0x7f4d23f20198}, co_queue_next =3D {
    sqe_next =3D 0x1}}
--------------------------------------------------------------------------

Same thing.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673130

Title:
  qemu 2.7.0 receives SIGABRT in qemu_coroutine_enter()

Status in QEMU:
  New

Bug description:
  I've been experiencing frequent SIGABRTs (in addition to segfaults in
  #1671876) lately with qemu 2.7.0 running Ubuntu 16.04 guests. The
  crash usually happens in qemu_coroutine_enter(). I haven't seen this
  so far with any other guests or distros.

  Here is one stack trace I obtained
  --------------------------------------------------------------------------
  (gdb) bt
  #0  0x00007fd7cc676067 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sys=
deps/unix/sysv/linux/raise.c:56
  #1  0x00007fd7cc677448 in __GI_abort () at abort.c:89
  #2  0x0000556aed247b6c in qemu_coroutine_enter (co=3D0x7fd574300df0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
  #3  0x0000556aed247e55 in qemu_co_queue_run_restart (co=3D0x7fd574300ce0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #4  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd574300ce0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #5  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589111670)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #6  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589111670) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #7  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd57430dba0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #8  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd57430dba0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #9  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589119130)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #10 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589119130) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #11 0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589117410)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #12 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589117410) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #13 0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd577f00e00)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #14 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd577f00e00) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #15 0x0000556aed247fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x556=
aef34e5e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.=
c:106
  #16 0x0000556aed1e6060 in timer_cb (blk=3D0x556aef34e590, is_write=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c=
:400
  #17 0x0000556aed1a3615 in timerlist_run_timers (timer_list=3D0x556aef3bad=
40) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
  #18 0x0000556aed1a3679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x=
556af0738758) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
  #19 0x0000556aed1a3f47 in aio_dispatch (ctx=3Dctx@entry=3D0x556af0738610)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
  #20 0x0000556aed1a40e8 in aio_poll (ctx=3D0x556af0738610, blocking=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
  #21 0x0000556aed005c79 in iothread_run (opaque=3D0x556af07383c0) at /buil=
d/pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
  #22 0x00007fd7cc9f40a4 in start_thread (arg=3D0x7fd7aafff700) at pthread_=
create.c:403
  #23 0x00007fd7cc72962d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:111
  --------------------------------------------------------------------------

  The code crashes here
  --------------------------------------------------------------------------
  void qemu_coroutine_enter(Coroutine *co)
  {
      Coroutine *self =3D qemu_coroutine_self();
      CoroutineAction ret;

      trace_qemu_coroutine_enter(self, co, co->entry_arg);

      if (co->caller) {
          fprintf(stderr, "Co-routine re-entered recursively\n");          =
  =

          abort();  <--- Code aborts here                                  =
             =

      }

      [...]
  }
  --------------------------------------------------------------------------

  Debugging further we see:
  --------------------------------------------------------------------------
  (gdb) frame 2
  #2  0x0000556aed247b6c in qemu_coroutine_enter (co=3D0x7fd574300df0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
  113    /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c: No such=
 file or directory.
  (gdb) print *co
  $1 =3D {entry =3D 0x7fd793e95a58, entry_arg =3D 0x1, caller =3D 0x7fd793e=
95a38, pool_next =3D {sle_next =3D 0x10}, co_queue_wakeup =3D {sqh_first =
=3D 0x7fd6ebbd2000, sqh_last =3D 0x1000}, co_queue_next =3D {
      sqe_next =3D 0x7fd6ebbd1000}}
  (gdb) print *co->caller
  $2 =3D {entry =3D 0x400400000001, entry_arg =3D 0xc546a20, caller =3D 0x0=
, pool_next =3D {sle_next =3D 0x0}, co_queue_wakeup =3D {sqh_first =3D 0x0,=
 sqh_last =3D 0xffffea00061f7480}, co_queue_next =3D {sqe_next =3D 0x100000=
000000}}
  (gdb) frame 4
  #4  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd574300ce0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  119    in /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c
  (gdb) print *co
  $3 =3D {entry =3D 0xc00000053, entry_arg =3D 0x7fd500000001, caller =3D 0=
x7fd574300d88, pool_next =3D {sle_next =3D 0x7fd574300d90}, co_queue_wakeup=
 =3D {sqh_first =3D 0x7fd6ebbd1000, sqh_last =3D 0x7fd574300e00}, =

    co_queue_next =3D {sqe_next =3D 0xc546a20}}
  (gdb) print *co->caller
  $4 =3D {entry =3D 0x230095a58, entry_arg =3D 0x230095a38, caller =3D 0x18=
7dd2000, pool_next =3D {sle_next =3D 0x187dd1000}, co_queue_wakeup =3D {sqh=
_first =3D 0x187dd0000, sqh_last =3D 0x187dcf000}, co_queue_next =3D {
      sqe_next =3D 0x184970000}}
  --------------------------------------------------------------------------

  The question is, why did qemu_coroutine_enter not complain when in
  earlier calls co->caller was not NULL?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673130/+subscriptions
