Received: from eggs.gnu.org ([2001:4830:134:3::10]:55806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAAeU-0000IS-3d
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAAeO-0005eB-45
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAAeN-0005do-UL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:19:28 -0400
Date: Wed, 10 Oct 2018 10:19:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181010091922.GA2412@work-vm>
References: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
Subject: Re: [Qemu-devel] OpenBSD with VirtIO networking causes QEMU to crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: viq <vicviq@gmail.com>
Cc: qemu-devel@nongnu.org

* viq (vicviq@gmail.com) wrote:
> (please CC me as I'm not subscribed to the list)
> I verified the behaviour on two different machines, both running archlinux
> with QEMU 3.0.0 and reported it on https://bugs.archlinux.org/task/60141
> where it was suggested I bring it to the list.
> 
> So what happens: if you try to run OpenBSD with VirtIO networking enabled,
> the moment OpenBSD brings up network the QEMU process crashes. Easiest
> steps to reproduce:
> Download for example
> https://ftp.halifax.rwth-aachen.de/pub/OpenBSD/6.3/amd64/install63.iso
> Create new VM under libvirt as OpenBSD 6.3, create disk, "change options
> before installation", change disk and network types to virtio
> Proceed with installation (basically enter-enter-enter-...)
> Observe qemu crash when network is brought up.
> 
> Sorry, I don't really know how to proceed further with that.

Hi Viq,
  Do you have the full qemu command line you're using?
  Does QEMU spit out any error messages when it crashes?

Dave

> -- 
> viq
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
