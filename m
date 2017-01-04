Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOoHj-0002kU-TP
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOoHg-0007wB-3z
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:19:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOoHf-0007uw-Rv
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:19:28 -0500
Date: Wed, 4 Jan 2017 16:19:21 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104161921.GH10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <376FE1EF-577A-4BE3-B398-99ACB7F280F4@gmail.com>
	<1483433944.24493.3.camel@redhat.com>
	<D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
	<1483519059.5670.42.camel@redhat.com>
	<20170104155116.GG10541@redhat.com>
	<FC181425-036D-4203-9C89-4E69D866F59F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FC181425-036D-4203-9C89-4E69D866F59F@gmail.com>
Subject: Re: [Qemu-devel] Speed menu for GTK interfaace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Wed, Jan 04, 2017 at 11:01:30AM -0500, Programmingkid wrote:
> 
> On Jan 4, 2017, at 10:51 AM, Daniel P. Berrange wrote:
> 
> > On Wed, Jan 04, 2017 at 09:37:39AM +0100, Gerd Hoffmann wrote:
> >>  Hi,
> >> 
> >>> It is quite simple, there would be a 100% to a 1% menu item. It would look like
> >>> this:
> >>> 
> >>> Speed
> >>> -------
> >>> 100%
> >>> 90%
> >>> 80%
> >>> 70%
> >>> 60%
> >>> 50%
> >>> 40%
> >>> 30%
> >>> 20%
> >>> 10%
> >>> 1%
> >>> 
> >>> 
> >>> Each menu item would call cpu_throttle_set(). The value sent to this function would
> >>> be determined like this:
> >>> speed = -1 * menu_number + 100;
> >> 
> >> ok, that is the info I was looking for.
> >> 
> >>> speed would be sent to the cpu_throttle_set() function. This function would reduce
> >>> the CPU usage of QEMU on the host. 
> >>> 
> >>> Why would someone want to slow down QEMU?
> >>> - The user is using a laptop and don't want it to heat up.
> >> 
> >> Sort-of makes sense, to keep the laptop quiet.
> >> 
> >>> - The user wants to slow down a video game that is a little too challenging.
> >> 
> >> Sure this would work?  Throttling isn't a smooth slowdown, the cpu
> >> continues to run at full speed and is forced to pause now and then.
> >> 
> >>> - The user wants to save energy.
> >> 
> >> Pointless.  Laptop may run longer, but your job needs more time to
> >> complete too.  And constant vcpu start/stop isn't good to save power,
> >> the cpus can't enter deep sleep states then because of the frequent
> >> wakeups.
> >> 
> >>> - The user wants to conduct some kind of stress test on a program and see how
> >>> it handles under low cpu resources. 
> >> 
> >> Makes sense too.
> >> 
> >> We already have "pause" in gtk, adding a "throttle" item next to it
> >> looks reasonable to me.  I don't think it is that useful to have 10%
> >> steps in there, you probably never throttle 10% in practice.  It's
> >> probably more useful to have something like "throttle -> off / 50% /
> >> 90% / 95% / 99%".
> > 
> > This feels like going down the slippery slope to turn the GTK frontend
> > into a full mgmt UI, which is something we've said we don't want todo
> > inside QEMU UI frontends. IMHO this kind of feature is best left to
> > external mgmt layers, like  virt-manager/GNOME Boxes/etc. It is already
> > possible to timebox VMs CPU execution using cgroups quotas via libvirt.
> 
> Are you saying that so we can use your Virt-manager? The thing is having more
> options is a good thing. If one solution doesn't work, another solution might.
> We don't live in a world with only one Linux distribution. We live in a world
> with many Linux distributions. We have the power of choice. There currently
> isn't a single QEMU front-end that runs on all three operating systems. Yes the
> Linux people do have Virt-manager, but what about the Windows and Macintosh
> people. They are not so fortunate. Enhancing the GTK front-end does not
> hurt any of the Virt-manager users at all. This change is just for the people
> who prefer the GTK front-end.

This is not about choice, it is about the focusing QEMU community resources
where they are most effectively applied. Turning the GTK front-end into a
fully featured mgmt UI would put a significant, ongoing burden on the QEMU
maintainers over the long term. This will taking resources away from other
areas of work in QEMU, just to duplicate features that already exist / will
exist in layers above / apps external to QEMU.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
