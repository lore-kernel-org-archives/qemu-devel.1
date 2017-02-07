Received: from eggs.gnu.org ([2001:4830:134:3::10]:34763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cauHk-0003vx-Hl
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cauHg-0000QZ-Ie
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:09:32 -0500
Received: from [45.249.212.189] (port=2387 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cauHX-0007OJ-Vx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:09:28 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 7 Feb 2017 00:59:42 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1AF46A@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<33183CC9F5247A488A2544077AF19020DA1AED04@DGGEMA505-MBX.china.huawei.com>
	<20170206154625.GB32590@stefanha-x1.localdomain>
	<20170206201814-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170206201814-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "claudio.fontana@huawei.com" <claudio.fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi,

> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 07, 2017 2:20 AM
> Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypt=
o
> device specification
>=20
> On Mon, Feb 06, 2017 at 03:46:25PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 06, 2017 at 01:48:09AM +0000, Gonglei (Arei) wrote:
> > > > > +\item The device MUST set \field{max_size} to show the maximum s=
ize
> of
> > > > crypto request the device supports.
> > > >
> > > > In bytes?
> > > >
> > > > > +\item The device MUST set \field{max_cipher_key_len} to show the
> > > > maximum length of cipher key if the device supports CIPHER service.
> > > >
> > > > In bits or bytes?
> > > >
> > > > > +\item The device MUST set \field{max_auth_key_len} to show the
> maximum
> > > > length of authenticated key if the device supports MAC service.
> > > >
> > > > In bits or bytes?
> > > >
> > >
> > > All lengths in virtio crypto spec are bytes.
> >
> > Please move this before the first length field is defined:
> >
> >   +\begin{note}
> >   +The basic unit of all data length the byte.
> >   +\end{note}
>=20
> And I'd rewrite as
>=20
>    All data length fields specify the length in bytes.
>=20

Okay, will do it.

BTW if no other objections or comments,=20
I'd like to send v17 as the final version to ballot, can I?

Thanks,
-Gonglei

> >
> > It should be at the beginning of the spec.
>=20
