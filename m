Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv7D-00032n-1Q
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv79-0007i2-Me
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:19:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAv78-0007hg-R1
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:19:27 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 17 May 2017 09:18:38 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA29B247@DGGEMA505-MBS.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<20170516153348.GR8498@stefanha-x1.localdomain>
In-Reply-To: <20170516153348.GR8498@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v18 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, Linqiangmin <linqiangmin@huawei.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen,
	Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>

>
>=20
> On Sat, Apr 22, 2017 at 02:23:50PM +0800, Gonglei wrote:
> > +Dataq requests for both session and stateless modes are as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_data_req_mux {
> > +    struct virtio_crypto_op_header header;
> > +
> > +    union {
> > +        struct virtio_crypto_sym_data_req   sym_req;
> > +        struct virtio_crypto_hash_data_req  hash_req;
> > +        struct virtio_crypto_mac_data_req   mac_req;
> > +        struct virtio_crypto_aead_data_req  aead_req;
> > +        struct virtio_crypto_sym_data_req_stateless
> sym_stateless_req;
> > +        struct virtio_crypto_hash_data_req_stateless
> hash_stateless_req;
> > +        struct virtio_crypto_mac_data_req_stateless
> mac_stateless_req;
> > +        struct virtio_crypto_aead_data_req_stateless
> aead_stateless_req;
> > +    } u;
> > +};
> > +\end{lstlisting}
>=20
> Halil touched on this in the discussion: this spec uses a C-like struct
> syntax but does not define whether unions really affect sizeof(mystruct)
> like they would in C or whether you just mean that any of the union
> fields can be used.  This distinction is important so device and driver
> authors understand the exact memory layout of requests and responses.
>=20
> Please include an explanation about the meaning of "union" in the text.
>=20
Halil has different opinion in other thread, I replied.

I'll wait for his new response about it. Thanks!

> > +Session mode MAC service requests are as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_mac_para {
> > +    struct virtio_crypto_hash_para hash;
> > +};
> > +
> > +struct virtio_crypto_mac_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_mac_para para;
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_mac_data_req structure to store
> information
>=20
> "Each request uses the virtio_crypto_mac_data_req structure to store
> information"
>=20
OK.

> > +Session mode requests of symmetric algorithm are as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_sym_data_req {
> > +    union {
> > +        struct virtio_crypto_cipher_data_req cipher;
> > +        struct virtio_crypto_alg_chain_data_req chain;
> > +    } u;
> > +
> > +    /* Device-readable part */
> > +
> > +    /* See above VIRTIO_CRYPTO_SYM_OP_* */
> > +    le32 op_type;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_sym_data_req structure to store
> information
>=20
> s/virtio_crypto_sym_data_req structure/the virtio_crypto_sym_data_req
> structure/

OK.

Thanks,
-Gonglei
