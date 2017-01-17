Received: from eggs.gnu.org ([2001:4830:134:3::10]:35984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cTOHh-0006L2-EZ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cTOHd-00087v-FC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:34:25 -0500
Date: Tue, 17 Jan 2017 08:33:46 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <5878AF90.8020709@kamp.de>
References: <5878AF90.8020709@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Hi,

proxmox users have reported recently corruption with qemu 2.7 and scsi-bloc=
k (with passing physical /dev/sdX to virtio-scsi).

working fine with qemu 2.6.

qemu 2.7 + scsi-hd works fine

https://forum.proxmox.com/threads/proxmox-4-4-virtio_scsi-regression.31471/=
page-2



----- Mail original -----
De: "Peter Lieven" <pl@kamp.de>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Cc: "qemu-stable" <qemu-stable@nongnu.org>
Envoy=C3=A9: Vendredi 13 Janvier 2017 11:44:32
Objet: [Qemu-devel] Data corruption in Qemu 2.7.1

Hi,=20

i currently facing a problem in our testing environment where I see file sy=
stem corruption with 2.7.1 on iSCSI and Local Storage (LVM).=20
Trying to bisect, but has anyone observed this before?=20

Thanks,=20
Peter=20
