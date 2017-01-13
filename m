Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1f-00061t-Gl
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1a-0000kh-Sp
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:45269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRx1a-0000kE-I8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRx1Z-0004E5-JS
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BA9102E80D8
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 08:01:44 -0000
From: Thomas Huth <886621@bugs.launchpad.net>
Reply-To: Bug 886621 <886621@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111105175724.17903.79511.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170113080144.14210.20603.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 886621] Re: Mac OS X Lion: segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently version 2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/886621

Title:
  Mac OS X Lion: segmentation fault

Status in QEMU:
  Incomplete

Bug description:
  /usr/local/xeos-build/qemu/bin/qemu -boot order=3Da -M pc -cpu 486 -vga
  std -smp 1 -m 16 -soundhw sb16 -d
  out_asm,in_asm,op,op_opt,int,exec,cpu,pcall,cpu_reset -fda
  ./build/release/xeos.flp

  Process:         qemu [5680]
  Path:            /usr/local/xeos-build/qemu/bin/qemu
  Identifier:      qemu
  Version:         ??? (???)
  Code Type:       X86-64 (Native)
  Parent Process:  make [5677]

  Date/Time:       2011-11-05 18:53:25.574 +0100
  OS Version:      Mac OS X 10.7.2 (11C74)
  Report Version:  9
  Sleep/Wake UUID: 3C81B8F7-0321-4621-923C-AB655F2CC701

  Interval Since Last Report:          503994 sec
  Crashes Since Last Report:           35
  Per-App Crashes Since Last Report:   9
  Anonymous UUID:                      28E7367A-4697-43A4-8D12-005F1917DFD3

  Crashed Thread:  0  Dispatch queue: com.apple.main-thread

  Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
  Exception Codes: KERN_INVALID_ADDRESS at 0x000000000000003a

  VM Regions Near 0x3a:
  -->
  =C2=A0=C2=A0=C2=A0=C2=A0__TEXT                 0000000107c75000-000000010=
7ebc000 [ 2332K] r-x/rwx SM=3DCOW  /usr/local/xeos-build/qemu/bin/qemu

  Application Specific Information:
  objc[5680]: garbage collection is OFF

  Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
  0   qemu                          	0x0000000107d9d0ed 0x107c75000 + 12126=
53
  1   qemu                          	0x0000000107dabc39 0x107c75000 + 12728=
89
  2   ???                           	0x000000010c3b007c 0 + 4500160636

  Thread 1:: Dispatch queue: com.apple.libdispatch-manager
  0   libsystem_kernel.dylib        	0x00007fff85abb7e6 kevent + 10
  1   libdispatch.dylib             	0x00007fff8e7b15be _dispatch_mgr_invok=
e + 923
  2   libdispatch.dylib             	0x00007fff8e7b014e _dispatch_mgr_threa=
d + 54

  Thread 2:
  0   libsystem_kernel.dylib        	0x00007fff85abb192 __workq_kernreturn =
+ 10
  1   libsystem_c.dylib             	0x00007fff85886594 _pthread_wqthread +=
 758
  2   libsystem_c.dylib             	0x00007fff85887b85 start_wqthread + 13

  Thread 3:
  0   libsystem_kernel.dylib        	0x00007fff85abb192 __workq_kernreturn =
+ 10
  1   libsystem_c.dylib             	0x00007fff85886594 _pthread_wqthread +=
 758
  2   libsystem_c.dylib             	0x00007fff85887b85 start_wqthread + 13

  Thread 4:
  0   libsystem_kernel.dylib        	0x00007fff85abb192 __workq_kernreturn =
+ 10
  1   libsystem_c.dylib             	0x00007fff85886594 _pthread_wqthread +=
 758
  2   libsystem_c.dylib             	0x00007fff85887b85 start_wqthread + 13

  Thread 5:
  0   libsystem_kernel.dylib        	0x00007fff85abb036 __sigwait + 10
  1   libsystem_c.dylib             	0x00007fff8583aaab sigwait + 68
  2   qemu                          	0x0000000107d221ef 0x107c75000 + 709103
  3   libsystem_c.dylib             	0x00007fff858848bf _pthread_start + 335
  4   libsystem_c.dylib             	0x00007fff85887b75 thread_start + 13

  Thread 0 crashed with X86 Thread State (64-bit):
  =C2=A0=C2=A0rax: 0x5433ade07f7c29e7  rbx: 0x0000000000000010  rcx: 0x0000=
000000000000  rdx: 0x0000000000002000
  =C2=A0=C2=A0rdi: 0x0000000000000010  rsi: 0x0000000000000000  rbp: 0x0000=
7fff678714a0  rsp: 0x00007fff67871470
  =C2=A0=C2=A0=C2=A0r8: 0x0000000109fe8000   r9: 0x0000000000000fff  r10: 0=
x00007fa7c185c01d  r11: 0x0000000000000246
  =C2=A0=C2=A0r12: 0x00000001087ae368  r13: 0x0000000000000000  r14: 0x0000=
000000000000  r15: 0x0000000000001f80
  =C2=A0=C2=A0rip: 0x0000000107d9d0ed  rfl: 0x0000000000010202  cr2: 0x0000=
