Received: from eggs.gnu.org ([2001:4830:134:3::10]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOQZQ-0006eR-Lf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOQZM-00069f-O5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:00:12 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cOQZM-000676-I0
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:00:08 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so48730618wmi.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 07:00:06 -0800 (PST)
Date: Tue, 3 Jan 2017 15:00:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103150003.GD14707@stefanha-x1.localdomain>
References: <1478856187-284644-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA16E01B@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA16E01B@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v14 0/2] virtio-crypto: virtio crypto
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 02:38:29AM +0000, Gonglei (Arei) wrote:
> Both Alex and Stefan mentioned that the process of create/close a session
> makes we have a least one full round-trip cost from guest to host to guest
> to be able to send any data for symmetric algorithms. It gets ourself into
> synchronization troubles in some scenarios like a web server handling lots
> of small requests whose algorithms and keys are different.
>=20
> Because the virtio crypto specification has not been voted yet and v15 is=
 on the way.
> I'd like to make some changes in order to support those scenarios better.=
 That means
> we will support one-blob request (no sessions) as well for symmetric
> algorithms, including HASH, MAC services. The benefit is obvious for
> HASH service because it's usually a one-blob operation.
>=20
> The main changes will be:
>  1) using the flag property of struct virtio_crypto_op_header to identify=
 the
>     type of crypto request. Aka Is it a session-based or non-session requ=
est?
>     The flag is not used currently, so we can make use of it.
>=20
>  2) extending virtio_crypto_*_para structures, for example, add the conte=
nt of
>     struct virtio_crypto_cipher_session_para into struct virtio_crypto_ci=
pher_para.
>     It's true that will increase the size of each crypto request after th=
is change.
>=20
> Does it make sense? Thanks!

That sounds good.  Hopefully many crypto API users only use a single
operation and can therefore benefit from this optimization.

Stefan

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa7xzAAoJEJykq7OBq3PIZrwIAK+SynZPtt/BhnEQsMrzRDPf
/2c6S3ty0h81MlFL+YG/mSQAzB4TbpfEQgXQ/CZMWnylj8Ukisw2P/MMu4qQNfoa
81q4LLbeV/WKDZcFfhSSANW2yE2BXEA5tdhVo+ROeQTyiu8uN3yMBFPCAc6rbJEx
fZkgcKL9m54ot2Nl8OfgIxebOjo0oTUG3d0XFsimviCMdF5t2lJ827VFGilk/wrY
Uba/DxSDcwgWLKD5pBs6a71AbT1K1Moh0BJ3oPUu2kdARkUVDL/42J1gcXepqxTV
vkta9Ea5rfdU6OY+pCdsVQPRld7EeIzJXVPOh3XfuGFpFRmr7Lc4cF70ZaZl57U=
=iqUa
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
