Received: from eggs.gnu.org ([2001:4830:134:3::10]:51959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfMq-0007C7-D6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfMl-0000lg-NL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWfMl-0000lJ-Hf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:34:15 -0500
Date: Tue, 11 Dec 2018 10:34:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181211103407.GF2734@work-vm>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181210173151.16629-8-dgilbert@redhat.com>
	<a893ff17-9bfe-b541-75c9-6d4bd34176db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a893ff17-9bfe-b541-75c9-6d4bd34176db@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 7/7] virtio-fs: Allow mapping of journal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

* Eric Blake (eblake@redhat.com) wrote:
> On 12/10/18 11:31 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > The 'journal' is a shared block of RAM between QEMU and it's
> 
> s/it's/its/ (here, you want possessive)

Fixed.

Dave

> > fuse daemon.  It's typically a shmfs file and it's specified as:
> 
> whereas here, both uses of "it's" are correct as contractions for "it is"
> (although I might use just "is" instead of "it's" for that last instance).
> 
> > 
> > -device
> > vhost-user-fs-pci,chardev=char0,tag=myfs,cache-size=1G,versiontable=/dev/shm/mdvt1,journal=/dev/shm/journal1
> > 
> > It gets mapped into the PCI bar after the version table.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
