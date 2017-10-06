Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0QqF-0007wF-17
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0QqB-0002Kz-LZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:59800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0QqB-0002K7-EF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0QqA-00019X-AS
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 11:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4D2D52E80CB
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 11:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Oct 2017 11:21:08 -0000
From: Greg Kurz <groug@kaod.org>
Reply-To: Bug 1721744 <1721744@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150728578413.796.15373444520066064008.malonedeb@chaenomeles.canonical.com>
Message-Id: <150728886813.8130.14646885344900219104.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721744] Re: Help content missing for newly added
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hmm... -h is common to all targets, ie, you should only find properties
that can be passed to -machine for all qemu-system-* binaries (I don't
know how s390-squash-mcss landed there but it looks wrong).

The right way to query properties supported by a pseries machine type
is:

$ ./ppc64-softmmu/qemu-system-ppc64 -machine pseries,help
pseries-2.11.kvm-type=3Dstring (Specifies the KVM virtualization mode (HV, =
PR))
pseries-2.11.vsmt=3Duint32 (Virtual SMT: KVM behaves as if this were the ho=
st's SMT mode)
pseries-2.11.modern-hotplug-events=3Dbool (Use dedicated hotplug event mech=
anism in place of standard EPOW events when possible (required for memory h=
ot-unplug support))
pseries-2.11.max-cpu-compat=3Dstring (Maximum permitted CPU compatibility m=
ode. Valid values are power6, power7, power7+, power8, power9.)
pseries-2.11.resize-hpt=3Dstring (Resizing of the Hash Page Table (enabled,=
 disabled, required))
pseries-2.11.kvm-shadow-mem=3Dint (KVM shadow MMU size)
pseries-2.11.enforce-config-section=3Dbool (Set on to enforce configuration=
 section migration)
pseries-2.11.initrd=3Dstring (Linux initial ramdisk file)
pseries-2.11.mem-merge=3Dbool (Enable/disable memory merge support)
pseries-2.11.firmware=3Dstring (Firmware image)
pseries-2.11.dtb=3Dstring (Linux kernel device tree file)
pseries-2.11.suppress-vmdesc=3Dbool (Set on to disable self-describing migr=
ation)
pseries-2.11.usb=3Dbool (Set on/off to enable/disable usb)
pseries-2.11.kernel=3Dstring (Linux kernel image file)
pseries-2.11.dt-compatible=3Dstring (Overrides the "compatible" property of=
 the dt root node)
pseries-2.11.igd-passthru=3Dbool (Set on/off to enable/disable igd passthro=
u)
pseries-2.11.dumpdtb=3Dstring (Dump current dtb to a file and quit)
pseries-2.11.append=3Dstring (Linux kernel command line)
pseries-2.11.accel=3Dstring (Accelerator list)
pseries-2.11.kernel-irqchip=3DOnOffSplit (Configure KVM in-kernel irqchip)
pseries-2.11.dump-guest-core=3Dbool (Include guest memory in  a core dump)
pseries-2.11.phandle-start=3Dint (The first phandle ID we may generate dyna=
mically)
pseries-2.11.graphics=3Dbool (Set on/off to enable/disable graphics emulati=
on)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721744

Title:
  Help content missing for newly added machine properties

Status in QEMU:
  New

Bug description:
  =

  Help content missing for newly added machine properties, it would be need=
ed by libvirt and other management layers to query to add support, Thanks.

  max-cpu-compat,vsmt,modern-hotplug-events,resize-hpt

  Steps:
  1. Compile qemu @below commit
  2. ./ppc64-softmmu/qemu-system-ppc64 -h
  ....
  -machine [type=3D]name[,prop[=3Dvalue][,...]]
                  selects emulated machine ('-machine help' for list)
                  property accel=3Daccel1[:accel2[:...]] selects accelerator
                  supported accelerators are kvm, xen, hax or tcg (default:=
 tcg)
                  kernel_irqchip=3Don|off|split controls accelerated irqchi=
p support (default=3Doff)
                  vmport=3Don|off|auto controls emulation of vmport (defaul=
t: auto)
                  kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes
                  dump-guest-core=3Don|off include guest memory in a core d=
ump (default=3Don)
                  mem-merge=3Don|off controls memory merge support (default=
: on)
                  igd-passthru=3Don|off controls IGD GFX passthrough suppor=
t (default=3Doff)
                  aes-key-wrap=3Don|off controls support for AES key wrappi=
ng (default=3Don)
                  dea-key-wrap=3Don|off controls support for DEA key wrappi=
ng (default=3Don)
                  suppress-vmdesc=3Don|off disables self-describing migrati=
on (default=3Doff)
                  nvdimm=3Don|off controls NVDIMM support (default=3Doff)
                  enforce-config-section=3Don|off enforce configuration sec=
tion migration (default=3Doff)
                  s390-squash-mcss=3Don|off controls support for squashing =
into default css (default=3Doff)
  ....

  =3D=3D=3D> Not showing help of mentioned properties.


  Verified at todays below commit
  #git show
  commit d8f932cc696250cb740240d668b39df5fbb2d5a0
  Merge: 67caeea 4504273
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Thu Oct 5 16:54:29 2017 +0100

      Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-requ=
est' into staging
      =

      # gpg: Signature made Thu 05 Oct 2017 15:25:21 BST
      # gpg:                using RSA key 0x9CA4ABB381AB73C8
      # gpg: Good signature from "Stefan Hajnoczi <stefanha@redhat.com>"
      # gpg:                 aka "Stefan Hajnoczi <stefanha@gmail.com>"
      # Primary key fingerprint: 8695 A8BF D3F9 7CDA AC35  775A 9CA4 ABB3 8=
1AB 73C8
      =

      * remotes/stefanha/tags/tracing-pull-request:
        checkpatch: fix incompatibility with old perl
      =

      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721744/+subscriptions
