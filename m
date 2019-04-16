Received: from eggs.gnu.org ([209.51.188.92]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGH88-0005g5-F8
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGH87-0006kJ-15
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:59:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:56384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGH86-0006jw-Nh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:59:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGH85-0002Lk-UA
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:59:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DDF222E805D
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:59:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 05:48:05 -0000
From: Thomas Huth <1574572@bugs.launchpad.net>
Reply-To: Bug 1574572 <1574572@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160425105439.5722.90720.malonedeb@chaenomeles.canonical.com>
Message-Id: <155539368607.20874.5802821986165108067.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1574572=5D_Re=3A_config_20_sriov_di?=
 =?utf-8?q?rect_bond_ports=EF=BC=8Cvm_create_failed=2E?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you please provide the complete QEMU command line when reporting
QEMU bugs? Just dumping a log of Nova is not very useful for debugging
QEMU problems. Thanks.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1574572

Title:
  config 20 sriov direct bond ports=EF=BC=8Cvm create failed.

Status in QEMU:
  Incomplete

Bug description:
  nova log=EF=BC=9A

   2016-04-08 09:57:48.640 5057 INFO nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -] report
  alarm_instance_shutoff success

  2016-04-08 09:57:48.712 5057 INFO nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -] [instance: d860169c-
  0dac-448f-a644-01a9b200cebe] During _sync_instance_power_state the DB
  power_state (1) does not match the vm_power_state from the hypervisor
  (4). Updating power_state in the DB to match the hypervisor.

  2016-04-08 09:57:48.791 5057 WARNING nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -] [instance: d860169c-
  0dac-448f-a644-01a9b200cebe] Instance shutdown by itself. Calling the
  heal_instance_state. Current vm_state: active, current task_state:
  None, original DB power_state: 1, current VM power_state: 4

  2016-04-08 09:57:48.892 5057 INFO nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -]
  alarm_notice_heal_event result:1,host_name:tfg120,instance_id
  :d860169c-0dac-
  448f-a644-01a9b200cebe,instance_name:vfnicdirect,vm_state:active,power_st=
ate:shutdown,action:start

  2016-04-08 09:57:48.997 5057 INFO nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -]
  Refresh_instance_block_device_info:False

  2016-04-08 09:57:48.998 5057 INFO nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -] [instance: d860169c-
  0dac-448f-a644-01a9b200cebe] Rebooting instance

  2016-04-08 09:57:49.373 5057 WARNING nova.compute.manager [req-
  4e1b4d70-62b6-4158-8413-3c9f226fd13b - - - - -] [instance: d860169c-
  0dac-448f-a644-01a9b200cebe] trying to reboot a non-running instance:
  (state: 4 expected: 1)

  2016-04-08 09:57:49.479 5057 INFO nova.virt.libvirt.driver [-]
  [instance: d860169c-0dac-448f-a644-01a9b200cebe] Instance destroyed
  successfully.

  =

  libvirtd  log=EF=BC=9A

  2016-04-08 02:05:05.785+0000: 4778: info : qemuDomainDestroyFlags:2227
  : Log: VM: name=3D instance-000000b8

  2016-04-08 02:05:16.156+0000: 4771: info :
  qemuDomainDefineXMLFlags:7576 : Creating domain 'instance-000000b8'

  2016-04-08 02:05:16.158+0000: 4773: info :
  qemuDomainCreateWithFlags:7448 : Log: VM: name=3D instance-000000b8

  2016-04-08 02:05:16.158+0000: 4773: info : qemuProcessStart:4412 :
  vm=3D0x7f19482fdb30 name=3Dinstance-000000b8 id=3D-1 asyncJob=3D0
  migrateFrom=3D<null> stdin_fd=3D-1 stdin_path=3D<null> snapshot=3D(nil) v=
mop=3D0
  flags=3D0x1

  2016-04-08 02:05:16.169+0000: 4773: info :
  virNetDevReplaceNetConfig:2541 : Replace Net Config of linkdev
  enp132s0f0, vf 28, macaddress 00:d1:d4:00:05:03, vlanid 1250, stateDir
  /var/run/libvirt/hostdevmgr

  2016-04-08 02:05:16.169+0000: 4773: info :
  virNetDevReplaceNetConfig:2566 : Replace  Vf Config of enp132s0f0, vf
  28, vlanid 1250, stateDir /var/run/libvirt/hostdevmgr

  2016-04-08 02:05:16.169+0000: 4773: info :
  virNetDevReplaceVfConfig:2390 : pflinkdev enp132s0f0, vf 28,vlanid
  1250

  2016-04-08 02:05:16.178+0000: 4773: info :
  virNetDevReplaceVfConfig:2428 : save oldmac 00:d1:d4:00:05:03,
  oldvlanid 1250

  2016-04-08 02:05:16.178+0000: 4773: info : virNetDevSetVfConfig:2196 :
  ifname enp132s0f0,ifindex -1,vf 28,macaddress 00:d1:d4:00:05:03,
  vlanid 1250

  =

  qemu log=EF=BC=9A

  kvm_alloc_slot: no free slot available

  2016-04-08 06:21:04.793+0000: shutting down

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1574572/+subscriptions
