Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfuQm-00034d-TZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cfuQj-00019E-JK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:19:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cfuQj-00018y-DU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:19:29 -0500
Date: Mon, 20 Feb 2017 20:19:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170220201923.GM2372@work-vm>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com, mst@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> >> CC Dave
> > 
> > This isn't an area I really understand; but if I'm
> > reading this right then 
> >    vmgenid is stored in fw_cfg?
> >    fw_cfg isn't migrated
> > 
> > So why should any changes to it get migrated, except if it's already
> > been read by the guest (and if the guest reads it again aftwards what's
> > it expected to read?)
> 
> Why are we expecting it to change on migration?  You want a new value

I'm not; I was asking why a change made prior to migration would be
preserved across migration.


> when you load state from disk (you don't know how many times the same
> state has been loaded previously, so each load is effectively forking
> the VM and you want a different value), but for a single live migration,
> you aren't forking the VM and don't need a new generation ID.
> 
> I guess it all boils down to what command line you're using: if libvirt
> is driving a live migration, it will request the same UUID in the
> command line of the destination as what is on the source; while if
> libvirt is loading from a [managed]save to restore state from a file, it
> will either request a new UUID directly or request auto to let qemu
> generate the new id.

Hmm now I've lost it a bit; I thought we would preserve the value
transmitted from the source, not the value on the command line of the destination.

Dave

> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
