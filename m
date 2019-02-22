Received: from eggs.gnu.org ([209.51.188.92]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9fY-0001sX-SG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9fX-0004G1-MD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:11:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gx9fX-0003gy-Ah
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:11:07 -0500
Date: Fri, 22 Feb 2019 12:10:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222121038.GO25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550836631.git.berto@igalia.com>
	<c86d09ddfada3d17bbdf9719fb0ac7df62964b51.1550836631.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c86d09ddfada3d17bbdf9719fb0ac7df62964b51.1550836631.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] main-loop: Add qemu_idle_add()
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

On Fri, Feb 22, 2019 at 01:59:11PM +0200, Alberto Garcia wrote:
> This works like g_idle_add() but allows specifying a different
> GMainContext. It also returns the GSource directly instead of its ID
> number for convenience.
>=20
> qio_task_thread_worker() is modified to make use of this new function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/qemu/main-loop.h | 12 ++++++++++++
>  io/task.c                | 10 +++-------
>  util/main-loop.c         |  9 +++++++++
>  3 files changed, 24 insertions(+), 7 deletions(-)

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
