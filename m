Received: from eggs.gnu.org ([2001:4830:134:3::10]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY8KK-0004MP-C5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY8KH-0002Aq-65
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fY8KG-0002AQ-Px
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:29 -0400
Date: Wed, 27 Jun 2018 12:09:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180627110923.GG30628@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu18ach6.fsf_-_@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Jun 27, 2018 at 09:57:09AM +0200, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 27.06.2018 08:51, Gerd Hoffmann wrote:
> [...]
> >> Drop support for 32bit hosts in qemu?
> >
> > I guess the only way to answer that question reliably is to send a patch
> > to mark 32-bit hosts as deprecated...
> >
> > Anyway, you still have got to fix that problem with -m32 now somehow
> > since we certainly can not drop 32-bit immediately.
> 
> We certainly can if we want to.
> 
> Our formal deprecation policy codifies our compromise between the need
> to evolve QEMU and the need of its users for stable external interfaces.
> 
> "Compiles on host X" is also a need, but it's a different one.
> Evidence: "Supported build platforms" has its own appendix, separate
> from "Deprecated features".  It's mum on 32-bit hosts.

It is silent on host architecture coverage in general in fact. It was
only really focusing on operating systems and so any arch coverage is
at best inferred from what those OS target. Fedora covers 32-bit & 64-bit
arches for example, so you could take that to imply we need to support
both in QEMU.

It is fuzzier though because while Peter has good OS coverage for his
merge testing, I don't think he has full host arch coverage for everything
that downstreams expect QEMU to build on ?

> I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
> feature deprecation policy does not apply.
> 
> Is QEMU still useful on 32-bit hosts?  Honest question!

That answer varies depending on what you're using QEMU for I think. It
could be that people see tools like qemu-img/qemu-nbd as useful even
if they don't use system emulators. And of course userspace emulators
are enough distinct use case.

IMHO as long as distros are shipping 32-bit support, it is reasonable
to assume there will be people who find QEMU useful to some degree.

Personally I don't have any need for 32-bit hosts, but clearly some
people do since otherwise distros would  have killed their 32-bit
arches already.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
