Received: from eggs.gnu.org ([2001:4830:134:3::10]:57470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsWK-0008Kr-6W
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsWH-0001oT-2P
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:59:56 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:56660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOsWG-0001oG-Sm
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:59:53 -0500
Date: Mon, 19 Nov 2018 23:59:50 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181119225950.43sytfmqg2ak2lho@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-4-marcandre.lureau@redhat.com>
	<20181114142234.GJ19298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114142234.GJ19298@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Hello,

Daniel P. Berrang=C3=A9, le mer. 14 nov. 2018 14:22:34 +0000, a ecrit:
> On Wed, Nov 14, 2018 at 04:36:05PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Use g_spawn_async_with_fds() to setup the child.
> >=20
> > GSpawn handles reaping the child, and closing parent file descriptors=
.
>=20
> The g_spawn* family of APIs is portable to Win32, which the current
> fork/exec code in slirp is not.
>=20
> So I'm curious if this conversion is sufficient to make this part
> of slirp work on Win32, or if further portability problems remain.
> If it does work on Win32, then you can also delete the stub
> fork_exec() impl the code currently has.

Mmm, I don't think any portability issue remains. SO_OOBINLINE is used
in other places, the rest is portable. There is the setsid() call which
may just not make sense on Windows, but we could just disable it there.

I have pushed to=20

https://people.debian.org/~sthibault/qemu.git slirp-2-win

what it could look like. I don't have a windows box off hand, could
somebody try it to confirm that it builds?

Samuel
