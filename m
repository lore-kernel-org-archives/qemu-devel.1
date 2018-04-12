Received: from eggs.gnu.org ([2001:4830:134:3::10]:49797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6TiA-0008LR-Cr
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 00:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6Ti7-0005SX-AA
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 00:19:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f6Ti7-0005SK-4n
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 00:19:47 -0400
Date: Thu, 12 Apr 2018 07:19:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180412071805-mutt-send-email-mst@kernel.org>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
	<20180412011059.yywn73znjdip2cyv@debian>
	<20180412042724-mutt-send-email-mst@kernel.org>
	<20180412013942.egucc4isxkokta7z@debian>
	<20180412044404-mutt-send-email-mst@kernel.org>
	<20180412023505.xftmhguzu7j55nif@debian>
	<20180412061108-mutt-send-email-mst@kernel.org>
	<20180412062216-mutt-send-email-mst@kernel.org>
	<9314ebd5-8e92-41b1-efd1-4371177075a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9314ebd5-8e92-41b1-efd1-4371177075a0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com

On Thu, Apr 12, 2018 at 11:43:41AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 11:35, Michael S. Tsirkin wrote:
> > > There are more advantages to using request with PASID:
> > >=20
> > > You can use hardware support for nesting, having guest supply 1st l=
evel
> > > translation and host second level translation.
> > >=20
> > > I actually had an idea to do something like this for AMD
> > > and ARM which support nesting even for requests with PASID,
> > > having intel benefit too would be nice.
> > Something else to consider is implementing PRS capability.
> >=20
> >=20
> > In theory this could then go like this:
> >=20
> > - get page request from device
> > - fetch request from VTD page tables
> > - use response to issue a page response message
> >=20
> >=20
> > This would match the current vhost-user model.
>=20
> This requires IOMMU driver can forward this to VFIO and then VFIO can
> forward it to userspace. Looks like a lot of changes and it would be ev=
en
> slower than what is proposed in this patch.
>=20
> Thanks


It would work better for a static table as only accessed pages would
need to be sent.  Slower for the dynamic case but dynamic case needs
hardware support to work properly in any case.

--=20
MST
