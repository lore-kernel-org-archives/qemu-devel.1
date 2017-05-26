Received: from eggs.gnu.org ([2001:4830:134:3::10]:55028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELRi-0002Ev-PY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELRh-00067d-VQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:02:50 -0400
Date: Fri, 26 May 2017 22:02:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526200232.GA4340@noname.redhat.com>
References: <CADNMjEBdXZeOonsKNf9LpFKK0NFUzAth=CDaSj8q22k+o=ZEFA@mail.gmail.com>
	<539d9960-d554-032f-3e88-b2531743a0a1@redhat.com>
	<CADNMjECLPFyZp1Rm_M4KuSqnY1cp7k0T38=zmWidYvinrutFPQ@mail.gmail.com>
	<20170526114023.GI7211@noname.str.redhat.com>
	<4626709f-2af0-ae9e-089d-089c918cfe44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4626709f-2af0-ae9e-089d-089c918cfe44@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block]  Behavior of QMP "query-block"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Bruno Alvisio <bruno.alvisio@gmail.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

Am 26.05.2017 um 18:55 hat John Snow geschrieben:
> On 05/26/2017 07:40 AM, Kevin Wolf wrote:
> > There is one completely crazy thing that Xen does with respect to disks.
> > Instead of having support for their PV disks (i.e. virtio-blk, just
> > different) in the BIOS, they add _both_ an IDE disk and a PV disk to the
> > VM, so that the bootloader or non-PV-aware guest OSes can access the IDE
> > disk, for which they most certainly do have drivers. As soon as a driver
> > for the PV disk is loaded, however, that driver calls a hypervisor
> > function that removes all the IDE disks from the VM and leaves only the
> > PV ones there, so that the PV-aware guest doesn't see two same disks.
> > 
> > I suspect that what you're seeing initially is the IDE disks, and when
> > the PV driver is loaded, they disappear.
> 
> Sure, but does that mean that you'd see *no* block devices via a query
> afterwards?

I believe xen_disk creates an anonymous BlockBackend, so it wouldn't
appear in 'info block'. Though remembering that Xen does weird things is
enough for me, I don't really want to know all the details that I am
lucky enough to have forgotten. And trust me, neither do you.

Kevin
