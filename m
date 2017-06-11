Received: from eggs.gnu.org ([2001:4830:134:3::10]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrq0-0007H5-4F
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrpz-0000Ff-AJ
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:38:44 -0400
Date: Sun, 11 Jun 2017 04:37:59 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170611013759.xaqkr5avny6b5jf6@postretch>
References: <20170611011427.6713-1-el13635@mail.ntua.gr>
	<149714452188.6210.6227845436168589119@84b42461e25a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ipqo5mnvzfzzuriq"
Content-Disposition: inline
In-Reply-To: <149714452188.6210.6227845436168589119@84b42461e25a>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/2] IO throttling block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, stefanha@redhat.com


--ipqo5mnvzfzzuriq
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2017 at 06:28:42PM -0700, no-reply@patchew.org wrote:
>Hi,

>/tmp/qemu-test/src/tests/test-throttle.c:144: error: static declaration of=
 =E2=80=98read_timer_cb=E2=80=99 follows non-static declaration
>/tmp/qemu-test/src/include/block/throttle-groups.h:50: note: previous decl=
aration of =E2=80=98read_timer_cb=E2=80=99 was here
>/tmp/qemu-test/src/tests/test-throttle.c:148: error: static declaration of=
 =E2=80=98write_timer_cb=E2=80=99 follows non-static declaration
>/tmp/qemu-test/src/include/block/throttle-groups.h:51: note: previous decl=
aration of =E2=80=98write_timer_cb=E2=80=99 was here
>make: *** [tests/test-throttle.o] Error 1
>make: *** Waiting for unfinished jobs....

Looks like I forgot to port a last minute change to test-throttle.c,=20
will clean it up.

--ipqo5mnvzfzzuriq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk8nvcACgkQc2J8L2kN
9xDJcg/+P3eOVbyiMETjmW+c9Ege6yRDzL7LynLKaPZtIaGS+DP1kI3PA08ZGmEi
N+bwoVPGaAKULUTdJShpxATN5OXDzD38Fnd19VE0MclyVPFX/BxEpSsIj4TLZmds
AkmHrtESgy4KWTWSF6wL3ZeUpvOK+/GfW86FGUGbBImmeiXJFQOPOa6H3QcDtNwk
N3ixA22++9wqYhhJqziABGR1R0wR+GMXmxgGhdSsFQ8TyspImyOsjObdqCtkvv1G
Zme+c56UyahbumU/WFIFz0NH5ngKUKJqvfMUG9oTkffYCeMImjxcfppVhjC9S7rz
SQlUf+VxBsLzhQogMAdDLUsnHZ1hsEDBMUmZm+qwmTY1mkbkFfWD0czAYkP5kyIQ
sLPh/gIMUbmR4xsBifJlfpnQG5ANzHAaFuyxFEz8CTUEmIk/K/xvElE1rLWyKbDV
N/PhFkWSVacLQfo/eQwOk5Fek8ndvXR0WCvECf5EKcZloXpptlQXworWv+hHBdE0
3+mTPMTCcJ8ZgnG+NEGL2JJm2yw8o+bW58clWrCa/mmaf7YWsFYNneNVjZLP8/Kp
/xfG8389dRB1wAgT4ZG3NK3WTmizgZcf5juZyBNMIMxasJuWbU0UPWQAHbFUqilz
mEdmSaTQPSCB+Poxq7jcLk35NrKwYv8jcQ1xSzq6ZLKiOxcDbIg=
=Bb97
-----END PGP SIGNATURE-----

--ipqo5mnvzfzzuriq--
