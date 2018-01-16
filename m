Received: from eggs.gnu.org ([2001:4830:134:3::10]:47170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebZzT-0000EG-3v
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebZzQ-0008Ld-1m
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:45:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ebZzP-0008LR-Rk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:45:55 -0500
Date: Tue, 16 Jan 2018 23:45:52 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180116224552.kb2y6yeq5n3pnjqb@eukaryote>
References: <20180109070112.30806-1-vincent@bernat.im>
	<20180112184727.GJ6646@localhost.localdomain>
	<87zi5ite88.fsf@luffy.cx>
	<20180116124111.GC627@localhost.localdomain>
	<87efmqx8sl.fsf@luffy.cx>
	<20180116153300.ahsce4wkxq3mzh7o@eukaryote>
	<20180116170815.GF627@localhost.localdomain>
	<20180116174344.GI1521@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116174344.GI1521@redhat.com>
Subject: Re: [Qemu-devel] [PATCH x86-next v2] target-i386: add PCID flag to
 Westmere, Sandy Bridge and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vincent Bernat <vincent@bernat.im>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>

On Tue, Jan 16, 2018 at 05:43:44PM +0000, Daniel P. Berrange wrote:
> On Tue, Jan 16, 2018 at 03:08:15PM -0200, Eduardo Habkost wrote:
> > [CCing Daniel]

[...]

> > I still don't understand why OpenStack doesn't let users add or
> > modify elements on the domain XML.  This isn't the first time I
> > see this preventing users from fixing problems or optimizing
> > their systems.
> > 
> > Is there a summary of the reasons behind this limitation
> > somewhere?
> 
> Exposing ability to control every aspect of Libvirt XML is a non-goal of
> Nova. A great many of the features require different modelling and/or
> explicit handling by Nova to work well in the context of OpenStack's
> architecture. The domain XML is automatically generated on the fly by
> Nova based on the info it gets from various inputs, so there's nothing
> that can be editted directly to add custom elements. The only way that
> would allow modification is for Nova to send the XML it generates to
> an external plugin script and read back modified XML. Historically Nova
> did have alot of plugin points that allowed arbitrary admin hacks like
> this, but they end up being a support burden in themselves, as they
> end up being black boxes which change Nova behaviour in unpredictable
> ways. Thus Nova has actually worked to remove as many of the plugins
> as possible.
> 
> In this case there is a clear benefit to being able to add extra CPU
> features, over the base named model. It is easy for Nova to wire this
> up and it should do so as a priority.

Agreed, it has long been pending in Nova; I also recall you've
identified other use cases for it (e.g. ability to mention 1G huge pages
with the CPU flag "pdpe1gb").  So I began a quick WIP Nova change to
allow it to specify CPU feature flags.  I haven't worked out all the
details yet, and still addressing the quick comment you (DanPB) made on
IRC.

    https://review.openstack.org/#/c/534384 -- [WIP] libvirt: Allow to
    specify granular CPU feature flags

PS: Thursday and Friday I'll be a bit sporadic in my availability, but
this change is on top of my TODO list.

-- 
/kashyap
