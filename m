Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Qdw-0006nG-J2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Qdt-0000WI-GN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:39:40 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f9Qdt-0000U3-9T
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:39:37 -0400
Received: by mail-pl0-x22f.google.com with SMTP id z12-v6so4797835plo.1
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 00:39:37 -0700 (PDT)
Date: Fri, 20 Apr 2018 15:39:32 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420073932.GI15181@stefanha-x1.localdomain>
References: <CAG0V3WRdK+p-qo9NmnKkKT6kMNBJBxj9vNuYBSzX7zrZU8FGiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline
In-Reply-To: <CAG0V3WRdK+p-qo9NmnKkKT6kMNBJBxj9vNuYBSzX7zrZU8FGiA@mail.gmail.com>
Subject: Re: [Qemu-devel] Let event loop use non-default GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eva Chen <debby83729@gmail.com>
Cc: qemu-devel@nongnu.org


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 04:52:34PM +0800, Eva Chen wrote:
> The reason for replacing default GMainContext is that I simultaneously run
> two qemu, called A and B, in threads. However, these two QEMU using the
> same default GMainContext causes A QEMU to handle the event from B QEMU,
> and run B's handler instead of A's handler.

I think you will hit many other issues if you try to run two instances
of QEMU within a single process.  There have been several efforts to
simulate heterogenous systems (e.g. different CPUs as part of one
computer).  Some of them run multiple QEMU instances and communicate
between the processes.

Before going further, have you looked into existing work on emulating
heterogenous systems under QEMU?

Stefan

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2Zk0AAoJEJykq7OBq3PIxpkH/1q3xHxi9BR0kDmQ4Y2lyFd9
2sZnhHxkbGGDzvSQL+n2EgBGTiWmunpV6MzRiY5aKjVoEuYdD9/Vlku+G74jTI6l
R8IeT4/8TVlYOzZBLPr1RKck3XSGviV+yeCkuVSKzUI1yJUiQwgmLT518eBdZTGV
X3tv+kZ9MljVJHdg2AzdkKqlGjRxpOLnKYftFc4zK3P9OkH6A+9thBJniey023pX
4zffC/0MkPPlamu0131ynS/HjjUjBy6rL8IOfW4YlfSYH98YVgI+29lLykzKi5XE
r38y1FfNV7IzPGYlQW8fch8BY8me+0whfJ+3TncNMq8jOV3LHDO6EJ+Vo+iTutg=
=Ev2D
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--
