Received: from eggs.gnu.org ([2001:4830:134:3::10]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKGF-0004Gb-Aj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKGB-0006e2-4g
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVKGA-0006dK-RB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:13:07 -0400
Date: Wed, 12 Jul 2017 17:12:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170712161254.GJ5237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 06:00:46PM +0200, Thomas Huth wrote:
> On 12.07.2017 17:04, Daniel P. Berrange wrote:
> > On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
> >> We don't want to carry along old machine types forever. If we are able to
> >> remove the pc machines up to 0.13 one day for example, this would allow
> >> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> >> BARs directly to low memory). Everything up to pc-1.2 is also known to
> >> have issues with migration.  So let's start with a deprecation message
> >> for the old machine types so that the (hopefully) few users of these old
> >> systems start switching over to newer machine types instead.
> > 
> > I think we must document & agree on our support policy for machine
> > types, before we start marking them as deprecated. eg please consider
> > the following document before accepting this deprecation patch:
> > 
> >  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00652.html
> > 
> > Note in that proposal there, I say we do *not* go through trouble of
> > explicitly marking machines as deprecated. We just document upfront
> > the intended lifecycle and then delete them when it is done.
> > 
> > Just use deprecation warnings for things where there is no predictable
> > lifecycle upfront.
> 
> I'm still not 100% sure whether that auto-deprecation of machine types
> is such a good idea ... since we might need to maintain machines in
> downstream a little bit longer than specified there, it might be better
> to rather deprecate them manually from time to time.

Downstreams usually maintain custom machine types, so fact that the
upstream machine types get deleted is not a problem in itself. The problem
comes if followup internal code removal then prevents downstream from
creating their custom machine type.  I don't think we need tie these
issues together. We can remove old machine types, without immediately
removing features that our harm creation of downstream machine types.

> Anyway, concerning my patch - I'll stop here and won't send another
> version. There is too much bikeshed painting going on in this area for
> my taste, and since I'm rather a powerpc / s390x guy, I'm also fine if
> the pc-0.x machines stay around forever. If somebody else wants to push
> this topic instead, feel free to do so.

FWIW, I think your proposals have been very useful in general. It has
been way overdue to have this kind of discussion. I just want us to
focus on defining a policy, rather than making adhoc decisions each
time around, as the later is rather unpredictable for users of qemu.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
