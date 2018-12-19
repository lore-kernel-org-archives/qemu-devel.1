Received: from eggs.gnu.org ([2001:4830:134:3::10]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZeyR-0004yK-LC
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZeyO-0005H2-Gz
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:45:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZeyO-0005Ep-7L
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:45:28 -0500
Date: Wed, 19 Dec 2018 16:45:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181219164517.GN20465@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
	<20181219113611-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219113611-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/9] tests: apci: consolidate and cleanup
 ACPI test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Dec 19, 2018 at 11:38:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 10, 2018 at 07:10:06PM +0100, Igor Mammedov wrote:
> > While working on adding tests for virt/arm board (uefi/XSDT/64-bit table pointers),
> > I found it's rather difficult to deal with mixed ACPI testing code that we've
> > collected so far. So instead of just adding a pile of XSDT hacks on top, here
> > goes small refactoring series:
> >    * that removes dead code
> >    * replaces reading tables with a fetch per table everywhere instead of
> >      mix of field by field and whole table
> >    * consolidates the way tables are read (reduces code duplication)
> >    * test no longer depends on ACPI structures from QEMU (i.e. doesn't affected
> >      by mistakes there) 
> >    * fixiex FACS not beint compared against reference tables
> > Overall test is reduced on ~170LOC and hopefully it makes easier to add more
> > stuff on top.
> 
> So this was posted outside the merge window - do you still want
> it merged? If yes pls repost.

Huh, QEMU development does not have merge windows. Subsystem maintainers
should review patch series at any time & queue it if it is acceptable.
The freeze process only applies to maintainers sending pull requests for
merge to git mater.  Contributors shouldn't be expected to resubmit
patches in this case.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
