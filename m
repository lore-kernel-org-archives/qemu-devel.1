Received: from eggs.gnu.org ([2001:4830:134:3::10]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSlui-00009j-78
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSluh-0000LG-2w
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:08:24 -0400
References: <20170703180950.9895-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <104e32b9-042b-b4c9-d83e-17a3e248385f@redhat.com>
Date: Wed, 5 Jul 2017 17:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170703180950.9895-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T7S1nGX32kMDU2uSNhCKxpSNXfRGLGURt"
Subject: Re: [Qemu-devel] [PATCH v4] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T7S1nGX32kMDU2uSNhCKxpSNXfRGLGURt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <104e32b9-042b-b4c9-d83e-17a3e248385f@redhat.com>
Subject: Re: [PATCH v4] tests: Avoid non-portable 'echo -ARG'
References: <20170703180950.9895-1-eblake@redhat.com>
In-Reply-To: <20170703180950.9895-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-03 20:09, Eric Blake wrote:
> POSIX says that backslashes in the arguments to 'echo', as well as
> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
> people should favor 'printf' instead.  This is definitely true where
> we do not control which shell is running (such as in makefile snippets
> or in documentation examples).  But even for scripts where we
> require bash (and therefore, where echo does what we want by default),
> it is still possible to use 'shopt -s xpg_echo' to change bash's
> behavior of echo.  And setting a good example never hurts when we are
> not sure if a snippet will be copied from a bash-only script to a
> general shell script (although I don't change the use of non-portable
> \e for ESC when we know the running shell is bash).
>=20
> Replace 'echo -n "..."' with 'printf %s "..."', and 'echo -e "..."'
> with 'printf %b "...\n"', with the optimization that the %s/%b
> argument can be omitted if the string being printed is a strict
> literal with no '%', '$', or '`' (we could technically also make
> this optimization when there are $ or `` substitutions but where
> we can prove their results will not be problematic, but proving
> that such substitutions are safe makes the patch less trivial
> compared to just being consistent).
>=20
> In the qemu-iotests check script, fix unusual shell quoting
> that would result in word-splitting if 'date' outputs a space.
>=20
> In test 051, take an opportunity to shorten the line.
>=20
> In test 068, get rid of a pointless second invocation of bash.
>=20
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: even more use of %b/%s [Max]
> v3: use 'printf %s' in a few more places that substitute [Max]
> v2: be robust to potential % in substitutions
> ---
>  qemu-options.hx             |  4 ++--
>  tests/multiboot/run_test.sh | 10 +++++-----
>  tests/qemu-iotests/051      |  7 ++++---
>  tests/qemu-iotests/068      |  2 +-
>  tests/qemu-iotests/142      | 48 ++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/171      | 14 ++++++-------
>  tests/qemu-iotests/check    | 18 ++++++++---------
>  tests/rocker/all            | 10 +++++-----
>  tests/tcg/cris/Makefile     |  8 ++++----
>  9 files changed, 61 insertions(+), 60 deletions(-)

Thanks a lot (not least for bearing my nagging)! Applied to my block bran=
ch:

https://github.com/XanClic/qemu/commits/block

(I agree it's fit for qemu-trivial now, but, well...)

Max


--T7S1nGX32kMDU2uSNhCKxpSNXfRGLGURt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXQDUEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQIzY
B/45mRD5+MKj6kG6zQZBYtt+js1BTLa0SaGVw9oZmf4Ii/BTvuUh+Mx3sA90SE0r
sCzHLF2qmyHtCT3ITZq9dyVO9Km8jD7Td5Vp5rpiyRxQgOxgq6a4nTdawi/Al9F4
KlvhvUByqJ5cw5O7GJbNciHyjNUyCsTjNmWH2tir++GZ9rmp97WbvTSvMsBTJsui
dqbQgHEBmYZd3gVqYBJWwIUkL2VF+Mf664jK4aZ0H8V94ffWGzh/ICEelHdDKlO7
ISDLT9hmDN3sYo23uMPyF7u2+qd2tHSfrH6MyfCO9+smA7dSWRx2XxPq8AgUSi/i
pwatAtgRbJckWzaohO4kd+zV
=5VjX
-----END PGP SIGNATURE-----

--T7S1nGX32kMDU2uSNhCKxpSNXfRGLGURt--
