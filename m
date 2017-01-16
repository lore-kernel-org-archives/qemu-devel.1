Received: from eggs.gnu.org ([2001:4830:134:3::10]:37828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Gp-0006mD-FQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Gl-0007cC-DD
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:24:23 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT7Gl-0007c6-6e
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:24:19 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so30828116wmr.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:24:19 -0800 (PST)
Date: Mon, 16 Jan 2017 13:24:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116132414.GC14681@stefanha-x1.localdomain>
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
	<1483524185-9036-2-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <1483524185-9036-2-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v15 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, weidong.huang@huawei.com, mst@redhat.com, john.griffin@intel.com, cornelia.huck@de.ibm.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, Hanweidong <hanweidong@huawei.com>, agraf@suse.de, nmorey@kalray.eu, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, Shiqing.Fan@huawei.com, Jani.Kokkonen@huawei.com, pasic@linux.vnet.ibm.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2017 at 06:03:04PM +0800, Gonglei wrote:
> +The general header of dataq:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_header {
> +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
> +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
> +#define VIRTIO_CRYPTO_HASH \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
> +#define VIRTIO_CRYPTO_MAC \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
> +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
> +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> +    le32 opcode;
> +    /* algo should be service-specific algorithms */
> +    le32 algo;
> +    /* session_id should be service-specific algorithms */
> +    le64 session_id;
> +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
> +#define VIRTIO_CRYPTO_FLAG_NONE_SESSION_MODE 2

This constant isn't mentioned anywhere in the spec, am I missing
something?

Regarding naming: "none session mode" != "non-session mode"

I think this constant should be called
VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE or
VIRTIO_CRYPTO_FLAG_SESSIONLESS_MODE.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMl+AAoJEJykq7OBq3PIk+YH/24bJ0YeQCwEE5HgoJeXr69M
URCLbomk1D0rEV1U0mziADsydJsYL8uY0rhf7/Y6M90tBqA9JXKooZBO/2oK5D7l
cMsJNJyG6wg2qkK3k38DL2+UHsP3HO94Ez2PelAqQQE6Xi0LKe7xG5+76aKleEja
BvmrcFzE4ln0F3cMqPbR/bYTCFPPC8i2dSc6EaF2B0Hz/7suq5X8PyPH/mKSR0MH
ezYt1TM1ol8wyaNYxR3XcRWLTtbZ28zLZ+wejk3jSivQNd7w/MRssaMHrWM2vr5u
SzIu6G9w4zSH0pB7CmAemcUL950jIM0ouRSD1/i6y1+M7W9NKcydFolQaEQcejk=
=YFrb
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
