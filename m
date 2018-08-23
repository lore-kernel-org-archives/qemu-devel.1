Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1fsgL6-00050p-2i
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 23:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1fsgL2-0002d6-Oz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 23:31:15 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:58706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1fsgL2-0002aA-IZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 23:31:12 -0400
Date: Thu, 23 Aug 2018 05:31:03 +0200 (CEST)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <443376549.3925188.1534995063956.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <153310582650.16549.13438398684929101168.malone@wampee.canonical.com>
References: <152840439622.3676.18260529468873821664.malonedeb@chaenomeles.canonical.com>
	<153310582650.16549.13438398684929101168.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1775702] Re: High host CPU load and slower
 guest after upgrade guest OS Windows 10 to ver 1803
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1775702 <1775702@bugs.launchpad.net>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi,
proxmox users have reported this bug
https://forum.proxmox.com/threads/high-cpu-load-for-windows-10-guests-when-=
idle.44531/#post-213876

hv_synic && hv_stimer  hyperv enlightments fix it


(seem to be related to some hpet change in windows)



----- Mail original -----
De: "Lemos Lemosov" <1775702@bugs.launchpad.net>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 1 Ao=C3=BBt 2018 08:43:46
Objet: [Qemu-devel] [Bug 1775702] Re: High host CPU load and slower guest a=
fter upgrade guest OS Windows 10 to ver 1803

This bug affect me=20

--=20
You received this bug notification because you are a member of qemu-=20
devel-ml, which is subscribed to QEMU.=20
https://bugs.launchpad.net/bugs/1775702=20

Title:=20
High host CPU load and slower guest after upgrade guest OS Windows 10=20
to ver 1803=20

Status in QEMU:=20
New=20

Bug description:=20
After upgrading Windows 10 guest to version 1803, guests VM runs=20
slower and there is high host CPU load even when guest is almost idle.=20
Did not happened with windows 10 up to version 1709.=20

See my 1st report here:=20
https://askubuntu.com/questions/1033985/kvm-high-host-cpu-load-after-upgrad=
ing-vm-to-windows-10-1803=20

Another user report is here:=20
https://lime-technology.com/forums/topic/71479-windows-10-vm-cpu-usage/=20

Tested on: Ubuntu 16.04 with qemu 2.5.0 and i3-3217U, Arch with qemu=20
2.12 i5-7200U, Ubuntu 18.04 qemu 2.11.1 AMD FX-4300. All three=20
platform showing the same slowdown and higher host cpu load with=20
windows 10 1803 VM compared to windows 10 1709 VM.=20

To manage notifications about this bug go to:=20
https://bugs.launchpad.net/qemu/+bug/1775702/+subscriptions=20
