Received: from eggs.gnu.org ([2001:4830:134:3::10]:43946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cF4rN-0001ge-6k
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cF4rJ-0000oO-CM
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:00:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cF4rJ-0000o1-7j
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:00:01 -0500
Date: Thu, 8 Dec 2016 19:59:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161208195955.GG2054@work-vm>
References: <CAC2QTZa8paD4kaY+fWqwWiAu9NKsCTZr9-=Ldn78HPHAUE1ZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZa8paD4kaY+fWqwWiAu9NKsCTZr9-=Ldn78HPHAUE1ZSA@mail.gmail.com>
Subject: Re: [Qemu-devel] migration: Introduce a new "--only-migratable"
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Hi Dave,
> 
> I have added the compatibility of this option for both command line
> and hotplug via qmp and hmp. Although, please confirm that making use
> of "device_add" is the only way of hotplugging devices into a QEMU
> instance.

Hmm; there's obsolete commands like usb_add and netdev_add as well.

> With this sorted out, there is one special case left where the device
> dynamically declares itself 'unmigratable' via migrate_add_blocker. I
> have a query regarding that which is, what is the preferred action in
> this scenario? Should I unmount the device or restrict the device from
> becoming unmigratable in the first place.
> For example, restrict 9pfs from mounting the filesystem (which you
> explained previously).
> 
> Or is there a completely different solution in your mind?

My preferred solution is to stop the device getting into the unmigratable
state; so whatever function tries to set it should fail (nicely) and
give an error - e.g the 9pfs should refuse to mount.  I'm not sure
how hard that is.

Dave

> Thanks
> Ashijeet
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
