Received: from eggs.gnu.org ([2001:4830:134:3::10]:48863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLUHk-0000of-1b
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLUHW-0000Zh-NX
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:30:46 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLUHQ-0000Jx-7Z
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:30:36 -0500
Date: Sat, 10 Nov 2018 15:30:29 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181110143029.y3jfmwkoepjfoayo@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181110134548.14741-6-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 05/13] slirp: remove unused EMU_RSH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:40 +0400, a ecrit:
> EMU_RSH handling was dropped in commit
> 0d62c4cfe21752df4c1d6e2c2398f15d5eaa794a.
>=20
> The assignment, and subsequent free() of ex_ptr->ex_exec to so->extra
> looks unsafe (double free is likely to occur).

Applied to my tree, thanks!

Samuel
