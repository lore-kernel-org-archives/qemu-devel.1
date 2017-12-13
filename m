Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4Dg-0007sc-Mg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4Db-00033t-NB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:24:56 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP4Db-00033Z-Fq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:24:51 -0500
Received: by mail-wr0-x230.google.com with SMTP id g53so1630879wra.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:24:51 -0800 (PST)
Date: Wed, 13 Dec 2017 10:24:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213102448.GE16782@stefanha-x1.localdomain>
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Introduce a new vhost-user-blk host
 device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:28:59AM +0800, Changpeng Liu wrote:
> Although virtio scsi specification was designed as a replacement for virt=
io_blk,
> there are still many users using virtio_blk. QEMU 2.9 introduced a new de=
vice
> vhost user scsi which can process I/O in user space for virtio_scsi, this=
 commit
> introduces a new vhost user block host device, which can support virtio_b=
lk in
> Guest OS, and I/O processing in another I/O target.
>=20
> Due to the limitation for virtio_blk specification, virtio_blk device can=
not get
> block information such as capacity, block size etc via the specification,=
 several
> new vhost user messages were added to deliver virtio config space
> information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER=
_SET_CONFIG
> messages used for get/set config space from/to I/O target, VHOST_USER_SET=
_CONFIG_FD
> was added for event notifier in case the change of virtio config space. A=
lso, those
> messages can be used for vhost device live migration as well.

Michael or Marc-Andr=E9, please take this through your tree once you've
reviewed it.

Stefan

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMP/wAAoJEJykq7OBq3PISdUIAIRZUkkf/J853RT4MjBU4GPx
QFIh76fUVWTcoGz53OUDHMfven0PkGKAF4IF8cih3sDNYfiSpieUITQTr0FuI3oM
RO/4JkQTNByZCOcDLTz7h3HZxHvtY0GLuPaiTkSHyEfbzjT0xKgVUP/TYOJlw//M
Vs+cEcrvfJ7cNyd6QFllaVkGufmVIZQHvKnfI/SCTB/sn1CeSCeAnapapUmhR3ej
GA96Pav+gHF5LjsQLBHORWk5a9QB73OOp+e07m4YoQOoBjtEuozslrneJS051P2a
pxYXuqyF4NsoHRa6NgFL9rQKD2nidrVORAaRp11he3hbpDY8MCE42aNCxKSp3ME=
=8zcI
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
