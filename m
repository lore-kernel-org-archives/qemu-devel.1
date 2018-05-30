Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO0Bx-0000sd-03
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO0Bw-0006bu-4t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:27:01 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-9-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8ea68c9-81d2-e5ef-1bd3-f04ae0cac2ad@redhat.com>
Date: Wed, 30 May 2018 14:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-9-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8GGy1a5FZdxhiubTjnGClQY0IgKBaqc8z"
Subject: Re: [Qemu-devel] [PATCH 08/17] iotest 056: skip testcases using
 blkdebug if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8GGy1a5FZdxhiubTjnGClQY0IgKBaqc8z
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <c8ea68c9-81d2-e5ef-1bd3-f04ae0cac2ad@redhat.com>
Subject: Re: [PATCH 08/17] iotest 056: skip testcases using blkdebug if
 disabled
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-9-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-9-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/056 | 3 +++
>  1 file changed, 3 insertions(+)

TestBeforeWriteNotifier uses blkdebug (and null-co) in its setUp
function.  Maybe you just want to skip the whole test if blkdebug is
disabled.

Then again, I'd argue there are block drivers without which running the
iotests is a bit pointless.  Why not just require blkdebug, null-co/aio,
raw, and file for all of them?

I think the reason why we added the check for quorum support was because
quorum relies on an external library (for hashing), so it isn't trivial
to enable.  But you can always easily whitelist those drivers above if
you want to do testing, so I'm not sure whether it's worth checking
their availability in every test that needs them.

Max


--8GGy1a5FZdxhiubTjnGClQY0IgKBaqc8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOmIsACgkQ9AfbAGHV
z0CgDAgAha1ej6cEPYmpU0+XK57PI+XsIizp519o9hjt5f/7SddWhgxx1QdiC6eF
g0DkaC7/rgRUE9rNMpxWlt4/L8KgGiZKVJqKGWDPQYJP3Ja0w0s8ruHVMHTL2qi2
K2TwVGlHBSuFESiOAsGuFqrrJkp7FB4UxJtwLTKfvGORD612mtf24A5TltWol9As
o+b6Uw6zFDXV4JuyieEGEIZ9ylQnhr3cbACfJvcStqMVt6qDPDmtIUqhaFaBRTz9
uFMIACKHPAX9sRRHb7Vi0ezaesU598iD/tr82veh76EAWSej2T3MpIbrrz8IHJ22
VjiEV+Be/J2qCcrYILW2JHbXFmQsrw==
=93sf
-----END PGP SIGNATURE-----

--8GGy1a5FZdxhiubTjnGClQY0IgKBaqc8z--
