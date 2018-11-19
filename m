Received: from eggs.gnu.org ([2001:4830:134:3::10]:56866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsTT-0006pw-72
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsTQ-0007mV-2W
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:56:59 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:56586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOsTP-0007mG-T7
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:56:56 -0500
Date: Mon, 19 Nov 2018 23:56:53 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181119225653.6gpycs3ygj6nh7mf@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 03/41] slirp: simplify fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Marc-Andr=C3=A9 Lureau, le mer. 14 nov. 2018 16:36:05 +0400, a ecrit:
> Use g_spawn_async_with_fds() to setup the child.
>=20
> GSpawn handles reaping the child, and closing parent file descriptors.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my slirp-2 tree, thanks!

Samuel
