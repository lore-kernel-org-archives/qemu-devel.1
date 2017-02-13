Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGtC-0005Ds-31
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGt7-00014H-4A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:41:58 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdGt6-00014A-TI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:41:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so19587032wmi.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 05:41:52 -0800 (PST)
Date: Mon, 13 Feb 2017 13:41:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213134149.GB10361@stefanha-x1.localdomain>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<20170203173607-mutt-send-email-mst@kernel.org>
	<1fdc2663-2090-9e19-5ea9-1f5b8eef4eb1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <1fdc2663-2090-9e19-5ea9-1f5b8eef4eb1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, weidong.huang@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de, Gonglei <arei.gonglei@huawei.com>, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 07:07:02PM +0100, Halil Pasic wrote:
>=20
>=20
> On 02/03/2017 04:37 PM, Michael S. Tsirkin wrote:
> > On Fri, Feb 03, 2017 at 10:33:16AM +0000, Stefan Hajnoczi wrote:
> >>> +\begin{description}
> >>> +\item[0] dataq1
> >>> +\item[\ldots]
> >>> +\item[N-1] dataqN
> >>> +\item[N] controlq
> >>> +\end{description}
> >>> +
> >>> +N is set by \field{max_dataqueues}.
> >>> +
> >>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / F=
eature bits}
> >>> +
> >>> +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
> >>> +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is avai=
lable for CIPHER service.
> >>> +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is availa=
ble for HASH service.
> >>> +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is availab=
le for MAC service.
> >>> +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is availa=
ble for AEAD service.
> >>
> >> Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4 c=
an
> >> be eliminated in favor of just bit 0.
> >=20
> > Too late to change it as QEMU released a device with that feature.
> >=20
>=20
> When was this introduced to QEMU? Can't find it in current master
> and I do not remember seeing the patches.

s/QEMU/Linux/

It's in drivers/crypto/virtio/.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobedAAoJEJykq7OBq3PIVskIAMOIO715x0zHrA+C/3yXFau1
+17EoRp9TYya0HJq076zOESa7/7+85kVlRTQRmJPAwfgRdulorirA6aVmUVApTQ3
5onV+235wdnd67ztFJrTTEDgjXHzM1CRXh1Hi+B84fj4kTH89cOFa4i5niBLFXSm
ArYqWJWnFxBuGLF4wp3u0eXk/Dvo+gmfoSuBGbw7PJznEpDmOV9VkSIjne38rrV4
FLKH7/7CDqRzo5AoKNGEJwqNH73AF6mXAnjzKLmQZINmo/IxbDJY04XEtsk0aOS7
/ZU2GtA91ncD2h8IFY+S4iSB05DupgWY5TuuMAHg6gGxG7wXMoD4EY6/mtCjaWU=
=b+Im
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
