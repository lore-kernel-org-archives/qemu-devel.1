Received: from eggs.gnu.org ([2001:4830:134:3::10]:40340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWpT-0003Nr-Pl
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWpS-0004L4-MR
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:24:07 -0500
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
Date: Tue, 30 Jan 2018 08:23:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180130063433.11605-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WUNwFtCXauQTSBBJGMDpgqY9TBWaJzhmV"
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUNwFtCXauQTSBBJGMDpgqY9TBWaJzhmV
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
Subject: Re: [PATCH v6 2/2] qemu-img: Document --force-share / -U
References: <20180130063433.11605-1-famz@redhat.com>
 <20180130063433.11605-3-famz@redhat.com>
In-Reply-To: <20180130063433.11605-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 12:34 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.texi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 60a0e080c6..ec7e2f5d1e 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is curren=
tly required to also use
>  the @var{-n} parameter to skip image creation. This restriction may be=
 relaxed
>  in a future release.
> =20
> +@item --force-share (-U)
> +If specified, @code{qemu-img} will open the image in shared mode, allo=
wing
> +concurrent writers. For example, this can be used to get the image inf=
ormation

Actually, we only permit one writer at a time.  Would it be better to
say "allowing a concurrent writer"?

> +(with 'info' subcommand) when the image is used by a running guest.  N=
ote that
> +this could produce inconsistent results because of concurrent metadata=
 changes,
> +etc. This option is only allowed when opening images in read-only mode=
=2E

After all, we are stating that this process (which must be read-only,
because we can't have two writers at once) is permitting some other
process to be the concurrent writer (but not multiple processes to be
concurrent writers)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WUNwFtCXauQTSBBJGMDpgqY9TBWaJzhmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwf/YACgkQp6FrSiUn
Q2oxnAf/ZCvE5GvLfGRSmubHEYbBG7QjAnZR5YaUcvO3m2Wl8wj9nUL4ziWc64UA
HMdLOgJPxIgcg/GCpA+S/h1u1+wPq5rPGlWjvPdWhbCNFrip22lUbGLpyraXK+uw
QGD5clqelReyL1g4qSBWnHKRCO1BMY9OcMAQ/ocFv5raOPPEu0inZyrZmTRwi/Sq
RB6ShKfk9HlENeWe9KFcXzAgueB+BUT2VvNJNQzH4bdPWJcHyeYooAIc/HWG7vQp
Cn5Zy2fV5Yv+mneoYalNq06dD18OyrTQM43cz0+yH6j6xPyOfx4e6P+rQapDlnOS
/E1gnz43a6ibaDAC/ouZL8fSC40brg==
=gik3
-----END PGP SIGNATURE-----

--WUNwFtCXauQTSBBJGMDpgqY9TBWaJzhmV--
