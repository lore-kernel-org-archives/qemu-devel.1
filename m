Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW3XU-00018H-4B
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW3XR-0002rs-1Y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dW3XQ-0002rn-RN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:33:56 -0400
Date: Fri, 14 Jul 2017 13:33:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170714163347.GG6020@localhost.localdomain>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
	<20170712161254.GJ5237@redhat.com>
	<d3c71dc9-1286-802a-b663-7d37f97daf72@redhat.com>
	<20170712162901.GL5237@redhat.com>
	<20170714020546-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714020546-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 14, 2017 at 02:14:33AM +0300, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 05:29:01PM +0100, Daniel P. Berrange wrote:
> > Yep, I'm amenable to that POV too. It is entirely valid to say that if
> > downstream distros need to care about such ancient back-compat, then they
> > will just have to do the extra work to use git history to undelete any bits
> > they need that upstream has discarded.
> 
> Unfortunately people seem to conflate compatibility question of live
> migration and of booting images.
> 
> Live migration is a complex topic, and you always have a work
> around of restarting the VM to upgrade if it does not work.
> 
> But I don't think we can stop supporting booting old images, ever, for
> all versions that have a decent number of users, until someone develops
> a tool to upgrade machine type in XML painlessly and safely.
> 

I don't agree with this part.  It's perfectly valid to remove a
feature from a software component if nobody is willing to
maintain it.

> If we can guarantee that changing pc-0.10 to pc-1.13 will keep booting,
> then we should just alias one to another so people can stil start their
> VMs. If we can't then we really can't drop old machine types from
> booting point of view.

I don't think we can't guarantee that changing "pc-0.10" to
"pc-0.13" will keep working, just like we can't guarantee that
"pc-0.10" is still working in QEMU 2.9 the way it did in QEMU
0.10.

We try to not break stuff, but we can't really guarantee anything
on either case (keeping the old machine-types; making the old
machine-type names aliases; or deleting the old machine-types),
if we are not spending efforts testing that.  Keeping the old
machine-type names (either as real machines or as aliases) just
gives us the illusion that we didn't break anything.

-- 
Eduardo
