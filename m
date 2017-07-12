Received: from eggs.gnu.org ([2001:4830:134:3::10]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVOOg-0003pc-96
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVOOd-0003t6-5N
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVOOc-0003sF-Sx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:38:07 -0400
Date: Wed, 12 Jul 2017 17:37:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712203757.GP6020@localhost.localdomain>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
	<20170712161254.GJ5237@redhat.com>
	<d3c71dc9-1286-802a-b663-7d37f97daf72@redhat.com>
	<20170712162901.GL5237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712162901.GL5237@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 05:29:01PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 12, 2017 at 06:23:51PM +0200, Paolo Bonzini wrote:
> > On 12/07/2017 18:12, Daniel P. Berrange wrote:
> > >> I'm still not 100% sure whether that auto-deprecation of machine types
> > >> is such a good idea ... since we might need to maintain machines in
> > >> downstream a little bit longer than specified there, it might be better
> > >> to rather deprecate them manually from time to time.
> > > 
> > > Downstreams usually maintain custom machine types, so fact that the
> > > upstream machine types get deleted is not a problem in itself. The problem
> > > comes if followup internal code removal then prevents downstream from
> > > creating their custom machine type.  I don't think we need tie these
> > > issues together. We can remove old machine types, without immediately
> > > removing features that our harm creation of downstream machine types.
> > 
> > I think machine type and feature removal should be tied together.
> > 
> > Doing the opposite leaves around code that is more or less dead from an
> > upstream point of view, and looks like an ad hoc rule for Red Hat.  It
> > harms downstreams that do not participate in upstream development
> > (though perhaps this is an intended side effect?).
> 
> Yep, I'm amenable to that POV too. It is entirely valid to say that if
> downstream distros need to care about such ancient back-compat, then they
> will just have to do the extra work to use git history to undelete any bits
> they need that upstream has discarded.

If they do this, won't it be better to cooperate and let those
bits to be maintained in the upstream tree (as long as somebody
is willing to maintain them), instead of being kept in their own
downstream fork?

(That doesn't mean we shouldn't have a deprecation policy, but
that I would prefer to have the deprecation policy amended if
necessary than having a diverging fork maintained by a downstream
distro).

-- 
Eduardo
