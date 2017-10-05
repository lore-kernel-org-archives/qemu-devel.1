Received: from eggs.gnu.org ([2001:4830:134:3::10]:51236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzvOB-0007x5-FY
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 21:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzvO8-0001ev-Ao
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 21:55:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:55892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzvO8-0001du-1A
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 21:55:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzvO5-0003AD-IK
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 01:55:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 875C52E8059
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 01:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Oct 2017 01:46:24 -0000
From: Sean Feole <sean.feole@canonical.com>
Reply-To: Bug 1719196 <1719196@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150626680089.6094.17724106932405637799.malonedeb@soybean.canonical.com>
Message-Id: <150716798480.29104.6024370247872021546.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719196] Re: [arm64 ocata] newly created
 instances are unable to raise network interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was able to gather libvirt XMLs from both Newton and Ocata Instances,
see attached

sfeole@BSG-75:~$ diff xmlocata xmlnewton =

1,2c1,2
< =

< main type=3D'kvm' id=3D'1'>
---
> ubuntu@lundmark:/var/lib/nova/instances/358596e4-135d-461d-a514-841164400=
14c$ sudo virsh dumpxml instance-00000001
> <domain type=3D'kvm' id=3D'1'>
4c4
<   <uuid>7c0dcd78-d6b4-4575-a882-ee5d29c64fe0</uuid>
---
>   <uuid>358596e4-135d-461d-a514-84116440014c</uuid>
7,9c7,9
<       <nova:package version=3D"15.0.6"/>
<       <nova:name>sfeole14</nova:name>
<       <nova:creationTime>2017-10-05 00:58:15</nova:creationTime>
---
>       <nova:package version=3D"14.0.8"/>
>       <nova:name>sfeole-newton</nova:name>
>       <nova:creationTime>2017-10-05 01:40:39</nova:creationTime>
18,19c18,19
<         <nova:user uuid=3D"d9f92a61c37948d9a29b8cc37e1bca05">admin</nova:=
user>
<         <nova:project uuid=3D"701441267bd148d3842f1696530b1c92">admin</no=
va:project>
---
>         <nova:user uuid=3D"12d13712253141ab845b89406507cd6c">admin</nova:=
user>
>         <nova:project uuid=3D"8b8fcaf183954f45b3eb15b27c52ec94">admin</no=
va:project>
21c21
<       <nova:root type=3D"image" uuid=3D"f329117f-5da2-4d61-8341-89a969bf0=
0e7"/>
---
>       <nova:root type=3D"image" uuid=3D"fcdf7c26-4238-4594-b8ee-fd59f601f=
dcb"/>
34c34
<     <type arch=3D'aarch64' machine=3D'virt-2.8'>hvm</type>
---
>     <type arch=3D'aarch64' machine=3D'virt'>hvm</type>
58c58
<       <source file=3D'/var/lib/nova/instances/7c0dcd78-d6b4-4575-a882-ee5=
d29c64fe0/disk'/>
---
>       <source file=3D'/var/lib/nova/instances/358596e4-135d-461d-a514-841=
16440014c/disk'/>
61c61
<         <source file=3D'/var/lib/nova/instances/_base/035458feead7f83be80=
ed020442ebf815a4067ea'/>
---
>         <source file=3D'/var/lib/nova/instances/_base/ab7429e8558ea27fb54=
f70eb92fbd0c1c07dd595'/>
70c70
<       <source file=3D'/var/lib/nova/instances/7c0dcd78-d6b4-4575-a882-ee5=
d29c64fe0/disk.eph0'/>
---
>       <source file=3D'/var/lib/nova/instances/358596e4-135d-461d-a514-841=
16440014c/disk.eph0'/>
82a83,93
>     <controller type=3D'pci' index=3D'1' model=3D'dmi-to-pci-bridge'>
>       <model name=3D'i82801b11-bridge'/>
>       <alias name=3D'pci.1'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x0'/>
>     </controller>
>     <controller type=3D'pci' index=3D'2' model=3D'pci-bridge'>
>       <model name=3D'pci-bridge'/>
>       <target chassisNr=3D'2'/>
>       <alias name=3D'pci.2'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x01' =
function=3D'0x0'/>
>     </controller>
84,86c95,97
<       <mac address=3D'fa:16:3e:a6:4b:d4'/>
<       <source bridge=3D'qbra7012530-32'/>
<       <target dev=3D'tapa7012530-32'/>
---
>       <mac address=3D'fa:16:3e:8e:fc:48'/>
>       <source bridge=3D'qbrb5d335fc-46'/>
>       <target dev=3D'tapb5d335fc-46'/>
92c103
<       <source path=3D'/var/lib/nova/instances/7c0dcd78-d6b4-4575-a882-ee5=
d29c64fe0/console.log'/>
---
>       <source path=3D'/var/lib/nova/instances/358596e4-135d-461d-a514-841=
16440014c/console.log'/>
95a107,111
>     <serial type=3D'pty'>
>       <source path=3D'/dev/pts/3'/>
>       <target port=3D'1'/>
>       <alias name=3D'serial1'/>
>     </serial>
97c113
<       <source path=3D'/var/lib/nova/instances/7c0dcd78-d6b4-4575-a882-ee5=
d29c64fe0/console.log'/>
---
>       <source path=3D'/var/lib/nova/instances/358596e4-135d-461d-a514-841=
16440014c/console.log'/>
108,113c124,125
<     <label>libvirt-7c0dcd78-d6b4-4575-a882-ee5d29c64fe0</label>
<     <imagelabel>libvirt-7c0dcd78-d6b4-4575-a882-ee5d29c64fe0</imagelabel>
<   </seclabel>
<   <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
<     <label>+64055:+117</label>
<     <imagelabel>+64055:+117</imagelabel>
---
>     <label>libvirt-358596e4-135d-461d-a514-84116440014c</label>
>     <imagelabel>libvirt-358596e4-135d-461d-a514-84116440014c</imagelabel>
sfeole@BSG-75:~$ =