00000000003a
  Logical CPU: 6

  Binary Images:
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x107c75000 -        0x107ebbff=
7 +qemu (??? - ???) <FECE8C8E-BD8E-34F1-B222-32D79C7A0037> /usr/local/xeos-=
build/qemu/bin/qemu
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1087cb000 -        0x1088b5fe=
7 +libglib-2.0.0.dylib (2704.0.0 - compatibility 2704.0.0) <5E6151CC-61F8-3=
335-A6FA-EFDD71474FA6> /usr/local/macmade/sw/glib/lib/libglib-2.0.0.dylib
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x108917000 -        0x10891fff=
f +libintl.8.dylib (9.1.0 - compatibility 9.0.0) <7D75E177-3172-2F78-1E08-1=
118A3D2D2A9> /usr/local/webstart/sw/gettext/lib/libintl.8.dylib
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x108928000 -        0x108949ff=
f +libpng12.0.dylib (23.0.0 - compatibility 23.0.0) <FDE69E98-1D25-EEA1-99C=
F-F0A04A9AD7FF> /usr/local/webstart/sw/lib-png/lib/libpng12.0.dylib
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10895a000 -        0x10897aff=
7 +libjpeg.62.dylib (63.0.0 - compatibility 63.0.0) <AD465C8A-66A4-E794-CA9=
A-96FB1B4D6CF0> /usr/local/webstart/sw/lib-jpeg/lib/libjpeg.62.dylib
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x108987000 -        0x108a67ff=
7 +libiconv.2.dylib (8.0.0 - compatibility 8.0.0) <54A03BBE-E505-9FF1-79AA-=
D4D5139BBF9C> /usr/local/webstart/sw/lib-iconv/lib/libiconv.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff67875000 -     0x7fff678a9ac7  dyld (195.5 =
- ???) <4A6E2B28-C7A2-3528-ADB7-4076B9836041> /usr/lib/dyld
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8547d000 -     0x7fff8547efff  libDiagnosti=
cMessagesClient.dylib (??? - ???) <3DCF577B-F126-302B-BCE2-4DB9A95B8598> /u=
sr/lib/libDiagnosticMessagesClient.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8582b000 -     0x7fff8582efff  com.apple.he=
lp (1.3.2 - 42) <AB67588E-7227-3993-927F-C9E6DAC507FD> /System/Library/Fram=
eworks/Carbon.framework/Versions/A/Frameworks/Help.framework/Versions/A/Help
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8582f000 -     0x7fff85835fff  libmacho.dyl=
ib (800.0.0 - compatibility 1.0.0) <D86F63EC-D2BD-32E0-8955-08B5EAFAD2CC> /=
usr/lib/system/libmacho.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85836000 -     0x7fff85913fef  libsystem_c.=
dylib (763.12.0 - compatibility 1.0.0) <FF69F06E-0904-3C08-A5EF-536FAFFFDC2=
2> /usr/lib/system/libsystem_c.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85914000 -     0x7fff85914fff  com.apple.au=
dio.units.AudioUnit (1.7.1 - 1.7.1) <04C10813-CCE5-3333-8C72-E8E35E417B3B> =
/System/Library/Frameworks/AudioUnit.framework/Versions/A/AudioUnit
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85915000 -     0x7fff8591bfff  IOSurface (?=
?? - ???) <06FA3FDD-E6D5-391F-B60D-E98B169DAB1B> /System/Library/Frameworks=
/IOSurface.framework/Versions/A/IOSurface
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85964000 -     0x7fff85972fff  com.apple.Ne=
tAuth (1.0 - 3.0) <F384FFFD-70F6-3B1C-A886-F5B446E456E7> /System/Library/Pr=
ivateFrameworks/NetAuth.framework/Versions/A/NetAuth
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85aa4000 -     0x7fff85ac4fff  libsystem_ke=
rnel.dylib (1699.22.73 - compatibility 1.0.0) <69F2F501-72D8-3B3B-8357-F441=
8B3E1348> /usr/lib/system/libsystem_kernel.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85ac5000 -     0x7fff85b10ff7  com.apple.Sy=
stemConfiguration (1.11.1 - 1.11) <F832FE21-5509-37C6-B1F1-48928F31BE45> /S=
ystem/Library/Frameworks/SystemConfiguration.framework/Versions/A/SystemCon=
figuration
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85c2a000 -     0x7fff85c39ff7  com.apple.op=
engl (1.7.5 - 1.7.5) <2945F1A6-910C-3596-9988-5701B04BD821> /System/Library=
/Frameworks/OpenGL.framework/Versions/A/OpenGL
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85c3a000 -     0x7fff85c3eff7  com.apple.Co=
mmonPanels (1.2.5 - 94) <0BB2C436-C9D5-380B-86B5-E355A7711259> /System/Libr=
ary/Frameworks/Carbon.framework/Versions/A/Frameworks/CommonPanels.framewor=
k/Versions/A/CommonPanels
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85ebb000 -     0x7fff85fbefff  libsqlite3.d=
ylib (9.6.0 - compatibility 9.0.0) <7F60B0FF-4946-3639-89AB-B540D318B249> /=
usr/lib/libsqlite3.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff85fbf000 -     0x7fff86063fef  com.apple.in=
k.framework (1.3.2 - 110) <F69DBD44-FEC8-3C14-8131-CC0245DBBD42> /System/Li=
brary/Frameworks/Carbon.framework/Versions/A/Frameworks/Ink.framework/Versi=
ons/A/Ink
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff860c5000 -     0x7fff860cafff  libpam.2.dyl=
ib (3.0.0 - compatibility 3.0.0) <D952F17B-200A-3A23-B9B2-7C1F7AC19189> /us=
r/lib/libpam.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff860dd000 -     0x7fff86147fff  com.apple.fr=
amework.IOKit (2.0 - ???) <87D55F1D-CDB5-3D13-A5F9-98EA4E22F8EE> /System/Li=
brary/Frameworks/IOKit.framework/Versions/A/IOKit
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86148000 -     0x7fff8614ffff  libcopyfile.=
dylib (85.1.0 - compatibility 1.0.0) <172B1985-F24A-34E9-8D8B-A2403C9A0399>=
 /usr/lib/system/libcopyfile.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8627e000 -     0x7fff862abfe7  libSystem.B.=
