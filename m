Received: from eggs.gnu.org ([2001:4830:134:3::10]:58454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <M.Raps@centron.de>) id 1cjV3T-000769-MU
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <M.Raps@centron.de>) id 1cjV3P-0000Ex-F8
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:02:19 -0500
Received: from centron-mail.internet1.de ([158.181.50.198]:62964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <M.Raps@centron.de>) id 1cjV3P-0000Dr-2F
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:02:15 -0500
From: "Raps, Markus (centron GmbH)" <M.Raps@centron.de>
Date: Thu, 2 Mar 2017 17:31:12 +0000
Message-ID: <fac16f434b4a45af8d217f865e292d89@centron.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] IPv6 gets removed on bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

Hi,

i have a short question iam using proxmox and my ipv6 settings gets removed=
 every time  a vm is added to the bridge.

So can you confirm this function/bug/behavior?

Before VM starts
~# sysctl -qa 2>/dev/null  | grep 'disable_ipv6'
net.ipv6.conf.all.disable_ipv6 =3D 0
net.ipv6.conf.bond0.disable_ipv6 =3D 1
net.ipv6.conf.bond0/102.disable_ipv6 =3D 1
net.ipv6.conf.bond0/605.disable_ipv6 =3D 1
net.ipv6.conf.default.disable_ipv6 =3D 0
net.ipv6.conf.eth0.disable_ipv6 =3D 0
net.ipv6.conf.eth1.disable_ipv6 =3D 0
net.ipv6.conf.eth2.disable_ipv6 =3D 0
net.ipv6.conf.eth3.disable_ipv6 =3D 0
net.ipv6.conf.lo.disable_ipv6 =3D 0
net.ipv6.conf.tun0.disable_ipv6 =3D 0
net.ipv6.conf.vmbr0.disable_ipv6 =3D 0
net.ipv6.conf.vmbr0v102.disable_ipv6 =3D 0
net.ipv6.conf.vmbr0v605.disable_ipv6 =3D 0

VM is started and hostconfig on vlan 102 and 605 is gone

~# sysctl -qa 2>/dev/null  | grep 'disable_ipv6'
net.ipv6.conf.all.disable_ipv6 =3D 0
net.ipv6.conf.bond0.disable_ipv6 =3D 1
net.ipv6.conf.bond0/102.disable_ipv6 =3D 1
net.ipv6.conf.bond0/605.disable_ipv6 =3D 1
net.ipv6.conf.default.disable_ipv6 =3D 0
net.ipv6.conf.eth0.disable_ipv6 =3D 0
net.ipv6.conf.eth1.disable_ipv6 =3D 0
net.ipv6.conf.eth2.disable_ipv6 =3D 0
net.ipv6.conf.eth3.disable_ipv6 =3D 0
net.ipv6.conf.lo.disable_ipv6 =3D 0
net.ipv6.conf.tun0.disable_ipv6 =3D 0
net.ipv6.conf.vmbr0.disable_ipv6 =3D 0
net.ipv6.conf.vmbr0v102.disable_ipv6 =3D 1
net.ipv6.conf.vmbr0v605.disable_ipv6 =3D 1
