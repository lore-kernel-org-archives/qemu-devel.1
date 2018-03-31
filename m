Received: from eggs.gnu.org ([2001:4830:134:3::10]:53242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2Ncb-00072M-NU
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2NcX-0000e9-Rk
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:49798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f2NcX-0000bG-JC
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f2NcU-0007gA-F8
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 21:01:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 642B62E80D3
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 21:01:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Mar 2018 20:54:46 -0000
From: Erik Kristian Sverre Uri <1758819@bugs.launchpad.net>
Reply-To: Bug 1758819 <1758819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
Message-Id: <152252968664.3132.12205040712398091559.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1758819] Re: HVF Illegal instruction: 4,
 High Sierra, v2.12-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Disregard the above log; that was from a September 2017 build.

On RC1:

Process:               qemu-system-x86_64 [6567]
Path:                  /usr/local/bin/qemu-system-x86_64
Identifier:            qemu-system-x86_64
Version:               0
Code Type:             X86-64 (Native)
Parent Process:        bash [1558]
Responsible:           qemu-system-x86_64 [6567]
User ID:               501

Date/Time:             2018-03-31 13:53:57.851 -0700
OS Version:            Mac OS X 10.13.4 (17E199)
Report Version:        12
Anonymous UUID:        28693BB0-7F66-6066-026C-DDE857D912F6


Time Awake Since Boot: 2200 seconds

System Integrity Protection: disabled

Crashed Thread:        0  Dispatch queue: com.apple.main-thread

Exception Type:        EXC_BAD_INSTRUCTION (SIGILL)
Exception Codes:       0x0000000000000001, 0x0000000000000000
Exception Note:        EXC_CORPSE_NOTIFY

