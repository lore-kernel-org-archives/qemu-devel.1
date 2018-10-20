Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDxez-0000M2-HC
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 16:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDxeu-00013U-Mg
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 16:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:49768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDxeu-00012K-9E
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 16:15:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDxeq-0000Vs-O6
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 20:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A510E2E8030
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 20:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Oct 2018 20:05:23 -0000
From: Rob Maskell <1798451@bugs.launchpad.net>
Reply-To: Bug 1798451 <1798451@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153980387714.3465.12419240219281347614.malonedeb@soybean.canonical.com>
Message-Id: <154006592429.17907.4900627916452465920.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798451] Re: HVF linux on OSX hangs 2nd time
 started after adding socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for replying Roman, I switched to your tap but even before that
I'm not struggling to get the machines to boot even without the smp/numa
lines... vga std flashes a lot then hangs with a black screen and a
blinking cursor whereas vga vmware quite unexpectedly.

Command to start QEMU:

qemu-system-x86_64 \
  -name Elementary4Dev \
  -machine pc,accel=3Dhvf \
  -cpu max \
  -m 8G \
  -vga vmware \
  -drive file=3Delem4.qcow2,format=3Dqcow2,media=3Ddisk -boot d \
  -cdrom ../VMImages/elementaryos-0.4.1-stable.20180214.iso

I tried the Elementary 0.4.1 and the new just released 5.0 and I get
this... also tried cpu host but no luck. It's weird as single cpu was
working the other day but stopped working on QEMU 3.0 before I switched
to your tap.

Process:               qemu-system-x86_64 [716]
Path:                  /usr/local/bin/qemu-system-x86_64
Identifier:            qemu-system-x86_64
Version:               0
Code Type:             X86-64 (Native)
Parent Process:        ??? [713]
Responsible:           qemu-system-x86_64 [716]
User ID:               501

Date/Time:             2018-10-20 20:58:31.473 +0100
OS Version:            Mac OS X 10.13.6 (17G65)
Report Version:        12
Bridge OS Version:     3.0 (14Y664)
Anonymous UUID:        A83DA3FD-C7C9-DAD6-4F7D-E36F1E90F993


Time Awake Since Boot: 1200 seconds

System Integrity Protection: enabled

Crashed Thread:        5

Exception Type:        EXC_CRASH (SIGABRT)
Exception Codes:       0x0000000000000000, 0x0000000000000000
Exception Note:        EXC_CORPSE_NOTIFY

Application Specific Information:
abort() called

