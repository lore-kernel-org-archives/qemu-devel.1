Received: from eggs.gnu.org ([2001:4830:134:3::10]:35776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dDTQ4-00068V-Bm
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dDTQ1-0004nS-40
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dDTQ0-0004mk-Qv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:21:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OAJJT3009322
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 06:21:27 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amvavu5kh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 06:21:26 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 24 May 2017 11:21:24 +0100
Date: Wed, 24 May 2017 12:21:20 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170524001758-mutt-send-email-mst@kernel.org>
References: <82063967A54EF84C8AFCD6BD7F6AD93310D199A2@SHSMSX103.ccr.corp.intel.com>
	<20170524001758-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170524122120.55aba623.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: virtio crypto device implemenation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zeng, Xin" <xin.zeng@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Wed, 24 May 2017 04:13:47 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 23, 2017 at 04:08:25PM +0000, Zeng, Xin wrote:
> > Hi, Michael,=20
> >    As you know, Lei Gong from Huawei and I are co-working  on virtio cr=
ypto device spec, he is focusing on symmetric algorithm part, I am focusing=
 on asymmetric part.  Now I am planning the implementation for asymmetric p=
art, would you please give me your point regarding the questions below?
> >    Current virtio crypto device implementation from Lei Gong:
> >    The virtio crypto device implementation has been upstreamed to QEMU =
and it has a qemu backend implementation for symmetric algorithm part, the =
front end Linux device driver for symmetric part has been upstreamed to Lin=
ux kernel as well.
> >    My questions:
> >    From my side, I planned to add the asymmetric part support in upstre=
amed front end device driver, and I don't want to add the asymmetric algori=
thm support to current virtio crypto device's qemu backend, instead, I woul=
d like to implement and upstream a DPDK vhost-user based backend for asymme=
tric algorithm, and accordingly Lei Gong will help to upstream a vhost user=
 agent for virtio crypto device in QEMU,  is this approach acceptable? Is a=
 qemu backend a mandatory requirement for the virtio crypto device?  Is the=
re a general policy for this?
> >=20
> > Thanks
>=20
> Parity on QEMU side is naturally preferable.  I don't think we should req=
uire it
> at all times, but if there's no implementation outside vhost-user,
> and if the feature includes a non-trivial amount of code, how
> will it be tested? I don't think we want to require all testers to use
> dpdk. An implementation under tests using libvhost-user might
> be a solution.

=46rom the s390 perspective, I'd naturally prefer a qemu implementation.
I think there is value in being able to try it out on a variety of
platforms, so that you can shake out problems such as endianness easily.
