Received: from eggs.gnu.org ([209.51.188.92]:54377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIyhR-00061k-AM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIyhQ-0000Bd-5M
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hIyhP-0000AX-Ts
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:55:16 -0400
Date: Tue, 23 Apr 2019 17:55:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190423165501.GA27867@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550842915.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1550842915.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

ping - paolo/marc-andr=C3=A9 - unless I'm missing something, it looks lik=
e
this chardev series slipped through the cracks and missed 4.0

On Fri, Feb 22, 2019 at 03:46:23PM +0200, Alberto Garcia wrote:
> This fixes a race condition in which the tcp_chr_read() ioc handler
> can close a connection that is being written to from another thread.
>=20
> Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.
>=20
> Berto
>=20
> RFC: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01510.htm=
l
>=20
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01834.html
> - Fixes memory leaks and adds a qemu_idle_add() function
>=20
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06137.html
> - Rebased on top of the current master (fc3dbb90f2eb069801bfb4cfe9cbc)
> - Patches 1 and 2: Remove the changes in char-pty.c, they're not
>                    needed after the rebase.
> - Patch 3: Fix conflicts after the rebase.
>=20
> v3:
> - Patch 3: Add tcp_chr_disconnect_locked() [Daniel]
>=20
> Alberto Garcia (3):
>   main-loop: Fix GSource leak in qio_task_thread_worker()
>   main-loop: Add qemu_idle_add()
>   char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout()
>=20
>  chardev/char-socket.c    | 25 +++++++++++++++++++++----
>  include/qemu/main-loop.h | 12 ++++++++++++
>  io/task.c                |  9 +++------
>  util/main-loop.c         |  9 +++++++++
>  4 files changed, 45 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.11.0
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
