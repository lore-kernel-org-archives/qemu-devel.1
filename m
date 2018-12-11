Received: from eggs.gnu.org ([2001:4830:134:3::10]:51525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWjZI-00071E-VA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWjZF-0006YY-6y
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:03:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWjZE-0006Xv-VM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:03:25 -0500
Date: Tue, 11 Dec 2018 15:03:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211150311.GL921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-2-git-send-email-liam.merwick@oracle.com>
	<20181211140124.GA23460@stefanha-x1.localdomain>
	<83b577e6-691e-08b3-e9e4-90651e988ff2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b577e6-691e-08b3-e9e4-90651e988ff2@oracle.com>
Subject: Re: [Qemu-devel] [RFC 1/3] pvh: Add x86/HVM direct boot ABI header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, ehabkost@redhat.com, mst@redhat.com, maran.wilson@oracle.com, qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, xen-devel@lists.xenproject.org, pbonzini@redhat.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, rth@twiddle.net, sgarzare@redhat.com

On Tue, Dec 11, 2018 at 02:57:29PM +0000, Liam Merwick wrote:
> 
> 
> On 11/12/2018 14:01, Stefan Hajnoczi wrote:
> > On Wed, Dec 05, 2018 at 10:37:24PM +0000, Liam Merwick wrote:
> > > From: Liam Merwick <Liam.Merwick@oracle.com>
> > > 
> > > The x86/HVM direct boot ABI permits Qemu to be able to boot directly
> > > into the uncompressed Linux kernel binary without the need to run firmware.
> > > 
> > > 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
> > > 
> > > This commit adds the header file that defines the start_info struct
> > > that needs to be populated in order to use this ABI.
> > > 
> > > Signed-off-by: Maran Wilson <Maran.Wilson@oracle.com>
> > > Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> > > Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
> > > ---
> > >   include/hw/xen/start_info.h | 146 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 146 insertions(+)
> > >   create mode 100644 include/hw/xen/start_info.h
> > 
> > Does it make sense to bring in Linux
> > include/xen/interface/hvm/start_info.h via QEMU's
> > include/standard-headers/?
> > 
> > QEMU has a script in scripts/update-linux-header.sh for syncing Linux
> > headers into include/standard-headers/.  This makes it easy to keep
> > Linux header files up-to-date.  We basically treat files in
> > include/standard-headers/ as auto-generated.
> > 
> > If you define start_info.h yourself without using
> > include/standard-headers/, then it won't be synced with Linux.
> > 
> 
> That does seem better.  I will make that change.
> 
> One a related note, I'm trying to fix the mingw compilation errors [1] in
> this series also.  I can fix the format issues with PRIx64, etc but I can't
> seem to find an include file to provide a declaration of mmap() et. al. -
> has this been resolved before? A pointer to something similar to investigate
> would be very welcome.

There is no mmap() on mingw, so you'll have to make sure that code is
conditionally compiled with  #ifndef WIN32 where appropriate.

> [1] http://patchew.org/logs/1544049446-6359-1-git-send-email-liam.merwick@oracle.com/testing.docker-mingw@fedora/?type=message
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
