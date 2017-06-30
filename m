Received: from eggs.gnu.org ([2001:4830:134:3::10]:34895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQx4V-0001EW-1H
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQx4U-0000He-2t
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:38:59 -0400
References: <20170628142137.7440-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
Date: Fri, 30 Jun 2017 16:38:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170628142137.7440-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OCJRkETdqxA0m7msUFl7s5OjO6mfJR59D"
Subject: Re: [Qemu-devel] [PATCH] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OCJRkETdqxA0m7msUFl7s5OjO6mfJR59D
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Jiri Pirko <jiri@resnulli.us>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
Subject: Re: [PATCH] tests: Avoid non-portable 'echo -ARG'
References: <20170628142137.7440-1-eblake@redhat.com>
In-Reply-To: <20170628142137.7440-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-28 16:21, Eric Blake wrote:
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
> Replace 'echo -n "..."' with 'printf "..."', and 'echo -e "..."'
> with 'printf "...\n"'.
>=20
> In the qemu-iotests check script, also fix unusual shell quoting
> that would result in word-splitting if 'date' outputs a space.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Of course, Stefan's pending patch:
> [PATCH 3/5] qemu-iotests: 068: extract _qemu() function
> also touches 068, so there may be some (obvious) merge conflicts
> to resolve there depending on what goes in first.
>=20
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

Question 1: Who's going to take this? :-)

Question 2: This breaks 171 if TEST_DIR contains a % (e.g.
"TEST_DIR=3D/tmp/foo%% ./check -raw 171"). Is that OK?

Max


--OCJRkETdqxA0m7msUFl7s5OjO6mfJR59D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVmJ2EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQI0M
B/490C9crNK4TdUu03pQr1iIdbANWFfqfHnw90s844E6YwGIH4OW8ka6LuNlL5Gp
hp+AzK6RSlHuzJtkLibvn860UIDc+uCA2X8Ch74IJF/KXbL+2Da86nXTh9wpJIiD
MYr0M8IRuhC68oHWCC4pM06WS/K7c4pbKwUDVU8QXFXBz210xEmlkxve6rHldAt7
2uuh3T/p1S5WktIR5sG+Xb5XXHk5KZigaViDz1lD++swXVtVpue1TiEeZTQpqZhu
YFv+jC1g5mM93ctDr1Z7ReKc/D92x57zkQnwYU5eYFA0z5VMC8ubN4PZN/J8rDfP
ZZ5Y/wOc4wtx3Qi4Y0ADjLwe
=G6vv
-----END PGP SIGNATURE-----

--OCJRkETdqxA0m7msUFl7s5OjO6mfJR59D--