** Attachment added: "xmlnotes.txt"
   https://bugs.launchpad.net/libvirt/+bug/1719196/+attachment/4962430/+fil=
es/xmlnotes.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719196

Title:
  [arm64 ocata] newly created instances are unable to raise network
  interfaces

Status in libvirt:
  New
Status in QEMU:
  New

Bug description:
  arm64 Ocata ,

  I'm testing to see I can get Ocata running on arm64 and using the
  openstack-base bundle to deploy it.  I have added the bundle to the
  log file attached to this bug.

  When I create a new instance via nova, the VM comes up and runs,
  however fails to raise its eth0 interface. This occurs on both
  internal and external networks.

  ubuntu@openstackaw:~$ nova list
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  | ID                                   | Name    | Status | Task State | =
Power State | Networks           |
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  | dcaf6d51-f81e-4cbd-ac77-0c5d21bde57c | sfeole1 | ACTIVE | -          | =
Running     | internal=3D10.5.5.3  |
  | aa0b8aee-5650-41f4-8fa0-aeccdc763425 | sfeole2 | ACTIVE | -          | =
Running     | internal=3D10.5.5.13 |
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  ubuntu@openstackaw:~$ nova show aa0b8aee-5650-41f4-8fa0-aeccdc763425
  +--------------------------------------+---------------------------------=
-------------------------+
  | Property                             | Value                           =
                         |
  +--------------------------------------+---------------------------------=
-------------------------+
  | OS-DCF:diskConfig                    | MANUAL                          =
                         |
  | OS-EXT-AZ:availability_zone          | nova                            =
                         |
  | OS-EXT-SRV-ATTR:host                 | awrep3                          =
                         |
  | OS-EXT-SRV-ATTR:hypervisor_hostname  | awrep3.maas                     =
                         |
  | OS-EXT-SRV-ATTR:instance_name        | instance-00000003               =
                         |
  | OS-EXT-STS:power_state               | 1                               =
                         |
  | OS-EXT-STS:task_state                | -                               =
                         |
  | OS-EXT-STS:vm_state                  | active                          =
                         |
  | OS-SRV-USG:launched_at               | 2017-09-24T14:23:08.000000      =
                         |
  | OS-SRV-USG:terminated_at             | -                               =
                         |
  | accessIPv4                           |                                 =
                         |
  | accessIPv6                           |                                 =
                         |
  | config_drive                         |                                 =
                         |
  | created                              | 2017-09-24T14:22:41Z            =
                         |
  | flavor                               | m1.small (717660ae-0440-4b19-a76=
2-ffeb32a0575c)          |
  | hostId                               | 5612a00671c47255d2ebd6737a64ec9b=
