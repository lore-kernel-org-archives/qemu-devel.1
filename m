Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbJEC-0000ox-I4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbJE9-0002Oe-Di
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:47:32 -0500
Received: from [45.249.212.187] (port=2530 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbJE6-0002M6-2l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:47:29 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 8 Feb 2017 03:46:53 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1AFF1E@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
	<20170207140710.01e4b694.cornelia.huck@de.ibm.com>
In-Reply-To: <20170207140710.01e4b694.cornelia.huck@de.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v16 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>

Hi Cornelia,

>=20
> On Tue, 7 Feb 2017 12:39:44 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
> > On 01/18/2017 09:22 AM, Gonglei wrote:
>=20
> > > +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> > > +
> > > +The virtio crypto device is a virtual cryptography device as well as=
 a kind of
> > > +virtual hardware accelerator for virtual machines. The encryption an=
d
> > > +decryption requests are placed in any of the data active queues and =
are
> ultimately handled by the
> >
> > Am I the only one having a problem with 'data active queues'?
>=20
> No. I think it looks weird.
>=20
> (...)
>=20
> > > +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or
> ~VIRTIO_CRYPTO_S_HW_READY.
> >
> > Not entirely happy with this. What you want to say is reserved
> > for future use, or? Would it make sense to have a general note
> > -- in a similar fashion like for 'sizes are in bytes' -- for
> > reserved for future use?
> >
> > One possible formulation would be:
> >
> > "In this specification, unless explicitly stated otherwise,
> > fields and bits reserved for future use shall be zeroed out.
> > Both the a device or a driver device and the driver should
> > detect violations of this rule, and deny the requested
> > operation in an appropriate way if possible."
>=20
> If we go with reserved-and-must-be-zero, we need to make rejecting
> non-zero for reserved value a MUST, or we may run into problems later.
>=20
> In this case, I'd opt for a specific formulation, though; like
>=20
> "The \field{status} field can be either zero or have one or more flags
> set. Valid flags are listed below."
>=20
> And then state that non-valid flags MUST NOT be set resp. MUST be
> rejected in a normative statement.
>=20
Sounds good.

> (...)
>=20
> > > +The following services are defined:
> > > +
> > > +\begin{lstlisting}
> > > +/* CIPHER service */
> > > +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
> > > +/* HASH service */
> > > +#define VIRTIO_CRYPTO_SERVICE_HASH   1
> > > +/* MAC (Message Authentication Codes) service */
> > > +#define VIRTIO_CRYPTO_SERVICE_MAC    2
> > > +/* AEAD (Authenticated Encryption with Associated Data) service */
> > > +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
> > > +\end{lstlisting}
> > > +
> > > +The last driver-read-only fields specify detailed algorithms masks
> > > +the device offers for corresponding services. The following CIPHER
> algorithms
> > > +are defined:
> >
> > You do not establish an explicit relationship between the fields and th=
e
> > macros for the flags. These are flags or? It seems quite common in the
> > spec to use _F_ in flag names. Would it be appropriate here?
>=20
> The values as specified do not look very flaggy to me...
>=20
> >
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_CRYPTO_NO_CIPHER                 0
> > > +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
> > > +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
> > > +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
> > > +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
> > > +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
> > > +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
> > > +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
> > > +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
> > > +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
> > > +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
> > > +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
> > > +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
> > > +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
> > > +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
> > > +\end{lstlisting}
> > > +
> > > +
> >
> > Would it make sense to interleave the flag definition
> > with the struct virtio_crypto_config?
> >
> > > +\begin{note}
> > > +Any other values are reserved for future use.
> >
> > Are these flags or values? I do not think values is appropriate here.
>=20
> These look like values to me and not flags.
>=20
> The more I stare at this, the more confused I become. Is the device
> supposed to indicate exactly one algorithm only? Or are these supposed
> to be bit numbers? (If yes, it would make sense to either call them
> that or specify flags in the (1 << bit_num) notation.)

Actually these are both bit numbers and values.

On the one hand, the device can set algorithms by '1 << bit_num' notation t=
o tell the driver what
algorithms are supported. On the other hand, the driver can set the value t=
o tell
the device a virtio crypto request's algorithm in struct virtio_crypto_op_h=
eader.algo.

Pls see cryptodev-builtin.c:: cryptodev_buitlin_init()

backend->conf.crypto_services =3D
                         1u << VIRTIO_CRYPTO_SERVICE_CIPHER |
                         1u << VIRTIO_CRYPTO_SERVICE_HASH |
                         1u << VIRTIO_CRYPTO_SERVICE_MAC;
backend->conf.cipher_algo_l =3D 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
backend->conf.hash_algo =3D 1u << VIRTIO_CRYPTO_HASH_SHA1;

Perhaps I should add a specific formulation about them.

Thanks,
-Gonglei
