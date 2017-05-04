Received: from eggs.gnu.org ([2001:4830:134:3::10]:33353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6HWc-0003Wi-4D
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6HWX-0005RH-AD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:14:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6HWW-0005Qq-FT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:14:29 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 4 May 2017 14:13:38 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA264026@DGGEMA505-MBX.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
	<17594b34-62c0-bc4e-2fda-fc54837e0732@linux.vnet.ibm.com>
In-Reply-To: <17594b34-62c0-bc4e-2fda-fc54837e0732@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v18 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "lixiao (H)" <lixiao91@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

>=20
>=20
> On 05/04/2017 03:33 PM, Gonglei (Arei) wrote:
> >>> +\begin{description}
> >>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires
> >> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires
> >> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires
> >> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires
> >> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>> +\end{description}
> >>
> >> I find feature bit 0 redundant and bit confusing. We had a discussion
> >> in v15 and v16.
> >>
> >> Could you answer:
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03214.html
> >> (Message-ID:
> <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>)
> >>
> >>
> > Please see my reply:
> > https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03186.html
> >
> > The main reason is we should keep compatibility to pre-existing driver =
and
> > support some function that different services have different modes.
> > We have only one unique crypto request named structure
> virtio_crypto_op_data_req_mux.
> > Please continue to see the sepc, you'll find the truth.
> >
>=20
> Sorry, I still do not understand why can't we drop
> VIRTIO_CRYPTO_F_STATELESS_MODE
> and just keep the four service specific modes.
>=20
> Can you point me to the (published) code where
> VIRTIO_CRYPTO_F_STATELESS_MODE is
> used (that's what I'm missing -- preferably state the repository, the com=
mit
> a file and a line using VIRTIO_CRYPTO_F_STATELESS_MODE)?
>=20
No no no, there isn't existing code use VIRTIO_CRYPTO_F_STATELESS_MODE yet,
It's just for future use.

Please the blow description:
"""
\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto =
Device / Device Operation / HASH Service Operation}

\begin{itemize*}
\item If the driver uses the session mode, then the driver MUST set \field{=
session_id} in struct virtio_crypto_op_header
      to a valid value assigned by the device when the session was created.
\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated, the =
driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto request=
s. Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated,=
 1) if the driver uses the stateless mode, then the driver MUST set the \fi=
eld{flag} field in struct virtio_crypto_op_header
      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the fields in struc=
t virtio_crypto_hash_para_statelession.sess_para, 2) if the driver uses the=
 session mode, then the driver MUST set the \field{flag} field in struct vi=
rtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header =
to VIRTIO_CRYPTO_HASH.
\end{itemize*}
"""

If we drop the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit, and the=20
VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is not negotiated,=20
then the driver doesn't to know use which structure to store the crypto req=
uest:=20
is struct virtio_crypto_op_data_req_mux ? or struct virtio_crypto_op_data_r=
eq.

We assume the driver uses struct virtio_crypto_op_data_req, what about the =
device?
The device doesn't know how to parse the request in the virtio_crypto_handl=
e_request()
of virito-crypto.c in Qemu.

static int
virtio_crypto_handle_request(VirtIOCryptoReq *request)
{
    VirtIOCrypto *vcrypto =3D request->vcrypto;
    VirtIODevice *vdev =3D VIRTIO_DEVICE(vcrypto);
    VirtQueueElement *elem =3D &request->elem;
    int queue_index =3D virtio_crypto_vq2q(virtio_get_queue_index(request->=
vq));
    struct virtio_crypto_op_data_req req; ???

    ///or struct virtio_crypto_op_data_req_mux req; ???

Thanks,
-Gonglei
