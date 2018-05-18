Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJbLA-0001ax-R6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJbL8-00051u-N0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:06:20 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::1]:23003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chzigotzky@xenosoft.de>)
	id 1fJbL8-00050U-3b
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:06:18 -0400
Mime-Version: 1.0 (1.0)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
Date: Fri, 18 May 2018 11:06:09 +0200
Message-Id: <5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PPC64] P5020DS: Booting from img possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

It works on my AmigaOne X5000 (P5020 board with 2x e5500 cores).

Screenshots: https://plus.google.com/115515624056477014971

=E2=80=94 Christian

Sent from my iPhone

> On 18. May 2018, at 10:54, Thomas Huth <huth@tuxfamily.org> wrote:
>=20
>> On 18.05.2018 08:01, Christian Zigotzky wrote:
>> Hello,
>>=20
>> I was able to boot a Linux kernel (uImage) with an initrd in a virtual
>> P5020DS PPC64 machine with an e5500 core (QEMU 2.12.0) with the
>> following command.
>>=20
>> qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -initrd
>> /home/christian/Downloads/slitaz25.gz -nographic -kernel
>> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uIm=
age-4.17
>> -net nic,vlan=3D0,model=3De1000 -net user,vlan=3D0 -machine
>> dt_compatible=3Dfsl,,P5020DS -append "root=3D/dev/ramdisk"
>>=20
>> It also works with the machine 'MPC8544DS':
>>=20
>> qemu-system-ppc64 -M mpc8544ds -cpu e5500 -m 2048 -initrd
>> /home/christian/Downloads/slitaz25.gz -nographic -kernel
>> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uIm=
age-4.17
>> -net nic,vlan=3D0,model=3De1000 -net user,vlan=3D0 -machine
>> dt_compatible=3Dfsl,,P5020DS -append "root=3D/dev/ramdisk"
>=20
> These two machines ppce500 and mpc8544ds are "embedded" PowerPC machines..=
.
>=20
>> I tried to boot ubuntu MATE 16.04 LTS PowerPC from an img with the
>> option '-drive' but without any success. Is it possible to boot from a
>> hard disk img with a virtual P5020DS PPC64 machine? Can I use a virtual
>> graphics card with this machine?
>=20
> ... but according to http://cdimage.ubuntu.com/releases/16.04/release/
> Ubuntu 16.04 is for Apple and IBM machines only, so I don't think that
> you'll be able to run this on an embedded PPC machine?
>=20
> Thomas
