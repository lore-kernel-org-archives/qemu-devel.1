Received: from eggs.gnu.org ([2001:4830:134:3::10]:41786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwY7-0006A7-DK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwY6-0007Fx-M8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:13:39 -0400
References: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f84e28fe-3169-8ab8-83e4-d94f1ec47838@redhat.com>
Date: Tue, 11 Apr 2017 16:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2OmrxuPCV1VmFkqrvtucd5vR3xfal2TEj"
Subject: Re: [Qemu-devel] [PATCH for-2.9] sheepdog: Fix crash in
 co_read_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, kchamart@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2OmrxuPCV1VmFkqrvtucd5vR3xfal2TEj
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, kchamart@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f84e28fe-3169-8ab8-83e4-d94f1ec47838@redhat.com>
Subject: Re: [PATCH for-2.9] sheepdog: Fix crash in co_read_response()
References: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 16:08, Kevin Wolf wrote:
> This fixes a regression introduced in commit 9d456654.
>=20
> aio_co_wake() can only be used to reenter a coroutine that was already
> previously entered, otherwise co->ctx is uninitialised and we access
> garbage. Using it immediately after qemu_coroutine_create() like in
> co_read_response() is wrong and causes segfaults.
>=20
> Replace the call with aio_co_enter(), which gets an explicit AioContext=

> parameter and works even for new coroutines.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2OmrxuPCV1VmFkqrvtucd5vR3xfal2TEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs5IkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXYsH/RBeWbVeeE2hL9dp6mfxPMi/2fFJb6Z3
EZZ+kOXsDU/WS6LPohuKc1qYB8NGVzmwjHaWy93WlaWD7uH0SHeEaaOPfM0G/zqJ
ccS7mZPXOT5cLZsFfZK85p3y+bKQmiy292xkGGT2gXhkEguosXVcgQey/t3sGHJC
9y/V4N2Oc7g5Pf6qJMN8IQa9gdbXEgPbuvch1MPagOts6q5YWmyKzgbIf9NWHeqr
Zk8gSQ7lchmuToKjY0Zhpt6E0RyktlACvEjLmqoZbJErf6MiGlHLPJh29ZZ2+6dj
/ePkUYM0YxHqbmMEvzVMrWllqBoRIyPmX8AIR4Wm97v3JLks4Vz24hA=
=b1VL
-----END PGP SIGNATURE-----

--2OmrxuPCV1VmFkqrvtucd5vR3xfal2TEj--
