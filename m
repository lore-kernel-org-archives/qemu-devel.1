Received: from eggs.gnu.org ([2001:4830:134:3::10]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWQZ5-0002Cu-GD
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWQZ2-0005RW-CK
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:09:11 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:49220)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWQZ2-0005PT-5H
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:09:08 -0400
Date: Sat, 15 Jul 2017 19:09:04 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170715170904.2ryezcjjieudzca7@var.youpi.perso.aquilenet.fr>
References: <20170715164350.5681-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170715164350.5681-1-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: fill error when failing to
 initialize user network
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

HEllo,

Herv=C3=A9 Poussineau, on sam. 15 juil. 2017 18:43:50 +0200, wrote:
> With "-netdev user,id=3Dnet0,dns=3D1.2.3.4"
> error was:
> qemu-system-i386: -netdev user,id=3Dnet0,dns=3D1.2.3.4: Device 'user' c=
ould not be initialized
>=20
> Error is now:
> qemu-system-i386: -netdev user,id=3Dnet0,dns=3D1.2.3.4: DNS doesn't bel=
ong to network
>=20
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Applied to my tree, thanks!

Samuel
