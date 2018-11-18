Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOQ7z-0003gB-EG
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 11:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOQ7w-0006CZ-5n
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 11:40:55 -0500
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:41760
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOQ7v-00068b-R2
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 11:40:52 -0500
Received: from dschgrazlin2.units.it (loopback [127.0.0.1])
	by dschgrazlin2.units.it (8.15.2/8.15.2) with ESMTP id wAIGeP50001236
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 17:40:25 +0100
From: balducci@units.it
Reply-to: balducci@units.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1234.1542559249.1@dschgrazlin2.units.it>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Nov 2018 17:40:25 +0100
Message-ID: <1235.1542559249@dschgrazlin2.units.it>
Subject: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hello

I'm building qemu from source and happily using it since a bit
(2.3.0)

Since 3.1.0-rc0 (including latest 3.1.0-rc1) I'm no more able to start
qemu, getting:

    ----8<----
    install:115> qemu
    qemu: error: failed to set MSR 0x10a to 0x0
    qemu: /home/balducci/tmp/install-us-d/qemu-3.1.0-rc1.d/qemu-3.1.0-rc0/=
target/i386/kvm.c:2185: kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_b=
uf->nmsrs' failed.
    Aborted
    ---->8----

I have no idea about what the reason might be, apologies.

Actually, I have found a recent (2018-10-16) post which might be
related to this (it mentions the same error message from qemu):
https://lkml.org/lkml/2018/10/16/440; but I'm not in the position to
go through. AFAICS, the commit mentioned in the link is present in the
4.19.2 kernel I'm using, so...?

I can add that 3.0.0 works nicely (everything else unchanged,
including running kernel 4.19.2)

OTOH, 3.1.0-rc0 dumps the same error message if I boot into 4.17.14 or
4.18.16 kernels.

I enclose my specs hoping that somebody can spot where the problem
might be. I will be happy to send any other detail which might be
useful.

I suspect that this might be some problem on my side, as I couldn't
find any similar report (apart some old (qemu-2.8.50) threads, that
didn't help)


thanks a lot in advance for any hint/help

ciao
gabriele


Here are my specs:

# --------------------------------
# command to run qemu is:
qemu -m 2G /opt/windog  \
    -accel kvm,thread=3Dmulti \
    -netdev user,id=3Dnet0,smb=3D/home/balducci \
    -device rtl8139,netdev=3Dnet0

# --------------------------------
# qemu build configuration:
--prefix=3D/opt/stow.d/versions/qemu-3.1.0-rc1/usr
--libdir=3D/opt/stow.d/versions/qemu-3.1.0-rc1/usr/lib64
--sysconfdir=3D/opt/stow.d/versions/qemu-3.1.0-rc1/etc
--localstatedir=3D/var/run
--docdir=3D/opt/stow.d/versions/qemu-3.1.0-rc1/usr/share/doc/qemu
--target-list=3Dx86_64-softmmu
--audio-drv-list=3Dalsa


# --------------------------------
install:154> uname -sr
Linux 4.19.2

# --------------------------------
install:155> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 21
model           : 48
model name      : AMD Athlon(tm) X4 860K Quad Core Processor
stepping        : 1
microcode       : 0x6003106
cpu MHz         : 3473.492
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 16
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
 cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pd=
pe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid a=
perfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xs=
ave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misaligns=
se 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoe=
xt perfctr_core perfctr_nb bpext ptsc cpb hw_pstate ssbd vmmcall fsgsbase =
bmi1 xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushb=
yasid decodeassists pausefilter pfthreshold overflow_recov
bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_=
v2 spec_store_bypass
bogomips        : 7380.73
TLB size        : 1536 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro [13]

[...cpus 1 2 3 omitted...]


# --------------------------------
install:156> egrep KVM .config-4.19.2
CONFIG_HAVE_KVM=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_IRQFD=3Dy
CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
CONFIG_HAVE_KVM_EVENTFD=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_KVM_ASYNC_PF=3Dy
CONFIG_HAVE_KVM_MSI=3Dy
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
CONFIG_KVM_VFIO=3Dy
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
CONFIG_KVM_COMPAT=3Dy
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
CONFIG_KVM=3Dy
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=3Dy

[of course, I can send the whole kernel configuration file, if needed]
