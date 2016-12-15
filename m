Received: from eggs.gnu.org ([2001:4830:134:3::10]:57098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaan-0007HR-SR
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaam-0008Pf-Ip
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHaam-0008P3-D0
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:17:20 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHaak-0002GG-Nk
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:17:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 416B92E81EF
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:17:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 18:02:12 -0000
From: Thomas Huth <938945@bugs.launchpad.net>
Reply-To: Bug 938945 <938945@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120222195009.30707.32438.malonedeb@chaenomeles.canonical.com>
Message-Id: <20161215180212.20030.20974.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 938945] Re: Slirp cannot be forward and makes
 segmentation faults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU did you use? Can you still reproduce this issue
with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/938945

Title:
  Slirp cannot be forward and makes segmentation faults

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  Let's consider the following lines:

  $ qemu -enable-kvm -name opeth -hda debian1.img -k fr -localtime -m
  512 -net user,vlan=3D0 -net
  nic,vlan=3D0,model=3D$model,macaddr=3Da2:00:00:00:00:10 -net
  socket,vlan=3D1,listen=3D127.0.0.1:5900 -net
  nic,vlan=3D1,model=3D$model,macaddr=3Da2:00:00:00:00:04

  $qemu -enable-kvm -name nightwish -hda debian2.img -k fr -localtime -m
  512 -net socket,vlan=3D0,connect=3D127.0.0.1:5900 -net
  nic,vlan=3D0,model=3D$model,macaddr=3Da2:00:00:00:00:02

  =

  My configuration is clear and allows to transmit packets between the Slir=
p and the guest nightwish.
  But when I try to do on nightwish :

  $ wget www.qemu.org

  The opeth QEMU makes a segfault :    "11586 Segmentation Fault"

  This phenomenon is not always present... If the Segfault does not
  appear, nightwish cannot enable a connection with internet :(

  =

  Thanks
  Vince

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/938945/+subscriptions
