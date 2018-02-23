Received: from eggs.gnu.org ([2001:4830:134:3::10]:52685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1ep7RZ-0008Qp-74
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1ep7Qw-000123-RK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:06:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:53564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1ep7Qw-0000tS-8O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:06:18 -0500
From: "Zhang, Tina" <tina.zhang@intel.com>
Date: Fri, 23 Feb 2018 07:06:10 +0000
Message-ID: <237F54289DF84E4997F34151298ABEBC7C6E9BA4@SHSMSX101.ccr.corp.intel.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
	<20180222064003.yzrcmh7hi6qvgcij@zhen-hp.sh.intel.com>
	<20180222093055.u34o2pp6twcx645f@sirius.home.kraxel.org>
	<20180223024257.vrnsisgmefdyarkc@zhen-hp.sh.intel.com>
In-Reply-To: <20180223024257.vrnsisgmefdyarkc@zhen-hp.sh.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Zhenyu Wang [mailto:zhenyuw@linux.intel.com]
> Sent: Friday, February 23, 2018 10:43 AM
> To: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>; Kirti Wankhede
> <kwankhede@nvidia.com>; intel-gvt-dev@lists.freedesktop.org; qemu-
> devel@nongnu.org; Zhang, Tina <tina.zhang@intel.com>
> Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
>=20
> On 2018.02.22 10:30:55 +0100, Gerd Hoffmann wrote:
> >   Hi,
> >
> > > Nice! Seems to be the last missing gap for local spice with cursor
> > > dmabuf support, we'll do more testing on that for sure. Btw, another
> > > method might be to add direct cursor dmabuf passing for spice as gl
> > > output, is that correct way?
> >
> > Passing on the cursor sprite needs the hotspot information, so spice
> > client can position the cursor correctly.  I didn't got hotspot
> > information in my testing yet, but maybe the guest kernel was too old.
> > Is that supported meanwhile?  If so, which kernel version is needed?
> >
>=20
> Current gvt dmabuf doesn't support true hotspot info yet which requires s=
ome
> pv info update as we can't get it from hw state. Tina is pursuing that.
Indeed. Guest OS needs to use pv info to deliver the hotspot info to host. =
And so far, only Windows igfx driver can support it.
With the following patch, host userspace can get the valid hotspot info if =
it is supported by guest driver (e.g. Windows), or invalid hotspot info whe=
n unsupported.
https://lists.freedesktop.org/archives/intel-gvt-dev/2018-February/003169.h=
tml

BR,
Tina
>=20
> > Spice already has support for setting pointers, we can simply use
> > that, at least initially.  Doesn't use dma-bufs.  If it turns out to
> > be a performance issue we can add support for using dma-bufs instead,
> > but that needs spice server changes.
> >
> > > And really like to see dmabuf support could be in upstream soon. Do
> > > you have any predict for which qemu version?
> >
> > I want have this in 2.12, at least the current, initial version.
> > Improved cursor support might take a little longer.
> >
>=20
> Good to know. Thanks!
>=20
> --
> Open Source Technology Center, Intel ltd.
>=20
> $gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827