Termination Signal:    Illegal instruction: 4
Termination Reason:    Namespace SIGNAL, Code 0x4
Terminating Process:   exc handler [0]

Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
0   qemu-system-x86_64            	0x000000010524165b 0x105134000 + 1103451
1   qemu-system-x86_64            	0x00000001051e2481 0x105134000 + 713857
2   qemu-system-x86_64            	0x00000001051e2170 0x105134000 + 713072
3   qemu-system-x86_64            	0x00000001051e3e2a 0x105134000 + 720426
4   qemu-system-x86_64            	0x00000001052b625a 0x105134000 + 1581658
5   qemu-system-x86_64            	0x00000001053e5606 0x105134000 + 2823686
6   qemu-system-x86_64            	0x00000001053e65bb 0x105134000 + 2827707
7   qemu-system-x86_64            	0x00000001053e4126 0x105134000 + 2818342
8   qemu-system-x86_64            	0x00000001051c35fc 0x105134000 + 587260
9   qemu-system-x86_64            	0x00000001051c36e6 0x105134000 + 587494
10  qemu-system-x86_64            	0x00000001051c8040 0x105134000 + 606272
11  qemu-system-x86_64            	0x000000010525a462 0x105134000 + 1205346
12  qemu-system-x86_64            	0x00000001053c8e28 0x105134000 + 2706984
13  com.apple.CoreFoundation      	0x00007fff5294561c __CFNOTIFICATIONCENTE=
R_IS_CALLING_OUT_TO_AN_OBSERVER__ + 12
14  com.apple.CoreFoundation      	0x00007fff529454ea _CFXRegistrationPost =
+ 458
15  com.apple.CoreFoundation      	0x00007fff52945221 ___CFXNotificationPos=
t_block_invoke + 225
16  com.apple.CoreFoundation      	0x00007fff52903d72 -[_CFXNotificationReg=
istrar find:object:observer:enumerator:] + 1826
17  com.apple.CoreFoundation      	0x00007fff52902e03 _CFXNotificationPost =
+ 659
18  com.apple.Foundation          	0x00007fff54a1f8c7 -[NSNotificationCente=
r postNotificationName:object:userInfo:] + 66
19  com.apple.AppKit              	0x00007fff4fff3206 -[NSApplication _post=
DidFinishNotification] + 313
20  com.apple.AppKit              	0x00007fff4fff2e4f -[NSApplication _send=
FinishLaunchingNotification] + 220
21  com.apple.AppKit              	0x00007fff4fec5ab3 -[NSApplication(NSApp=
leEventHandling) _handleAEOpenEvent:] + 562
22  com.apple.AppKit              	0x00007fff4fec56e9 -[NSApplication(NSApp=
leEventHandling) _handleCoreEvent:withReplyEvent:] + 690
23  com.apple.Foundation          	0x00007fff54a62714 -[NSAppleEventManager=
 dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 287
24  com.apple.Foundation          	0x00007fff54a62592 _NSAppleEventManagerG=
enericHandler + 102
25  com.apple.AE                  	0x00007fff53a3bdd0 aeDispatchAppleEvent(=
AEDesc const*, AEDesc*, unsigned int, unsigned char*) + 1788
26  com.apple.AE                  	0x00007fff53a3b677 dispatchEventAndSendR=
eply(AEDesc const*, AEDesc*) + 41
27  com.apple.AE                  	0x00007fff53a3b565 aeProcessAppleEvent +=
 383
28  com.apple.HIToolbox           	0x00007fff51c1d4a0 AEProcessAppleEvent +=
 55
29  com.apple.AppKit              	0x00007fff4fec0d32 _DPSNextEvent + 2788
30  com.apple.AppKit              	0x00007fff50656e34 -[NSApplication(NSEve=
nt) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 3044
31  com.apple.AppKit              	0x00007fff4feb5885 -[NSApplication run] =
+ 764
32  qemu-system-x86_64            	0x00000001053ca853 0x105134000 + 2713683
33  libdyld.dylib                 	0x00007fff7ace7015 start + 1

Thread 1:
0   libsystem_kernel.dylib        	0x00007fff7ae37a1e __psynch_cvwait + 10
1   libsystem_pthread.dylib       	0x00007fff7b000589 _pthread_cond_wait + =
732
2   qemu-system-x86_64            	0x00000001054b0b27 0x105134000 + 3656487
3   qemu-system-x86_64            	0x00000001054bf128 0x105134000 + 3715368
4   libsystem_pthread.dylib       	0x00007fff7afff661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff7afff50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff7affebf9 thread_start + 13

Thread 2:
0   libsystem_kernel.dylib        	0x00007fff7ae38292 __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff7afff009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 3:: Dispatch queue: NSCGSDisableUpdates
0   libsystem_kernel.dylib        	0x00007fff7ae2e20a mach_msg_trap + 10
1   libsystem_kernel.dylib        	0x00007fff7ae2d724 mach_msg + 60
2   com.apple.SkyLight            	0x00007fff74b129f5 CGSUpdateManager::ena=
ble_updates_common() + 565
3   com.apple.SkyLight            	0x00007fff74ab6b28 CGSUpdateManager::ena=
ble_update(unsigned long long) + 320
4   libdispatch.dylib             	0x00007fff7acb564a _dispatch_call_block_=
and_release + 12
5   libdispatch.dylib             	0x00007fff7acade08 _dispatch_client_call=
out + 8
6   libdispatch.dylib             	0x00007fff7acc2267 _dispatch_queue_seria=
l_drain + 635
7   libdispatch.dylib             	0x00007fff7acb51b6 _dispatch_queue_invok=
e + 373
8   libdispatch.dylib             	0x00007fff7acc2f5d _dispatch_root_queue_=
drain_deferred_wlh + 332
9   libdispatch.dylib             	0x00007fff7acc6d71 _dispatch_workloop_wo=
rker_thread + 880
10  libsystem_pthread.dylib       	0x00007fff7affefd2 _pthread_wqthread + 9=
80
11  libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 4:
0   libsystem_pthread.dylib       	0x00007fff7affebdc start_wqthread + 0
1   ???                           	0x000070000e958b50 0 + 123145546992464

Thread 5:
0   libsystem_kernel.dylib        	0x00007fff7ae38292 __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff7afff009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 6:
0   libsystem_kernel.dylib        	0x00007fff7ae38042 __sigwait + 10
1   libsystem_pthread.dylib       	0x00007fff7b001ad9 sigwait + 61
2   qemu-system-x86_64            	0x00000001054aee62 0x105134000 + 3649122
3   libsystem_pthread.dylib       	0x00007fff7afff661 _pthread_body + 340
4   libsystem_pthread.dylib       	0x00007fff7afff50d _pthread_start + 377
5   libsystem_pthread.dylib       	0x00007fff7affebf9 thread_start + 13

Thread 7:
0   libsystem_kernel.dylib        	0x00007fff7ae37cfa __select + 10
1   libglib-2.0.0.dylib           	0x00000001061ebb60 g_poll + 430
2   qemu-system-x86_64            	0x00000001054ae80b 0x105134000 + 3647499
3   qemu-system-x86_64            	0x0000000105252eb2 0x105134000 + 1175218
4   libsystem_pthread.dylib       	0x00007fff7afff661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff7afff50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff7affebf9 thread_start + 13

Thread 0 crashed with X86 Thread State (64-bit):
  rax: 0x0000000000000001  rbx: 0x000000000000000d  rcx: 0x0000000000000000=
  rdx: 0x0000000000000000
  rdi: 0x000000000000000d  rsi: 0x0000000000000000  rbp: 0x00007ffeeaac9f40=
  rsp: 0x00007ffeeaac9f00
   r8: 0x00007ffeeaac9f04   r9: 0x00007ffeeaac9f00  r10: 0x00007ffeeaac9f08=
  r11: 0x00007ffeeaac9f0c
  r12: 0x0000000000000000  r13: 0x00007fe43f0af400  r14: 0x0000000000000000=
  r15: 0x0000000000000000
  rip: 0x000000010524165b  rfl: 0x0000000000010246  cr2: 0x000000010518235d
  =

Logical CPU:     0
Error Code:      0x00000000
Trap Number:     6

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1758819

Title:
  HVF Illegal instruction: 4, High Sierra, v2.12-rc0

Status in QEMU:
  New

Bug description:
  I've built v2.12.0-rc0 on MacOS using homebrew. I'm running 10.13.3 on
  a 5,1 Mac Pro with a X5690 processor.

  When I run 'qemu-system-x86_64 -M accel=3Dhvf', I get a crash "Illegal
  instruction: 4".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1758819/+subscriptions
