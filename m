Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dufE5-0004vc-DU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dufE2-0003L0-69
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:38932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dufE1-0003KA-S4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duehp-0000Qw-3U
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:06:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CCB392E84D8
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:06:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Sep 2017 12:56:18 -0000
From: Sean Dague <sean@dague.net>
Reply-To: Bug 1718295 <1718295@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150585550121.23063.9617827911020778004.malonedeb@wampee.canonical.com>
Message-Id: <150591217970.30835.4275732173905533558.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718295] Re: Unexpected exception in API method:
 MigrationError_Remote: Migration error: Disk info file is invalid: qemu-img
 failed to execute - Failed to get shared "write" lock\nIs another process
 using the image?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This appears like it might be an issue with the ppa in pike

** Also affects: qemu
   Importance: Undecided
       Status: New

** Project changed: qemu =3D> ubuntu

** Package changed: ubuntu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718295

Title:
  Unexpected exception in API method: MigrationError_Remote: Migration
  error: Disk info file is invalid: qemu-img failed to execute - Failed
  to get shared "write" lock\nIs another process using the image?

Status in devstack:
  Fix Released
Status in OpenStack Compute (nova):
  Invalid
Status in qemu package in Ubuntu:
  New

Bug description:
  Looks like this is pretty new:

  http://logs.openstack.org/01/503601/7/check/gate-tempest-dsvm-
  multinode-live-migration-ubuntu-
  xenial/b19b77c/logs/screen-n-api.txt.gz?level=3DTRACE#_Sep_19_17_47_11_50=
8623

  Sep 19 17:47:11.508623 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: ERROR nova.api.openstack.extensions [None req-e31fde7b-3=
17f-4db9-b225-10b6e11b2dff tempest-LiveMigrationTest-1678596498 tempest-Liv=
eMigrationTest-1678596498] Unexpected exception in API method: MigrationErr=
or_Remote: Migration error: Disk info file is invalid: qemu-img failed to e=
xecute on /opt/stack/data/nova/instances/806812af-bf9e-4dc1-8e0c-11603ccd9f=
62/disk : Unexpected error while running command.
  Sep 19 17:47:11.508805 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Command: /usr/bin/python2 -m oslo_concurrency.prlimit --=
as=3D1073741824 --cpu=3D30 -- env LC_ALL=3DC LANG=3DC qemu-img info /opt/st=
ack/data/nova/instances/806812af-bf9e-4dc1-8e0c-11603ccd9f62/disk
  Sep 19 17:47:11.508946 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Exit code: 1
  Sep 19 17:47:11.509079 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Stdout: u''
  Sep 19 17:47:11.509233 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Stderr: u'qemu-img: Could not open \'/opt/stack/data/nov=
a/instances/806812af-bf9e-4dc1-8e0c-11603ccd9f62/disk\': Failed to get shar=
ed "write" lock\nIs another process using the image?\n'
  Sep 19 17:47:11.509487 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Traceback (most recent call last):
  Sep 19 17:47:11.509649 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_mess=
aging/rpc/server.py", line 160, in _process_incoming
  Sep 19 17:47:11.509789 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     res =3D self.dispatcher.dispatch(message)
  Sep 19 17:47:11.510231 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_mess=
aging/rpc/dispatcher.py", line 222, in dispatch
  Sep 19 17:47:11.510418 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     return self._do_dispatch(endpoint, method, ctxt, arg=
s)
  Sep 19 17:47:11.510555 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_mess=
aging/rpc/dispatcher.py", line 192, in _do_dispatch
  Sep 19 17:47:11.510687 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     result =3D func(ctxt, **new_args)
  Sep 19 17:47:11.510829 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/exception_wrapper.py", =
line 76, in wrapped
  Sep 19 17:47:11.510959 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     function_name, call_dict, binary)
  Sep 19 17:47:11.511194 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_util=
s/excutils.py", line 220, in __exit__
  Sep 19 17:47:11.511713 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     self.force_reraise()
  Sep 19 17:47:11.511852 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_util=
s/excutils.py", line 196, in force_reraise
  Sep 19 17:47:11.512037 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     six.reraise(self.type_, self.value, self.tb)
  Sep 19 17:47:11.512687 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/exception_wrapper.py", =
