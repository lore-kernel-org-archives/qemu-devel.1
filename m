Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cbo9k-0000Bn-33
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cbo9f-00066N-78
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:49:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cbo9e-00066J-U7
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:48:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19Civfh070282
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 07:48:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28gqghk7tp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 07:48:53 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 9 Feb 2017 12:48:49 -0000
Date: Thu, 9 Feb 2017 13:48:39 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1AFF1E@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
	<20170207140710.01e4b694.cornelia.huck@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1AFF1E@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170209134839.0062b8fe.cornelia.huck@de.ibm.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>

On Wed, 8 Feb 2017 03:46:53 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> Hi Cornelia,
> 
> > 
> > On Tue, 7 Feb 2017 12:39:44 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> > > On 01/18/2017 09:22 AM, Gonglei wrote:
>
> > > > +The following services are defined:
> > > > +
> > > > +\begin{lstlisting}
> > > > +/* CIPHER service */
> > > > +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
> > > > +/* HASH service */
> > > > +#define VIRTIO_CRYPTO_SERVICE_HASH   1
> > > > +/* MAC (Message Authentication Codes) service */
> > > > +#define VIRTIO_CRYPTO_SERVICE_MAC    2
> > > > +/* AEAD (Authenticated Encryption with Associated Data) service */
> > > > +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
> > > > +\end{lstlisting}
> > > > +
> > > > +The last driver-read-only fields specify detailed algorithms masks
> > > > +the device offers for corresponding services. The following CIPHER
> > algorithms
> > > > +are defined:
> > >
> > > You do not establish an explicit relationship between the fields and the
> > > macros for the flags. These are flags or? It seems quite common in the
> > > spec to use _F_ in flag names. Would it be appropriate here?
> > 
> > The values as specified do not look very flaggy to me...
> > 
> > >
> > > > +
> > > > +\begin{lstlisting}
> > > > +#define VIRTIO_CRYPTO_NO_CIPHER                 0
> > > > +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
> > > > +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
> > > > +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
> > > > +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
> > > > +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
> > > > +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
> > > > +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
> > > > +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
> > > > +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
> > > > +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
> > > > +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
> > > > +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
> > > > +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
> > > > +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
> > > > +\end{lstlisting}
> > > > +
> > > > +
> > >
> > > Would it make sense to interleave the flag definition
> > > with the struct virtio_crypto_config?
> > >
> > > > +\begin{note}
> > > > +Any other values are reserved for future use.
> > >
> > > Are these flags or values? I do not think values is appropriate here.
> > 
> > These look like values to me and not flags.
> > 
> > The more I stare at this, the more confused I become. Is the device
> > supposed to indicate exactly one algorithm only? Or are these supposed
> > to be bit numbers? (If yes, it would make sense to either call them
> > that or specify flags in the (1 << bit_num) notation.)
> 
> Actually these are both bit numbers and values.
> 
> On the one hand, the device can set algorithms by '1 << bit_num' notation to tell the driver what
> algorithms are supported. On the other hand, the driver can set the value to tell
> the device a virtio crypto request's algorithm in struct virtio_crypto_op_header.algo.
> 
> Pls see cryptodev-builtin.c:: cryptodev_buitlin_init()
> 
> backend->conf.crypto_services =
>                          1u << VIRTIO_CRYPTO_SERVICE_CIPHER |
>                          1u << VIRTIO_CRYPTO_SERVICE_HASH |
>                          1u << VIRTIO_CRYPTO_SERVICE_MAC;
> backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
> backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
> 
> Perhaps I should add a specific formulation about them.

Can you add, for example, a note that the respective fields define the
supported services (...) with bits corresponding to a specific service
(...) on a 1:1 basis? Then define which way your bit numbering is done
and that the following defines specify the bit number. Then your
existing lists are fine, I think.
