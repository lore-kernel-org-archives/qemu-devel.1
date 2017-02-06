Received: from eggs.gnu.org ([2001:4830:134:3::10]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1calUw-0001cE-F7
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1calUt-00068g-Bx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1calUt-00068G-37
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:46:31 -0500
Date: Mon, 6 Feb 2017 15:46:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170206154625.GB32590@stefanha-x1.localdomain>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<33183CC9F5247A488A2544077AF19020DA1AED04@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1AED04@DGGEMA505-MBX.china.huawei.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "claudio.fontana@huawei.com" <claudio.fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 01:48:09AM +0000, Gonglei (Arei) wrote:
> > > +\item The device MUST set \field{max_size} to show the maximum size =
of
> > crypto request the device supports.
> >=20
> > In bytes?
> >=20
> > > +\item The device MUST set \field{max_cipher_key_len} to show the
> > maximum length of cipher key if the device supports CIPHER service.
> >=20
> > In bits or bytes?
> >=20
> > > +\item The device MUST set \field{max_auth_key_len} to show the maxim=
um
> > length of authenticated key if the device supports MAC service.
> >=20
> > In bits or bytes?
> >=20
>=20
> All lengths in virtio crypto spec are bytes.

Please move this before the first length field is defined:

  +\begin{note}
  +The basic unit of all data length the byte.
  +\end{note}

It should be at the beginning of the spec.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYmJpRAAoJEJykq7OBq3PIlI8H/2XRskfmvcd+Ml8MbgSfwH/+
kiildggwiRcRxFNhrqqXyjHo7QNEVZ2eeQvmQUKeAvS8x3I2wF3BF9LhERygGVUx
TnNQpCdctQ7r63AysqFRAxI20eJS60fpcIek+ntS5Wfb2Tupyr21VfCXDKboDRmN
Z/MHFmRqNbZrFTHCF8ts6rWlr58HMVpr/YIJxB6xnLdVYyJreL1fF4i6xilfBnzK
1PLhinJnhb6R9G3aJSSqv4hXuAg2S8r+ve8zZnEIR4fJS/LmlPzIljYd0yY7mrRB
iL9z6iGSUZPi2R/7ioRc848l5j+mmHJDozplSbKqGtLoNo2BNCq5TTYT0y6W/PE=
=PMIO
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
