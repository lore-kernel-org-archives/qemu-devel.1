Received: from eggs.gnu.org ([2001:4830:134:3::10]:57189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNjqt-0001J6-TS
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNjqr-00026N-2C
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:45825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNjqq-000264-ST
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:55:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNjqp-0006Kt-8y
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 17:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E7E612E8193
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 17:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2017 17:38:31 -0000
From: Anatol Pomozov <1248959@bugs.launchpad.net>
Reply-To: Bug 1248959 <1248959@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131107133921.24319.20662.malonedeb@gac.canonical.com>
Message-Id: <149806671142.3407.13126852924519842175.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1248959] Re: pdpe1gb flag is missing in guest
 running on Intel h/w
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I observe the same situation. My host CPU (Intel Xeon CPU E5-2690)
supports 1gb pages but qemu keeps it disabled by default. I have to use
either '-cpu phenom' or '-cpu host' with KVM.

It makes me wondering what is the default CPU for QEMU? Is it possible
to set qemu CPU featureset closer to what host CPU has?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1248959

Title:
  pdpe1gb flag is missing in guest running on Intel h/w

Status in QEMU:
  New

Bug description:
  I need to utilize 1G hugepages on my guest system. But this is not
  possible as long as there is no pdpe1gb support in guest system.  The
  latest source code contains pdpe1gb  support for AMD but not for
  Intel.

  Are there any obstacles that does not allow to implement it for modern
  Intel chips?

  My configuration:
  Host:
  -------
  uname -a
  Linux tripel.salab.cic.nsn-rdnet.net 2.6.32-358.14.1.el6.x86_64 #1 SMP Tu=
e Jul 16 23:51:20 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

  cat /etc/*-release
  CentOS release 6.4 (Final)

  yum list installed | grep qemu
  gpxe-roms-qemu.noarch                0.9.7-6.9.el6             @base
  qemu-img.x86_64                      2:0.12.1.2-2.355.0.1.el6.centos.5
  qemu-kvm.x86_64                      2:0.12.1.2-2.355.0.1.el6.centos.5

  cat /proc/cpuinfo
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 45
  model name      : Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
  stepping        : 7
  cpu MHz         : 2700.000
  cache size      : 20480 KB
  physical id     : 0
  siblings        : 16
  core id         : 0
  cpu cores       : 8
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 13
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=
 pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology no=
nstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ss=
se3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer =
aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dts tpr_shadow vnmi fle=
xpriority ept vpid
  bogomips        : 5387.09
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 46 bits physical, 48 bits virtual

  /usr/libexec/qemu-kvm -cpu ?
  Recognized CPUID flags:
    f_edx: pbe ia64 tm ht ss sse2 sse fxsr mmx acpi ds clflush pn pse36 pat=
 cmov mca pge mtrr sep apic cx8 mce pae msr tsc pse de vme fpu
    f_ecx: hypervisor rdrand f16c avx osxsave xsave aes tsc-deadline popcnt=
 movbe x2apic sse4.2|sse4_2 sse4.1|sse4_1 dca pcid pdcm xtpr cx16 fma cid s=
sse3 tm2 est smx vmx ds_cpl monitor dtes64 pclmulqdq|pclmuldq pni|sse3
    extf_edx: 3dnow 3dnowext lm|i64 rdtscp pdpe1gb fxsr_opt|ffxsr fxsr mmx =
mmxext nx|xd pse36 pat cmov mca pge mtrr syscall apic cx8 mce pae msr tsc p=
se de vme fpu
    extf_ecx: perfctr_nb perfctr_core topoext tbm nodeid_msr tce fma4 lwp w=
dt skinit xop ibs osvw 3dnowprefetch misalignsse sse4a abm cr8legacy extapi=
c svm cmp_legacy lahf_lm

  ps ax | grep qemu
   7197 ?        Sl     0:15 /usr/libexec/qemu-kvm -name vladimir.AS-0 -S -=
M rhel6.4.0 -cpu SandyBridge,+pdpe1gb,+osxsave,+dca,+pcid,+pdcm,+xtpr,+tm2,=
+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -en=
able-kvm -m 8192 -mem-prealloc -mem-path /var/lib/hugetlbfs/pagesize-1GB/li=
bvirt/qemu -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid ec2d3c58-a7f0-fdb=
d-9de5-b547a5b3130f -nographic -nodefconfig -nodefaults -chardev socket,id=
=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/vladimir.AS-0.monitor,server,no=
wait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc=
 -no-shutdown -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -n=
etdev tap,fd=3D28,id=3Dhostnet0 -device e1000,netdev=3Dhostnet0,id=3Dnet0,m=
ac=3D52:54:00:81:5b:df,bus=3Dpci.0,addr=3D0x3,bootindex=3D1 -chardev pty,id=
=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -devic=
e pci-assign,host=3D02:00.0,id=3Dhostdev0,configfd=3D29,bus=3Dpci.0,addr=3D=
0x4 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5

  Guest:
  ---------
  # uname -a
  Linux AS-0 2.6.34.13-WR4.3.fp_x86_64_standard-00019-g052bb3e #1 SMP Wed M=
ay 8 12:21:02 EEST 2013 x86_64 x86_64 x86_64 GNU/Linux

  #  cat /etc/*-release
  Wind River Linux 4.3 glibc_cgl

  # cat /proc/cpuinfo
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 42
  model name      : Intel Xeon E312xx (Sandy Bridge)
  stepping        : 1
  cpu MHz         : 2693.893
  cache size      : 4096 KB
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 13
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cm=
ov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx lm constant_tsc rep_go=
od pni pclmulqdq ssse3 cx16 sse4_1 sse4_2 x2apic popcnt aes xsave avx hyper=
visor lahf_lm xsaveopt
  bogomips        : 5387.78
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 46 bits physical, 48 bits virtual

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1248959/+subscriptions
