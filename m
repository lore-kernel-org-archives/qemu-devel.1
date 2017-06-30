Received: from eggs.gnu.org ([2001:4830:134:3::10]:51974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQsks-000772-7Z
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQskn-0000kS-1a
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:02:21 -0400
Date: Fri, 30 Jun 2017 11:02:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170630100211.GA24009@stefanha-x1.localdomain>
References: <20170628142137.7440-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20170628142137.7440-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:Block layer core" <qemu-block@nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 09:21:37AM -0500, Eric Blake wrote:
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
>  tests/qemu-iotests/142      | 48 ++++++++++++++++++++++-----------------=
------
>  tests/qemu-iotests/171      | 14 ++++++-------
>  tests/qemu-iotests/check    | 18 ++++++++---------
>  tests/rocker/all            | 10 +++++-----
>  tests/tcg/cris/Makefile     |  8 ++++----
>  9 files changed, 61 insertions(+), 60 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZViGjAAoJEJykq7OBq3PICdwH/2fjqpwIRdljidm6KmNBIaT+
y/7Yv4U1uWsRvb/I74XcMM6rn4+dgfuL105uiuZV+P4/cuuC87nKm5q4mdUIR825
1ofM78ipmGT4XFH1UvthwezerX9NB4augTg0XuLfqAZUZiRRS+8v/pXf/z+c1/hz
SfiNUizKZiQy23L70D/LT4+E28trhTKZkfvQtccUxSx/H1HO92PoWtUWXAqmGyAv
NKShs1L+zfQxuqlXrSpLdHs7fvMbYNTD5bHhBlAI0ccNnk6yzWaf86Bf+vGEI38X
neE5B6Uz03biFCGxm1RskFLgveC/ERUDT0XgnfrxPMshDzioxybo0z/UaBl3Coc=
=otZn
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
