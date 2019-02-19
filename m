Received: from eggs.gnu.org ([209.51.188.92]:48114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gw0h7-0004uk-Gu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gw0h6-0006FJ-OE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gw0h6-0006Eb-HP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:24:00 -0500
Date: Tue, 19 Feb 2019 16:21:01 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190219082101.GA15343@wei-ubt>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-8-git-send-email-wexu@redhat.com>
	<7d71fb88-2651-41eb-023e-63a11a83cd38@redhat.com>
	<20190218144640.GA28793@wei-ubt>
	<71fd17b4-9509-3f13-556d-fc4c3e617e84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71fd17b4-9509-3f13-556d-fc4c3e617e84@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/11] virtio: fill/flush/pop for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

On Tue, Feb 19, 2019 at 02:49:42PM +0800, Jason Wang wrote:
>=20
> On 2019/2/18 =E4=B8=8B=E5=8D=8810:46, Wei Xu wrote:
> >>Do we allow chain more descriptors than vq size in the case of indire=
ct?
> >>According to the spec:
> >>
> >>"
> >>
> >>The device limits the number of descriptors in a list through a
> >>transport-specific and/or device-specific value. If not limited,
> >>the maximum number of descriptors in a list is the virt queue
> >>size.
> >>"
> >>
> >>This looks possible, so the above is probably wrong if the max number=
 of
> >>chained descriptors is negotiated through a device specific way.
> >>
> >OK, I will remove this check, while it is necessary to have a limitati=
on
> >for indirect descriptor anyway, otherwise it is possible to hit an ove=
rflow
> >since presumably u16 is used for most number/size in the spec.
> >
>=20
> Please try to test block and scsi device for you changes as well.

Any idea about what kind of test should be covered? AFAICT, currently
packed ring is targeted for virtio-net as discussed during voting spec.

Wei

>=20
> Thanks
>=20
>=20
