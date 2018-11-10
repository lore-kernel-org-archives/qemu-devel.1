Received: from eggs.gnu.org ([2001:4830:134:3::10]:38443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTiX-0005jy-N2
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTiN-0004bX-Q9
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:54:24 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLTiK-0004V5-0z
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:54:17 -0500
Date: Sat, 10 Nov 2018 14:54:13 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181110135413.3rriapffjvroafqh@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181110134548.14741-14-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 13/13] slirp: simplify fork_exec()
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

Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:48 +0400, a ecrit:
> Use g_spawn_async_with_fds() to setup the child.
>=20
> GSpawn handles reaping the child, and closing parent file descriptors.

Similarly :)

Samuel