d3a5866d1233ecf3e988b025 |
  | id                                   | aa0b8aee-5650-41f4-8fa0-aeccdc76=
3425                     |
  | image                                | zestynosplash (e88fd1bd-f040-44d=
8-9e7c-c462ccf4b945)     |
  | internal network                     | 10.5.5.13                       =
                         |
  | key_name                             | mykey                           =
                         |
  | metadata                             | {}                              =
                         |
  | name                                 | sfeole2                         =
                         |
  | os-extended-volumes:volumes_attached | []                              =
                         |
  | progress                             | 0                               =
                         |
  | security_groups                      | default                         =
                         |
  | status                               | ACTIVE                          =
                         |
  | tenant_id                            | 9f7a21c1ad264fec81abc09f3960ad1d=
                         |
  | updated                              | 2017-09-24T14:23:09Z            =
                         |
  | user_id                              | e6bb6f5178a248c1b5ae66ed388f9040=
                         |
  +--------------------------------------+---------------------------------=
-------------------------+


  As seen above the instances boot an run.  Full Console output is
  attached to this bug.

  =

  [  OK  ] Started Initial cloud-init job (pre-networking).
  [  OK  ] Reached target Network (Pre).
  [  OK  ] Started AppArmor initialization.
           Starting Raise network interfaces...
  [FAILED] Failed to start Raise network interfaces.
  See 'systemctl status networking.service' for details.
           Starting Initial cloud-init job (metadata service crawler)...
  [  OK  ] Reached target Network.
  [  315.051902] cloud-init[881]: Cloud-init v. 0.7.9 running 'init' at Fri=
, 22 Sep 2017 18:29:15 +0000. Up 314.70 seconds.
  [  315.057291] cloud-init[881]: ci-info: +++++++++++++++++++++++++++Net d=
evice info+++++++++++++++++++++++++++
  [  315.060338] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.063308] cloud-init[881]: ci-info: | Device |  Up  |  Address  |   =
 Mask   | Scope |     Hw-Address    |
  [  315.066304] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.069303] cloud-init[881]: ci-info: | eth0:  | True |     .     |   =
  .     |   .   | fa:16:3e:39:4c:48 |
  [  315.072308] cloud-init[881]: ci-info: | eth0:  | True |     .     |   =
  .     |   d   | fa:16:3e:39:4c:48 |
  [  315.075260] cloud-init[881]: ci-info: |  lo:   | True | 127.0.0.1 | 25=
