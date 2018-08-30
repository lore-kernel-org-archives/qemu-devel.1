Received: from eggs.gnu.org ([2001:4830:134:3::10]:57235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvLAH-0002BX-Al
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvL0U-0006u6-Lm
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:21:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:42906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvL0U-0006sm-G8
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:20:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvL0S-000706-Ft
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 11:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BD352E8137
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 11:20:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Aug 2018 11:08:41 -0000
From: Heiko Sieger <1788665@bugs.launchpad.net>
Reply-To: Bug 1788665 <1788665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153504502595.30588.13203676939349086206.malonedeb@soybean.canonical.com>
Message-Id: <153562732107.21537.18103342443445007447.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788665] Re: Low 2D graphics performance with
 Windows 10 (1803) VGA passthrough VM using "Spectre" protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Downloaded and ran the spectre-meltdown-checker.sh

$ spectre-meltdown-checker.sh =

Spectre and Meltdown mitigation detection tool v0.39+

Checking for vulnerabilities on current system
Kernel is Linux 4.15.0-33-generic #36-Ubuntu SMP Wed Aug 15 16:00:05 UTC 20=
18 x86_64
CPU is Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz

Hardware check
* Hardware support (CPU microcode) for mitigation techniques
  * Indirect Branch Restricted Speculation (IBRS)
    * SPEC_CTRL MSR is available:  YES =

    * CPU indicates IBRS capability:  YES  (SPEC_CTRL feature bit)
  * Indirect Branch Prediction Barrier (IBPB)
    * PRED_CMD MSR is available:  YES =

    * CPU indicates IBPB capability:  YES  (SPEC_CTRL feature bit)
  * Single Thread Indirect Branch Predictors (STIBP)
    * SPEC_CTRL MSR is available:  YES =

    * CPU indicates STIBP capability:  NO =

  * Speculative Store Bypass Disable (SSBD)
    * CPU indicates SSBD capability:  YES  (Intel SSBD)
  * L1 data cache invalidation
    * FLUSH_CMD MSR is available:  YES =

  * Enhanced IBRS (IBRS_ALL)
    * CPU indicates ARCH_CAPABILITIES MSR availability:  NO =

    * ARCH_CAPABILITIES MSR advertises IBRS_ALL capability:  NO =

  * CPU explicitly indicates not being vulnerable to Meltdown (RDCL_NO):  N=
O =

  * CPU explicitly indicates not being vulnerable to Variant 4 (SSB_NO):  N=
O =

  * Hypervisor indicates host CPU might be vulnerable to RSB underflow (RSB=
A):  NO =

  * CPU microcode is known to cause stability problems:  NO  (model 0x2d fa=
mily 0x6 stepping 0x7 ucode 0x1 cpuid 0x206d7)
  * CPU microcode is the latest known available version:  NO  (latest known=
 version is 0x714 according to Intel Microcode Guidance, August 8 2018)
* CPU vulnerability to the speculative execution attack variants
  * Vulnerable to Variant 1:  YES =

  * Vulnerable to Variant 2:  YES =

  * Vulnerable to Variant 3:  YES =

  * Vulnerable to Variant 3a:  YES =

  * Vulnerable to Variant 4:  YES =

  * Vulnerable to Variant l1tf:  YES =


CVE-2017-5753 [bounds check bypass] aka 'Spectre Variant 1'
* Mitigated according to the /sys interface:  YES  (Mitigation: __user poin=
ter sanitization)
* Kernel has array_index_mask_nospec:  YES  (1 occurrence(s) found of x86 6=
4 bits array_index_mask_nospec())
* Kernel has the Red Hat/Ubuntu patch:  NO =

* Kernel has mask_nospec64 (arm64):  NO =

> STATUS:  NOT VULNERABLE  (Mitigation: __user pointer sanitization)

CVE-2017-5715 [branch target injection] aka 'Spectre Variant 2'
* Mitigated according to the /sys interface:  YES  (Mitigation: Full generi=
c retpoline, IBPB, IBRS_FW)
* Mitigation 1
  * Kernel is compiled with IBRS support:  YES =

    * IBRS enabled and active:  YES  (for kernel and firmware code)
  * Kernel is compiled with IBPB support:  YES =

    * IBPB enabled and active:  YES =

* Mitigation 2
  * Kernel has branch predictor hardening (arm):  NO =

  * Kernel compiled with retpoline option:  YES =

    * Kernel compiled with a retpoline-aware compiler:  YES  (kernel report=
s full retpoline compilation)
> STATUS:  NOT VULNERABLE  (Full retpoline + IBPB are mitigating the vulner=
ability)

