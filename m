Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1cU7Ns-0005RI-IR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1cU7NN-0002E6-Nv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:43:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:55853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xin.zeng@intel.com>) id 1cU7NN-0002BV-DN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:43:17 -0500
From: "Zeng, Xin" <xin.zeng@intel.com>
Date: Thu, 19 Jan 2017 07:42:55 +0000
Message-ID: <82063967A54EF84C8AFCD6BD7F6AD93310C4FD2F@SHSMSX103.ccr.corp.intel.com>
References: <1484051484-86503-1-git-send-email-xin.zeng@intel.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C4C74E@SHSMSX103.ccr.corp.intel.com>
	<33183CC9F5247A488A2544077AF19020DA195C57@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA195C57@DGGEMA505-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/1] virtio crypto device
 specification: asymmetric crypto service
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Keating, Brian A" <brian.a.keating@intel.com>, "Griffin, John" <john.griffin@intel.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Wednesday, January 18, 2017 10:04 AM, Gonglei (Arei) wrote:
> I update the virtio crypto spec to support non-session based crypto
> Operations and your asym service also needs change struct
> virtio_crypto_op_data_req which maybe cause the compatibility complaint
> with the pre-existing code.
>=20
> So I strongly suggest you rebase my v16 (will be submitted today), and pu=
t
> asym service to struct virtio_crypto_op_data_req_mixed.
>=20

Yes, sure.

> struct virtio_crypto_op_data_req_mixed {
>     struct virtio_crypto_op_header header;
>=20
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
>         struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
>         struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
>         struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
>         struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
>=20
> 		/* asymmetric crypto requests here */
> 		...
>     } u;
> };
>=20
> > We also plan to add asymmetric crypto service part support in LKCF
> > based virtio crypto frontend driver, and upstream DPDK vhost library
> > based vhost user for cryptodev which also focuses on asymmetric crypto
> service , any comments?
> >
> Sounds great. It's very helpful to accelerate the progress of reviewing.
> After all they are kinds of special knowledge.
>=20
> Meanwhile, I can submit the cryptodev-vhost-user/cryptodev-vhost-kernel
> backends in QEMU if needs.
>=20

That's great. We planned to upstream vhost-user for cryptodev to DPDK in Q3=
 this year.=20
Let's have another collaboration.

> Thanks,
> -Gonglei
>=20