dylib (159.1.0 - compatibility 1.0.0) <095FDD3C-3961-3865-A59B-A5B0A4B8B923=
> /usr/lib/libSystem.B.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff862ac000 -     0x7fff86314ff7  com.apple.Sy=
mbolication (1.2 - 89) <1D7F9E72-B1B6-30CF-AC8A-23A763930A92> /System/Libra=
ry/PrivateFrameworks/Symbolication.framework/Versions/A/Symbolication
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86315000 -     0x7fff86316ff7  libsystem_bl=
ocks.dylib (53.0.0 - compatibility 1.0.0) <8BCA214A-8992-34B2-A8B9-B74DEACA=
1869> /usr/lib/system/libsystem_blocks.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8633a000 -     0x7fff8634cff7  libbsm.0.dyl=
ib (??? - ???) <349BB16F-75FA-363F-8D98-7A9C3FA90A0D> /usr/lib/libbsm.0.dyl=
ib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8634d000 -     0x7fff863b5ff7  com.apple.au=
dio.CoreAudio (4.0.1 - 4.0.1) <7966E3BE-376B-371A-A21D-9BD763C0BAE7> /Syste=
m/Library/Frameworks/CoreAudio.framework/Versions/A/CoreAudio
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86411000 -     0x7fff86423ff7  libsasl2.2.d=
ylib (3.15.0 - compatibility 3.0.0) <6245B497-784B-355C-98EF-2DC6B45BF05C> =
/usr/lib/libsasl2.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86428000 -     0x7fff86462fff  libncurses.5=
.4.dylib (5.4.0 - compatibility 5.4.0) <387DE593-9CC5-38C7-911B-A5F2264D34F=
2> /usr/lib/libncurses.5.4.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86463000 -     0x7fff864a2ff7  libGLImage.d=
ylib (??? - ???) <2D1D8488-EC5F-3229-B983-CFDE0BB37586> /System/Library/Fra=
meworks/OpenGL.framework/Versions/A/Libraries/libGLImage.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff864a3000 -     0x7fff86545ff7  com.apple.se=
curityfoundation (5.0 - 55005) <0D59908C-A61B-389E-AF37-741ACBBA6A94> /Syst=
em/Library/Frameworks/SecurityFoundation.framework/Versions/A/SecurityFound=
ation
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86546000 -     0x7fff865cbff7  com.apple.He=
imdal (2.1 - 2.0) <C92E327E-CB5F-3C9B-92B0-F1680095C8A3> /System/Library/Pr=
ivateFrameworks/Heimdal.framework/Versions/A/Heimdal
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff865cc000 -     0x7fff865d0fff  libCGXType.A=
.dylib (600.0.0 - compatibility 64.0.0) <5EEAD17D-006C-3855-8093-C7A4A97EE0=
D0> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Fra=
meworks/CoreGraphics.framework/Versions/A/Resources/libCGXType.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff865d1000 -     0x7fff8664cff7  com.apple.pr=
int.framework.PrintCore (7.1 - 366.1) <3F140DEB-9F87-3672-97CC-F983752581AC=
> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frame=
works/PrintCore.framework/Versions/A/PrintCore
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8664d000 -     0x7fff86654ff7  com.apple.Co=
mmerceCore (1.0 - 17) <AA783B87-48D4-3CA6-8FF6-0316396022F4> /System/Librar=
y/PrivateFrameworks/CommerceKit.framework/Versions/A/Frameworks/CommerceCor=
e.framework/Versions/A/CommerceCore
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86655000 -     0x7fff86655fff  com.apple.Ac=
celerate.vecLib (3.7 - vecLib 3.7) <C06A140F-6114-3B8B-B080-E509303145B8> /=
System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib=
.framework/Versions/A/vecLib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86656000 -     0x7fff8665afff  libmathCommo=
n.A.dylib (2026.0.0 - compatibility 1.0.0) <FF83AFF7-42B2-306E-90AF-D539C51=
A4542> /usr/lib/system/libmathCommon.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8665b000 -     0x7fff86768fff  libJP2.dylib=
 (??? - ???) <6052C973-9354-35CB-AAB9-31D00D8786F9> /System/Library/Framewo=
rks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framework/V=
ersions/A/Resources/libJP2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86769000 -     0x7fff867acff7  libRIP.A.dyl=
ib (600.0.0 - compatibility 64.0.0) <2B1571E1-8E87-364E-BC36-C9C9B5D3EAC4> =
/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Framewo=
rks/CoreGraphics.framework/Versions/A/Resources/libRIP.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff867ad000 -     0x7fff86d91fff  libBLAS.dyli=
b (??? - ???) <C34F6D88-187F-33DC-8A68-C0C9D1FA36DF> /System/Library/Framew=
orks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A=
/libBLAS.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff86d92000 -     0x7fff86da4ff7  libz.1.dylib=
 (1.2.5 - compatibility 1.0.0) <30CBEF15-4978-3DED-8629-7109880A19D4> /usr/=
