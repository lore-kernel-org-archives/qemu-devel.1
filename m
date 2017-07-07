Received: from eggs.gnu.org ([2001:4830:134:3::10]:36928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTV1B-0002vV-Tp
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTV17-0003Mt-Tq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dTV17-0003MS-Ml
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:01 -0400
Date: Fri, 7 Jul 2017 18:17:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170707181642-mutt-send-email-mst@kernel.org>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707133949.GH10776@localhost.localdomain>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Laszlo Ersek <lersek@redhat.com>

On Fri, Jul 07, 2017 at 10:39:49AM -0300, Eduardo Habkost wrote:
> On Wed, Jul 05, 2017 at 12:32:10PM +0300, Marcel Apfelbaum wrote:
> > On 05/07/2017 11:14, Thomas Huth wrote:
> > >   Hi,
> > > 
> > 
> > Hi,
> > 
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
> > 
> > Agreed
> > 
> > > Yes, IMHO at one point in time, we should switch the default machine
> > > type to q35.
> > 
> > +1
> > 
> > > The i440FX is really quite old...
> > > 
> > > > There are certainly some drawbacks:
> > > > -        Compatibility: current code or script may need adjustment
> > > 
> > > That might be a real concern ...
> > 
> > I am not so sure about that. Developers working on upstream projects
> > should expect such changes and, for our case,
> > modifying the command line by adding "-M pc" should not be a big deal.
> 
> We could print a warning for 1 or 2 releases when users don't add
> a explicit "-M pc" or "-M q35" argument to qemu-system-x86_64,
> but:
> 
> > 
> > The upper layers should manage the defaults by themselves so
> > are not supposed to be affected.
> 
> But they would be.  libvirt uses the default machine-type from
> QEMU.

How about extending the command for supported machines with a
recommended machine type, and teaching libvirt to use that?

This way no existing users will be affected.

> 
> > [...]
> 
> -- 
> Eduardo