line 67, in wrapped
  Sep 19 17:47:11.516811 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     return f(self, context, *args, **kw)
  Sep 19 17:47:11.516966 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/compute/utils.py", line=
 876, in decorated_function
  Sep 19 17:47:11.517110 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     return function(self, context, *args, **kwargs)
  Sep 19 17:47:11.525392 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/compute/manager.py", li=
ne 217, in decorated_function
  Sep 19 17:47:11.525526 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     kwargs['instance'], e, sys.exc_info())
  Sep 19 17:47:11.525654 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_util=
s/excutils.py", line 220, in __exit__
  Sep 19 17:47:11.525783 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     self.force_reraise()
  Sep 19 17:47:11.525909 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/usr/local/lib/python2.7/dist-packages/oslo_util=
s/excutils.py", line 196, in force_reraise
  Sep 19 17:47:11.526057 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     six.reraise(self.type_, self.value, self.tb)
  Sep 19 17:47:11.526186 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/compute/manager.py", li=
ne 205, in decorated_function
  Sep 19 17:47:11.526314 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     return function(self, context, *args, **kwargs)
  Sep 19 17:47:11.529795 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/compute/manager.py", li=
ne 5378, in check_can_live_migrate_source
  Sep 19 17:47:11.529952 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     block_device_info)
  Sep 19 17:47:11.530083 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/libvirt/driver.py"=
, line 5960, in check_can_live_migrate_source
  Sep 19 17:47:11.530446 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     block_device_info)
  Sep 19 17:47:11.530587 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/libvirt/driver.py"=
, line 6060, in _assert_dest_node_has_enough_disk
  Sep 19 17:47:11.530720 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     disk_infos =3D self._get_instance_disk_info(instance=
, block_device_info)
  Sep 19 17:47:11.531945 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/libvirt/driver.py"=
, line 7254, in _get_instance_disk_info
  Sep 19 17:47:11.532099 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     block_device_info)
  Sep 19 17:47:11.532234 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/libvirt/driver.py"=
, line 7222, in _get_instance_disk_info_from_config
  Sep 19 17:47:11.532366 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     backing_file =3D libvirt_utils.get_disk_backing_file=
(path)
  Sep 19 17:47:11.532496 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/libvirt/utils.py",=
 line 197, in get_disk_backing_file
  Sep 19 17:47:11.532627 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     backing_file =3D images.qemu_img_info(path, format).=
backing_file
  Sep 19 17:47:11.532755 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:   File "/opt/stack/new/nova/nova/virt/images.py", line 7=
2, in qemu_img_info
  Sep 19 17:47:11.532896 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]:     raise exception.InvalidDiskInfo(reason=3Dmsg)
  Sep 19 17:47:11.533373 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: InvalidDiskInfo: Disk info file is invalid: qemu-img fai=
led to execute on /opt/stack/data/nova/instances/806812af-bf9e-4dc1-8e0c-11=
603ccd9f62/disk : Unexpected error while running command.
  Sep 19 17:47:11.534451 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Command: /usr/bin/python2 -m oslo_concurrency.prlimit --=
as=3D1073741824 --cpu=3D30 -- env LC_ALL=3DC LANG=3DC qemu-img info /opt/st=
ack/data/nova/instances/806812af-bf9e-4dc1-8e0c-11603ccd9f62/disk
  Sep 19 17:47:11.534670 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Exit code: 1
  Sep 19 17:47:11.534902 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Stdout: u''
  Sep 19 17:47:11.541303 ubuntu-xenial-2-node-rax-ord-10997038 devstack@n-a=
pi.service[28339]: Stderr: u'qemu-img: Could not open \'/opt/stack/data/nov=
a/instances/806812af-bf9e-4dc1-8e0c-11603ccd9f62/disk\': Failed to get shar=
ed "write" lock\nIs another process using the image?\n'

  http://logstash.openstack.org/#dashboard/file/logstash.json?query=3Dmessa=
ge%3A%5C%22Unexpected%20exception%20in%20API%20method%3A%20MigrationError_R=
emote%3A%20Migration%20error%3A%20Disk%20info%20file%20is%20invalid%3A
  %20qemu-
  img%20failed%20to%20execute%20on%5C%22%20AND%20tags%3A%5C%22screen-n-api.=
txt%5C%22&from=3D7d

  252 hits starting on 9/19, check and gate, all failures.

To manage notifications about this bug go to:
https://bugs.launchpad.net/devstack/+bug/1718295/+subscriptions
