Received: from eggs.gnu.org ([2001:4830:134:3::10]:46183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAZzQ-0003Ky-2B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAZzM-0000Ml-Qr
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dAZzM-0000LH-8c
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:46:00 -0400
Date: Tue, 16 May 2017 11:45:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516104556.GD27093@stefanha-x1.localdomain>
References: <20170515134753.28412-1-stefanha@redhat.com>
	<87a86erypz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <87a86erypz.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] .gdbinit: load QEMU sub-commands when gdb
 starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 03:17:28PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
> > file so GDB either loads qemu-gdb.py automatically or prints a message
> > informing the user how to enable them (some systems disable ./.gdbinit
> > loading for security reasons).
> >
> > Suggested-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  .gdbinit | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 .gdbinit
> >
> > diff --git a/.gdbinit b/.gdbinit
> > new file mode 100644
> > index 0000000..9d322fc
> > --- /dev/null
> > +++ b/.gdbinit
> > @@ -0,0 +1,8 @@
> > +# GDB may have ./.gdbinit loading disabled by default.  In that case y=
ou can
> > +# follow the instructions it prints.  They boil down to adding the fol=
lowing to
> > +# your home directory's ~/.gdbinit file:
> > +#
> > +#   add-auto-load-safe-path /path/to/qemu/.gdbinit
> > +
> > +# Load QEMU-specific sub-commands and settings
> > +source scripts/qemu-gdb.py
>=20
> While this works well enough you might as well just comment the helper
> script itself.

People don't know scripts/qemu-gdb.py exists so adding a comment there
doesn't help.

> Would this script take precedence over a users ~/.gdbinit?

All gdbinit files are loaded.  The order in which they are loaded is:

1. System-wide
2. Home directory
3. Current directory

https://sourceware.org/gdb/onlinedocs/gdb/Startup.html#Startup

> How would it work for out-of-tree builds?

=2E/.gdbinit assumes your current working directory is the root of the
QEMU source tree.  If gdb is launched outside this directory then
nothing will happen (e.g. from arm-softmmu/ or from an out-of-tree
build).

I'm not sure if there is a simple way of making ./.gdbinit work from
out-of-tree build directories.

> GDB does have a mechanism for autoloading extensions by way of adding
> ELF sections:
>=20
>   https://sourceware.org/gdb/current/onlinedocs/gdb/dotdebug_005fgdb_005f=
scripts-section.html#dotdebug_005fgdb_005fscripts-section

Hmm...this still requires the user to configure auto-load safe paths and
it hardcodes a path into the QEMU binary (execute in-place vs make
install generally wouldn't work with the same binary).

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGthkAAoJEJykq7OBq3PIFGgH/37FH90sCUZQJ3CKZ1eXabk3
4lgX7yEpB6WKNT+E901/r73TC/h/8lXy1/8azTxck5Ar2W6+GMa8JbmtTD4Om2UY
DjhHt3GqvW0pWrcngdl++Rq3vjBJ5JE3sPMcnfTzI6K02qCf7V9xgj0amQPFuMqB
hc2mlr17kGabea39DGetbqH8W+o/iuiSBkazUEsbWTtl2m5My0F1UH4rsapSSQVc
PpXkw3OyYCz2c7dKrtgl2+u12pBXrFWHOaeTesERPXTUSN9FAP/17jCbu5lGsMT0
xHIWo7/SY6pPpmxCdq8u8UZOeBTuahZal+63yJvTg4SQBoQP/ttQXpd8bCtV0ZU=
=UlcU
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
