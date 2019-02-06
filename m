Received: from eggs.gnu.org ([209.51.188.92]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grN3R-0008Lh-NY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grN1w-0004g4-K6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:14:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grN1w-0004fo-Ej
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:14:20 -0500
Date: Wed, 6 Feb 2019 13:14:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206131410.GK12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190206124345.14942-1-berto@igalia.com>
	<20190206124902.GI12331@redhat.com>
	<a7e15d04-c8d5-4415-fdea-c71015607965@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7e15d04-c8d5-4415-fdea-c71015607965@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] char-socket: hold chr_write_lock
 during tcp_chr_free_connection()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Feb 06, 2019 at 01:52:59PM +0100, Paolo Bonzini wrote:
> On 06/02/19 13:49, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Feb 06, 2019 at 02:43:45PM +0200, Alberto Garcia wrote:
> >> There's a race condition in which the tcp_chr_read() ioc handler can
> >> close a connection that is being written to from another thread.
> > Isn't the chardev only ever supposed to be read/written from a
> > single thread.
> >=20
>=20
> No, writes from multiple threads are allowed; of course they have to
> have proper locking to avoid mixing messages.
>=20
> Reads have to happen from a single thread because they are tied to the
> chr_read handlers.

Ok, then we really ought to have full locking around tcp_chr_disconnect

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
