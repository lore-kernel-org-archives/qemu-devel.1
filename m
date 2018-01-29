Received: from eggs.gnu.org ([2001:4830:134:3::10]:55794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egB5S-0006Mi-Sn
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egB5J-0006zy-5r
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:11:10 -0500
References: <20171219163713.31383-1-f4bug@amsat.org>
	<20171219163713.31383-3-f4bug@amsat.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <baeb922f-0a07-e5e6-54df-d124183ec991@redhat.com>
Date: Mon, 29 Jan 2018 16:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171219163713.31383-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IWOZWFaOGTBxqJu6HYmGrhA7qmVgNZR9o"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-iotests: check socket_scm_helper
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IWOZWFaOGTBxqJu6HYmGrhA7qmVgNZR9o
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wenchao Xia <xiawenc@linux.vnet.ibm.com>,
 Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>
Message-ID: <baeb922f-0a07-e5e6-54df-d124183ec991@redhat.com>
Subject: Re: [PATCH 2/2] qemu-iotests: check socket_scm_helper is available
References: <20171219163713.31383-1-f4bug@amsat.org>
 <20171219163713.31383-3-f4bug@amsat.org>
In-Reply-To: <20171219163713.31383-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-19 17:37, Philippe Mathieu-Daud=C3=A9 wrote:
> This now throws a more helpful error message when not found:
>=20
>   tests/qemu-iotests$ ./check 045
>   QEMU          -- "/qemu/build/x86_64-softmmu/qemu-system-x86_64" -nod=
efaults -machine accel=3Dqtest
>   QEMU_IMG      -- "/qemu/build/qemu-img"
>   QEMU_IO       -- "/qemu/build/qemu-io"  --cache writeback -f raw
>   QEMU_NBD      -- "/qemu/build/qemu-nbd"
>   TEST_DIR      -- /qemu/build/tests/qemu-iotests/scratch
>   SOCKET_SCM_HELPER --
>=20
>   045 1s ... [failed, exit status 1] - output mismatch (see 045.out.bad=
)
>   -...........
>   +......EE.EE
>   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   +ERROR: test_add_fd (__main__.TestSCMFd)
>   +--------------------------------------------------------------------=
--
>   +Traceback (most recent call last):
>   +  File "045", line 147, in test_add_fd
>   +    self._send_fd_by_SCM()
>   +  File "045", line 143, in _send_fd_by_SCM
>   +    ret =3D self.vm.send_fd_scm(image0)
>   +  File "/source/qemu/tests/qemu-iotests/../../scripts/qemu.py", line=
 125, in send_fd_scm
>   +    self._socket_scm_helper)
>   +QEMUMachineError: socket_scm_helper does not exist
>   +
>    --------------------------------------------------------------------=
--
>   Failures: 045
>   Failed 1 of 1 tests
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/check | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e6b6ff7a04..a2c0bab1cc 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -597,6 +597,8 @@ fi
>  if [ -x "$build_iotests/socket_scm_helper" ]
>  then
>      export SOCKET_SCM_HELPER=3D"$build_iotests/socket_scm_helper"
> +else
> +    _init_error "socket_scm_helper not found"
>  fi

Hmm... I'm not so sure about this.  Now if you don't have
socket_scm_helper for some reason and you want to run a test that does
not need it, you cannot do that anymore (but currently you can).

OTOH, I'm not sure how important that use case is.  Usually, you can run
the iotests only if you can build the socket_scm_helper, too.

Also, the error message you mention in the commit message is exactly
what I get without this patch.  Your patch just changes it to
=E2=80=9Csocket_scm_helper not found=E2=80=9D.  So even if nobody really =
would care
about the =E2=80=9Cregression=E2=80=9D, I don't quite see the point of th=
is change...

Max


--IWOZWFaOGTBxqJu6HYmGrhA7qmVgNZR9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvOW0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFSIH/RNjTu5yMmepn35IQHlbPMmjhAc3Aevv
r6JJBBRTPjfC0l+ddQBaxfvgDuNUnP4TLUMw2oi7KO49JBrmtdVOpBKTZFLOem3i
P/fAVR49dgKfx5bfaJdgmsNk3pV6ltY+l/6x0q++ZZERXH5tFFOqzAsMRCi5oMHo
RYqdJKbD0bqBxbOQQYpbvVIbRNTFJ+PS6NlRtmqVRq7zQT52QQRDXK73uLIwXr9e
MBdyZPXv48uyDzblzs80RX29hS7qCArkY2zcf+1L/9EvXgBRQ2jn6yWmb4nYvwRp
Lr2tdwJIpeHgB3Xq97YZMwNSjLqF0BaKRJcLd9S4NvHHy44dHkInYT4=
=iWEW
-----END PGP SIGNATURE-----

--IWOZWFaOGTBxqJu6HYmGrhA7qmVgNZR9o--
