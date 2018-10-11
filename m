Received: from eggs.gnu.org ([2001:4830:134:3::10]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAWzp-0004JT-Bf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAWzk-0001A3-Q4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:11:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:53022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gAWzk-00019M-IA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:11:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gAWzi-0003NO-2H
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 09:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 41A582E80E9
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 09:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Oct 2018 09:05:04 -0000
From: Nicolas <1797332@bugs.launchpad.net>
Reply-To: Bug 1797332 <1797332@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153924853499.3904.14862750971017456756.malonedeb@soybean.canonical.com>
Message-Id: <153924870470.13001.10675506766526716778.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1797332] Re: qemu nested virtualization is not
 working with Ubuntu16.04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "The same question, but markdown readable and with mor=
e spaces"
   https://bugs.launchpad.net/qemu/+bug/1797332/+attachment/5199881/+files/=
nestedVirtBug.md

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1797332

Title:
  qemu nested virtualization is not working with Ubuntu16.04

Status in QEMU:
  New

Bug description:
  # 1 What am I trying to do ? #

  I want to use `libvirt` `qemu/KVM` with **nested virtualization** like de=
scribed
  in [1] and [2].
  **But it does not work with Ubuntu16.04.** It worked some times ago, but =
not
  anymore.

  =

  I want 2 levels of virtualization like this:

  * L0 =E2=80=93 the bare metal host, running KVM on `Ubuntu 16.04`
  * L1 =E2=80=93 a `Ubuntu 16.04` VM running on L0; also called the "guest =
hypervisor" =

    =E2=80=94 as it itself is capable of running KVM
  * L2 =E2=80=93 a `Ubuntu 16.04` VM running on L1, also called the "nested=
 guest"

  =

  [1] https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtuali=
zation-in-kvm/
  [2] https://www.linux-kvm.org/page/Nested_Guests

  =

  My goal is to deploy an `OpenStack` environnement on top of VMs rather th=
an on
  bare metal hosts for convenience for a lab experiment. As a result, the =

  `OpenStack` nodes are L1 VMs. Compute nodes are L1 VMs as well and the VM=
s =

  created with `OpenStack` and wich are running on the compute nodes are L2=
 VMs.



  =

  # 2 What is my problem ? #

  I can **not** run my 2nd levels of virtualization in 16.04:

  * L0 is just fine: running `Ubuntu 16.04.5 LTS`, installed with the `.iso=
` image
  * L1: I install `libvirt` + `KVM` on L0. I can run VMs like the `Ubuntu16=
.04` =

    cloud image on L0.
  * L2: I install `libvirt` + `KVM` on L1 as well. But I **can not** run VM=
s on =

    L1: I get `kernel panic` or `general protection fault`.

  =

  **But if I do the same with Ubuntu18.04** (on the same hardware) instead =
of =

  `Ubuntu16.04`, it works without faults.
  I don't change the configuration or `virt-install scripts` (other than us=
ing =

  the 18.04 .iso and cloud image).



  =

  # 3 My libvirt installation for Ubuntu16.04 #

  I install `libvir KVM` in both L0 and L1 using a custom repository [3] fr=
om =

  `OpenStack` team, because their version of libvirt in this repo is newer =
