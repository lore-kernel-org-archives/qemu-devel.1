Received: from eggs.gnu.org ([2001:4830:134:3::10]:40815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dx3vJ-0005CV-Dj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dx3vG-0004uq-9K
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:26:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dx3vG-0004u8-38
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:26:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dx3vC-0006yJ-Dw
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 04:26:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E5C02E8520
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 04:26:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 04:17:36 -0000
From: Launchpad Bug Tracker <1706866@bugs.launchpad.net>
Reply-To: Bug 1706866 <1706866@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150113818340.31767.9409806903366726521.malonedeb@gac.canonical.com>
Message-Id: <150648585618.20621.6766970903072980557.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1706866] Re: migrate:  add tls option in virsh,
 migrate failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1706866

Title:
  migrate:  add tls option in virsh, migrate failed

Status in QEMU:
  Expired

Bug description:
  version:
      libvirt-3.4.0 + qemu-2.9.90(latest)

  domain:
      any

  step:
      1. generate tls certificate in /etc/pki/libvirt-migrate
      2. start vm
      3. migrate vm, cmdline:
         virsh migrate rh7.1-3 --live --undefinesource --persistent --verbo=
se --tls qemu+ssh://IP/system
      4. then migrate failed and reported:
   Migration: [ 64 %]error: internal error: qemu unexpectedly closed the mo=
nitor: Domain pid=3D5288, libvirtd pid=3D49634
   kvm: warning: CPU(s) not present in any NUMA nodes: 2 3 4 5 6 7 8 9 10 1=
1 12 13 14 15 16 17 18 19 20 21 22 23
   kvm: warning: All CPU(s) up to maxcpus should be described in NUMA config
   kvm: error while loading state section id 2(ram)
   kvm: load of migration failed: Input/output error

  other:
      Analysis qemu code and debug:
  #0  ram_save_page (f=3D0x55ca8be370e0, pss=3D0x7fefdfc7b9a0, last_stage=
=3Dfalse, bytes_transferred=3D0x55ca885ec1d8) =

  #1  0x000055ca87b00b21 in ram_save_target_page (ms=3D0x55ca885b8d80, f=3D=
0x55ca8be370e0, pss=3D0x7fefdfc7b9a0, last_stage=3Dfalse, bytes_transferred=
=3D0x55ca885ec1d8, dirty_ram_abs=3D0)
  #2  0x000055ca87b00bda in ram_save_host_page (ms=3D0x55ca885b8d80, f=3D0x=
55ca8be370e0, pss=3D0x7fefdfc7b9a0, last_stage=3Dfalse, bytes_transferred=
=3D0x55ca885ec1d8, dirty_ram_abs=3D0)
  #3  0x000055ca87b00d39 in ram_find_and_save_block (f=3D0x55ca8be370e0, la=
st_stage=3Dfalse, bytes_transferred=3D0x55ca885ec1d8)
  #4  0x000055ca87b020b8 in ram_save_iterate (f=3D0x55ca8be370e0, opaque=3D=
0x0)
  #5  0x000055ca87b07a9a in qemu_savevm_state_iterate (f=3D0x55ca8be370e0, =
postcopy=3Dfalse) =

  #6  0x000055ca87e404e5 in migration_thread (opaque=3D0x55ca885b8d80)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1706866/+subscriptions
