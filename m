Received: from eggs.gnu.org ([2001:4830:134:3::10]:42652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT4Eb-0007jR-H7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT4EX-00082V-Hb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dT4EX-00082K-8P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:42:05 -0400
Date: Thu, 6 Jul 2017 11:41:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170706104156.GI3988@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<20170705110757.GF22008@redhat.com>
	<20170706103043.GJ30447@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170706103043.GJ30447@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>

On Thu, Jul 06, 2017 at 11:30:43AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 05, 2017 at 12:07:57PM +0100, Daniel P. Berrange wrote:
> > On Wed, Jul 05, 2017 at 10:14:23AM +0200, Thomas Huth wrote:
> > >  Hi,
> > > 
> > > On 05.07.2017 08:57, Chao Peng wrote:
> > > > 
> > > > Q35 has been in QEMU for quite a while. Compared to the current default
> > > > i440FX, Q35 is probably not that mature and not widely used, however in
> > > > some case, Q35 has advantages, for example, in supporting new features.
> > > > For instance, we have some features require PCI-e support which is only
> > > > available on Q35 and some others need it for EFI support. It is of
> > > > course not necessary to change it as the default but if more and more
> > > > features have dependencies on Q35 because of requiring much more modern
> > > > features then I think it may be worth to do so. In such case we can have
> > > > more people to use it and find problems we may know or not know.
> > > 
> > > Yes, IMHO at one point in time, we should switch the default machine
> > > type to q35. The i440FX is really quite old...
> > > 
> > > > There are certainly some drawbacks:
> > > > -        Compatibility: current code or script may need adjustment
> > > 
> > > That might be a real concern ... so I think a good point in time to
> > > switch to the q35 machine type would be when we switch to the next major
> > > version number of QEMU, i.e. when we switch to version 3.0. If the users
> > > see a new major version number, they might be more willing to accept
> > > such major changes (yeah, I know, we've discussed in the past that
> > > version numbers are just numbers ... but still, there is some kind of
> > > psychological aspect to this, too, I think)
> > 
> > Most users aren't even aware of version numbers of QEMU - they'll just
> > take whatever their distro has provided run it. The notion that their
> > latest distro version happened to pull in a "major" version instead of
> > previously pulling in a "minor" version is invisible to everyone,
> > except the minority of people who care about the low level details.
> 
> When user-visible changes break existing setups it's common for
> packagers to ship a new family of packages that includes the major
> version number (e.g. apache2, postgresql-9.6).
> 
> The last QEMU 2.x version would be considered stable and still available
> from package repos.  Only critical bug and security fixes could be
> released for another, say, 2 years.
> 
> This way users don't have to migrate to QEMU 3.x until they are ready.

Given the number of security vulnerabilities packagers have to deal with
for QEMU, maintaining multiple QEMU streams in parallel is a pretty
major undertaking. I can't say that would be appealing from a Fedora
maintainer POV - it'd likely just end up shipping only the newest version
to avoid that extra maint burden. I doubt enterprise distros would ship
both versions in parallel in this way [1].

Even if both versions are available, the people affected by the breakage
still need to figure out that the breakage they're seeing is caused by
the change in machine type, and that installing the old version will
fix it. This is still an unpleasant experiance IMHO. 

Regards,
Daniel

[1] RHEL does already ship 2 QEMU streams in parallel, but they are
    differentiated for other reasons, one being a feature limited
    version of the other, and not as frequently rebased.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
