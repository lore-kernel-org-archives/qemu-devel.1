Received: from eggs.gnu.org ([2001:4830:134:3::10]:33232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVZ5H-0003L3-2v
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVZ5C-0005qn-1Z
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:30:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVZ5B-0005qW-SH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:30:29 -0500
Date: Mon, 23 Jan 2017 15:30:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170123073020.GI26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
	<e1b09efe-0201-a746-9aa9-62f798a222f9@redhat.com>
	<20170122090958.GC26526@pxdev.xzpeter.org>
	<33026fc1-3649-0d33-2bf1-6260daedfe03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33026fc1-3649-0d33-2bf1-6260daedfe03@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing
 pages before replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Mon, Jan 23, 2017 at 09:57:23AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:09, Peter Xu wrote:
> >On Sun, Jan 22, 2017 at 04:13:32PM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> >>>Previous replay works for domain switch only if the original domain =
does
> >>>not have mapped pages. For example, if we switch domain from A to B,=
 it
> >>>will only work if A has no existing mapping. If there is, then there=
's
> >>>problem - current replay didn't make sure the old mappings are clear=
ed
> >>>before replaying the new one.
> >>I'm not quite sure this is needed. I thought the only thing we need t=
o do is
> >>stop DMA of device during the moving? Or is there an example that wil=
l cause
> >>trouble?
> >I think this patch is essential.
> >
> >Example:
> >
> >- device D1 moved to domain A, domain A has no mapping
> >- map page P1 in domain A, so D1 will have a mapping of page P1
> >- create domain B with mapping P2
> >- move D1 from domain A to domain B
> >
> >Here if we don't unmap existing pages in domain A (P1),
>=20
> I thought driver should do this work instead of device, because only dr=
iver
> knows whether or not iova is still needed?

Do you mean "device driver" above?

I don't know whether I understood the question above, but the problem
should be there no matter which one is managing iova?

Thanks,

-- peterx
