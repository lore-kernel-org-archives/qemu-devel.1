Received: from eggs.gnu.org ([208.118.235.92]:35804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Wi-0007Np-QE
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Wi-0001G5-5b
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:23:36 -0500
References: <20190102100113.24621-1-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa8862b8-0352-0422-2f33-7166d0c13a73@redhat.com>
Date: Thu, 3 Jan 2019 14:23:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190102100113.24621-1-mahaocong_work@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kfpuJAOXI14QKt1fkGrs2y3Q13sgaLKT0"
Subject: Re: [Qemu-devel] [PATCH v1] add new function to copy dirty-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kfpuJAOXI14QKt1fkGrs2y3Q13sgaLKT0
From: Eric Blake <eblake@redhat.com>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mahaocong <mahaocong@didichuxing.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com
Message-ID: <aa8862b8-0352-0422-2f33-7166d0c13a73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] add new function to copy dirty-bitmap
References: <20190102100113.24621-1-mahaocong_work@163.com>
In-Reply-To: <20190102100113.24621-1-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/2/19 4:01 AM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
>=20
> This patch adds new function to copy the hbitmap from an exist dirty-bi=
tmap to
> another. The destination bitmap should have the same size and granulari=
ty with
> the source bitmap, or the copy will fail.

Is there a client in mind for this new code?  And how does it differ to
what you can already achieve by the combination of
bdrv_clear_dirty_bitmap/bdrv_merge_dirty_bitmap?

>=20
> Signed-off-by: mahaocong <mahaocong@didichuxing.com>

Typical S-o-b and git authorship uses a preferred legal name rather than
a single-word username (there have been exceptions made in the past, but
we try not to introduce more without good reason).  You can also teach
git to spell your name in both native UTF-8 characters and a Latinized
form, if you prefer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kfpuJAOXI14QKt1fkGrs2y3Q13sgaLKT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwubzwACgkQ3g5py3or
ov1VZAgAlRm9TISJ4vZkjRHxwaUqF4thql77oBM+/o5zp6Tj5A7uVGd8Se8CHpg7
cgdhRJNAjplIuncOiEWAhzPpjkGlIN0a5/wLTuVIUXeLsWtAwrCwhel42gIZ0RsX
DqLh09b2G1f9VQ5Z43Olkkjnn/RRiQcDRarxfFjBHWYQCxXBH9G4W7yg7GRZe+Gr
9GicNXW/CkNjsY0mDD2cmINyudd71UbUqd3+7YVDNGpqRw8sQThrvn45k092jIkl
J1AF2jOL8VMXnKwlWFbiQBGqPQpZKvgzrV0wcMnmCYYGfvS0vt7hliBNr3bMm2cW
t+sLBxmWq7rKhXt+eywWuSNaqbkFyw==
=fd+s
-----END PGP SIGNATURE-----

--kfpuJAOXI14QKt1fkGrs2y3Q13sgaLKT0--