5.0.0.0 |   .   |         .         |
  [  315.078258] cloud-init[881]: ci-info: |  lo:   | True |     .     |   =
  .     |   d   |         .         |
  [  315.081249] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.084240] cloud-init[881]: 2017-09-22 18:29:15,393 - url_helper.py[W=
ARNING]: Calling 'http://169.254.169.254/2009-04-04/meta-data/instance-id' =
failed [0/120s]: request error [HTTPConnectionPool(host=3D'169.254.169.254'=
, port=3D80): Max retries exceeded with url: /2009-04-04/meta-data/instance=
-id (Caused by NewConnectionError('<requests.packages.urllib3.connection.HT=
TPConnection object at 0xffffb10794e0>: Failed to establish a new connectio=
n: [Errno 101] Network is unreachable',))]


  =

  ----------------


  I have checked all services in neutron and made sure that they are
  running and restarted in neutron-gateway

  =

   [ + ]  neutron-dhcp-agent
   [ + ]  neutron-l3-agent
   [ + ]  neutron-lbaasv2-agent
   [ + ]  neutron-metadata-agent
   [ + ]  neutron-metering-agent
   [ + ]  neutron-openvswitch-agent
   [ + ]  neutron-ovs-cleanup

  and have also restarted and checked the nova-compute logs for their
  neutron counterparts.

  =

   [ + ]  neutron-openvswitch-agent
   [ + ]  neutron-ovs-cleanup


   There are some warnings/errors in the neutron-gateway logs which I
  have attached the full tarball in a separate attachment to this bug:

  2017-09-24 14:39:33.152 10322 INFO ryu.base.app_manager [-] instantiating=
 app ryu.controller.ofp_handler of OFPHandler
  2017-09-24 14:39:33.153 10322 INFO ryu.base.app_manager [-] instantiating=
 app ryu.app.ofctl.service of OfctlService
  2017-09-24 14:39:39.577 10322 ERROR neutron.agent.ovsdb.impl_vsctl [req-2=
f084ae8-13dc-47dc-b351-24c8f3c57067 - - - - -] Unable to execute ['ovs-vsct=
l', '--timeout=3D10', '--oneline', '--format=3Djson', '--', '--id=3D@manage=
r', 'create', 'Manager', 'target=3D"ptcp:6640:127.0.0.1"', '--', 'add', 'Op=
en_vSwitch', '.', 'manager_options', '@manager']. Exception: Exit code: 1; =
Stdin: ; Stdout: ; Stderr: ovs-vsctl: transaction error: {"details":"Transa=
ction causes multiple rows in \"Manager\" table to have identical values (\=
"ptcp:6640:127.0.0.1\") for index on column \"target\".  First row, with UU=
ID e02a5f7f-bfd2-4a1d-ae3c-0321db4bd3fb, existed in the database before thi=
s transaction and was not modified by the transaction.  Second row, with UU=
ID 6e9aba3a-471a-4976-bffd-b7131bbe5377, was inserted by this transaction."=
,"error":"constraint violation"}


  These warnings/errors also occur on the nova-compute hosts in
  /var/log/neutron/


  =

  2017-09-22 18:54:52.130 387556 INFO ryu.base.app_manager [-] instantiatin=
g app ryu.app.ofctl.service of OfctlService
  2017-09-22 18:54:56.124 387556 ERROR neutron.agent.ovsdb.impl_vsctl [req-=
e291c2f9-a123-422c-be7c-fadaeb5decfa - - - - -] Unable to execute ['ovs-vsc=
tl', '--timeout=3D10', '--oneline', '--format=3Djson', '--', '--id=3D@manag=
er', 'create', 'Manager', 'target=3D"ptcp:6640:127.0.0.1"', '--', 'add', 'O=
pen_vSwitch', '.', 'manager_options', '@manager']. Exception: Exit code: 1;=
 Stdin: ; Stdout: ; Stderr: ovs-vsctl: transaction error: {"details":"Trans=
action causes multiple rows in \"Manager\" table to have identical values (=
\"ptcp:6640:127.0.0.1\") for index on column \"target\".  First row, with U=
UID 9f27ddee-9881-4cbc-9777-2f42fee735e9, was inserted by this transaction.=
  Second row, with UUID ccf0e097-09d5-449c-b353-6b69781dc3f7, existed in th=
e database before this transaction and was not modified by the transaction.=
","error":"constraint violation"}


  I'm not sure if the above error could be pertaining to the failure, I
  have also attached those logs to this bug as well...

  =

  .
  (neutron) agent-list
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+
  | id                                   | agent_type           | host   | =
availability_zone | alive | admin_state_up | binary                    |
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+
  | 0cca03fb-abb2-4704-8b0b-e7d3e117d882 | DHCP agent           | awrep1 | =
nova              | :-)   | True           | neutron-dhcp-agent        |
  | 14a5fd52-fbc3-450c-96d5-4e9a65776dad | L3 agent             | awrep1 | =
nova              | :-)   | True           | neutron-l3-agent          |
  | 2ebc7238-5e61-41f8-bc60-df14ec6b226b | Loadbalancerv2 agent | awrep1 | =
                  | :-)   | True           | neutron-lbaasv2-agent     |
  | 4f6275be-fc8b-4994-bdac-13a4b76f6a83 | Metering agent       | awrep1 | =
                  | :-)   | True           | neutron-metering-agent    |
  | 86ecc6b0-c100-4298-b861-40c17516cc08 | Open vSwitch agent   | awrep1 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | 947ad3ab-650b-4b96-a520-00441ecb33e7 | Open vSwitch agent   | awrep4 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | 996b0692-7d19-4641-bec3-e057f4a856f6 | Open vSwitch agent   | awrep3 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | ab6b1065-0b98-4cf3-9f46-6bddba0c5e75 | Metadata agent       | awrep1 | =
                  | :-)   | True           | neutron-metadata-agent    |
  | fe24f622-b77c-4eed-ae22-18e4195cf763 | Open vSwitch agent   | awrep2 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+

  =

  Should neutron-openvswitch be assigned to the 'nova' availability zone? =


  I have also attached the ovs-vsctl show from a nova-compute host and
  the neutron-gateway host to ensure that the open v switch routes are
  correct.

  =

  I can supply more logs if required.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1719196/+subscriptions
