Received: from eggs.gnu.org ([2001:4830:134:3::10]:35790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIYLh-00045Y-4P
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIYLg-00010j-8D
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:14:49 -0400
Date: Fri, 2 Nov 2018 13:14:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181102121430.GF7521@dhcp-200-186.str.redhat.com>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<152b8d37c7d54de687f4ced536ba6a10@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152b8d37c7d54de687f4ced536ba6a10@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] xen_disk qdevification (was: [PATCH 0/3]
 Performance improvements for xen_disk v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: Tim Smith <tim.smith@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

Am 02.11.2018 um 12:13 hat Paul Durrant geschrieben:
> > -----Original Message-----
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Sent: 02 November 2018 11:04
> > To: Tim Smith <tim.smith@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; qemu-
> > block@nongnu.org; Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
> > <Paul.Durrant@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>;
> > Max Reitz <mreitz@redhat.com>; armbru@redhat.com
> > Subject: xen_disk qdevification (was: [PATCH 0/3] Performance improvements
> > for xen_disk v2)
> > 
> > Am 02.11.2018 um 11:00 hat Tim Smith geschrieben:
> > > A series of performance improvements for disks using the Xen PV ring.
> > >
> > > These have had fairly extensive testing.
> > >
> > > The batching and latency improvements together boost the throughput
> > > of small reads and writes by two to six percent (measured using fio
> > > in the guest)
> > >
> > > Avoiding repeated calls to posix_memalign() reduced the dirty heap
> > > from 25MB to 5MB in the case of a single datapath process while also
> > > improving performance.
> > >
> > > v2 removes some checkpatch complaints and fixes the CCs
> > 
> > Completely unrelated, but since you're the first person touching
> > xen_disk in a while, you're my victim:
> > 
> > At KVM Forum we discussed sending a patch to deprecate xen_disk because
> > after all those years, it still hasn't been converted to qdev. Markus is
> > currently fixing some other not yet qdevified block device, but after
> > that xen_disk will be the only one left.
> > 
> > A while ago, a downstream patch review found out that there are some QMP
> > commands that would immediately crash if a xen_disk device were present
> > because of the lacking qdevification. This is not the code quality
> > standard I envision for QEMU. It's time for non-qdev devices to go.
> > 
> > So if you guys are still interested in the device, could someone please
> > finally look into converting it?
> 
> I have a patch series to do exactly this. It's somewhat involved as I
> need to convert the whole PV backend infrastructure. I will try to
> rebase and clean up my series a.s.a.p.

Thanks a lot, Paul! This is good news.

Kevin
