Received: from eggs.gnu.org ([2001:4830:134:3::10]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZfw1-0008JS-Dz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZfvy-0002e2-6F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:38:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cZfvx-0002cw-Vx
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:37:58 -0500
Date: Fri, 3 Feb 2017 17:37:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170203173607-mutt-send-email-mst@kernel.org>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203103316.GA29200@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, weidong.huang@huawei.com, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, agraf@suse.de, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, pasic@linux.vnet.ibm.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com

On Fri, Feb 03, 2017 at 10:33:16AM +0000, Stefan Hajnoczi wrote:
> > +\begin{description}
> > +\item[0] dataq1
> > +\item[\ldots]
> > +\item[N-1] dataqN
> > +\item[N] controlq
> > +\end{description}
> > +
> > +N is set by \field{max_dataqueues}.
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
> > +
> > +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
> > +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is available for CIPHER service.
> > +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is available for HASH service.
> > +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is available for MAC service.
> > +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is available for AEAD service.
> 
> Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4 can
> be eliminated in favor of just bit 0.

Too late to change it as QEMU released a device with that feature.

-- 
MST