CVE-2017-5754 [rogue data cache load] aka 'Meltdown' aka 'Variant 3'
* Mitigated according to the /sys interface:  YES  (Mitigation: PTI)
* Kernel supports Page Table Isolation (PTI):  YES =

  * PTI enabled and active:  YES =

  * Reduced performance impact of PTI:  YES  (CPU supports PCID, performanc=
e impact of PTI will be reduced)
* Running as a Xen PV DomU:  NO =

> STATUS:  NOT VULNERABLE  (Mitigation: PTI)

CVE-2018-3640 [rogue system register read] aka 'Variant 3a'
* CPU microcode mitigates the vulnerability:  YES =

> STATUS:  NOT VULNERABLE  (your CPU microcode mitigates the vulnerability)

CVE-2018-3639 [speculative store bypass] aka 'Variant 4'
* Mitigated according to the /sys interface:  YES  (Mitigation: Speculative=
 Store Bypass disabled via prctl and seccomp)
* Kernel supports speculation store bypass:  YES  (found in /proc/self/stat=
us)
> STATUS:  NOT VULNERABLE  (Mitigation: Speculative Store Bypass disabled v=
ia prctl and seccomp)

CVE-2018-3615/3620/3646 [L1 terminal fault] aka 'Foreshadow & Foreshadow-NG'
* Mitigated according to the /sys interface:  YES  (Mitigation: PTE Inversi=
on; VMX: conditional cache flushes, SMT vulnerable)
> STATUS:  NOT VULNERABLE  (Mitigation: PTE Inversion; VMX: conditional cac=
he flushes, SMT vulnerable)


It shows that the microcode is not updated, and reports vulnerability.

If I understand correctly, the Linux VM should not install the
microcode, but report the microcode features of the host.

     * CPU indicates STIBP capability:  NO

Obviously stibp is not passed to the guest.

Is there any other/better way to pass the host cpu capabilities to the
VM?


** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2017-5753

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2017-5754

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2018-3615

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2018-3639

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2018-3640

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788665

Title:
  Low 2D graphics performance with Windows 10 (1803) VGA passthrough VM
  using "Spectre" protection

Status in QEMU:
  New

Bug description:
  Windows 10 (1803) VM using VGA passthrough via qemu script.

  After upgrading Windows 10 Pro VM to version 1803, or possibly after
  applying the March/April security updates from Microsoft, the VM would
  show low 2D graphics performance (sluggishness in 2D applications and
  low Passmark results).

  Turning off Spectre vulnerability protection in Windows remedies the
  issue.

  Expected behavior:
  qemu/kvm hypervisor to expose firmware capabilities of host to guest OS -=
 see https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CVE=
-2017-5715-and-hyper-v-vms

  Background:

  Starting in March or April Microsoft began to push driver updates in
  their updates / security updates. See https://support.microsoft.com
  /en-us/help/4073757/protect-your-windows-devices-against-spectre-
  meltdown

  One update concerns the Intel microcode - see
  https://support.microsoft.com/en-us/help/4100347. It is activated by
  default within Windows.

  Once the updates are applied within the Windows guest, 2D graphics
  performance drops significantly. Other performance benchmarks are not
  affected.

  A bare metal Windows installation does not display a performance loss
  after the update. See https://heiko-sieger.info/low-2d-graphics-
  benchmark-with-windows-10-1803-kvm-vm/

  Similar reports can be found here:
  https://www.reddit.com/r/VFIO/comments/97unx4/passmark_lousy_2d_graphics_=
performance_on_windows/

  Hardware:

  6 core Intel Core i7-3930K (-MT-MCP-)

  Host OS:
  Linux Mint 19/Ubuntu 18.04
  Kernel: 4.15.0-32-generic x86_64
  Qemu: QEMU emulator version 2.11.1
  Intel microcode (host): 0x714
  dmesg | grep microcode
  [    0.000000] microcode: microcode updated early to revision 0x714, date=
 =3D 2018-05-08
  [    2.810683] microcode: sig=3D0x206d7, pf=3D0x4, revision=3D0x714
  [    2.813340] microcode: Microcode Update Driver: v2.2.

  Note: I manually updated the Intel microcode on the host from 0x713 to
  0x714. However, both microcode versions produce the same result in the
  Windows guest.

  Guest OS:
  Windows 10 Pro 64 bit, release 1803

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788665/+subscriptions