lib/libz.1.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87016000 -     0x7fff8701cfff  libGFXShared=
.dylib (??? - ???) <343AE6C0-EB02-333C-8D35-DF6093B92758> /System/Library/F=
rameworks/OpenGL.framework/Versions/A/Libraries/libGFXShared.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8701d000 -     0x7fff87290fff  com.apple.Co=
reImage (7.82 - 1.0.1) <282801B6-5D80-3E2C-88A4-00FE29906D5A> /System/Libra=
ry/Frameworks/QuartzCore.framework/Versions/A/Frameworks/CoreImage.framewor=
k/Versions/A/CoreImage
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff872da000 -     0x7fff87315fff  com.apple.LD=
APFramework (3.0 - 120.1) <0C23534F-A8E7-3144-B2B2-50F9875101E2> /System/Li=
brary/Frameworks/LDAP.framework/Versions/A/LDAP
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87322000 -     0x7fff87524fff  libicucore.A=
.dylib (46.1.0 - compatibility 1.0.0) <38CD6ED3-C8E4-3CCD-89AC-9C3198803101=
> /usr/lib/libicucore.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87a4c000 -     0x7fff87a4dfff  libsystem_sa=
ndbox.dylib (??? - ???) <8D14139B-B671-35F4-9E5A-023B4C523C38> /usr/lib/sys=
tem/libsystem_sandbox.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87b4f000 -     0x7fff87b4ffff  libkeymgr.dy=
lib (23.0.0 - compatibility 1.0.0) <61EFED6A-A407-301E-B454-CD18314F0075> /=
usr/lib/system/libkeymgr.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87b50000 -     0x7fff87ba7fff  libTIFF.dyli=
b (??? - ???) <FF0D9A24-6956-3F03-81EA-3EEAD22C9DB8> /System/Library/Framew=
orks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framework/=
Versions/A/Resources/libTIFF.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff87c87000 -     0x7fff8839a587  com.apple.Co=
reGraphics (1.600.0 - ???) <A9F2451E-6F60-350E-A6E5-539669B53074> /System/L=
ibrary/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/CoreG=
raphics.framework/Versions/A/CoreGraphics
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8839b000 -     0x7fff883b1ff7  com.apple.Im=
ageCapture (7.0 - 7.0) <69E6E2E1-777E-332E-8BCF-4F0611517DD0> /System/Libra=
ry/Frameworks/Carbon.framework/Versions/A/Frameworks/ImageCapture.framework=
/Versions/A/ImageCapture
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff883b2000 -     0x7fff883b9fff  com.apple.Ne=
tFS (4.0 - 4.0) <B9F41443-679A-31AD-B0EB-36557DAF782B> /System/Library/Fram=
eworks/NetFS.framework/Versions/A/NetFS
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff883d7000 -     0x7fff884b5fff  com.apple.Im=
ageIO.framework (3.1.1 - 3.1.1) <13E549F8-5BD6-3BAE-8C33-1D0BD269C081> /Sys=
tem/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/=
ImageIO.framework/Versions/A/ImageIO
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff884b6000 -     0x7fff884b6fff  com.apple.Co=
coa (6.6 - ???) <021D4214-9C23-3CD8-AFB2-F331697A4508> /System/Library/Fram=
eworks/Cocoa.framework/Versions/A/Cocoa
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff884b7000 -     0x7fff884b7fff  com.apple.Ap=
plicationServices (41 - 41) <03F3FA8F-8D2A-3AB6-A8E3-40B001116339> /System/=
Library/Frameworks/ApplicationServices.framework/Versions/A/ApplicationServ=
ices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff884b8000 -     0x7fff8861efff  com.apple.CF=
Network (520.2.5 - 520.2.5) <406712D9-3F0C-3763-B4EB-868D01F1F042> /System/=
Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/CFNetwork.f=
ramework/Versions/A/CFNetwork
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8861f000 -     0x7fff88943fff  com.apple.HI=
Toolbox (1.8 - ???) <A3BE7C59-52E6-3A7F-9B30-24B7DD3E95F2> /System/Library/=
Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versi=
ons/A/HIToolbox
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88944000 -     0x7fff88961ff7  com.apple.op=
enscripting (1.3.3 - ???) <A64205E6-D3C5-3E12-B1A0-72243151AF7D> /System/Li=
brary/Frameworks/Carbon.framework/Versions/A/Frameworks/OpenScripting.frame=
work/Versions/A/OpenScripting
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88962000 -     0x7fff88c3aff7  com.apple.se=
curity (7.0 - 55010) <93713FF4-FE86-3B4C-8150-5FCC7F3320C8> /System/Library=
/Frameworks/Security.framework/Versions/A/Security
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88c5b000 -     0x7fff88cbbfff  libvDSP.dyli=
b (325.4.0 - compatibility 1.0.0) <3A7521E6-5510-3FA7-AB65-79693A7A5839> /S=
ystem/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.=
framework/Versions/A/libvDSP.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88cbf000 -     0x7fff88d43ff7  com.apple.Ap=
plicationServices.ATS (317.5.0 - ???) <FE629F2D-6BC0-3A58-9844-D8B9A6808A00=
> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frame=
works/ATS.framework/Versions/A/ATS
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88d81000 -     0x7fff88e48ff7  com.apple.Co=
lorSync (4.7.0 - 4.7.0) <F325A9D7-7203-36B7-8C1C-B6A4D5CC73A8> /System/Libr=
ary/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ColorSyn=
c.framework/Versions/A/ColorSync
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88e59000 -     0x7fff88e6dff7  com.apple.La=
ngAnalysis (1.7.0 - 1.7.0) <04C31EF0-912A-3004-A08F-CEC27030E0B2> /System/L=
ibrary/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/LangA=
nalysis.framework/Versions/A/LangAnalysis
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88e6e000 -     0x7fff88e79ff7  com.apple.sp=
eech.recognition.framework (4.0.19 - 4.0.19) <7ADAAF5B-1D78-32F2-9FFF-D2E3F=
BB41C2B> /System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/=
SpeechRecognition.framework/Versions/A/SpeechRecognition
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff88f54000 -     0x7fff88f55fff  libunc.dylib=
 (24.0.0 - compatibility 1.0.0) <C67B3B14-866C-314F-87FF-8025BEC2CAAC> /usr=
/lib/system/libunc.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89095000 -     0x7fff89148fff  com.apple.Co=
reText (220.11.0 - ???) <4EA8E2DF-542D-38D5-ADB9-C0DAA73F898B> /System/Libr=
ary/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/CoreText=
.framework/Versions/A/CoreText
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8932e000 -     0x7fff894cdfff  com.apple.Qu=
artzCore (1.7 - 270.0) <E8FC9AA4-A5CB-384B-AD29-7190A1387D3E> /System/Libra=
ry/Frameworks/QuartzCore.framework/Versions/A/QuartzCore
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff894f6000 -     0x7fff89530fe7  com.apple.De=
bugSymbols (2.1 - 87) <E9000AB8-CCE4-3636-871D-E17703814B68> /System/Librar=
y/PrivateFrameworks/DebugSymbols.framework/Versions/A/DebugSymbols
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89531000 -     0x7fff8958cff7  com.apple.HI=
Services (1.10 - ???) <BAB8B422-7047-3D2D-8E0A-13FCF153E4E7> /System/Librar=
y/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices=
.framework/Versions/A/HIServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89a1d000 -     0x7fff89a6bfff  libauto.dyli=
b (??? - ???) <D8AC8458-DDD0-3939-8B96-B6CED81613EF> /usr/lib/libauto.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89a6c000 -     0x7fff89ac0ff7  com.apple.Sc=
alableUserInterface (1.0 - 1) <1873D7BE-2272-31A1-8F85-F70C4D706B3B> /Syste=
m/Library/Frameworks/QuartzCore.framework/Versions/A/Frameworks/ScalableUse=
rInterface.framework/Versions/A/ScalableUserInterface
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89ac1000 -     0x7fff89ae0fff  libresolv.9.=
dylib (46.0.0 - compatibility 1.0.0) <33263568-E6F3-359C-A4FA-66AD1300F7D4>=
 /usr/lib/libresolv.9.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89b26000 -     0x7fff89b65fff  com.apple.AE=
 (527.7 - 527.7) <B82F7ABC-AC8B-3507-B029-969DD5CA813D> /System/Library/Fra=
