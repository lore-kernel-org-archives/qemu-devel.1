Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etYDa-00010X-8A
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etYDX-0000wg-3w
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:30:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etYDW-0000wX-VK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:30:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78CD740252F0
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:30:46 +0000 (UTC)
Date: Wed, 7 Mar 2018 12:30:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307123037.GZ20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306053320.15401-6-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] chardev: introduce chr_machine_done
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Mar 06, 2018 at 01:33:16PM +0800, Peter Xu wrote:
> Introduce ChardevClass.chr_machine_done() hook so that chardevs can run
> customized procedures after machine init.
>=20
> There was an existing mux user already that did similar thing but used =
a
> raw machine done notifier.  Generalize it into a framework, and let the
> mux chardevs provide such a class-specific hook to achieve the same
> thing.  Then we can move the mux related code to the char-mux.c file.
>=20
> Since at it, replace the mux_realized variable with the global
> machine_init_done varible.
>=20
> This notifier framework will be further leverged by other type of
> chardevs soon.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-mux.c         | 33 +++++++++++++++++++++++++++++----
>  chardev/char.c             | 43 +++++++++++++++++---------------------=
-----
>  include/chardev/char-mux.h |  2 --
>  include/chardev/char.h     |  2 ++
>  tests/test-char.c          |  1 -
>  5 files changed, 48 insertions(+), 33 deletions(-)

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