than  =

  the one on Ubuntu 16.04 official repo and it match the version of `libvir=
t` =

  in Ubuntu 18.04.

  [3] https://wiki.ubuntu.com/OpenStack/CloudArchive



  =

  # 4 hardware and CPU #

  CPU is:
  > Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
  > Intel virt is enable in the bios/uefi.

  The rest is standard HDD, standard I/O...



  =

  # 5 .iso and cloud image #

  I download .iso for L0 bare metal server and cloud image =

  for L1/L2 VMs from official repository:

  Ubuntu 16.04
   * http://releases.ubuntu.com/16.04/
   * https://cloud-images.ubuntu.com/releases/16.04/release/

  Ubuntu 18.04
   * http://releases.ubuntu.com/bionic/
   * https://cloud-images.ubuntu.com/releases/18.04/release/



  =

  # 6 Details #

  ## Details about L0 Ubuntu 16.04 bare metal host ##
  L0 is running `Ubuntu 16.04.5 LTS` installed with the .iso.

  =

  **kernel**
  ```
  user@L0:~$ uname -a
  Linux L0 4.4.0-137-generic #163-Ubuntu SMP Mon Sep 24 13:14:43 UTC 2018 x=
86_64 x86_64 x86_64 GNU/Linux
  ```

  **libvirt version** running on L0
  ```
  user@L0:~$ virsh version
  Compiled against library: libvirt 4.0.0
  Using library: libvirt 4.0.0
  Using API: QEMU 4.0.0
  Running hypervisor: QEMU 2.11.1
  ```

  **qemu version detail**
  ```
  ukvm2@kvm2:~$ qemu-system-x86_64 --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.5~cloud0)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  ```

  **KVM acceleration**
  ```
  user@L0:~$ kvm-ok =

  INFO: /dev/kvm exists
  KVM acceleration can be used
  ```

  **nested parameter**
  ```
  user@L0:~$ cat /sys/module/kvm_intel/parameters/nested
  Y
  ```

  **number of CPU**
  ```
  user@L0:~$ egrep -c '(vmx|svm)' /proc/cpuinfo
  48
  ```


  ## Details about a L1 Ubuntu 16.04 VM ##
  A VM in L1 (which is running on L0) which is running `Ubuntu 16.04.5 LTS` =

  installed by a cloud image.

  **kernel**
  ```
  user@L1-VM:~$ uname -a
  Linux L1 4.4.0-137-generic #163-Ubuntu SMP Mon Sep 24 13:14:43 UTC 2018 x=
86_64 x86_64 x86_64 GNU/Linux
  ```

  **libvirt version** running on the L1 VM
  ```
  user@L1-VM:~$ sudo virsh version
  Compiled against library: libvirt 4.0.0
  Using library: libvirt 4.0.0
  Using API: QEMU 4.0.0
  Running hypervisor: QEMU 2.11.1
  ```

  **qemu version detail**
  ```
  user@L1-VM:~$ qemu-system-x86_64 --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.5~cloud0)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  ```

  **KVM acceleration**
  ```
  user@L1-VM:~$ kvm-ok =

  INFO: /dev/kvm exists
  KVM acceleration can be used
  ```

  **nested parameter**
  ```
  user@L1-VM:~$ cat /sys/module/kvm_intel/parameters/nested
  Y
  ```

  **number of CPU**, which are vCPU given by L0 to the L1 VM
  I give 20 vCPU.
  ```
  user@L1-VM:~$ egrep -c '(vmx|svm)' /proc/cpuinfo
  20
  ```


  ## L1 VM virt-install script parameter ##
  If you want to reproduce an L1 VM, I followed this [4]:

  ```
  virt-install \
      --connect=3Dqemu:///system \
      --name $VMName \
      --memory $RAM \
      --vcpus $VCPUS \
      --cpu host \
      --metadata description=3D$DESCRIPTION \
      --os-type linux \
      --os-variant ubuntu16.04 \
      --disk $DISK_PATH/$VMName.$DISK_FORMAT,size=3D$DISK_SIZE,bus=3Dvirtio=
 \
      --disk $CFGIMG_PATH/config_$VMName.$DISK_FORMAT,device=3Dcdrom \
      --network bridge=3Dvirbr0 \
      --graphics none \
      --console pty,target_type=3Dserial \
      --hvm
  ```

  [4] https://youth2009.org/post/kvm-with-ubuntu-cloud-image/


  ## Details about a L2 VM ##

  I want to create a L2 `Ubuntu 16.04.5 LTS` VM installed by a cloud image =
VM =

  within my L1 `KVM` VM. But whatever I do, my L2 VM crash before finishing=
 to be =

  instantiated. I get `kernel panic` or `general protection fault`.

  =

  Here is the log of an L2 VM after the instanciation failed:
  ```
  user@L1-VM:~$ less /var/log/libvirt/qemu/VMNAME.log

  2018-10-11T07:40:45.837151Z qemu-system-x86_64: -chardev pty,id=3Dcharser=
ial0: char device redirected to /dev/pts/1 (label charserial0)
  2018-10-11T07:40:45.844279Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: CPUID.07H:EBX.invpcid [bit 10]
  2018-10-11T07:40:45.848532Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: CPUID.07H:EBX.invpcid [bit 10]
  ```

  =

  If you want to reproduce an L2 VM running on L1, follow [4].

  =

  **However** a Cirros OS image can run on a L1 VM !



  =

  # 7 Thoughts #
  I think this is a bug in either `Ubuntu16.04` or `libvirt`.
  All the information are here to reproduce the bug, I think.

  =

  If I do the same with `Ubuntu 18.04`, on the same hardware, following the=
 same =

  steps but with Ubuntu 18.04 .iso and cloud image, it works.

  It works if:

  * L0 =3D Ubuntu18.04 (.iso) + qemu/KVM
  * L1 =3D Ubuntu18.04 (cloud image) + qemu/KVM
  * L2 =3D Ubuntu18.04 (cloud image)

  =

  It also works if:

  * L0 =3D Ubuntu18.04 (.iso) + qemu/KVM
  * L1 =3D Ubuntu18.04 (cloud image) + qemu/KVM
  * L2 =3D Ubuntu16.04 (cloud image)


  =

  Thank you for your time reading !
  --
  nico

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1797332/+subscriptions