meworks/CoreServices.framework/Versions/A/Frameworks/AE.framework/Versions/=
A/AE
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff89fd5000 -     0x7fff8a1a9fff  com.apple.Co=
reFoundation (6.7.1 - 635.15) <FE4A86C2-3599-3CF8-AD1A-822F1FEA820F> /Syste=
m/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8a1aa000 -     0x7fff8a1d3fff  libJPEG.dyli=
b (??? - ???) <64D079F9-256A-323B-A837-84628B172F21> /System/Library/Framew=
orks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framework/=
Versions/A/Resources/libJPEG.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8a929000 -     0x7fff8a94dfff  com.apple.Ke=
rberos (1.0 - 1) <1F826BCE-DA8F-381D-9C4C-A36AA0EA1CB9> /System/Library/Fra=
meworks/Kerberos.framework/Versions/A/Kerberos
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8a94e000 -     0x7fff8a94efff  com.apple.Co=
reServices (53 - 53) <043C8026-8EDD-3241-B090-F589E24062EF> /System/Library=
/Frameworks/CoreServices.framework/Versions/A/CoreServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8a94f000 -     0x7fff8a9c4ff7  libc++.1.dyl=
ib (19.0.0 - compatibility 1.0.0) <C0EFFF1B-0FEB-3F99-BE54-506B35B555A9> /u=
sr/lib/libc++.1.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8af21000 -     0x7fff8afa4fef  com.apple.Me=
tadata (10.7.0 - 627.20) <E00156B0-663A-35EF-A307-A2CEB00F1845> /System/Lib=
rary/Frameworks/CoreServices.framework/Versions/A/Frameworks/Metadata.frame=
work/Versions/A/Metadata
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b02d000 -     0x7fff8b036ff7  libsystem_no=
tify.dylib (80.1.0 - compatibility 1.0.0) <A4D651E3-D1C6-3934-AD49-7A104FD1=
4596> /usr/lib/system/libsystem_notify.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b06d000 -     0x7fff8b10cfff  com.apple.La=
unchServices (480.21 - 480.21) <6BFADEA9-5BC1-3B53-A013-488EB7F1AB57> /Syst=
em/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchSe=
rvices.framework/Versions/A/LaunchServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b10d000 -     0x7fff8b14efff  com.apple.QD=
 (3.12 - ???) <4F3C5629-97C7-3E55-AF3C-ACC524929DA2> /System/Library/Framew=
orks/ApplicationServices.framework/Versions/A/Frameworks/QD.framework/Versi=
ons/A/QD
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b14f000 -     0x7fff8b251ff7  libxml2.2.dy=
lib (10.3.0 - compatibility 10.0.0) <D46F371D-6422-31B7-BCE0-D80713069E0E> =
/usr/lib/libxml2.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b2f6000 -     0x7fff8b2f9fff  libCoreVMCli=
ent.dylib (??? - ???) <E034C772-4263-3F48-B083-25A758DD6228> /System/Librar=
y/Frameworks/OpenGL.framework/Versions/A/Libraries/libCoreVMClient.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b2fd000 -     0x7fff8b402ff7  libFontParse=
r.dylib (??? - ???) <B9A53808-C97E-3293-9C33-1EA9D4E83EC8> /System/Library/=
Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ATS.framewor=
k/Versions/A/Resources/libFontParser.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b41e000 -     0x7fff8b449ff7  libxslt.1.dy=
lib (3.24.0 - compatibility 3.0.0) <8051A3FC-7385-3EA9-9634-78FC616C3E94> /=
usr/lib/libxslt.1.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b49e000 -     0x7fff8b4a3fff  libcompiler_=
rt.dylib (6.0.0 - compatibility 1.0.0) <98ECD5F6-E85C-32A5-98CD-8911230CB66=
A> /usr/lib/system/libcompiler_rt.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b656000 -     0x7fff8b65bfff  libcache.dyl=
ib (47.0.0 - compatibility 1.0.0) <B7757E2E-5A7D-362E-AB71-785FE79E1527> /u=
sr/lib/system/libcache.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b65c000 -     0x7fff8b695fe7  libssl.0.9.8=
.dylib (44.0.0 - compatibility 0.9.8) <79AAEC98-1258-3DA4-B1C0-4120049D390B=
> /usr/lib/libssl.0.9.8.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b696000 -     0x7fff8b69bff7  libsystem_ne=
twork.dylib (??? - ???) <5DE7024E-1D2D-34A2-80F4-08326331A75B> /usr/lib/sys=
tem/libsystem_network.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b6c6000 -     0x7fff8b6d1ff7  libc++abi.dy=
lib (14.0.0 - compatibility 1.0.0) <8FF3D766-D678-36F6-84AC-423C878E6D14> /=
usr/lib/libc++abi.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8b909000 -     0x7fff8bd36fff  libLAPACK.dy=
lib (??? - ???) <4F2E1055-2207-340B-BB45-E4F16171EE0D> /System/Library/Fram=
eworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions=
/A/libLAPACK.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bd37000 -     0x7fff8bd42fff  com.apple.Co=
mmonAuth (2.1 - 2.0) <BFDD0A8D-4BEA-39EC-98B3-2E083D7B1ABD> /System/Library=
/PrivateFrameworks/CommonAuth.framework/Versions/A/CommonAuth
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bd43000 -     0x7fff8bd76ff7  com.apple.GS=
S (2.1 - 2.0) <9A2C9736-DA10-367A-B376-2C7A584E6C7A> /System/Library/Framew=
orks/GSS.framework/Versions/A/GSS
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bd77000 -     0x7fff8bd78ff7  libremovefil=
e.dylib (21.0.0 - compatibility 1.0.0) <C6C49FB7-1892-32E4-86B5-25AD165131A=
A> /usr/lib/system/libremovefile.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bd79000 -     0x7fff8bd7dfff  libdyld.dyli=
b (195.5.0 - compatibility 1.0.0) <F1903B7A-D3FF-3390-909A-B24E09BAD1A5> /u=
sr/lib/system/libdyld.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bdac000 -     0x7fff8bdc8ff7  com.apple.Ge=
nerationalStorage (1.0 - 125) <31F60175-E38D-3C63-8D95-32CFE7062BCB> /Syste=
m/Library/PrivateFrameworks/GenerationalStorage.framework/Versions/A/Genera=
tionalStorage
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bdcd000 -     0x7fff8bdf5ff7  com.apple.Co=
reVideo (1.7 - 70.1) <98F917B2-FB53-3EA3-B548-7E97B38309A7> /System/Library=
/Frameworks/CoreVideo.framework/Versions/A/CoreVideo
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8bdf6000 -     0x7fff8be0dfff  com.apple.Mu=
ltitouchSupport.framework (220.62.1 - 220.62.1) <F21C79C0-4B5A-3645-81A6-74=
F8EFA900CE> /System/Library/PrivateFrameworks/MultitouchSupport.framework/V=
ersions/A/MultitouchSupport
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8be0e000 -     0x7fff8be34ff7  com.apple.fr=
amework.familycontrols (3.0 - 300) <41A6DFC2-EAF5-390A-83A1-C8832528705C> /=
System/Library/PrivateFrameworks/FamilyControls.framework/Versions/A/Family=
Controls
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8c071000 -     0x7fff8c155def  libobjc.A.dy=
lib (228.0.0 - compatibility 1.0.0) <C5F2392D-B481-3A9D-91BE-3D039FFF4DEC> =
/usr/lib/libobjc.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8c156000 -     0x7fff8c17dfff  com.apple.Pe=
rformanceAnalysis (1.10 - 10) <2A058167-292E-3C3A-B1F8-49813336E068> /Syste=
m/Library/PrivateFrameworks/PerformanceAnalysis.framework/Versions/A/Perfor=
manceAnalysis
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8c17e000 -     0x7fff8c1c0ff7  libcommonCry=
pto.dylib (55010.0.0 - compatibility 1.0.0) <A5B9778E-11C3-3F61-B740-1F2114=
E967FB> /usr/lib/system/libcommonCrypto.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8c3ff000 -     0x7fff8c452fff  libFontRegis=
try.dylib (??? - ???) <57FBD85F-41A6-3DB9-B5F4-FCC6B260F1AD> /System/Librar=
y/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/ATS.framew=
ork/Versions/A/Resources/libFontRegistry.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8c461000 -     0x7fff8c4fbff7  com.apple.Se=
archKit (1.4.0 - 1.4.0) <4E70C394-773E-3A4B-A93C-59A88ABA9509> /System/Libr=
ary/Frameworks/CoreServices.framework/Versions/A/Frameworks/SearchKit.frame=
work/Versions/A/SearchKit
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d20f000 -     0x7fff8d24aff7  libsystem_in=
fo.dylib (??? - ???) <9C8C2DCB-96DB-3471-9DCE-ADCC26BE2DD4> /usr/lib/system=
/libsystem_info.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d24b000 -     0x7fff8d250fff  libGIF.dylib=
 (??? - ???) <393E2DB5-9479-39A6-A75A-B5F20B852532> /System/Library/Framewo=
