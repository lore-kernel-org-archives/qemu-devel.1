Received: from eggs.gnu.org ([2001:4830:134:3::10]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deicN-00034S-Ks
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deicI-00044s-S1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:02:51 -0400
Date: Mon, 7 Aug 2017 16:02:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807140227.GG6578@localhost.localdomain>
References: <20170804144354.21985-1-kwolf@redhat.com>
	<5af7c79e-130c-1010-e164-3989fd1c27fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <5af7c79e-130c-1010-e164-3989fd1c27fb@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/null: Remove 'filename'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.08.2017 um 16:56 hat Eric Blake geschrieben:
> On 08/04/2017 09:43 AM, Kevin Wolf wrote:
> > This option was only added to allow 'null-co://' and 'null-aio://' as
> > filenames, its value never served any actual purpose and was ignored.
> > Nevertheless it was accepted as '-drive driver=3Dnull,filename=3Dfoo'.
> >=20
> > The correct way to enable the protocol prefixes (and that without adding
> > a useless -drive option) is implementing .bdrv_parse_filename. This is
> > what this patch does.
> >=20
> > Technically, this is an incompatible change, but the null block driver
> > is only used for benchmarking, testing and debugging, and an option
> > without effect isn't likely to be used by anyone anyway, so no bad
> > effects are to be expected.
>=20
> Agreed with the analysis. Still, better to get it into 2.10 rather than
> going yet another release with the option available.

Makes sense. Applied to the block branch.

Kevin

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZiHLzAAoJEH8JsnLIjy/WYLAQAMnYl2E8e2769IyHwMDbtjwc
s6jOGxxka9E06v9u4N4aJqXirXnIf5CjdVeePkI5jyYQpQm5CDfhjS16qgWm6ksG
8S3XLrT7/1HT6MyW1xPrJtEaeIf6+h5+GBDT4SJAzQQWHkUEHXhvo8HgDjxQxT25
ERx2LJzunCrFz3hvhZyJtPebDyjl0sFsitqWOjPw+Ycplp5FmZMRhzntIWYJuGPY
b8OXxpNowYABFJDoxhnHiZ43Qrdk9utCwrTvajqxts43tm+nbw/pFz7JKjaPEow2
OYsUYoiNbDzpB7SmND35Lsbx5W4EuIMpGOIHibtX4DXIAAISFbjvWx0/TeHt7Tnc
g1HWpB8StDly0zbSxWpHlpVS10vJ9C8cufSHh6thVC9dLrLgMHwz0nwdYf93SwtL
uOcJB9D8wLsymEzFBzM+Kp7S9/MMZmNiHuH2NFHeOqQLb4TFq4PtNRYbcAJXH4l/
wyupWzgGUI24dSd5iJ0b1Dl/CBqkerCtsva6amASkONEmfx+6fIRQhxugtbnK+vt
sMT0vZ5rSdnzW4pJ/xBnas/zVDNP7g7Rye5ki/CMcni4WMwclgdjAuvGEVlAP0/a
Q6ZRGHM4BkhRJgSDJH81UOYHV7EcsiaoSuEh1G/yrv3M3Uxgu6UvS5z7oJbL33Co
+I7PIQ/vBs3UOdvldOvU
=/iKN
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
