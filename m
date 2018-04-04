Received: from eggs.gnu.org ([2001:4830:134:3::10]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3mdg-0004h9-9Z
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3mdb-0001lH-Du
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:56:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:60370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3mdb-0001l7-7j
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:55:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3mdX-0005Xo-Kg
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 17:55:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ADFAD2E818C
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 17:55:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 17:41:20 -0000
From: Thomas Huth <1441443@bugs.launchpad.net>
Reply-To: Bug 1441443 <1441443@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150408062216.7311.52657.malonedeb@chaenomeles.canonical.com>
Message-Id: <152286368013.8590.7601486193968184353.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1441443] Re: Is there a way to create a 10G
 network interface for VMs in KVM2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets ... have you already tried to use vhost-
net? That should be one of the fastest ways of networking with QEMU as
far as I know...

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1441443

Title:
  Is there a way to create a 10G network interface for VMs in KVM2.0?

Status in QEMU:
  Incomplete

Bug description:

  We have installed & configured the KVM 2.0 (qemu-kvm 2.0.0+dfsg-
  2ubuntu1.10) on Ubuntu 14.04. The physical server is connected to 10G
  network, KVM is configured in Bridged mode But the issue is, when we
  create Network interface on VMs, we have only 1G device as an options
  for vmhosts. Is this the limit of the KVM or is there a way to create
  a 10G network interface for VMs? Available device models

  E1000
  Ne2k_pci
  Pcnet
  Rtl8139
  virtio

  Please find the network configuration details

  Source device : Host device vnet1 (Bridge =E2=80=98br0=E2=80=99)
  Device model : virtio =


  Network configuration in the host /etc/network/interfaces

  auto br0
  iface br0 inet static
          address 10.221.x.10
          netmask 255.255.255.0
          network 10.221.x.0
          broadcast 10.221.x.255
          gateway 10.221.x.1
          # dns-* options are implemented by the resolvconf package, if ins=
talled
          dns-nameservers X.X.X.X
          dns-search XXX.NET
          bridge_ports em1
          bridge_fd 0
          bridge_stp off
          bridge_maxwait 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1441443/+subscriptions