rks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framework/V=
ersions/A/Resources/libGIF.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d251000 -     0x7fff8d268fff  com.apple.CF=
OpenDirectory (10.7 - 144) <9709423E-8484-3B26-AAE8-EF58D1B8FB3F> /System/L=
ibrary/Frameworks/OpenDirectory.framework/Versions/A/Frameworks/CFOpenDirec=
tory.framework/Versions/A/CFOpenDirectory
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d269000 -     0x7fff8d26efff  com.apple.Op=
enDirectory (10.7 - 146) <91A87249-6A2F-3F89-A8DE-0E95C0B54A3A> /System/Lib=
rary/Frameworks/OpenDirectory.framework/Versions/A/OpenDirectory
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d26f000 -     0x7fff8d2c1ff7  libGLU.dylib=
 (??? - ???) <3C9153A0-8499-3DC0-AAA4-9FA6E488BE13> /System/Library/Framewo=
rks/OpenGL.framework/Versions/A/Libraries/libGLU.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d2c2000 -     0x7fff8d789fff  FaceCoreLigh=
t (1.4.7 - compatibility 1.0.0) <E9D2A69C-6E81-358C-A162-510969F91490> /Sys=
tem/Library/PrivateFrameworks/FaceCoreLight.framework/Versions/A/FaceCoreLi=
ght
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d78a000 -     0x7fff8d792fff  libsystem_dn=
ssd.dylib (??? - ???) <7749128E-D0C5-3832-861C-BC9913F774FA> /usr/lib/syste=
m/libsystem_dnssd.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d793000 -     0x7fff8d7bcfff  com.apple.Co=
reServicesInternal (113.8 - 113.8) <C1A3CF1B-BC45-3FC6-82B3-1511EBBA9D51> /=
System/Library/PrivateFrameworks/CoreServicesInternal.framework/Versions/A/=
CoreServicesInternal
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8d823000 -     0x7fff8d838fff  com.apple.sp=
eech.synthesis.framework (4.0.74 - 4.0.74) <C061ECBB-7061-3A43-8A18-90633F9=
43295> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/=
Frameworks/SpeechSynthesis.framework/Versions/A/SpeechSynthesis
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e34d000 -     0x7fff8e371ff7  com.apple.Re=
moteViewServices (1.2 - 39) <862849C8-84C1-32A1-B87E-B29E74778C9F> /System/=
Library/PrivateFrameworks/RemoteViewServices.framework/Versions/A/RemoteVie=
wServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e508000 -     0x7fff8e51bff7  libCRFSuite.=
dylib (??? - ???) <034D4DAA-63F0-35E4-BCEF-338DD7A453DD> /usr/lib/libCRFSui=
te.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7a7000 -     0x7fff8e7a9ff7  com.apple.pr=
int.framework.Print (7.1 - 247.1) <8A4925A5-BAA3-373C-9B5D-03E0270C6B12> /S=
ystem/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/Print.frame=
work/Versions/A/Print
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7aa000 -     0x7fff8e7adff7  com.apple.se=
curityhi (4.0 - 1) <B37B8946-BBD4-36C1-ABC6-18EDBC573F03> /System/Library/F=
rameworks/Carbon.framework/Versions/A/Frameworks/SecurityHI.framework/Versi=
ons/A/SecurityHI
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7ae000 -     0x7fff8e7bcfff  libdispatch.=
dylib (187.7.0 - compatibility 1.0.0) <712AAEAC-AD90-37F7-B71F-293FF8AE8723=
> /usr/lib/system/libdispatch.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7bd000 -     0x7fff8e7befff  liblangid.dy=
lib (??? - ???) <CACBE3C3-2F7B-3EED-B50E-EDB73F473B77> /usr/lib/liblangid.d=
ylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7cc000 -     0x7fff8e7e9fff  libPng.dylib=
 (??? - ???) <3C70A94C-9442-3E11-AF51-C1B0EF81680E> /System/Library/Framewo=
rks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framework/V=
ersions/A/Resources/libPng.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7ea000 -     0x7fff8e7eafff  com.apple.Ac=
celerate (1.7 - Accelerate 1.7) <82DDF6F5-FBC3-323D-B71D-CF7ABC5CF568> /Sys=
tem/Library/Frameworks/Accelerate.framework/Versions/A/Accelerate
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e7eb000 -     0x7fff8e801fff  libGL.dylib =
(??? - ???) <6A473BF9-4D35-34C6-9F8B-86B68091A9AF> /System/Library/Framewor=
ks/OpenGL.framework/Versions/A/Libraries/libGL.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e810000 -     0x7fff8e81aff7  liblaunch.dy=
lib (392.18.0 - compatibility 1.0.0) <39EF04F2-7F0C-3435-B785-BF283727FFBD>=
 /usr/lib/system/liblaunch.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e95f000 -     0x7fff8e9f5ff7  libvMisc.dyl=
