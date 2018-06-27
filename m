Received: from eggs.gnu.org ([2001:4830:134:3::10]:52726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYAEI-0005PK-7Z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYAEE-0001Fl-W2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYAEE-0001FA-R8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:22 -0400
Date: Wed, 27 Jun 2018 14:11:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180627131117.GL30628@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<87fu18jsav.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu18jsav.fsf@secure.laptop>
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Martin Schrodt <martin@schrodt.org>, Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Jun 27, 2018 at 03:02:48PM +0200, Juan Quintela wrote:
> Markus Armbruster <armbru@redhat.com> wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> >
> >> On 27.06.2018 08:51, Gerd Hoffmann wrote:
> > [...]
> >>> Drop support for 32bit hosts in qemu?
> >>
> >> I guess the only way to answer that question reliably is to send a patch
> >> to mark 32-bit hosts as deprecated...
> >>
> >> Anyway, you still have got to fix that problem with -m32 now somehow
> >> since we certainly can not drop 32-bit immediately.
> >
> > We certainly can if we want to.
> >
> > Our formal deprecation policy codifies our compromise between the need
> > to evolve QEMU and the need of its users for stable external interfaces.
> >
> > "Compiles on host X" is also a need, but it's a different one.
> > Evidence: "Supported build platforms" has its own appendix, separate
> > from "Deprecated features".  It's mum on 32-bit hosts.
> >
> > I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
> > feature deprecation policy does not apply.
> >
> > Is QEMU still useful on 32-bit hosts?  Honest question!
> 
> At least require 32bits architectures/compilers able to use 64bit
> atomics.  That leaves us with x86 (depending on compiler).  And there
> haven't been 32bit x86 hosts since .....

....the most recent machine you bought, since the Intel ME is running
on some kind of i486-like CPU behind the back of your main CPU ;-P

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
