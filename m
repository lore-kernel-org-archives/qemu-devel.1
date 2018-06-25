Received: from eggs.gnu.org ([2001:4830:134:3::10]:53450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXNQU-0003AW-RY
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXNQT-0002SF-Sp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:04:46 -0400
Date: Mon, 25 Jun 2018 10:04:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625090433.GA18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<20180625071610.GH16514@angien.pipo.sk>
	<f34a06e6-2487-e7dd-1393-cb8d82e0bfb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f34a06e6-2487-e7dd-1393-cb8d82e0bfb5@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, Jun 25, 2018 at 10:23:03AM +0200, Thomas Huth wrote:
> On 25.06.2018 09:16, Peter Krempa wrote:
> > On Fri, Jun 22, 2018 at 14:55:02 +0200, Kevin Wolf wrote:
> >> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> >>>
> >>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> >>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
> >>>> remove it.
> >>>>
> >>>> Tests need to be updated to set the serial number with -global instead
> >>>> of using the -drive option.
> [...]
> >>> So it seems that this breaks s390x.
> >>
> >> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
> >> released.
> > 
> > So, I already extracted the code that formats the attributes which
> > should be actually done for the frontend few months ago, but did not
> > swithc to it since I did not want to check when everything was added.
> > 
> > The fix will be rather simple if we are certain that the disk serial,
> > geometry and error policies were supported in qemu 1.5. In that case we
> > can switch unconditionally to the new format.
> 
> The CHS device properties are available since QEMU v1.2:
> - IDE: https://git.qemu.org/?p=qemu.git;a=commitdiff;h=ba801960
> - SCSI: https://git.qemu.org/?p=qemu.git;a=commitdiff;h=d252df48
> - virtio-blk: https://git.qemu.org/?p=qemu.git;a=commitdiff;h=e63e7fde2
> 
> The "serial" property and the PCI "addr" property are also available
> since 2012 at least, I didn't fully track their origins, but QEMU v1.2
> already supported them.
> 
> So yes, all these properties should be available in QEMU 1.5 already.

The werror/rerror attributes were not added until 2.7.0, so we still
need a capabilities check for them

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