ib (325.4.0 - compatibility 1.0.0) <642D8D54-F9F5-3FBB-A96C-EEFE94C6278B> /=
System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib=
.framework/Versions/A/libvMisc.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8e9f6000 -     0x7fff8ec10fef  com.apple.Co=
reData (104 - 358.12) <33B1FA75-7970-3751-9DCC-FF809D3E1FA2> /System/Librar=
y/Frameworks/CoreData.framework/Versions/A/CoreData
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8ef91000 -     0x7fff8f2aaff7  com.apple.Fo=
undation (6.7.1 - 833.20) <D922F590-FDA6-3D89-A271-FD35E2290624> /System/Li=
brary/Frameworks/Foundation.framework/Versions/C/Foundation
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8f2ab000 -     0x7fff8f38cfff  com.apple.Co=
reServices.OSServices (478.29 - 478.29) <B487110E-C942-33A8-A494-3BDEDB88B1=
CD> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks=
/OSServices.framework/Versions/A/OSServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8f3c8000 -     0x7fff8f3d5fff  libCSync.A.d=
ylib (600.0.0 - compatibility 64.0.0) <931F40EB-CA75-3A90-AC97-4DB8E210BC76=
> /System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frame=
works/CoreGraphics.framework/Versions/A/Resources/libCSync.A.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8f44d000 -     0x7fff8f4c0fff  libstdc++.6.=
dylib (52.0.0 - compatibility 7.0.0) <6BDD43E4-A4B1-379E-9ED5-8C713653DFF2>=
 /usr/lib/libstdc++.6.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8f7e3000 -     0x7fff8f7e3fff  com.apple.Ca=
rbon (153 - 153) <895C2BF2-1666-3A59-A669-311B1F4F368B> /System/Library/Fra=
meworks/Carbon.framework/Versions/A/Carbon
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8fb82000 -     0x7fff8fc9aff7  com.apple.De=
sktopServices (1.6.1 - 1.6.1) <4418EAA6-7163-3A77-ABD3-F8289796C81A> /Syste=
m/Library/PrivateFrameworks/DesktopServicesPriv.framework/Versions/A/Deskto=
pServicesPriv
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8fc9d000 -     0x7fff8fc9ffff  com.apple.Tr=
ustEvaluationAgent (2.0 - 1) <1F31CAFF-C1C6-33D3-94E9-11B721761DDF> /System=
/Library/PrivateFrameworks/TrustEvaluationAgent.framework/Versions/A/TrustE=
valuationAgent
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8fca0000 -     0x7fff8fdf9fff  com.apple.au=
dio.toolbox.AudioToolbox (1.7.1 - 1.7.1) <4877267E-F736-3019-85D3-40A32A042=
A80> /System/Library/Frameworks/AudioToolbox.framework/Versions/A/AudioTool=
box
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8fef9000 -     0x7fff8ff39ff7  libcups.2.dy=
lib (2.9.0 - compatibility 2.0.0) <B7173CA4-CE16-3BAB-8D83-185FCEFA15F5> /u=
sr/lib/libcups.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff8ff9c000 -     0x7fff900a8fff  libcrypto.0.=
9.8.dylib (44.0.0 - compatibility 0.9.8) <3A8E1F89-5E26-3C8B-B538-81F5D61DB=
F8A> /usr/lib/libcrypto.0.9.8.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff900a9000 -     0x7fff900b7ff7  libkxld.dyli=
b (??? - ???) <65BE345D-6618-3D1A-9E2B-255E629646AA> /usr/lib/system/libkxl=
d.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff900b8000 -     0x7fff900beff7  libunwind.dy=
lib (30.0.0 - compatibility 1.0.0) <1E9C6C8C-CBE8-3F4B-A5B5-E03E3AB53231> /=
usr/lib/system/libunwind.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff900cb000 -     0x7fff90204fef  com.apple.vI=
mage (5.1 - 5.1) <EB634387-CD15-3246-AC28-5FB368ACCEA2> /System/Library/Fra=
meworks/Accelerate.framework/Versions/A/Frameworks/vImage.framework/Version=
s/A/vImage
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff9020d000 -     0x7fff9023dff7  com.apple.Di=
ctionaryServices (1.2.1 - 158.2) <3FC86118-7553-38F7-8916-B329D2E94476> /Sy=
stem/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/Dictio=
naryServices.framework/Versions/A/DictionaryServices
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff9024e000 -     0x7fff90343fff  libiconv.2.d=
ylib (7.0.0 - compatibility 7.0.0) <5C40E880-0706-378F-B864-3C2BD922D926> /=
usr/lib/libiconv.2.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff90344000 -     0x7fff9038aff7  libcurl.4.dy=
lib (7.0.0 - compatibility 7.0.0) <EAF61ADC-DC00-34CE-B23E-7238ED54E31D> /u=
sr/lib/libcurl.4.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff9038b000 -     0x7fff903a8ff7  libxpc.dylib=
 (77.17.0 - compatibility 1.0.0) <72A16104-2F23-3C22-B474-1953F06F9376> /us=
r/lib/system/libxpc.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff90b3e000 -     0x7fff90b3ffff  libdnsinfo.d=
ylib (395.6.0 - compatibility 1.0.0) <718A135F-6349-354A-85D5-430B128EFD57>=
 /usr/lib/system/libdnsinfo.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff90b40000 -     0x7fff90e5cff7  com.apple.Co=
