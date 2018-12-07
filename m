Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVCq4-00033e-2l
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVCq0-0005hI-1M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:54:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gVCpz-0005dC-Pk
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:54:23 -0500
Date: Fri, 7 Dec 2018 09:54:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207095417.GF13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Dec 05, 2018 at 03:43:07PM -0500, Ed Maste wrote:
> I'd very much like to have CI coverage for QEMU on FreeBSD, and as of
> yesterday there's a hosted CI service that supports FreeBSD: Cirrus
> CI. They also offer free service for OSS projects. I created a
> .cirrus.yml (shown below) in a QEMU GitHub fork and successfully
> executed a build test.

Looking at this more generally I see they support Linux containers,
native Windows containers, macOS and FreeBSD. IOW, they offer more
platforms than our current Travis setup does and aren't stuck on an
amcient Ubuntu version.

Thus I wonder if we could in fact switch all our travis setup over to
use Cirrus CI, and stop using Travis entirely.

One key thing I can't find out is what, if any, limitations they put
on resources used by the free service for OSS projects.  Does anyone
know if they limit the number of concurrent build jobs like Travis
does ? Do they put a fixed time limit on execution of a single job ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
