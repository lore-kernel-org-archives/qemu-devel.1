Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1lU8-0002iZ-LX
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1lU5-0008Os-Gk
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1lU5-0008GO-7D
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:13:17 -0400
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-6-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4d67c71-ee5b-a698-69e8-c2ed5bb56e3c@redhat.com>
Date: Fri, 21 Apr 2017 10:37:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170421035606.448-6-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bDJSk2Mj1g8JIuaQHR1XdStTQB2pjKEd4"
Subject: Re: [Qemu-devel] [PATCH v14 05/20] qemu-img: Update documentation
 for --share-rw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bDJSk2Mj1g8JIuaQHR1XdStTQB2pjKEd4
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <b4d67c71-ee5b-a698-69e8-c2ed5bb56e3c@redhat.com>
Subject: Re: [PATCH v14 05/20] qemu-img: Update documentation for --share-rw
References: <20170421035606.448-1-famz@redhat.com>
 <20170421035606.448-6-famz@redhat.com>
In-Reply-To: <20170421035606.448-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 10:55 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img-cmds.hx | 48 ++++++++++++++++++++++++------------------------=

>  1 file changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 8ac7822..1b00bb8 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -10,15 +10,15 @@ STEXI
>  ETEXI
> =20
>  DEF("bench", img_bench,
> -    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_in=
terval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buff=
er_size] [-S step_size] [-t cache] [-w] filename")
> +    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_in=
terval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buff=
er_size] [-S step_size] [-t cache] [-w] [--share-rw] filename")

General comment - it seems that we favor the short-option spelling where
one exists; should all of these updates mention -U instead of --share-rw?=


Also, why did you rename it from --unsafe-reads in an earlier revision?
After all, if I'm understanding this flag correctly, what you are asking
for is the ability to read the image in spite of other simultaneous
writers that may make your reads inconsistent.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bDJSk2Mj1g8JIuaQHR1XdStTQB2pjKEd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+idSAAoJEKeha0olJ0NqYEkH/3j8/qu5iDAF7TP3JT8xwm3t
l4xjYZimRsRl83i3JltgzQjBwQKeh5ibxMRcMapW4jfnYPsneBp/1YeKz3zyIdkE
7Ta8zfELIPoF1FxZMWyF1OJ84p+BMDgM5ynKTjS1FMz5jVFqPokOa3zhQBpafiqT
7RW2IPW2qMH7GCxygAl1W8uf5Th1lEUPWViZhC8eMSJ/Mm4zD2OqrTfpolAP1BKO
woHRY7EDxMUDGEJHi/uo1IODCfpvsfM3rIPTx7pg0olARNf/mZ65tpN4xEn/puWD
+OHi0i/272lRzjOB34KJrv4lMqR8ZuxMpLjhrEgn5yzefsU9QBdq+/imKiF7aQc=
=I7VD
-----END PGP SIGNATURE-----

--bDJSk2Mj1g8JIuaQHR1XdStTQB2pjKEd4--