reServices.CarbonCore (960.18 - 960.18) <6020C3FB-6125-3EAE-A55D-1E77E38BED=
EA> /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks=
/CarbonCore.framework/Versions/A/CarbonCore
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff90e9b000 -     0x7fff90e9bfff  com.apple.ve=
cLib (3.7 - vecLib 3.7) <9A58105C-B36E-35B5-812C-4ED693F2618F> /System/Libr=
ary/Frameworks/vecLib.framework/Versions/A/vecLib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff90fe4000 -     0x7fff90feafff  com.apple.Di=
skArbitration (2.4.1 - 2.4.1) <CEA34337-63DE-302E-81AA-10D717E1F699> /Syste=
m/Library/Frameworks/DiskArbitration.framework/Versions/A/DiskArbitration
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91024000 -     0x7fff91027fff  libRadiance.=
dylib (??? - ???) <CD89D70D-F177-3BAE-8A26-644EA7D5E28E> /System/Library/Fr=
ameworks/ApplicationServices.framework/Versions/A/Frameworks/ImageIO.framew=
ork/Versions/A/Resources/libRadiance.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91220000 -     0x7fff91222fff  libquarantin=
e.dylib (36.0.0 - compatibility 1.0.0) <4C3BFBC7-E592-3939-B376-1C2E2D7C538=
9> /usr/lib/system/libquarantine.dylib
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91223000 -     0x7fff9128bfff  com.apple.Co=
reSymbolication (2.1 - 71) <0715BF39-D53C-3BFE-BBEA-B8EBF7274850> /System/L=
ibrary/PrivateFrameworks/CoreSymbolication.framework/Versions/A/CoreSymboli=
cation
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff9128c000 -     0x7fff912eefff  com.apple.co=
reui (1.2.1 - 164.1) <F7972630-F696-3FC5-9FCF-A6E1C8771078> /System/Library=
/PrivateFrameworks/CoreUI.framework/Versions/A/CoreUI
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff912ef000 -     0x7fff9135ffff  com.apple.da=
tadetectorscore (3.0 - 179.4) <2A822A13-94B3-3A43-8724-98FDF698BB12> /Syste=
m/Library/PrivateFrameworks/DataDetectorsCore.framework/Versions/A/DataDete=
ctorsCore
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91367000 -     0x7fff91394ff7  com.apple.op=
encl (1.50.63 - 1.50.63) <DB335C5C-3ABD-38C8-B6A5-8436EE1484D3> /System/Lib=
rary/Frameworks/OpenCL.framework/Versions/A/OpenCL
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91395000 -     0x7fff91f96ff7  com.apple.Ap=
pKit (6.7.2 - 1138.23) <5CD2C850-4F52-3BA2-BA11-3107DFD2D23C> /System/Libra=
ry/Frameworks/AppKit.framework/Versions/C/AppKit
  =C2=A0=C2=A0=C2=A0=C2=A00x7fff91f97000 -     0x7fff91f99fff  libCVMSPlugi=
nSupport.dylib (??? - ???) <61D89F3C-C64D-3733-819F-8AAAE4E2E993> /System/L=
ibrary/Frameworks/OpenGL.framework/Versions/A/Libraries/libCVMSPluginSuppor=
t.dylib

  External Modification Summary:
  =C2=A0=C2=A0Calls made by other processes targeting this process:
  =C2=A0=C2=A0=C2=A0=C2=A0task_for_pid: 2
  =C2=A0=C2=A0=C2=A0=C2=A0thread_create: 0
  =C2=A0=C2=A0=C2=A0=C2=A0thread_set_state: 0
  =C2=A0=C2=A0Calls made by this process:
  =C2=A0=C2=A0=C2=A0=C2=A0task_for_pid: 0
  =C2=A0=C2=A0=C2=A0=C2=A0thread_create: 0
  =C2=A0=C2=A0=C2=A0=C2=A0thread_set_state: 0
  =C2=A0=C2=A0Calls made by all processes on this machine:
  =C2=A0=C2=A0=C2=A0=C2=A0task_for_pid: 103153
  =C2=A0=C2=A0=C2=A0=C2=A0thread_create: 1
  =C2=A0=C2=A0=C2=A0=C2=A0thread_set_state: 0

  VM Region Summary:
  ReadOnly portion of Libraries: Total=3D144.3M resident=3D100.5M(70%) swap=
ped_out_or_unallocated=3D43.8M(30%)
  Writable regions: Total=3D185.9M written=3D3692K(2%) resident=3D23.0M(12%=
) swapped_out=3D0K(0%) unallocated=3D162.9M(88%)

  REGION TYPE                      VIRTUAL
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                      =3D=3D=3D=3D=3D=3D=
=3D
  CG backing stores                  1496K
  CG image                              4K
  CG raster data                       64K
  CG shared images                   3480K
  CoreGraphics                         16K
  CoreServices                       4112K
  MALLOC                             67.1M
  MALLOC guard page                    32K
  MALLOC_LARGE (reserved)            25.3M        reserved VM address space=
 (unallocated)
  Memory tag=3D242                       12K
  STACK GUARD                          24K
  Stack                              66.5M
  VM_ALLOCATE                        16.1M
  __CI_BITMAP                          80K
  __DATA                             21.1M
  __IMAGE                            1256K
  __LINKEDIT                         48.1M
  __TEXT                             96.2M
  __UNICODE                           544K
  mapped file                        32.2M
  shared memory                       308K
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                      =3D=3D=3D=3D=3D=3D=
=3D
  TOTAL                             383.7M
  TOTAL, minus reserved VM space    358.4M

  Model: MacBookPro8,3, BootROM MBP81.0047.B24, 4 processors, Intel Core i7=
, 2.3 GHz, 8 GB, SMC 1.70f3
  Graphics: AMD Radeon HD 6750M, AMD Radeon HD 6750M, PCIe, 1024 MB
  Graphics: Intel HD Graphics 3000, Intel HD Graphics 3000, Built-In, 512 MB
  Memory Module: BANK 0/DIMM0, 4 GB, DDR3, 1333 MHz, 0x80AD, 0x484D54333531=
533642465238432D48392020
  Memory Module: BANK 1/DIMM0, 4 GB, DDR3, 1333 MHz, 0x80AD, 0x484D54333531=
533642465238432D48392020
  AirPort: spairport_wireless_card_type_airport_extreme (0x14E4, 0xD6), Bro=
adcom BCM43xx 1.0 (5.100.98.75.18)
  Bluetooth: Version 4.0.1f4, 2 service, 11 devices, 1 incoming serial ports
  Network Service: Wi-Fi, AirPort, en1
  Serial ATA Device: APPLE SSD TS512C, 500.28 GB
  Serial ATA Device: MATSHITADVD-R   UJ-898
  USB Device: FaceTime HD Camera (Built-in), apple_vendor_id, 0x8509, 0xfa2=
00000 / 3
  USB Device: hub_device, 0x0424  (SMSC), 0x2514, 0xfa100000 / 2
  USB Device: BRCM2070 Hub, 0x0a5c  (Broadcom Corp.), 0x4500, 0xfa110000 / 5
  USB Device: Bluetooth USB Host Controller, apple_vendor_id, 0x821a, 0xfa1=
13000 / 7
  USB Device: Apple Internal Keyboard / Trackpad, apple_vendor_id, 0x0253, =
0xfa120000 / 4
  USB Device: hub_device, 0x0424  (SMSC), 0x2514, 0xfd100000 / 2
  USB Device: Freecom Hard Drive XS, 0x07ab  (Freecom Computer Peripherals)=
, 0xfc8e, 0xfd120000 / 5
  USB Device: IR Receiver, apple_vendor_id, 0x8242, 0xfd110000 / 3

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/886621/+subscriptions
