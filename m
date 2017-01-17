Received: from eggs.gnu.org ([2001:4830:134:3::10]:40321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTIZ0-0002Tb-SG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTIYx-0007ze-Pf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:27:54 -0500
Received: from [45.249.212.187] (port=2527 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTIYu-0006cF-2T
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:27:51 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 17 Jan 2017 01:23:30 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA193FB6@DGGEMA505-MBX.china.huawei.com>
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
	<1483524185-9036-2-git-send-email-arei.gonglei@huawei.com>
	<20170116132414.GC14681@stefanha-x1.localdomain>
In-Reply-To: <20170116132414.GC14681@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi Stefan,

>=20
> On Wed, Jan 04, 2017 at 06:03:04PM +0800, Gonglei wrote:
> > +The general header of dataq:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_header {
> > +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
> > +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
> > +#define VIRTIO_CRYPTO_HASH \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
> > +#define VIRTIO_CRYPTO_MAC \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
> > +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
> > +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> > +    le32 opcode;
> > +    /* algo should be service-specific algorithms */
> > +    le32 algo;
> > +    /* session_id should be service-specific algorithms */
> > +    le64 session_id;
> > +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
> > +#define VIRTIO_CRYPTO_FLAG_NONE_SESSION_MODE 2
>=20
> This constant isn't mentioned anywhere in the spec, am I missing
> something?
>=20
> Regarding naming: "none session mode" !=3D "non-session mode"
>=20
> I think this constant should be called
> VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE or
> VIRTIO_CRYPTO_FLAG_SESSIONLESS_MODE.

Sorry for my typo, I used VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE.

Thanks,
-Gonglei
