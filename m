Received: from eggs.gnu.org ([209.51.188.92]:35324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grkbn-0002X6-Hf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grkbm-0001zV-Kw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:24:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grkbm-0001qW-E7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:24:54 -0500
Date: Thu, 7 Feb 2019 14:24:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207142426.GK19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1549545591.git.berto@igalia.com>
	<2c1d9d03c5b3ee26b116db3438caa3df73dffa46.1549545591.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c1d9d03c5b3ee26b116db3438caa3df73dffa46.1549545591.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] main-loop: Add qemu_idle_add()
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

On Thu, Feb 07, 2019 at 03:23:22PM +0200, Alberto Garcia wrote:
> This works like g_idle_add() but allows specifying a different
> GMainContext. It also returns the GSource directly instead of its ID
> number for convenience.
>=20
> pty_chr_state() and qio_task_thread_worker() are modified to make use
> of this new function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  chardev/char-pty.c       | 8 ++------
>  include/qemu/main-loop.h | 8 ++++++++
>  io/task.c                | 7 ++-----
>  util/main-loop.c         | 9 +++++++++
>  4 files changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
