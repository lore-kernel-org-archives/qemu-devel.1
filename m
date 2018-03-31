Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2Ncb-00072L-Mt
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2NcX-0000dn-PP
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:49802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f2NcX-0000bH-Fk
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 17:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f2NcU-0007d9-5e
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 21:01:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3ACB2E80E3
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 21:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Mar 2018 20:51:34 -0000
From: Erik Kristian Sverre Uri <1758819@bugs.launchpad.net>
Reply-To: Bug 1758819 <1758819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
Message-Id: <152252949475.3279.15008307264831029122.malone@wampee.canonical.com>
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

Process:               qemu-system-x86_64 [6330]
Path:                  /Users/USER/*/qemu-system-x86_64
Identifier:            qemu-system-x86_64
Version:               0
Code Type:             X86-64 (Native)
Parent Process:        bash [1558]
Responsible:           qemu-system-x86_64 [6330]
User ID:               501

Date/Time:             2018-03-31 13:46:58.355 -0700
OS Version:            Mac OS X 10.13.4 (17E199)
Report Version:        12
Anonymous UUID:        28693BB0-7F66-6066-026C-DDE857D912F6


Time Awake Since Boot: 1800 seconds

System Integrity Protection: disabled

Crashed Thread:        0  Dispatch queue: com.apple.main-thread

Exception Type:        EXC_BAD_INSTRUCTION (SIGILL)
Exception Codes:       0x0000000000000001, 0x0000000000000000
Exception Note:        EXC_CORPSE_NOTIFY

Termination Signal:    Illegal instruction: 4
Termination Reason:    Namespace SIGNAL, Code 0x4
Terminating Process:   exc handler [0]

Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
0   qemu-system-x86_64            	0x000000010d8acafc hvf_get_supported_cpu=
id + 300 (x86_cpuid.c:102)
1   qemu-system-x86_64            	0x000000010d8453e8 x86_cpu_expand_featur=
es + 200 (cpu.c:2408)
2   qemu-system-x86_64            	0x000000010d847770 x86_cpu_realizefn + 2=
88 (cpu.c:3669)
3   qemu-system-x86_64            	0x000000010d92fa73 device_set_realized +=
 899 (qdev.c:917)
4   qemu-system-x86_64            	0x000000010da6e123 property_set_bool + 99
5   qemu-system-x86_64            	0x000000010da6f410 object_property_set_q=
object + 48 (qom-qobject.c:28)
6   qemu-system-x86_64            	0x000000010da6ca71 object_property_set_b=
ool + 49 (qobject.h:81)
7   qemu-system-x86_64            	0x000000010d824baf pc_cpus_init + 415 (p=
c.c:1104)
8   qemu-system-x86_64            	0x000000010d829c6d pc_init1 + 349 (pc_pi=
ix.c:157)
9   qemu-system-x86_64            	0x000000010d8cb234 qemu_main + 17476 (vl=
.c:1275)
10  qemu-system-x86_64            	0x000000010da6723e -[QemuCocoaAppControl=
ler startEmulationWithArgc:argv:] + 30 (cocoa.m:1017)
11  com.apple.CoreFoundation      	0x00007fff5294561c __CFNOTIFICATIONCENTE=
R_IS_CALLING_OUT_TO_AN_OBSERVER__ + 12
12  com.apple.CoreFoundation      	0x00007fff529454ea _CFXRegistrationPost =
+ 458
13  com.apple.CoreFoundation      	0x00007fff52945221 ___CFXNotificationPos=
t_block_invoke + 225
14  com.apple.CoreFoundation      	0x00007fff52903d72 -[_CFXNotificationReg=
istrar find:object:observer:enumerator:] + 1826
15  com.apple.CoreFoundation      	0x00007fff52902e03 _CFXNotificationPost =
+ 659
16  com.apple.Foundation          	0x00007fff54a1f8c7 -[NSNotificationCente=
r postNotificationName:object:userInfo:] + 66
17  com.apple.AppKit              	0x00007fff4fff3206 -[NSApplication _post=
DidFinishNotification] + 313
18  com.apple.AppKit              	0x00007fff4fff2e4f -[NSApplication _send=
FinishLaunchingNotification] + 220
19  com.apple.AppKit              	0x00007fff4fec5ab3 -[NSApplication(NSApp=
leEventHandling) _handleAEOpenEvent:] + 562
20  com.apple.AppKit              	0x00007fff4fec56e9 -[NSApplication(NSApp=
leEventHandling) _handleCoreEvent:withReplyEvent:] + 690
21  com.apple.Foundation          	0x00007fff54a62714 -[NSAppleEventManager=
 dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 287
22  com.apple.Foundation          	0x00007fff54a62592 _NSAppleEventManagerG=
enericHandler + 102
23  com.apple.AE                  	0x00007fff53a3bdd0 aeDispatchAppleEvent(=
AEDesc const*, AEDesc*, unsigned int, unsigned char*) + 1788
24  com.apple.AE                  	0x00007fff53a3b677 dispatchEventAndSendR=
eply(AEDesc const*, AEDesc*) + 41
25  com.apple.AE                  	0x00007fff53a3b565 aeProcessAppleEvent +=
 383
26  com.apple.HIToolbox           	0x00007fff51c1d4a0 AEProcessAppleEvent +=
 55
27  com.apple.AppKit              	0x00007fff4fec0d32 _DPSNextEvent + 2788
28  com.apple.AppKit              	0x00007fff50656e34 -[NSApplication(NSEve=
nt) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 3044
29  com.apple.AppKit              	0x00007fff4feb5885 -[NSApplication run] =
+ 764
30  qemu-system-x86_64            	0x000000010da68e99 main + 2537 (cocoa.m:=
1462)
31  libdyld.dylib                 	0x00007fff7ace7015 start + 1

Thread 1:
0   libsystem_kernel.dylib        	0x00007fff7ae37d8a __semwait_signal + 10
1   libsystem_c.dylib             	0x00007fff7adb2724 nanosleep + 199
2   libglib-2.0.0.dylib           	0x000000010e8fc9fe g_usleep + 71
3   qemu-system-x86_64            	0x000000010db55f39 call_rcu_thread + 217=
 (rcu.c:244)
4   libsystem_pthread.dylib       	0x00007fff7afff661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff7afff50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff7affebf9 thread_start + 13

Thread 2:: Dispatch queue: NSCGSDisableUpdates
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

Thread 3:
0   libsystem_kernel.dylib        	0x00007fff7ae38292 __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff7afff009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 4:
0   libsystem_kernel.dylib        	0x00007fff7ae38292 __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff7afff009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 5:
0   libsystem_kernel.dylib        	0x00007fff7ae38292 __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff7afff009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff7affebe9 start_wqthread + 13

Thread 6:
0   libsystem_kernel.dylib        	0x00007fff7ae38042 __sigwait + 10
1   libsystem_pthread.dylib       	0x00007fff7b001ad9 sigwait + 61
2   qemu-system-x86_64            	0x000000010db4061b sigwait_compat + 59 (=
compatfd.c:37)
3   libsystem_pthread.dylib       	0x00007fff7afff661 _pthread_body + 340
4   libsystem_pthread.dylib       	0x00007fff7afff50d _pthread_start + 377
5   libsystem_pthread.dylib       	0x00007fff7affebf9 thread_start + 13

Thread 0 crashed with X86 Thread State (64-bit):
  rax: 0x000000010d8acae7  rbx: 0x000000000000000d  rcx: 0x0000000000000000=
  rdx: 0x0000000000000002
  rdi: 0x000000000000000d  rsi: 0x0000000000000000  rbp: 0x00007ffee246eed0=
  rsp: 0x00007ffee246ee80
   r8: 0x00007ffee246ee8c   r9: 0x00007ffee246ee88  r10: 0x00007ffee246ee90=
  r11: 0x00007ffee246ee94
  r12: 0x0000000000000000  r13: 0x00007f875509b201  r14: 0x0000000000000000=
  r15: 0x0000000000000000
  rip: 0x000000010d8acafc  rfl: 0x0000000000010246  cr2: 0x000000010d847650
  =

Logical CPU:     2
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
