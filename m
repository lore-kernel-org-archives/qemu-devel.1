Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgxg-0003t8-3Z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgxf-0006CB-9k
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:39:24 -0500
Date: Mon, 19 Nov 2018 10:39:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119103914.GI19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sat, Nov 17, 2018 at 02:49:22PM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add tests that validate it is possible to connect to an NBD server
> > running TLS mode. Also test mis-matched TLS vs non-TLS connections
> > correctly fail.
> > ---
>=20
> Missing your Signed-off-by. Can you please supply that, so I can includ=
e
> this in my pull request?

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> Also, I'm getting failures when trying to test it:
>=20
> @@ -17,9 +17,9 @@
>=20
>  =3D=3D check plain client to TLS server fails =3D=3D
>  option negotiation failed: read failed: Unexpected end-of-file before =
all
> bytes were read
> +write failed (error message): Unable to write to socket: Broken pipe
>  qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation requ=
ired
> before option 8 (structured reply)
>  server reported: Option 0x8 not permitted before TLS
> -write failed (error message): Unable to write to socket: Broken pipe
>=20
>=20
> which looks like an output race. :(

Guess that shows the message is in fact coming from the server rather
than the client then.

We could just silence the qemu-nbd process to null, since we're primarily
interested in what the client displays in this test

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