Thread 0:: Dispatch queue: com.apple.main-thread
0   libsystem_kernel.dylib        	0x00007fff65ad5cf2 __select + 10
1   libglib-2.0.0.dylib           	0x00000001036ae359 g_poll + 407
2   qemu-system-x86_64            	0x0000000102d53bb6 0x1029a8000 + 3849142
3   qemu-system-x86_64            	0x0000000102af1c3e 0x1029a8000 + 1350718
4   qemu-system-x86_64            	0x0000000102aef736 0x1029a8000 + 1341238
5   qemu-system-x86_64            	0x0000000102c684ee 0x1029a8000 + 2884846
6   com.apple.CoreFoundation      	0x00007fff3db57edc __CFNOTIFICATIONCENTE=
R_IS_CALLING_OUT_TO_AN_OBSERVER__ + 12
7   com.apple.CoreFoundation      	0x00007fff3db57daa _CFXRegistrationPost =
+ 458
8   com.apple.CoreFoundation      	0x00007fff3db57ae1 ___CFXNotificationPos=
t_block_invoke + 225
9   com.apple.CoreFoundation      	0x00007fff3db15880 -[_CFXNotificationReg=
istrar find:object:observer:enumerator:] + 1664
10  com.apple.CoreFoundation      	0x00007fff3db149b7 _CFXNotificationPost =
+ 599
11  com.apple.Foundation          	0x00007fff3fc248c7 -[NSNotificationCente=
r postNotificationName:object:userInfo:] + 66
12  com.apple.AppKit              	0x00007fff3b210206 -[NSApplication _post=
DidFinishNotification] + 313
13  com.apple.AppKit              	0x00007fff3b20fe4f -[NSApplication _send=
FinishLaunchingNotification] + 220
14  com.apple.AppKit              	0x00007fff3b0e2ab3 -[NSApplication(NSApp=
leEventHandling) _handleAEOpenEvent:] + 562
15  com.apple.AppKit              	0x00007fff3b0e26e9 -[NSApplication(NSApp=
leEventHandling) _handleCoreEvent:withReplyEvent:] + 690
16  com.apple.Foundation          	0x00007fff3fc67714 -[NSAppleEventManager=
 dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 287
17  com.apple.Foundation          	0x00007fff3fc67592 _NSAppleEventManagerG=
enericHandler + 102
18  com.apple.AE                  	0x00007fff3ec40dd0 aeDispatchAppleEvent(=
AEDesc const*, AEDesc*, unsigned int, unsigned char*) + 1788
19  com.apple.AE                  	0x00007fff3ec40677 dispatchEventAndSendR=
eply(AEDesc const*, AEDesc*) + 41
20  com.apple.AE                  	0x00007fff3ec40565 aeProcessAppleEvent +=
 383
21  com.apple.HIToolbox           	0x00007fff3ce3c4a0 AEProcessAppleEvent +=
 55
22  com.apple.AppKit              	0x00007fff3b0ddd32 _DPSNextEvent + 2788
23  com.apple.AppKit              	0x00007fff3b873e34 -[NSApplication(NSEve=
nt) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 3044
24  com.apple.AppKit              	0x00007fff3b0d2885 -[NSApplication run] =
+ 764
25  qemu-system-x86_64            	0x0000000102c69ea1 0x1029a8000 + 2891425
26  libdyld.dylib                 	0x00007fff65985015 start + 1

Thread 1:
0   libsystem_kernel.dylib        	0x00007fff65ad5a16 __psynch_cvwait + 10
1   libsystem_pthread.dylib       	0x00007fff65c9e589 _pthread_cond_wait + =
732
2   qemu-system-x86_64            	0x0000000102d56db1 0x1029a8000 + 3861937
3   qemu-system-x86_64            	0x0000000102d65659 0x1029a8000 + 3921497
4   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 2:
0   libsystem_kernel.dylib        	0x00007fff65ad628a __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff65c9d009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff65c9cbe9 start_wqthread + 13

Thread 3:
0   libsystem_kernel.dylib        	0x00007fff65ad5cf2 __select + 10
1   libglib-2.0.0.dylib           	0x00000001036ae359 g_poll + 407
2   qemu-system-x86_64            	0x0000000102d547eb 0x1029a8000 + 3852267
3   qemu-system-x86_64            	0x0000000102ae7638 0x1029a8000 + 1308216
4   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 4:
0   libsystem_kernel.dylib        	0x00007fff65ad603a __sigwait + 10
1   libsystem_pthread.dylib       	0x00007fff65c9fad9 sigwait + 61
2   qemu-system-x86_64            	0x0000000102d54d9a 0x1029a8000 + 3853722
3   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
4   libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
5   libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 5 Crashed:
0   libsystem_kernel.dylib        	0x00007fff65ad5b66 __pthread_kill + 10
1   libsystem_pthread.dylib       	0x00007fff65ca0080 pthread_kill + 333
2   libsystem_c.dylib             	0x00007fff65a311ae abort + 127
3   qemu-system-x86_64            	0x0000000102adcfa1 0x1029a8000 + 1265569
4   qemu-system-x86_64            	0x0000000102adbab4 0x1029a8000 + 1260212
5   qemu-system-x86_64            	0x0000000102adb3fa 0x1029a8000 + 1258490
6   qemu-system-x86_64            	0x0000000102ada385 0x1029a8000 + 1254277
7   qemu-system-x86_64            	0x0000000102ad5963 0x1029a8000 + 1235299
8   qemu-system-x86_64            	0x00000001029ec5ae 0x1029a8000 + 279982
9   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
10  libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
11  libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 6:: com.apple.NSEventThread
0   libsystem_kernel.dylib        	0x00007fff65acc20a mach_msg_trap + 10
1   libsystem_kernel.dylib        	0x00007fff65acb724 mach_msg + 60
2   com.apple.CoreFoundation      	0x00007fff3db43785 __CFRunLoopServiceMac=
hPort + 341
3   com.apple.CoreFoundation      	0x00007fff3db42ad7 __CFRunLoopRun + 1783
4   com.apple.CoreFoundation      	0x00007fff3db42153 CFRunLoopRunSpecific =
+ 483
5   com.apple.AppKit              	0x00007fff3b21afc4 _NSEventThread + 184
6   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
7   libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
8   libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 7:
0   libsystem_kernel.dylib        	0x00007fff65ad628a __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff65c9d009 _pthread_wqthread + 1=
035
2   libsystem_pthread.dylib       	0x00007fff65c9cbe9 start_wqthread + 13

Thread 8:
0   libsystem_kernel.dylib        	0x00007fff65ad628a __workq_kernreturn + =
10
1   libsystem_pthread.dylib       	0x00007fff65c9d20e _pthread_wqthread + 1=
552
2   libsystem_pthread.dylib       	0x00007fff65c9cbe9 start_wqthread + 13

Thread 9:
0   libsystem_kernel.dylib        	0x00007fff65ad5a16 __psynch_cvwait + 10
1   libsystem_pthread.dylib       	0x00007fff65c9e589 _pthread_cond_wait + =
732
2   qemu-system-x86_64            	0x0000000102d56b2a 0x1029a8000 + 3861290
3   qemu-system-x86_64            	0x0000000102d52a3b 0x1029a8000 + 3844667
4   libsystem_pthread.dylib       	0x00007fff65c9d661 _pthread_body + 340
5   libsystem_pthread.dylib       	0x00007fff65c9d50d _pthread_start + 377
6   libsystem_pthread.dylib       	0x00007fff65c9cbf9 thread_start + 13

Thread 5 crashed with X86 Thread State (64-bit):
  rax: 0x0000000000000000  rbx: 0x000070000f325000  rcx: 0x000070000f324c38=
  rdx: 0x0000000000000000
  rdi: 0x0000000000007803  rsi: 0x0000000000000006  rbp: 0x000070000f324c70=
  rsp: 0x000070000f324c38
   r8: 0x00007fff9e476f78   r9: 0x0000000000000040  r10: 0x0000000000000000=
  r11: 0x0000000000000206
  r12: 0x0000000000007803  r13: 0x00007f9b4a864400  r14: 0x0000000000000006=
  r15: 0x000000000000002d
  rip: 0x00007fff65ad5b66  rfl: 0x0000000000000206  cr2: 0x00007fff9e475168
  =

Logical CPU:     0
Error Code:      0x02000148
Trap Number:     133


Binary Images:
       0x1029a8000 -        0x10302cff7 +qemu-system-x86_64 (0) <B403B322-7=
D8A-314E-8603-87BE55E2B497> /usr/local/bin/qemu-system-x86_64
       0x1033aa000 -        0x1033e4ff3 +libncursesw.6.dylib (0) <20A2D861-=
87A5-3B8A-90DE-55BA26EC70DA> /usr/local/opt/ncurses/lib/libncursesw.6.dylib
       0x1033f7000 -        0x10346dff7 +libpixman-1.0.dylib (0) <8D85DEAA-=
9C08-3BD5-9D6D-99BAD7F1D504> /usr/local/opt/pixman/lib/libpixman-1.0.dylib
       0x103489000 -        0x1034acfff +libpng16.16.dylib (0) <621C81BB-39=
E7-3301-9D31-307112D1DC55> /usr/local/opt/libpng/lib/libpng16.16.dylib
       0x1034b9000 -        0x1034e5ff7 +libjpeg.9.dylib (0) <C76CAB50-100A=
-3873-9E2E-7861B0C9D8C4> /usr/local/opt/jpeg/lib/libjpeg.9.dylib
       0x1034ef000 -        0x103515ffb +libnettle.6.dylib (0) <2B221011-3E=
71-3BA4-ADE4-0C6EC6196E21> /usr/local/opt/nettle/lib/libnettle.6.dylib
       0x103524000 -        0x103626fe7 +libgnutls.30.dylib (0) <A3EDF8A2-A=
796-3ACE-A130-185C681C2C56> /usr/local/opt/gnutls/lib/libgnutls.30.dylib
       0x103668000 -        0x10366bfff +libgthread-2.0.0.dylib (0) <D695C8=
FD-A4F0-343A-AA62-A37DCB9D817D> /usr/local/opt/glib/lib/libgthread-2.0.0.dy=
lib
       0x103672000 -        0x103742ff3 +libglib-2.0.0.dylib (0) <59AAEC33-=
B877-3DE1-A485-B4E711C33408> /usr/local/opt/glib/lib/libglib-2.0.0.dylib
       0x103769000 -        0x103771ff7 +libintl.8.dylib (0) <2BE4B1C7-92C9=
-39E9-B4A7-F880907047DB> /usr/local/opt/gettext/lib/libintl.8.dylib
       0x103777000 -        0x10381eff3 +libp11-kit.0.dylib (0) <BBD76BEB-F=
58A-3516-B047-93BDFA31A3F0> /usr/local/opt/p11-kit/lib/libp11-kit.0.dylib
       0x10386e000 -        0x1039d1fff +libunistring.2.dylib (0) <A4545916=
-E2F4-3D6A-862B-528A6806E9FC> /usr/local/opt/libunistring/lib/libunistring.=
2.dylib
       0x1039e9000 -        0x1039f4fff +libtasn1.6.dylib (0) <A39E91B7-03B=
4-3674-9F21-00CED14D080E> /usr/local/opt/libtasn1/lib/libtasn1.6.dylib
       0x1039fa000 -        0x103a22fff +libhogweed.4.dylib (0) <DF0DE14F-2=
A23-378D-BF21-60DADF53911C> /usr/local/opt/nettle/lib/libhogweed.4.dylib
       0x103a2e000 -        0x103a8afcf +libgmp.10.dylib (0) <7D2A1AB0-B206=
-3196-954C-5A0E17049998> /usr/local/opt/gmp/lib/libgmp.10.dylib
       0x103a98000 -        0x103a9cfff +libffi.6.dylib (0) <47F6B233-3552-=
3D42-A3EC-1917E141AC53> /usr/local/opt/libffi/lib/libffi.6.dylib
       0x103aa1000 -        0x103b04ff3 +libpcre.1.dylib (0) <5B4FAAF7-7EC4=
-36BB-B62E-57DE5F60AB9A> /usr/local/opt/pcre/lib/libpcre.1.dylib
       0x1096fc000 -        0x109833fff  com.apple.AMDMTLBronzeDriver (1.68=
.20 - 1.6.8) <C5D6A803-7CE1-32BD-BE34-C518131CED8B> /System/Library/Extensi=
ons/AMDMTLBronzeDriver.bundle/Contents/MacOS/AMDMTLBronzeDriver
       0x10d6db000 -        0x10d725acf  dyld (551.4) <8A72DE9C-A136-3506-A=
A02-4BA2B82DCAF3> /usr/lib/dyld
    0x7fff37a57000 -     0x7fff37c42fff  com.apple.driver.AppleIntelKBLGrap=
hicsMTLDriver (10.36.19 - 10.3.6) <A5C358C5-A4EC-3726-A7EB-49300B599A2D> /S=
ystem/Library/Extensions/AppleIntelKBLGraphicsMTLDriver.bundle/Contents/Mac=
OS/AppleIntelKBLGraphicsMTLDriver
    0x7fff3a036000 -     0x7fff3a036fff  com.apple.Accelerate (1.11 - Accel=
erate 1.11) <8632A9C5-19EA-3FD7-A44D-80765CC9C540> /System/Library/Framewor=
ks/Accelerate.framework/Versions/A/Accelerate
    0x7fff3a037000 -     0x7fff3a04dfef  libCGInterfaces.dylib (417.2) <2E6=
7702C-75F6-308A-A023-F28120BEE667> /System/Library/Frameworks/Accelerate.fr=
amework/Versions/A/Frameworks/vImage.framework/Versions/A/Libraries/libCGIn=
terfaces.dylib
    0x7fff3a04e000 -     0x7fff3a54cfc3  com.apple.vImage (8.1 - ???) <A243=
A7EF-0C8E-3A9A-AA38-44AFD7507F00> /System/Library/Frameworks/Accelerate.fra=
mework/Versions/A/Frameworks/vImage.framework/Versions/A/vImage
    0x7fff3a54d000 -     0x7fff3a6a7fe3  libBLAS.dylib (1211.50.2) <62C659E=
B-3E32-3B5F-83BF-79F5DF30D5CE> /System/Library/Frameworks/Accelerate.framew=
ork/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
    0x7fff3a6a8000 -     0x7fff3a6d6fef  libBNNS.dylib (38.1) <7BAEFDCA-322=
7-3E07-80D8-59B6370B89C6> /System/Library/Frameworks/Accelerate.framework/V=
ersions/A/Frameworks/vecLib.framework/Versions/A/libBNNS.dylib
    0x7fff3a6d7000 -     0x7fff3aa96ff7  libLAPACK.dylib (1211.50.2) <40ADB=
A5F-8B2D-30AC-A7AD-7B17C37EE52D> /System/Library/Frameworks/Accelerate.fram=
ework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLAPACK.dylib
    0x7fff3aa97000 -     0x7fff3aaacff7  libLinearAlgebra.dylib (1211.50.2)=
 <E8E0B7FD-A0B7-31E5-AF01-81781F71EBBE> /System/Library/Frameworks/Accelera=
te.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLinearAlg=
ebra.dylib
    0x7fff3aaad000 -     0x7fff3aab2ff3  libQuadrature.dylib (3) <3D6BF66A-=
55B2-3692-BAC7-DEB0C676ED29> /System/Library/Frameworks/Accelerate.framewor=
k/Versions/A/Frameworks/vecLib.framework/Versions/A/libQuadrature.dylib
    0x7fff3aab3000 -     0x7fff3ab33fff  libSparse.dylib (79.50.2) <0DC25CD=
D-F8C1-3D6E-B472-8B060708424F> /System/Library/Frameworks/Accelerate.framew=
ork/Versions/A/Frameworks/vecLib.framework/Versions/A/libSparse.dylib
    0x7fff3ab34000 -     0x7fff3ab47fff  libSparseBLAS.dylib (1211.50.2) <7=
22573CC-31CC-34B2-9032-E4F652A9CCFE> /System/Library/Frameworks/Accelerate.=
framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libSparseBLAS.d=
ylib
    0x7fff3ab48000 -     0x7fff3acf5fc3  libvDSP.dylib (622.50.5) <40690941=
-CF89-3F90-A0AC-A4D200744A5D> /System/Library/Frameworks/Accelerate.framewo=
rk/Versions/A/Frameworks/vecLib.framework/Versions/A/libvDSP.dylib
    0x7fff3acf6000 -     0x7fff3ada7fff  libvMisc.dylib (622.50.5) <BA2532D=
F-2D68-3DD0-9B59-D434BF702AA4> /System/Library/Frameworks/Accelerate.framew=
ork/Versions/A/Frameworks/vecLib.framework/Versions/A/libvMisc.dylib
    0x7fff3ada8000 -     0x7fff3ada8fff  com.apple.Accelerate.vecLib (3.11 =
- vecLib 3.11) <54FF3B43-E66C-3F36-B34B-A2B3B0A36502> /System/Library/Frame=
works/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/=
A/vecLib
    0x7fff3b09c000 -     0x7fff3befafff  com.apple.AppKit (6.9 - 1561.60.10=
0) <3C27CF6F-E640-3411-A87D-CCB2222CC754> /System/Library/Frameworks/AppKit=
.framework/Versions/C/AppKit
    0x7fff3bf4c000 -     0x7fff3bf4cfff  com.apple.ApplicationServices (48 =
- 50) <AFFBD94A-AF76-336E-B53E-57524EAE8EF3> /System/Library/Frameworks/App=
licationServices.framework/Versions/A/ApplicationServices
    0x7fff3bf4d000 -     0x7fff3bfb3fff  com.apple.ApplicationServices.ATS =
(377 - 445.4) <85E779EE-0219-3181-B4C4-201E4CC82AB5> /System/Library/Framew=
orks/ApplicationServices.framework/Versions/A/Frameworks/ATS.framework/Vers=
ions/A/ATS
    0x7fff3c04c000 -     0x7fff3c16efff  libFontParser.dylib (222.1.6) <6CE=
BACDD-B848-302E-B4B2-630CB16E663E> /System/Library/Frameworks/ApplicationSe=
rvices.framework/Versions/A/Frameworks/ATS.framework/Versions/A/Resources/l=
ibFontParser.dylib
    0x7fff3c16f000 -     0x7fff3c1b9ff7  libFontRegistry.dylib (221.4) <5FD=
B4F1A-E15C-3ACB-A5C1-F15458C0C6DC> /System/Library/Frameworks/ApplicationSe=
rvices.framework/Versions/A/Frameworks/ATS.framework/Versions/A/Resources/l=
ibFontRegistry.dylib
    0x7fff3c25e000 -     0x7fff3c291ff7  libTrueTypeScaler.dylib (222.1.6) =
<9147F859-8BD9-31D9-AB54-8E9549B92AE9> /System/Library/Frameworks/Applicati=
onServices.framework/Versions/A/Frameworks/ATS.framework/Versions/A/Resourc=
es/libTrueTypeScaler.dylib
    0x7fff3c2fb000 -     0x7fff3c2ffff3  com.apple.ColorSyncLegacy (4.13.0 =
- 1) <A5FB2694-1559-34A8-A3D3-2029F68A63CA> /System/Library/Frameworks/Appl=
icationServices.framework/Versions/A/Frameworks/ColorSyncLegacy.framework/V=
ersions/A/ColorSyncLegacy
    0x7fff3c39f000 -     0x7fff3c3f1ffb  com.apple.HIServices (1.22 - 624.1=
) <66FD9ED2-9630-313C-86AE-4C2FBCB3F351> /System/Library/Frameworks/Applica=
tionServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/=
A/HIServices
    0x7fff3c3f2000 -     0x7fff3c400fff  com.apple.LangAnalysis (1.7.0 - 1.=
7.0) <B65FF7E6-E9B5-34D8-8CA7-63D415A8A9A6> /System/Library/Frameworks/Appl=
icationServices.framework/Versions/A/Frameworks/LangAnalysis.framework/Vers=
ions/A/LangAnalysis
    0x7fff3c401000 -     0x7fff3c44dfff  com.apple.print.framework.PrintCor=
e (13.4 - 503.2) <B90C67C1-0292-3CEC-885D-F1882CD104BE> /System/Library/Fra=
meworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.frame=
work/Versions/A/PrintCore
    0x7fff3c44e000 -     0x7fff3c488fff  com.apple.QD (3.12 - 404.2) <38B20=
AFF-9D54-3B52-A6DC-C0D71380AA5F> /System/Library/Frameworks/ApplicationServ=
ices.framework/Versions/A/Frameworks/QD.framework/Versions/A/QD
    0x7fff3c489000 -     0x7fff3c495fff  com.apple.speech.synthesis.framewo=
rk (7.8.1 - 7.8.1) <A08DE016-C8F2-3B0E-BD34-15959D13DBF0> /System/Library/F=
rameworks/ApplicationServices.framework/Versions/A/Frameworks/SpeechSynthes=
is.framework/Versions/A/SpeechSynthesis
    0x7fff3c496000 -     0x7fff3c724ff7  com.apple.audio.toolbox.AudioToolb=
ox (1.14 - 1.14) <E0B8B5D8-80A0-308B-ABD6-F8612102B5D8> /System/Library/Fra=
meworks/AudioToolbox.framework/Versions/A/AudioToolbox
    0x7fff3c726000 -     0x7fff3c726fff  com.apple.audio.units.AudioUnit (1=
.14 - 1.14) <ABF8778E-4F9D-305E-A528-DE406A1A2B68> /System/Library/Framewor=
ks/AudioUnit.framework/Versions/A/AudioUnit
    0x7fff3ca49000 -     0x7fff3cde3ff7  com.apple.CFNetwork (902.1 - 902.1=
) <76EB8CB6-BF59-3BDA-BF2B-F21B161611B9> /System/Library/Frameworks/CFNetwo=
rk.framework/Versions/A/CFNetwork
    0x7fff3cdf8000 -     0x7fff3cdf8fff  com.apple.Carbon (158 - 158) <F8B3=
70D9-2103-3276-821D-ACC756167F86> /System/Library/Frameworks/Carbon.framewo=
rk/Versions/A/Carbon
    0x7fff3cdf9000 -     0x7fff3cdfcffb  com.apple.CommonPanels (1.2.6 - 98=
) <2391761C-5CAA-3F68-86B7-50B37927B104> /System/Library/Frameworks/Carbon.=
framework/Versions/A/Frameworks/CommonPanels.framework/Versions/A/CommonPan=
els
    0x7fff3cdfd000 -     0x7fff3d102fff  com.apple.HIToolbox (2.1.1 - 911.1=
0) <BF7F9C0E-C732-3FB2-9BBC-362888BDA57B> /System/Library/Frameworks/Carbon=
.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/HIToolbox
    0x7fff3d103000 -     0x7fff3d106ffb  com.apple.help (1.3.8 - 66) <DEBAD=
FA8-C189-3195-B0D6-A1F2DE95882A> /System/Library/Frameworks/Carbon.framewor=
k/Versions/A/Frameworks/Help.framework/Versions/A/Help
    0x7fff3d107000 -     0x7fff3d10cfff  com.apple.ImageCapture (9.0 - 9.0)=
 <23B4916F-3B43-3DFF-B956-FC390EECA284> /System/Library/Frameworks/Carbon.f=
ramework/Versions/A/Frameworks/ImageCapture.framework/Versions/A/ImageCaptu=
re
    0x7fff3d10d000 -     0x7fff3d1a2ffb  com.apple.ink.framework (10.9 - 22=
1) <5206C8B0-22DA-36C9-998E-846EDB626D5B> /System/Library/Frameworks/Carbon=
.framework/Versions/A/Frameworks/Ink.framework/Versions/A/Ink
    0x7fff3d1a3000 -     0x7fff3d1bdff7  com.apple.openscripting (1.7 - 174=
) <1B2A1F9E-5534-3D61-83CA-9199B39E8708> /System/Library/Frameworks/Carbon.=
framework/Versions/A/Frameworks/OpenScripting.framework/Versions/A/OpenScri=
pting
    0x7fff3d1de000 -     0x7fff3d1dffff  com.apple.print.framework.Print (1=
2 - 267) <3682ABFB-2561-3419-847D-02C247F4800D> /System/Library/Frameworks/=
Carbon.framework/Versions/A/Frameworks/Print.framework/Versions/A/Print
    0x7fff3d1e0000 -     0x7fff3d1e2ff7  com.apple.securityhi (9.0 - 55006)=
 <C1406B8D-7D05-3959-808F-9C82189CF57F> /System/Library/Frameworks/Carbon.f=
ramework/Versions/A/Frameworks/SecurityHI.framework/Versions/A/SecurityHI
    0x7fff3d1e3000 -     0x7fff3d1e9fff  com.apple.speech.recognition.frame=
work (6.0.3 - 6.0.3) <2ED8643D-B0C3-3F17-82A2-BBF13E6CBABC> /System/Library=
/Frameworks/Carbon.framework/Versions/A/Frameworks/SpeechRecognition.framew=
ork/Versions/A/SpeechRecognition
    0x7fff3d30a000 -     0x7fff3d30afff  com.apple.Cocoa (6.11 - 22) <78E6C=
28E-4308-3D10-AD14-0CBCF6789B3F> /System/Library/Frameworks/Cocoa.framework=
/Versions/A/Cocoa
    0x7fff3d318000 -     0x7fff3d3d1fff  com.apple.ColorSync (4.13.0 - 3325=
) <D283C285-447D-3258-A7E4-59532123B8FF> /System/Library/Frameworks/ColorSy=
nc.framework/Versions/A/ColorSync
    0x7fff3d55e000 -     0x7fff3d5f1ff7  com.apple.audio.CoreAudio (4.3.0 -=
 4.3.0) <EB35D3EC-56EA-33E6-98DC-BDC3A5FA8ACE> /System/Library/Frameworks/C=
oreAudio.framework/Versions/A/CoreAudio
    0x7fff3d658000 -     0x7fff3d681ffb  com.apple.CoreBluetooth (1.0 - 1) =
<E1335074-9D07-370E-8440-61C4874BAC56> /System/Library/Frameworks/CoreBluet=
ooth.framework/Versions/A/CoreBluetooth
    0x7fff3d682000 -     0x7fff3d9d8fef  com.apple.CoreData (120 - 851) <A2=
B59780-FB16-36A3-8EE0-E0EF072454E0> /System/Library/Frameworks/CoreData.fra=
mework/Versions/A/CoreData
    0x7fff3d9d9000 -     0x7fff3dabcfff  com.apple.CoreDisplay (99.14 - 99.=
14) <A1B91ADD-828D-33A0-8A92-CC3F83DF89D0> /System/Library/Frameworks/CoreD=
isplay.framework/Versions/A/CoreDisplay
    0x7fff3dabd000 -     0x7fff3df5efef  com.apple.CoreFoundation (6.9 - 14=
54.90) <E5D594BF-9142-3325-A62D-CF4AAF472642> /System/Library/Frameworks/Co=
reFoundation.framework/Versions/A/CoreFoundation
    0x7fff3df60000 -     0x7fff3e570fef  com.apple.CoreGraphics (2.0 - 1161=
.21) <375C477F-5A89-3C49-9B63-373C81A63F7E> /System/Library/Frameworks/Core=
Graphics.framework/Versions/A/CoreGraphics
    0x7fff3e572000 -     0x7fff3e861fff  com.apple.CoreImage (13.0.0 - 579.=
5) <AAE2DFD0-9B0A-3D56-8A3E-C460BAF70394> /System/Library/Frameworks/CoreIm=
age.framework/Versions/A/CoreImage
    0x7fff3ec36000 -     0x7fff3ec36fff  com.apple.CoreServices (822.36 - 8=
22.36) <C8368F17-1589-3BA5-A0E7-89CB8DF2454F> /System/Library/Frameworks/Co=
reServices.framework/Versions/A/CoreServices
    0x7fff3ec37000 -     0x7fff3ecabffb  com.apple.AE (735.1 - 735.1) <08EB=
A184-20F7-3725-AEA6-C314448161C6> /System/Library/Frameworks/CoreServices.f=
ramework/Versions/A/Frameworks/AE.framework/Versions/A/AE
    0x7fff3ecac000 -     0x7fff3ef83fff  com.apple.CoreServices.CarbonCore =
(1178.4 - 1178.4) <0D5E19BF-18CB-3FA4-8A5F-F6C787C5EE08> /System/Library/Fr=
ameworks/CoreServices.framework/Versions/A/Frameworks/CarbonCore.framework/=
Versions/A/CarbonCore
    0x7fff3ef84000 -     0x7fff3efb8fff  com.apple.DictionaryServices (1.2 =
- 284.2) <6505B075-41C3-3C62-A4C3-85CE3F6825CD> /System/Library/Frameworks/=
CoreServices.framework/Versions/A/Frameworks/DictionaryServices.framework/V=
ersions/A/DictionaryServices
    0x7fff3efb9000 -     0x7fff3efc1ffb  com.apple.CoreServices.FSEvents (1=
239.50.1 - 1239.50.1) <3637CEC7-DF0E-320E-9634-44A442925C65> /System/Librar=
y/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framewor=
k/Versions/A/FSEvents
    0x7fff3efc2000 -     0x7fff3f17ffff  com.apple.LaunchServices (822.36 -=
 822.36) <6E68C090-B12D-3D3D-9617-E5D82C36B2D0> /System/Library/Frameworks/=
CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versi=
ons/A/LaunchServices
    0x7fff3f180000 -     0x7fff3f230ff7  com.apple.Metadata (10.7.0 - 1191.=
4.13) <B5C22E70-C265-3C9F-865F-B138994A418D> /System/Library/Frameworks/Cor=
eServices.framework/Versions/A/Frameworks/Metadata.framework/Versions/A/Met=
adata
    0x7fff3f231000 -     0x7fff3f291fff  com.apple.CoreServices.OSServices =
(822.36 - 822.36) <3BB2E0CE-81AE-3D3D-9FCE-E1B7FC6D6A61> /System/Library/Fr=
ameworks/CoreServices.framework/Versions/A/Frameworks/OSServices.framework/=
Versions/A/OSServices
    0x7fff3f292000 -     0x7fff3f300fff  com.apple.SearchKit (1.4.0 - 1.4.0=
) <3662545A-B1CF-3079-BDCD-C83855CEFEEE> /System/Library/Frameworks/CoreSer=
vices.framework/Versions/A/Frameworks/SearchKit.framework/Versions/A/Search=
Kit
    0x7fff3f301000 -     0x7fff3f325ffb  com.apple.coreservices.SharedFileL=
ist (71.21 - 71.21) <35582D88-5975-35E2-A29A-E3148C3EE727> /System/Library/=
Frameworks/CoreServices.framework/Versions/A/Frameworks/SharedFileList.fram=
ework/Versions/A/SharedFileList
    0x7fff3f5c6000 -     0x7fff3f716fff  com.apple.CoreText (352.0 - 578.22=
) <6129F39D-284D-3BBF-8999-7854AB61C01C> /System/Library/Frameworks/CoreTex=
t.framework/Versions/A/CoreText
    0x7fff3f717000 -     0x7fff3f751fff  com.apple.CoreVideo (1.8 - 0.0) <8=
6CCC036-51BB-3DD1-9601-D93798BCCD0F> /System/Library/Frameworks/CoreVideo.f=
ramework/Versions/A/CoreVideo
    0x7fff3f752000 -     0x7fff3f7ddff3  com.apple.framework.CoreWLAN (13.0=
 - 1350.1) <E862CC02-69D2-3503-887B-B6E8223081E7> /System/Library/Framework=
s/CoreWLAN.framework/Versions/A/CoreWLAN
    0x7fff3fa58000 -     0x7fff3fa5dfff  com.apple.DiskArbitration (2.7 - 2=
.7) <A975AD56-4CD3-3A89-8732-858CA9BD3DAA> /System/Library/Frameworks/DiskA=
rbitration.framework/Versions/A/DiskArbitration
    0x7fff3fc1e000 -     0x7fff3ffe4fff  com.apple.Foundation (6.9 - 1454.9=
0) <8EA924F3-ADAE-3F4B-8482-8B11C027D9A5> /System/Library/Frameworks/Founda=
tion.framework/Versions/C/Foundation
    0x7fff40055000 -     0x7fff40085fff  com.apple.GSS (4.0 - 2.0) <D774A16=
5-5581-3479-AB5D-2BBDB5CF8882> /System/Library/Frameworks/GSS.framework/Ver=
sions/A/GSS
    0x7fff4015f000 -     0x7fff40163ff7  com.apple.Hypervisor (1.0 - 1) <54=
448501-AF47-3409-BBF4-283F77D2E4A0> /System/Library/Frameworks/Hypervisor.f=
ramework/Versions/A/Hypervisor
    0x7fff40197000 -     0x7fff4029bffb  com.apple.Bluetooth (6.0.7 - 6.0.7=
f10) <557F26F9-C7A0-34EA-A905-22E243BF6B48> /System/Library/Frameworks/IOBl=
uetooth.framework/Versions/A/IOBluetooth
    0x7fff402fb000 -     0x7fff40396fff  com.apple.framework.IOKit (2.0.2 -=
 1445.71.1) <2EA4F383-CAA9-3AF0-99C5-90C22ADAA6B6> /System/Library/Framewor=
ks/IOKit.framework/Versions/A/IOKit
    0x7fff40398000 -     0x7fff4039ffff  com.apple.IOSurface (211.15 - 211.=
15) <9FD406F1-6BF2-35B0-8339-DF83A1A661EB> /System/Library/Frameworks/IOSur=
face.framework/Versions/A/IOSurface
    0x7fff403f6000 -     0x7fff40570ff7  com.apple.ImageIO.framework (3.3.0=
 - 1739.3) <7C579D3F-AE0B-31C9-8F80-67F2290B8DE0> /System/Library/Framework=
s/ImageIO.framework/Versions/A/ImageIO
    0x7fff40571000 -     0x7fff40575ffb  libGIF.dylib (1739.3) <7AA44C9D-48=
E8-3090-B044-61FE6F0AEF38> /System/Library/Frameworks/ImageIO.framework/Ver=
sions/A/Resources/libGIF.dylib
    0x7fff40576000 -     0x7fff4065dfef  libJP2.dylib (1739.3) <AEBF7260-0C=
10-30C0-8F0F-8B347DEE78B3> /System/Library/Frameworks/ImageIO.framework/Ver=
sions/A/Resources/libJP2.dylib
    0x7fff4065e000 -     0x7fff40681ff7  libJPEG.dylib (1739.3) <D8C966AD-A=
00C-3E8B-A7ED-D7CC7ECB3224> /System/Library/Frameworks/ImageIO.framework/Ve=
rsions/A/Resources/libJPEG.dylib
    0x7fff4095d000 -     0x7fff40983feb  libPng.dylib (1739.3) <1737F680-99=
D1-3F03-BFA5-5CDA30EB880A> /System/Library/Frameworks/ImageIO.framework/Ver=
sions/A/Resources/libPng.dylib
    0x7fff40984000 -     0x7fff40986ffb  libRadiance.dylib (1739.3) <217464=
34-FCC7-36DE-9331-11277DF66AA8> /System/Library/Frameworks/ImageIO.framewor=
k/Versions/A/Resources/libRadiance.dylib
    0x7fff40987000 -     0x7fff409d5fef  libTIFF.dylib (1739.3) <C4CB5C1D-2=
0F2-3BD4-B0E6-629FDB3EF8E8> /System/Library/Frameworks/ImageIO.framework/Ve=
rsions/A/Resources/libTIFF.dylib
    0x7fff4188f000 -     0x7fff418a8ff7  com.apple.Kerberos (3.0 - 1) <F86D=
CCDF-93C1-38B3-82C2-477C12E8EE6D> /System/Library/Frameworks/Kerberos.frame=
work/Versions/A/Kerberos
    0x7fff418a9000 -     0x7fff418defff  com.apple.LDAPFramework (2.4.28 - =
194.5) <08888215-BBCE-3402-8142-2C9ADB091580> /System/Library/Frameworks/LD=
AP.framework/Versions/A/LDAP
    0x7fff4228a000 -     0x7fff4230bfff  com.apple.Metal (125.30 - 125.30) =
<975FD6B5-D695-346A-869F-0584A968D100> /System/Library/Frameworks/Metal.fra=
mework/Versions/A/Metal
    0x7fff42328000 -     0x7fff42343fff  com.apple.MetalPerformanceShaders.=
MPSCore (1.0 - 1) <AD754E8F-CA00-3878-9AF3-208C224A230B> /System/Library/Fr=
ameworks/MetalPerformanceShaders.framework/Frameworks/MPSCore.framework/Ver=
sions/A/MPSCore
    0x7fff42344000 -     0x7fff423b3fef  com.apple.MetalPerformanceShaders.=
MPSImage (1.0 - 1) <338B7779-E608-3D68-8A07-2ACC11299744> /System/Library/F=
rameworks/MetalPerformanceShaders.framework/Frameworks/MPSImage.framework/V=
ersions/A/MPSImage
    0x7fff423b4000 -     0x7fff423d8fff  com.apple.MetalPerformanceShaders.=
MPSMatrix (1.0 - 1) <9CE072D7-853B-3939-9645-7EB951376B87> /System/Library/=
Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSMatrix.framework=
/Versions/A/MPSMatrix
    0x7fff423d9000 -     0x7fff424c0ff7  com.apple.MetalPerformanceShaders.=
MPSNeuralNetwork (1.0 - 1) <0DE891AD-27E5-38FF-AEC8-4A95356C4357> /System/L=
ibrary/Frameworks/MetalPerformanceShaders.framework/Frameworks/MPSNeuralNet=
work.framework/Versions/A/MPSNeuralNetwork
    0x7fff424c1000 -     0x7fff424c1ff7  com.apple.MetalPerformanceShaders.=
MetalPerformanceShaders (1.0 - 1) <2D2D261C-50B0-32F9-BF9A-5C01382BB528> /S=
ystem/Library/Frameworks/MetalPerformanceShaders.framework/Versions/A/Metal=
PerformanceShaders
    0x7fff434c0000 -     0x7fff434ccffb  com.apple.NetFS (6.0 - 4.0) <471DD=
96F-FA2E-3FE9-9746-2519A6780D1A> /System/Library/Frameworks/NetFS.framework=
/Versions/A/NetFS
    0x7fff462be000 -     0x7fff46318ff7  com.apple.opencl (2.8.24 - 2.8.24)=
 <4D7401A7-6ADD-3632-85AE-7A5012DFFA04> /System/Library/Frameworks/OpenCL.f=
ramework/Versions/A/OpenCL
    0x7fff46319000 -     0x7fff46335ffb  com.apple.CFOpenDirectory (10.13 -=
 207.50.1) <29F55F7B-379F-3053-8FF3-5C6675A3DD4D> /System/Library/Framework=
s/OpenDirectory.framework/Versions/A/Frameworks/CFOpenDirectory.framework/V=
ersions/A/CFOpenDirectory
    0x7fff46336000 -     0x7fff46341fff  com.apple.OpenDirectory (10.13 - 2=
07.50.1) <F895547D-4915-353F-9C1E-E95172BA803B> /System/Library/Frameworks/=
OpenDirectory.framework/Versions/A/OpenDirectory
    0x7fff474c0000 -     0x7fff474c2fff  libCVMSPluginSupport.dylib (16.7.4=
) <F9270AE0-CC3B-3E3E-BA32-CC1068DD8F27> /System/Library/Frameworks/OpenGL.=
framework/Versions/A/Libraries/libCVMSPluginSupport.dylib
    0x7fff474c3000 -     0x7fff474c8ffb  libCoreFSCache.dylib (162.9) <7AF8=
7F3E-D5D0-3625-BE09-CA4223195466> /System/Library/Frameworks/OpenGL.framewo=
rk/Versions/A/Libraries/libCoreFSCache.dylib
    0x7fff474c9000 -     0x7fff474cdfff  libCoreVMClient.dylib (162.9) <115=
FE643-6141-39B4-8193-77DFCBE7A4E0> /System/Library/Frameworks/OpenGL.framew=
ork/Versions/A/Libraries/libCoreVMClient.dylib
    0x7fff474ce000 -     0x7fff474d7ff3  libGFXShared.dylib (16.7.4) <EB2BF=
8A0-E10D-35EA-8F46-B2E3C62C12A8> /System/Library/Frameworks/OpenGL.framewor=
k/Versions/A/Libraries/libGFXShared.dylib
    0x7fff474d8000 -     0x7fff474e3fff  libGL.dylib (16.7.4) <2BB333D3-5C6=
1-33DF-8545-06DF2D08B83D> /System/Library/Frameworks/OpenGL.framework/Versi=
ons/A/Libraries/libGL.dylib
    0x7fff474e4000 -     0x7fff4751ffe7  libGLImage.dylib (16.7.4) <4DA003C=
E-0B74-3FE4-808C-B2FBCE517EB4> /System/Library/Frameworks/OpenGL.framework/=
Versions/A/Libraries/libGLImage.dylib
    0x7fff4768e000 -     0x7fff476ccffb  libGLU.dylib (16.7.4) <BCB09CD8-EB=
0E-38FA-8B5A-9E29532EE364> /System/Library/Frameworks/OpenGL.framework/Vers=
ions/A/Libraries/libGLU.dylib
    0x7fff48044000 -     0x7fff48053ff3  com.apple.opengl (16.7.4 - 16.7.4)=
 <9BDE8FF9-5418-3C70-8D1C-09656884CE48> /System/Library/Frameworks/OpenGL.f=
ramework/Versions/A/OpenGL
    0x7fff48ea2000 -     0x7fff490eeff7  com.apple.QuartzCore (1.11 - 584.6=
2) <1950D993-DE48-3C97-95A5-66D98BDFC95D> /System/Library/Frameworks/Quartz=
Core.framework/Versions/A/QuartzCore
    0x7fff49924000 -     0x7fff49c4ffff  com.apple.security (7.0 - 58286.70=
.7) <9FC166E1-14D0-305C-A086-02B9E83F547E> /System/Library/Frameworks/Secur=
ity.framework/Versions/A/Security
    0x7fff49c50000 -     0x7fff49cdcff7  com.apple.securityfoundation (6.0 =
- 55185.50.5) <D708D069-AEDB-36C2-B1DA-479DA91D7711> /System/Library/Framew=
orks/SecurityFoundation.framework/Versions/A/SecurityFoundation
    0x7fff49d0e000 -     0x7fff49d12ffb  com.apple.xpc.ServiceManagement (1=
.0 - 1) <71B45D83-ECA4-3265-997E-683A8B8DF413> /System/Library/Frameworks/S=
erviceManagement.framework/Versions/A/ServiceManagement
    0x7fff4a0b7000 -     0x7fff4a127ff3  com.apple.SystemConfiguration (1.1=
7 - 1.17) <8532B8E9-7E30-35A3-BC4A-DDE8E0614FDA> /System/Library/Frameworks=
/SystemConfiguration.framework/Versions/A/SystemConfiguration
    0x7fff4d024000 -     0x7fff4d0b7fff  com.apple.APFS (1.0 - 1) <6BBB3988=
-1C91-314F-A77A-4E093A1B18F0> /System/Library/PrivateFrameworks/APFS.framew=
ork/Versions/A/APFS
    0x7fff4dce2000 -     0x7fff4dd0afff  com.apple.framework.Apple80211 (13=
.0 - 1361.7) <16627876-8CF5-3502-A1D6-35FCBDD5E79A> /System/Library/Private=
Frameworks/Apple80211.framework/Versions/A/Apple80211
    0x7fff4dd0c000 -     0x7fff4dd1bfef  com.apple.AppleFSCompression (96.6=
0.1 - 1.0) <A7C875C4-F5EE-3272-AFB6-57C9FD5352B3> /System/Library/PrivateFr=
ameworks/AppleFSCompression.framework/Versions/A/AppleFSCompression
    0x7fff4de1a000 -     0x7fff4de25ff7  com.apple.AppleIDAuthSupport (1.0 =
- 1) <2FAF5567-CDB3-33EF-AB71-05D37F2248B7> /System/Library/PrivateFramewor=
ks/AppleIDAuthSupport.framework/Versions/A/AppleIDAuthSupport
    0x7fff4de5f000 -     0x7fff4dea7ff3  com.apple.AppleJPEG (1.0 - 1) <8DD=
410CB-76A1-3F22-9A9F-0491FA0CEB4A> /System/Library/PrivateFrameworks/AppleJ=
PEG.framework/Versions/A/AppleJPEG
    0x7fff4ded9000 -     0x7fff4dee1ff3  com.apple.AppleSRP (5.0 - 1) <4CEC=
34CF-63E3-3023-B61B-F8D133698534> /System/Library/PrivateFrameworks/AppleSR=
P.framework/Versions/A/AppleSRP
    0x7fff4dee2000 -     0x7fff4df0afff  com.apple.applesauce (1.0 - ???) <=
CCA8B094-1BCE-3AE3-A0A7-D544C818DE36> /System/Library/PrivateFrameworks/App=
leSauce.framework/Versions/A/AppleSauce
    0x7fff4e35c000 -     0x7fff4e5f5ffb  com.apple.AuthKit (1.0 - 1) <6CA71=
A11-91C5-307C-B933-9FCDEDCB580A> /System/Library/PrivateFrameworks/AuthKit.=
framework/Versions/A/AuthKit
    0x7fff4e72c000 -     0x7fff4e733ff7  com.apple.coreservices.BackgroundT=
askManagement (1.0 - 57.1) <51A41CA3-DB1D-3380-993E-99C54AEE518E> /System/L=
ibrary/PrivateFrameworks/BackgroundTaskManagement.framework/Versions/A/Back=
groundTaskManagement
    0x7fff4e734000 -     0x7fff4e7bbff7  com.apple.backup.framework (1.9.5 =
- 1.9.5) <5E7B0925-8C71-353D-BB0F-9CA144BB264C> /System/Library/PrivateFram=
eworks/Backup.framework/Versions/A/Backup
    0x7fff50175000 -     0x7fff5017eff3  com.apple.CommonAuth (4.0 - 2.0) <=
4D237B25-27E5-3577-948B-073659F6D3C0> /System/Library/PrivateFrameworks/Com=
monAuth.framework/Versions/A/CommonAuth
    0x7fff50b0d000 -     0x7fff50b16ff7  com.apple.frameworks.CoreDaemon (1=
.3 - 1.3) <35A43584-2AF8-3202-A139-27D916E444BE> /System/Library/PrivateFra=
meworks/CoreDaemon.framework/Versions/B/CoreDaemon
    0x7fff50c84000 -     0x7fff50c94ff7  com.apple.CoreEmoji (1.0 - 69.3) <=
A4357F5C-0C38-3A61-B456-D7321EB2CEE5> /System/Library/PrivateFrameworks/Cor=
eEmoji.framework/Versions/A/CoreEmoji
    0x7fff51428000 -     0x7fff51430ff3  com.apple.CorePhoneNumbers (1.0 - =
1) <A5D41251-9F38-3AB9-9DE7-F77023FAAA44> /System/Library/PrivateFrameworks=
/CorePhoneNumbers.framework/Versions/A/CorePhoneNumbers
    0x7fff515bb000 -     0x7fff515ecff3  com.apple.CoreServicesInternal (30=
9.1 - 309.1) <4ECD14EA-A493-3B84-A32F-CF928474A405> /System/Library/Private=
Frameworks/CoreServicesInternal.framework/Versions/A/CoreServicesInternal
    0x7fff51929000 -     0x7fff519bafff  com.apple.CoreSymbolication (9.3 -=
 64026.2) <D55A6E5B-0267-3F3A-8D90-4B8F39458420> /System/Library/PrivateFra=
meworks/CoreSymbolication.framework/Versions/A/CoreSymbolication
    0x7fff51a3d000 -     0x7fff51b72fff  com.apple.coreui (2.1 - 494.1) <B2=
C515C3-FCE8-3B28-A225-05AD917F509B> /System/Library/PrivateFrameworks/CoreU=
I.framework/Versions/A/CoreUI
    0x7fff51b73000 -     0x7fff51ca4fff  com.apple.CoreUtils (5.6 - 560.11)=
 <1A02D6F0-8C65-3FAE-AD63-56477EDE4773> /System/Library/PrivateFrameworks/C=
oreUtils.framework/Versions/A/CoreUtils
    0x7fff51cf9000 -     0x7fff51d5dfff  com.apple.framework.CoreWiFi (13.0=
 - 1350.1) <6EC5DEB3-6E2F-3DC2-BE59-1FD05175FB0C> /System/Library/PrivateFr=
ameworks/CoreWiFi.framework/Versions/A/CoreWiFi
    0x7fff51d5e000 -     0x7fff51d6eff7  com.apple.CrashReporterSupport (10=
.13 - 1) <A909F468-0648-3F51-A77E-3F9ADBC9A941> /System/Library/PrivateFram=
eworks/CrashReporterSupport.framework/Versions/A/CrashReporterSupport
    0x7fff51dec000 -     0x7fff51dfbff7  com.apple.framework.DFRFoundation =
(1.0 - 191.7) <5F486F5A-3795-3CD4-86A2-FD008A23F205> /System/Library/Privat=
eFrameworks/DFRFoundation.framework/Versions/A/DFRFoundation
    0x7fff51dfe000 -     0x7fff51e02ffb  com.apple.DSExternalDisplay (3.1 -=
 380) <901B7F6D-376A-3848-99D0-170C4D00F776> /System/Library/PrivateFramewo=
rks/DSExternalDisplay.framework/Versions/A/DSExternalDisplay
    0x7fff51e84000 -     0x7fff51efafff  com.apple.datadetectorscore (7.0 -=
 590.3) <7437160E-68A3-3FD7-8868-5E3F92E23C4F> /System/Library/PrivateFrame=
works/DataDetectorsCore.framework/Versions/A/DataDetectorsCore
    0x7fff51f48000 -     0x7fff51f88ff7  com.apple.DebugSymbols (181.0 - 18=
1.0) <299A0238-ED78-3676-B131-274D972824AA> /System/Library/PrivateFramewor=
ks/DebugSymbols.framework/Versions/A/DebugSymbols
    0x7fff51f89000 -     0x7fff520b8fff  com.apple.desktopservices (1.12.5 =
- 1.12.5) <7739C9A5-64D9-31A5-899B-5FFA242AD70D> /System/Library/PrivateFra=
meworks/DesktopServicesPriv.framework/Versions/A/DesktopServicesPriv
    0x7fff52ed2000 -     0x7fff53300fff  com.apple.vision.FaceCore (3.3.2 -=
 3.3.2) <B574FE33-4A41-3611-9738-388EBAF03E37> /System/Library/PrivateFrame=
works/FaceCore.framework/Versions/A/FaceCore
    0x7fff54f5c000 -     0x7fff54f5cfff  libmetal_timestamp.dylib (802.4.8)=
 <311A8FAA-5FA9-3AAF-887E-DC9884DE8BE5> /System/Library/PrivateFrameworks/G=
PUCompiler.framework/Versions/3802/Libraries/libmetal_timestamp.dylib
    0x7fff565c8000 -     0x7fff565cdfff  com.apple.GPUWrangler (3.20.13 - 3=
.20.13) <9C5BD618-69E3-36D5-9BC9-A4841BC00D2A> /System/Library/PrivateFrame=
works/GPUWrangler.framework/Versions/A/GPUWrangler
    0x7fff57343000 -     0x7fff57352fff  com.apple.GraphVisualizer (1.0 - 5=
) <B993B8A2-5700-3DFC-9EB7-4CCEE8F959F1> /System/Library/PrivateFrameworks/=
GraphVisualizer.framework/Versions/A/GraphVisualizer
    0x7fff573d5000 -     0x7fff57449fff  com.apple.Heimdal (4.0 - 2.0) <930=
91531-CC91-34FF-8B93-5D3F02C37BC5> /System/Library/PrivateFrameworks/Heimda=
l.framework/Versions/A/Heimdal
    0x7fff57d4f000 -     0x7fff57d58fff  com.apple.IOAccelMemoryInfo (1.0 -=
 1) <E2416468-8B64-3BB8-A099-361954C8DED7> /System/Library/PrivateFramework=
s/IOAccelMemoryInfo.framework/Versions/A/IOAccelMemoryInfo
    0x7fff57d59000 -     0x7fff57d60ff7  com.apple.IOAccelerator (378.26 - =
378.26) <2274BE11-18DE-3B13-BCDB-C488C9BB19AD> /System/Library/PrivateFrame=
works/IOAccelerator.framework/Versions/A/IOAccelerator
    0x7fff57d64000 -     0x7fff57d7bfff  com.apple.IOPresentment (1.0 - 35.=
1) <7C6332FF-6535-3064-B437-1E9F70671927> /System/Library/PrivateFrameworks=
/IOPresentment.framework/Versions/A/IOPresentment
    0x7fff58146000 -     0x7fff5816cffb  com.apple.IconServices (97.6 - 97.=
6) <A56D826D-20D2-34BE-AACC-A80CFCB4E915> /System/Library/PrivateFrameworks=
/IconServices.framework/Versions/A/IconServices
    0x7fff583f1000 -     0x7fff58404ff3  com.apple.security.KeychainCircle.=
KeychainCircle (1.0 - 1) <AED421B0-90A0-3969-98A4-CCBCF2D3360B> /System/Lib=
rary/PrivateFrameworks/KeychainCircle.framework/Versions/A/KeychainCircle
    0x7fff58405000 -     0x7fff584faff7  com.apple.LanguageModeling (1.0 - =
159.5.3) <7F0AC200-E3DD-39FB-8A95-00DD70B66A9F> /System/Library/PrivateFram=
eworks/LanguageModeling.framework/Versions/A/LanguageModeling
    0x7fff584fb000 -     0x7fff5853dfff  com.apple.Lexicon-framework (1.0 -=
 33.5) <DC94CF9E-1EB4-3C0E-B298-CA1190885276> /System/Library/PrivateFramew=
orks/Lexicon.framework/Versions/A/Lexicon
    0x7fff58541000 -     0x7fff58548ff7  com.apple.LinguisticData (1.0 - 23=
8.3) <49A54649-1021-3DBD-99B8-1B2EDFFA5378> /System/Library/PrivateFramewor=
ks/LinguisticData.framework/Versions/A/LinguisticData
    0x7fff5925a000 -     0x7fff592c3ff7  com.apple.gpusw.MetalTools (1.0 - =
1) <458F319A-2707-3C83-8351-BD9F02EC05BD> /System/Library/PrivateFrameworks=
/MetalTools.framework/Versions/A/MetalTools
    0x7fff59443000 -     0x7fff5945cfff  com.apple.MobileKeyBag (2.0 - 1.0)=
 <32E63C7B-E133-33DE-A593-C3C10D64FCAA> /System/Library/PrivateFrameworks/M=
obileKeyBag.framework/Versions/A/MobileKeyBag
    0x7fff594e8000 -     0x7fff59512ffb  com.apple.MultitouchSupport.framew=
ork (1404.4 - 1404.4) <45374A2A-C0BC-3A70-8183-37295205CDFA> /System/Librar=
y/PrivateFrameworks/MultitouchSupport.framework/Versions/A/MultitouchSupport
    0x7fff59779000 -     0x7fff59784fff  com.apple.NetAuth (6.2 - 6.2) <B37=
95F63-C14A-33E1-9EE6-02A2E7661321> /System/Library/PrivateFrameworks/NetAut=
h.framework/Versions/A/NetAuth
    0x7fff5b01a000 -     0x7fff5b02affb  com.apple.PerformanceAnalysis (1.1=
94 - 194) <2844933E-B71C-3BE9-9A84-27B29E111F13> /System/Library/PrivateFra=
meworks/PerformanceAnalysis.framework/Versions/A/PerformanceAnalysis
    0x7fff5cde9000 -     0x7fff5ce07fff  com.apple.ProtocolBuffer (1 - 260)=
 <40704740-4A53-3010-A49B-08D1D69D1D5E> /System/Library/PrivateFrameworks/P=
rotocolBuffer.framework/Versions/A/ProtocolBuffer
    0x7fff5cfde000 -     0x7fff5d001ffb  com.apple.RemoteViewServices (2.0 =
- 125) <592323D1-CB44-35F1-9921-4C2AB8D920A0> /System/Library/PrivateFramew=
orks/RemoteViewServices.framework/Versions/A/RemoteViewServices
    0x7fff5e925000 -     0x7fff5ea3aff7  com.apple.Sharing (1050.22.2 - 105=
0.22.2) <4E3CCDF2-EA26-334F-8EBA-79BD28486C9D> /System/Library/PrivateFrame=
works/Sharing.framework/Versions/A/Sharing
    0x7fff5ea65000 -     0x7fff5ea66ff7  com.apple.performance.SignpostNoti=
fication (1.2.6 - 2.6) <8F04800F-3570-3392-A24D-B229FF03F7F9> /System/Libra=
ry/PrivateFrameworks/SignpostNotification.framework/Versions/A/SignpostNoti=
fication
    0x7fff5f7ae000 -     0x7fff5fa4aff7  com.apple.SkyLight (1.600.0 - 312.=
103) <27F91170-846C-3E9E-9B8A-788F27C7DAF5> /System/Library/PrivateFramewor=
ks/SkyLight.framework/Versions/A/SkyLight
    0x7fff60213000 -     0x7fff60220fff  com.apple.SpeechRecognitionCore (4=
.6.1 - 4.6.1) <87EE7AB5-6925-3D21-BE00-F155CB457699> /System/Library/Privat=
eFrameworks/SpeechRecognitionCore.framework/Versions/A/SpeechRecognitionCore
    0x7fff60dc6000 -     0x7fff60e4ffc7  com.apple.Symbolication (9.3 - 640=
33) <C2C55C9A-C264-3044-A953-16457148190A> /System/Library/PrivateFramework=
s/Symbolication.framework/Versions/A/Symbolication
    0x7fff613c0000 -     0x7fff613c8ff7  com.apple.TCC (1.0 - 1) <E1EB7272-=
FE6F-39AB-83CA-B2B5F2A88D9B> /System/Library/PrivateFrameworks/TCC.framewor=
k/Versions/A/TCC
    0x7fff615d5000 -     0x7fff61692ff7  com.apple.TextureIO (3.7 - 3.7) <F=
8BAC954-405D-3CC3-AB7B-048C866EF980> /System/Library/PrivateFrameworks/Text=
ureIO.framework/Versions/A/TextureIO
    0x7fff6173c000 -     0x7fff6173dfff  com.apple.TrustEvaluationAgent (2.=
0 - 31) <39F533B2-211E-3635-AF47-23F27749FF4A> /System/Library/PrivateFrame=
works/TrustEvaluationAgent.framework/Versions/A/TrustEvaluationAgent
    0x7fff61743000 -     0x7fff618f2fff  com.apple.UIFoundation (1.0 - 547.=
5) <86A2FBA7-2709-3894-A3D5-A00C19BAC48D> /System/Library/PrivateFrameworks=
/UIFoundation.framework/Versions/A/UIFoundation
    0x7fff625c7000 -     0x7fff62696ff7  com.apple.ViewBridge (343.2 - 343.=
2) <5519FCED-1F88-3BE6-9BE1-69992086B01B> /System/Library/PrivateFrameworks=
/ViewBridge.framework/Versions/A/ViewBridge
    0x7fff62ffb000 -     0x7fff62ffdffb  com.apple.loginsupport (1.0 - 1) <=
D1232C1B-80EA-3DF8-9466-013695D0846E> /System/Library/PrivateFrameworks/log=
in.framework/Versions/A/Frameworks/loginsupport.framework/Versions/A/logins=
upport
    0x7fff63164000 -     0x7fff63197ff7  libclosured.dylib (551.4) <3FB6B20=
9-51F4-38DA-B1D8-2EE29D5BDD83> /usr/lib/closure/libclosured.dylib
    0x7fff63251000 -     0x7fff6328aff7  libCRFSuite.dylib (41) <FE5EDB68-2=
593-3C2E-BBAF-1C52D206F296> /usr/lib/libCRFSuite.dylib
    0x7fff6328b000 -     0x7fff63296fff  libChineseTokenizer.dylib (28) <53=
633C9B-A3A8-36F7-A53C-432D802F4BB8> /usr/lib/libChineseTokenizer.dylib
    0x7fff63328000 -     0x7fff63329ff3  libDiagnosticMessagesClient.dylib =
(104) <9712E980-76EE-3A89-AEA6-DF4BAF5C0574> /usr/lib/libDiagnosticMessages=
Client.dylib
    0x7fff63360000 -     0x7fff6352aff3  libFosl_dynamic.dylib (17.8) <C58E=
D77A-4986-31C2-994C-34DDFB8106F0> /usr/lib/libFosl_dynamic.dylib
    0x7fff63562000 -     0x7fff63562fff  libOpenScriptingUtil.dylib (174) <=
610F0242-7CE5-3C86-951B-B646562694AF> /usr/lib/libOpenScriptingUtil.dylib
    0x7fff63699000 -     0x7fff6369dffb  libScreenReader.dylib (562.18.4) <=
E239923D-54C9-3BBF-852F-87C09DEF4091> /usr/lib/libScreenReader.dylib
    0x7fff6369e000 -     0x7fff6369fffb  libSystem.B.dylib (1252.50.4) <CD5=
55F3B-FDDB-35E5-A2FB-FBBF3D62031A> /usr/lib/libSystem.B.dylib
    0x7fff63732000 -     0x7fff63732fff  libapple_crypto.dylib (109.50.14) =
<48BA2E76-BF2F-3522-A54E-D7FB7EAF7A57> /usr/lib/libapple_crypto.dylib
    0x7fff63733000 -     0x7fff63749ff7  libapple_nghttp2.dylib (1.24) <014=
02BC4-4822-3676-9C80-50D83F816424> /usr/lib/libapple_nghttp2.dylib
    0x7fff6374a000 -     0x7fff63774ff3  libarchive.2.dylib (54) <8FC28DD8-=
E315-3C3E-95FE-D1D2CBE49888> /usr/lib/libarchive.2.dylib
    0x7fff63775000 -     0x7fff637f6fdf  libate.dylib (1.13.1) <178ACDAD-DE=
7E-346C-A613-1CBF7929AC07> /usr/lib/libate.dylib
    0x7fff637fa000 -     0x7fff637faff3  libauto.dylib (187) <A05C7900-F8C7=
-3E75-8D3F-909B40C19717> /usr/lib/libauto.dylib
    0x7fff637fb000 -     0x7fff638b3ff3  libboringssl.dylib (109.50.14) <E6=
813F87-B5E4-3F7F-A725-E6A7F2BD02EC> /usr/lib/libboringssl.dylib
    0x7fff638b4000 -     0x7fff638c4ff3  libbsm.0.dylib (39) <6BC96A72-AFBE=
-34FD-91B1-748A530D8AE6> /usr/lib/libbsm.0.dylib
    0x7fff638c5000 -     0x7fff638d2ffb  libbz2.1.0.dylib (38) <0A5086BB-47=
24-3C14-979D-5AD4F26B5B45> /usr/lib/libbz2.1.0.dylib
    0x7fff638d3000 -     0x7fff63929fff  libc++.1.dylib (400.9) <7D3DACCC-3=
804-393C-ABC1-1A580FD00CB6> /usr/lib/libc++.1.dylib
    0x7fff6392a000 -     0x7fff6394eff7  libc++abi.dylib (400.8.2) <EF5E37D=
7-11D9-3530-BE45-B986612D13E2> /usr/lib/libc++abi.dylib
    0x7fff63950000 -     0x7fff63960fff  libcmph.dylib (6) <A5509EE8-7E00-3=
224-8814-015B077A3CF5> /usr/lib/libcmph.dylib
    0x7fff63961000 -     0x7fff63978fcf  libcompression.dylib (47.60.2) <54=
3F07BF-2F2F-37D5-9866-E84BF659885B> /usr/lib/libcompression.dylib
    0x7fff63c23000 -     0x7fff63c3bff7  libcoretls.dylib (155.50.1) <D3500=
52E-DC4D-3185-ADBA-BA48EDCEE955> /usr/lib/libcoretls.dylib
    0x7fff63c3c000 -     0x7fff63c3dff3  libcoretls_cfhelpers.dylib (155.50=
.1) <B297F5D8-F2FE-3566-A752-E9D998B9C039> /usr/lib/libcoretls_cfhelpers.dy=
lib
    0x7fff63dd6000 -     0x7fff63f67fff  libcrypto.35.dylib (22.50.2) <9782=
8BFD-4675-35DF-BE2E-C6D1555BB71D> /usr/lib/libcrypto.35.dylib
    0x7fff6410e000 -     0x7fff64164ff3  libcups.2.dylib (462.2.4) <908099F=
B-C70E-38FA-9573-88CB98FDDE29> /usr/lib/libcups.2.dylib
    0x7fff6418f000 -     0x7fff641e3ffb  libcurl.4.dylib (105.40.1) <B04E77=
91-EAF9-3D72-B4ED-DD8F135140EC> /usr/lib/libcurl.4.dylib
    0x7fff642a4000 -     0x7fff642a4fff  libenergytrace.dylib (16) <A92AB8B=
8-B986-3CE6-980D-D55090FEF387> /usr/lib/libenergytrace.dylib
    0x7fff642db000 -     0x7fff642e0ff3  libheimdal-asn1.dylib (520.50.6) <=
E358445A-B84E-31B5-BCCD-7E1397519D96> /usr/lib/libheimdal-asn1.dylib
    0x7fff6430c000 -     0x7fff643fdff7  libiconv.2.dylib (51.50.1) <2FEC97=
07-3FAF-3828-A50D-8605086D060F> /usr/lib/libiconv.2.dylib
    0x7fff643fe000 -     0x7fff64625ffb  libicucore.A.dylib (59180.0.1) <34=
EBADD6-4092-30EC-90E8-F75241E94D76> /usr/lib/libicucore.A.dylib
    0x7fff64672000 -     0x7fff64673fff  liblangid.dylib (128) <39C39393-0D=
05-301D-93B2-F224FC4949AA> /usr/lib/liblangid.dylib
    0x7fff64674000 -     0x7fff6468dffb  liblzma.5.dylib (10) <3D419A50-961=
F-37D2-8A01-3DC7AB7B8D18> /usr/lib/liblzma.5.dylib
    0x7fff6468e000 -     0x7fff646a4ff7  libmarisa.dylib (9) <D6D2D55D-1D2E=
-3442-B152-B18803C0ABB4> /usr/lib/libmarisa.dylib
    0x7fff64755000 -     0x7fff6497dff7  libmecabra.dylib (779.7.6) <F462F1=
70-E872-3D09-B219-973D5E99C09F> /usr/lib/libmecabra.dylib
    0x7fff64b55000 -     0x7fff64cd0fff  libnetwork.dylib (1229.70.2) <E185=
D902-AC7F-3044-87C0-AE2887C59CE7> /usr/lib/libnetwork.dylib
    0x7fff64d57000 -     0x7fff651457e7  libobjc.A.dylib (723) <DD9E5EC5-B5=
07-3249-B700-93433E2D5EDF> /usr/lib/libobjc.A.dylib
    0x7fff65158000 -     0x7fff6515cfff  libpam.2.dylib (22) <7B4D2CE2-1438=
-387A-9802-5CEEFBF26F86> /usr/lib/libpam.2.dylib
    0x7fff6515f000 -     0x7fff65193fff  libpcap.A.dylib (79.20.1) <FA13918=
B-A247-3181-B256-9B852C7BA316> /usr/lib/libpcap.A.dylib
    0x7fff65212000 -     0x7fff6522effb  libresolv.9.dylib (65) <E8F3415B-4=
472-3202-8901-41FD87981DB2> /usr/lib/libresolv.9.dylib
    0x7fff6526a000 -     0x7fff6527cfff  libsasl2.2.dylib (211) <04EF3F61-1=
2EC-3319-A649-851999F4C7A4> /usr/lib/libsasl2.2.dylib
    0x7fff6527f000 -     0x7fff65412ff7  libsqlite3.dylib (274.8.1) <FCAD6A=
57-829E-3701-B16E-1833D620E0E8> /usr/lib/libsqlite3.dylib
    0x7fff6546e000 -     0x7fff654c1ffb  libssl.35.dylib (22.50.2) <AF523E9=
B-7183-3A87-8FB4-E26936EC4FDB> /usr/lib/libssl.35.dylib
    0x7fff655e6000 -     0x7fff65646ff3  libusrtcp.dylib (1229.70.2) <1E065=
228-D0E3-3808-9405-894056C6BEC0> /usr/lib/libusrtcp.dylib
    0x7fff65647000 -     0x7fff6564affb  libutil.dylib (51.20.1) <216D18E5-=
0BAF-3EAF-A38E-F6AC37CBABD9> /usr/lib/libutil.dylib
    0x7fff6564b000 -     0x7fff65658fff  libxar.1.dylib (400) <0316128D-3B4=
7-3052-995D-97B4FE5491DC> /usr/lib/libxar.1.dylib
    0x7fff6565c000 -     0x7fff65743fff  libxml2.2.dylib (31.11) <C2B5C43F-=
9C0B-31E6-8EC0-939591EDAC49> /usr/lib/libxml2.2.dylib
    0x7fff65744000 -     0x7fff6576cfff  libxslt.1.dylib (15.12) <4A5E011D-=
8B29-3135-A52B-9A9070ABD752> /usr/lib/libxslt.1.dylib
    0x7fff6576d000 -     0x7fff6577fffb  libz.1.dylib (70) <48C67CFC-940D-3=
857-8DAD-857774605352> /usr/lib/libz.1.dylib
    0x7fff6581b000 -     0x7fff6581fff7  libcache.dylib (80) <092479CB-1008=
-3A83-BECF-E115F24D13C1> /usr/lib/system/libcache.dylib
    0x7fff65820000 -     0x7fff6582aff3  libcommonCrypto.dylib (60118.50.1)=
 <029F5985-9B6E-3DCB-9B96-FD007678C6A7> /usr/lib/system/libcommonCrypto.dyl=
ib
    0x7fff6582b000 -     0x7fff65832fff  libcompiler_rt.dylib (62) <968B8E3=
F-3681-3230-9D78-BB8732024F6E> /usr/lib/system/libcompiler_rt.dylib
    0x7fff65833000 -     0x7fff6583cffb  libcopyfile.dylib (146.50.5) <3885=
083D-50D8-3EEC-B481-B2E605180D7F> /usr/lib/system/libcopyfile.dylib
    0x7fff6583d000 -     0x7fff658c2fff  libcorecrypto.dylib (562.70.1) <5C=
26364F-2269-31EC-84AF-0FED2C902E38> /usr/lib/system/libcorecrypto.dylib
    0x7fff6594a000 -     0x7fff65983ff7  libdispatch.dylib (913.60.2) <232C=
69BD-022E-3AB9-8807-79F9FA7CB5EC> /usr/lib/system/libdispatch.dylib
    0x7fff65984000 -     0x7fff659a1ff7  libdyld.dylib (551.4) <81BF3A82-57=
19-3B54-ABA9-76C82D932CAC> /usr/lib/system/libdyld.dylib
    0x7fff659a2000 -     0x7fff659a2ffb  libkeymgr.dylib (28) <E34E283E-90F=
A-3C59-B48E-1277CDB9CDCE> /usr/lib/system/libkeymgr.dylib
    0x7fff659a3000 -     0x7fff659afff3  libkxld.dylib (4570.71.2) <C3C31E1=
B-3E74-3828-8429-4D442E26D41C> /usr/lib/system/libkxld.dylib
    0x7fff659b0000 -     0x7fff659b0ff7  liblaunch.dylib (1205.70.9) <B184B=
521-FF24-3142-AFAF-23D170CF918C> /usr/lib/system/liblaunch.dylib
    0x7fff659b1000 -     0x7fff659b5ffb  libmacho.dylib (906) <1902A611-081=
A-3452-B11E-EBD1B166E831> /usr/lib/system/libmacho.dylib
    0x7fff659b6000 -     0x7fff659b8ff3  libquarantine.dylib (86) <26C0BA22=
-8F93-3A07-9A4E-C8D53D2CE42E> /usr/lib/system/libquarantine.dylib
    0x7fff659b9000 -     0x7fff659baff3  libremovefile.dylib (45) <711E18B2=
-5BBE-3211-A916-56740C27D17A> /usr/lib/system/libremovefile.dylib
    0x7fff659bb000 -     0x7fff659d2fff  libsystem_asl.dylib (356.70.1) <39=
E46A6F-B228-3E78-B83E-1779F9707A39> /usr/lib/system/libsystem_asl.dylib
    0x7fff659d3000 -     0x7fff659d3fff  libsystem_blocks.dylib (67) <17303=
FDF-0D2D-3963-B05E-B4DF63052D47> /usr/lib/system/libsystem_blocks.dylib
    0x7fff659d4000 -     0x7fff65a5dff7  libsystem_c.dylib (1244.50.9) <118=
7BFE8-4576-3247-8177-481554E1F9E7> /usr/lib/system/libsystem_c.dylib
    0x7fff65a5e000 -     0x7fff65a61ffb  libsystem_configuration.dylib (963=
.50.8) <DF6B5287-203E-30CB-9947-78DF446C72B8> /usr/lib/system/libsystem_con=
figuration.dylib
    0x7fff65a62000 -     0x7fff65a65ffb  libsystem_coreservices.dylib (51) =
<486000D3-D8CB-3BE7-8EE5-8BF380DE6DF7> /usr/lib/system/libsystem_coreservic=
es.dylib
    0x7fff65a66000 -     0x7fff65a67fff  libsystem_darwin.dylib (1244.50.9)=
 <09C21A4A-9EE0-388B-A9D9-DFF8F6758791> /usr/lib/system/libsystem_darwin.dy=
lib
    0x7fff65a68000 -     0x7fff65a6eff7  libsystem_dnssd.dylib (878.70.2) <=
3290768B-54DE-3AB6-B155-AC0950AC5564> /usr/lib/system/libsystem_dnssd.dylib
    0x7fff65a6f000 -     0x7fff65ab8ff7  libsystem_info.dylib (517.30.1) <A=
B634A98-B8AA-3804-8436-38261FC8EC4D> /usr/lib/system/libsystem_info.dylib
    0x7fff65ab9000 -     0x7fff65adfff7  libsystem_kernel.dylib (4570.71.2)=
 <F22B8D73-69D8-36D7-BF66-7F9AC70C08C2> /usr/lib/system/libsystem_kernel.dy=
lib
    0x7fff65ae0000 -     0x7fff65b2bfcb  libsystem_m.dylib (3147.50.1) <8CF=
B51C9-B422-3379-8552-064C63943A23> /usr/lib/system/libsystem_m.dylib
    0x7fff65b2c000 -     0x7fff65b4bfff  libsystem_malloc.dylib (140.50.6) =
<7FD43735-9DDD-300E-8C4A-F909A74BDF49> /usr/lib/system/libsystem_malloc.dyl=
ib
    0x7fff65b4c000 -     0x7fff65c7cff7  libsystem_network.dylib (1229.70.2=
) <5E86B2DE-9E15-3354-8714-4094ED5F698D> /usr/lib/system/libsystem_network.=
dylib
    0x7fff65c7d000 -     0x7fff65c87ffb  libsystem_networkextension.dylib (=
767.70.1) <D23EAFC1-E8BD-34D5-969C-6E45A1C3B4E4> /usr/lib/system/libsystem_=
networkextension.dylib
    0x7fff65c88000 -     0x7fff65c91ff3  libsystem_notify.dylib (172) <0801=
2EC0-2CD2-34BE-BF93-E7F56491299A> /usr/lib/system/libsystem_notify.dylib
    0x7fff65c92000 -     0x7fff65c99ff7  libsystem_platform.dylib (161.50.1=
) <6355EE2D-5456-3CA8-A227-B96E8F1E2AF8> /usr/lib/system/libsystem_platform=
.dylib
    0x7fff65c9a000 -     0x7fff65ca5fff  libsystem_pthread.dylib (301.50.1)=
 <0E51CCBA-91F2-34E1-BF2A-FEEFD3D321E4> /usr/lib/system/libsystem_pthread.d=
ylib
    0x7fff65ca6000 -     0x7fff65ca9fff  libsystem_sandbox.dylib (765.70.1)=
 <553DFCC6-9D31-3B9C-AB7C-30F6F265786D> /usr/lib/system/libsystem_sandbox.d=
ylib
    0x7fff65caa000 -     0x7fff65cabff3  libsystem_secinit.dylib (30) <DE8D=
14E8-A276-3FF8-AE13-77F7040F33C1> /usr/lib/system/libsystem_secinit.dylib
    0x7fff65cac000 -     0x7fff65cb3ff7  libsystem_symptoms.dylib (820.60.2=
) <585BDFA2-D54D-39D0-8046-44E824DABD43> /usr/lib/system/libsystem_symptoms=
.dylib
    0x7fff65cb4000 -     0x7fff65cc7fff  libsystem_trace.dylib (829.70.1) <=
3A6CB706-8CA6-3616-8AFC-14AAD7FAF187> /usr/lib/system/libsystem_trace.dylib
    0x7fff65cc9000 -     0x7fff65cceff7  libunwind.dylib (35.3) <BEF3FB49-5=
604-3B5F-82B5-332B80023AC3> /usr/lib/system/libunwind.dylib
    0x7fff65ccf000 -     0x7fff65cfcff7  libxpc.dylib (1205.70.9) <0BC7AD67=
-671D-31D4-8B88-C317B8379598> /usr/lib/system/libxpc.dylib

External Modification Summary:
  Calls made by other processes targeting this process:
    task_for_pid: 1
    thread_create: 0
    thread_set_state: 0
  Calls made by this process:
    task_for_pid: 0
    thread_create: 0
    thread_set_state: 0
  Calls made by all processes on this machine:
    task_for_pid: 626
    thread_create: 0
    thread_set_state: 0

VM Region Summary:
ReadOnly portion of Libraries: Total=3D350.0M resident=3D0K(0%) swapped_out=
_or_unallocated=3D350.0M(100%)
Writable regions: Total=3D8.3G written=3D0K(0%) resident=3D0K(0%) swapped_o=
ut=3D0K(0%) unallocated=3D8.3G(100%)
 =

                                VIRTUAL   REGION =

REGION TYPE                        SIZE    COUNT (non-coalesced) =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                     =3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D =

Accelerate framework               384K        3 =

Activity Tracing                   256K        2 =

CG backing stores                 19.0M        5 =

CG image                            48K        4 =

CoreAnimation                      148K        8 =

CoreGraphics                         8K        2 =

CoreImage                           24K        3 =

CoreUI image data                 1764K       13 =

CoreUI image file                  188K        5 =

Dispatch continuations            16.0M        2 =

Foundation                           4K        2 =

IOKit                              128K        3 =

Kernel Alloc Once                    8K        2 =

MALLOC                           133.4M       38 =

MALLOC guard page                   48K       10 =

MALLOC_LARGE (reserved)           2816K        2         reserved VM addres=
s space (unallocated)
Memory Tag 242                      12K        2 =

STACK GUARD                       56.0M       11 =

Stack                             12.6M       13 =

VM_ALLOCATE                        8.1G      162 =

__DATA                            25.3M      255 =

__FONT_DATA                          4K        2 =

__LINKEDIT                       194.6M       21 =

__TEXT                           155.5M      258 =

__UNICODE                          560K        2 =

mapped file                       47.1M       18 =

shared memory                      676K       13 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                     =3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D =

TOTAL                              8.7G      834 =

TOTAL, minus reserved VM space     8.7G      834 =


Model: MacBookPro14,3, BootROM MBP143.0178.B00, 4 processors, Intel Core i7=
, 2.8 GHz, 16 GB, SMC 2.45f0
Graphics: Radeon Pro 555, Radeon Pro 555, PCIe
Graphics: Intel HD Graphics 630, Intel HD Graphics 630, Built-In
Memory Module: BANK 0/DIMM0, 8 GB, LPDDR3, 2133 MHz, 0x802C, 0x4D5435324C31=
473332443450472D30393320
Memory Module: BANK 1/DIMM0, 8 GB, LPDDR3, 2133 MHz, 0x802C, 0x4D5435324C31=
473332443450472D30393320
AirPort: spairport_wireless_card_type_airport_extreme (0x14E4, 0x173), Broa=
dcom BCM43xx 1.0 (7.77.37.31.1a9)
Bluetooth: Version 6.0.7f10, 3 services, 18 devices, 1 incoming serial ports
Network Service: Wi-Fi, AirPort, en0
USB Device: USB 3.0 Bus
USB Device: iBridge
Thunderbolt Bus: MacBook Pro, Apple Inc., 33.1
Thunderbolt Bus: MacBook Pro, Apple Inc., 33.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798451

Title:
  HVF linux on OSX hangs 2nd time started after adding socket

Status in QEMU:
  New

Bug description:
  =

  Robs-MacBook-Pro-2:~ robmaskell$ qemu-system-x86_64 --version
  QEMU emulator version 3.0.0

  Host: MacOS - 10.13.6
    Model Name:	MacBook Pro
    Model Identifier:	MacBookPro14,3
    Processor Name:	Intel Core i7
    Processor Speed:	2.8 GHz
    Number of Processors:	1
    Total Number of Cores:	4
    L2 Cache (per Core):	256 KB
    L3 Cache:	6 MB
    Memory:	16 GB

  Guest OS: Elementary Linux Loki 0.4.1, patched up to date

  Command used to start QEMU:

  qemu-system-x86_64 \
    -name ElementaryLokiDev \
    -machine pc,accel=3Dhvf \
    -cpu max \
    -smp cpus=3D2,sockets=3D2,cores=3D1,threads=3D1,maxcpus=3D2 \
    -numa node,nodeid=3D0 \
    -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D0,socket-id=3D1=
 \
    -m 8G \
    -vga vmware \
    -hda e4.qcow2

  Symptoms: Started without the -smp / -numa commands to install the OS,
  then added -smp / -numa and the machine boots and lscpu reports extra
  cpu as expected. Restart VM and it hangs on startup. Remove -smp /
  -numa and machine starts again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798451/+subscriptions
