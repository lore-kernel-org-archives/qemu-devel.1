Received: from eggs.gnu.org ([2001:4830:134:3::10]:52258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dT4ii-0001ct-8S
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dT4if-00039Z-3f
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dT4ie-00039Q-TD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:13:13 -0400
Date: Thu, 6 Jul 2017 12:13:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170706111305.GA3174@work-vm>
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com>
	<20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
	<20170705122200.GH29382@lemon.lan>
	<20170706104940.GJ3988@redhat.com>
	<bc77d893-8489-b38d-00e5-12456321ad9b@redhat.com>
	<20170706110627.GK3988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706110627.GK3988@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Jul 06, 2017 at 01:00:53PM +0200, Thomas Huth wrote:
> > On 06.07.2017 12:49, Daniel P. Berrange wrote:
> > [...]
> > > This avoids the user having problems with guest ABI silently changing
> > > behind their back, or migration suddenly failing to load vm state,
> > 
> > For proper migration, you've got to specify the right versioned machine
> > type anyway, so that should not be an issue here.
> 
> That's only true if you have mis-matched QEMU releases on each host.
> If you know you have the same QEMU release everywhere, there's no
> need for versioned machine types. Though obviously we'd still recommend
> people us versioned machine type, its not unreasonable that some people
> will not

We have got protection against machine type screwups; e.g going from -M
pc to -M q35 we get:

qemu-system-x86_64: Machine type received is 'pc-i440fx-2.9' and local is 'pc-q35-2.9'

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
