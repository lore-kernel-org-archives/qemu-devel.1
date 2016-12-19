Received: from eggs.gnu.org ([2001:4830:134:3::10]:37105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIu9s-0002rO-2Y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIu9o-0005KS-JD
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIu9o-0005J5-Dy
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:22:56 -0500
Date: Mon, 19 Dec 2016 17:22:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161219092250.GA4155@pxdev.xzpeter.org>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<20161218084250.GB24337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161218084250.GB24337@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/13] VT-d replay and misc cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: kevin.tian@intel.com, tianyu.lan@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, yi.l.liu@intel.com

On Sun, Dec 18, 2016 at 04:42:50PM +0800, Liu, Yi L wrote:
> On Tue, Dec 06, 2016 at 06:36:15PM +0800, Peter Xu wrote:
> > This RFC series is a continue work for Aviv B.D.'s vfio enablement
> > series with vt-d. Aviv has done a great job there, and what we still
> > lack there are mostly the following:
> >=20
> > (1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMM=
U
> >     memory region.
> >=20
> > (2) VT-d still haven't provide a correct replay() mechanism (e.g.,
> >     when IOMMU domain switches, things will broke).
> >=20
> > Here I'm trying to solve the above two issues.
> >=20
> > (1) is solved by patch 7, (2) is solved by patch 11-12.
> >=20
> > Basically it contains the following:
> >=20
> > patch 1:    picked up from Jason's vhost DMAR series, which is a bugf=
ix
> >=20
> > patch 2-6:  Cleanups/Enhancements for existing vt-d codes (please see
> >             specific commit message for details, there are patches
> >             that I thought may be suitable for 2.8 as well, but looks
> >             like it's too late)
> >=20
> > patch 7:    Solve the issue that vfio is notified more than once for
> >             IOTLB notifications with Aviv's patches
> >=20
> > patch 8-10: Some trivial memory APIs added for further patches, and
> >             add customize replay() support for MemoryRegion (I see
> >             Aviv's latest v7 contains similar replay, I can rebase
> >             onto that, merely the same thing)
> >=20
> > patch 11:   Provide a valid vt-d replay() callback, using page walk
> >=20
> Peter,
> Does your patch set based on Aviv's patch=EF=BC=9F I found the page can=
not be
> applied in my side.

Hi, Yi,

This series is based on Aviv's v6 series. If you wanna try it, you may
want to fetch the tree from:

 https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement

So you won't need to bother on the applying.

>=20
> BTW. it may be better if you can split the patches for mis cleanup
> and the patches for replay/"fix duplicate notify".

Yes. Here I just want to make sure things are stick together (e.g., to
test the replay, I will need to use the traces). And I feel it awkward
to maintain several series upstream while they interact with each
other. Sorry for the troublesome.

Thanks,

-- peterx
