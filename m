Received: from eggs.gnu.org ([209.51.188.92]:34175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grkYJ-0007uW-GJ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grkYI-0000Hx-Je
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:21:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grkYI-0000Cj-D4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:21:18 -0500
Date: Thu, 7 Feb 2019 14:21:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207142106.GJ19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
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

On Thu, Feb 07, 2019 at 03:23:21PM +0200, Alberto Garcia wrote:
> After g_source_attach() the GMainContext holds a reference to the
> GSource, so the caller does not need to keep it.
>=20
> pty_chr_state() and qio_task_thread_worker() are not doing this, so
> the GSource is being leaked in both cases (pty_chr_open_src_cancel()
> is the exception here because it does remove the extra reference
> correctly).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  chardev/char-pty.c | 2 +-
>  io/task.c          | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

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
