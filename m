Received: from eggs.gnu.org ([2001:4830:134:3::10]:59077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE8fa-0007ck-4Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE8fW-00022k-Rd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:28:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE8fW-00022N-MA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:28:46 -0400
Date: Thu, 3 May 2018 15:28:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503072828.GA29580@xz-mi>
References: <20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
	<547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jintack Lim <jintack@cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, May 03, 2018 at 03:20:11PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
> > IMHO the guest can't really detect this, but it'll found that the
> > device is not working functionally if it's doing something like what
> > Jason has mentioned.
> >=20
> > Actually now I have had an idea if we really want to live well even
> > with Jason's example: maybe we'll need to identify PSI/DSI.  For DSI,
> > we don't remap for mapped pages; for PSI, we unmap and remap the
> > mapped pages.  That'll complicate the stuff a bit, but it should
> > satisfy all the people.
> >=20
> > Thanks,
>=20
> So it looks like there will be still unnecessary unamps.

Could I ask what do you mean by "unecessary unmaps"?

> How about record the mappings in the tree too?

As I mentioned, for L1 guest (e.g., DPDK applications running in L1)
it'll be fine.  But I'm just afraid we will have other use cases, like
the L2 guests. That might need tons of the mapping entries in the
worst case scenario.

--=20
Peter Xu
