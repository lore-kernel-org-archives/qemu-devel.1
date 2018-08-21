Received: from eggs.gnu.org ([2001:4830:134:3::10]:55710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJa-0002CF-K7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJZ-0006cf-Fz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:35914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fryJZ-0006cQ-9q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fryJY-0003BS-Gw
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7F2352E8041
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 04:17:29 -0000
From: Launchpad Bug Tracker <1470720@bugs.launchpad.net>
Reply-To: Bug 1470720 <1470720@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150702054858.28284.89593.malonedeb@gac.canonical.com>
Message-Id: <153482504941.29888.8642582752355421963.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1470720] Re: high IRQ-TLB generates network
 interruptions
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
https://bugs.launchpad.net/bugs/1470720

Title:
  high IRQ-TLB generates network interruptions

Status in QEMU:
  Expired

Bug description:
   we are having a problem in our hosts, all the vm running on them
  suddenly, and for some seconds, lost network connectivity.

  the root cause appears to be the increase of irb-tlb from low values
  (less than 20) to more than >100k, that spike only last for some
  seconds then everything goes back to normal

  i've upload an screenshot of collectd for one hypervisor here
  http://zumbi.com.ar/tmp/irq-tlb.png

  =

  we have hosts running precise (qemu 1.5, ovs 2.0.2, libvirt 1.2.2 and ker=
nel 3.13) where the issue is frequent. also we have an small % of our fleet=
 running trusty (qemu 2.0.0 ovs 2.0.2 libvirt 1.2.2 and kernel 3.16) where =
the problem seemed to be nonexistent until today

  issue seems to be isolated to < 10% of our hypervisors, some hypervisors =
had this problem every few days, others only once or twice. our vm are a bl=
ack box to us we don't know what users run on them, but mostly cpu and netw=
ork bound workload.
  most of our guests run centos 6.5 (kernel 2.6.32)

  vm are bridged to a linuxbridge then veth wired to an ovs switch
  (neutron openvswitch agent setup)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1470720/+subscriptions
