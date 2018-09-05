Received: from eggs.gnu.org ([2001:4830:134:3::10]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxeGx-0003jE-CM
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 16:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxeDd-00069E-Cn
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 16:16:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:58926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxeDc-000606-PS
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 16:16:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxeDZ-0005fl-95
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 20:16:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A47E92E8137
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 20:15:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 20:01:21 -0000
From: Heiko Sieger <1788665@bugs.launchpad.net>
Reply-To: Bug 1788665 <1788665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153504502595.30588.13203676939349086206.malonedeb@soybean.canonical.com>
	<153614290639.16471.6235135409728947643.malone@chaenomeles.canonical.com>
Message-Id: <C0780D4A-0F0E-4D85-AD59-A293143585D0@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1788665] Re: Low 2D graphics performance with
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

I won=E2=80=99t be able to run any tests for the next 16 days at the very l=
east,
as I=E2=80=99m traveling.


> On 5 Sep 2018, at 13:21, Dr. David Alan Gilbert <dgilbert@redhat.com> wro=
te:
> =

> I don't have the nvidia for pass through to try this with; but I suggest
> that you try the following:
> =

>  a) Start a windows vm running an older version unaffected by the bug and=
 start a 2d test =

>  b) run 'perf top' on the host while the test is running and capture the =
results
>     - make sure you have debug symbols for both qemu (and related librari=
es) and the kernel =

>  c) now repeat a/b for the newer version of windows that's affected
> =

> add the results of the 'perf top' to this bug; hopefully we'll be able
> to see qemu or the kernel spending a lot more time in some particular
> routine in the new version.
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1788665
> =

> Title:
>  Low 2D graphics performance with Windows 10 (1803) VGA passthrough VM
>  using "Spectre" protection
> =

> Status in QEMU:
>  New
> =

> Bug description:
>  Windows 10 (1803) VM using VGA passthrough via qemu script.
> =

>  After upgrading Windows 10 Pro VM to version 1803, or possibly after
>  applying the March/April security updates from Microsoft, the VM would
>  show low 2D graphics performance (sluggishness in 2D applications and
>  low Passmark results).
> =

>  Turning off Spectre vulnerability protection in Windows remedies the
>  issue.
> =

>  Expected behavior:
>  qemu/kvm hypervisor to expose firmware capabilities of host to guest OS =
- see https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CV=
E-2017-5715-and-hyper-v-vms
> =

>  Background:
> =

>  Starting in March or April Microsoft began to push driver updates in
>  their updates / security updates. See https://support.microsoft.com
>  /en-us/help/4073757/protect-your-windows-devices-against-spectre-
>  meltdown
> =

>  One update concerns the Intel microcode - see
>  https://support.microsoft.com/en-us/help/4100347. It is activated by
>  default within Windows.
> =

>  Once the updates are applied within the Windows guest, 2D graphics
>  performance drops significantly. Other performance benchmarks are not
>  affected.
> =

>  A bare metal Windows installation does not display a performance loss
>  after the update. See https://heiko-sieger.info/low-2d-graphics-
>  benchmark-with-windows-10-1803-kvm-vm/
> =

>  Similar reports can be found here:
>  https://www.reddit.com/r/VFIO/comments/97unx4/passmark_lousy_2d_graphics=
_performance_on_windows/
> =

>  Hardware:
> =

>  6 core Intel Core i7-3930K (-MT-MCP-)
> =

>  Host OS:
>  Linux Mint 19/Ubuntu 18.04
>  Kernel: 4.15.0-32-generic x86_64
>  Qemu: QEMU emulator version 2.11.1
>  Intel microcode (host): 0x714
>  dmesg | grep microcode
>  [    0.000000] microcode: microcode updated early to revision 0x714, dat=
e =3D 2018-05-08
>  [    2.810683] microcode: sig=3D0x206d7, pf=3D0x4, revision=3D0x714
>  [    2.813340] microcode: Microcode Update Driver: v2.2.
> =

>  Note: I manually updated the Intel microcode on the host from 0x713 to
>  0x714. However, both microcode versions produce the same result in the
>  Windows guest.
> =

>  Guest OS:
>  Windows 10 Pro 64 bit, release 1803
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1788665/+subscriptions

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
