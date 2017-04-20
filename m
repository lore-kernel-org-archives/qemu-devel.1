Received: from eggs.gnu.org ([2001:4830:134:3::10]:34767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1DFE-00021N-Ol
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1DFD-0002XB-OS
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:39:40 -0400
Date: Thu, 20 Apr 2017 15:39:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170420143917.GG3227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
	<1492614962-20946-4-git-send-email-kwolf@redhat.com>
	<20170420141827.GN24486@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420141827.GN24486@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Test postcopy
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, lvivier@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

On Thu, Apr 20, 2017 at 10:18:27PM +0800, Fam Zheng wrote:
> On Wed, 04/19 17:16, Kevin Wolf wrote:
> > +_supported_fmt generic
> 
> This doesn't work for formats that install migration blockers, so maybe
> s/generic/raw qcow2/ instead?

It would be nice to use a more feature driven check and centralize
knowledge of which formats are migratable. eg define a
"_migratable_fmt" function in common.rc that checks a MIGRATABLE_FMT
env variable, and in 'common' where we process the command line args,
set MIGRATABLE_FMT for each format or protocol as needed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
