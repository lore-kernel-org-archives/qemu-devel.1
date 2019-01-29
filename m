Received: from eggs.gnu.org ([209.51.188.92]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRYK-0004M6-0s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRYH-0004iY-8q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:27:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goRY8-0004fr-EL
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:27:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33CC9D4E72
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:27:27 +0000 (UTC)
Date: Tue, 29 Jan 2019 11:27:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190129112720.GC2650@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-2-dgilbert@redhat.com>
	<5e2fce30-a0da-33d2-ed34-a963e4464b1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2fce30-a0da-33d2-ed34-a963e4464b1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] net: Introduce announce timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > The 'announce timer' will be used by migration, and explicit
> > requests for qemu to perform network announces.
> > 
> > Based on the work by Germano Veit Michel <germano@redhat.com>
> >  and Vlad Yasevich <vyasevic@redhat.com>
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> > +++ b/qapi/net.json
> > @@ -684,3 +684,26 @@
> >  ##
> >  { 'event': 'NIC_RX_FILTER_CHANGED',
> >    'data': { '*name': 'str', 'path': 'str' } }
> > +
> > +##
> > +# @AnnounceParameters:
> > +#
> > +# Parameters for self-announce timers
> > +#
> > +# @initial: Initial delay (in ms) before sending the first GARP/RARP
> > +#       announcement
> > +#
> > +# @max: Maximum delay (in ms) to between GARP/RARP announcement packets
> 
> "to between" should be either "to use in between" or merely "between"

I've changed it to the plain 'between'.

> > +#
> > +# @rounds: Number of self-announcement attempts
> > +#
> > +# @step: Delay increase (in ms) after each self-announcement attempt
> > +#
> > +# Since: 4.0
> > +##
> > +
> > +{ 'struct': 'AnnounceParameters',
> > +  'data': { 'initial': 'int',
> > +            'max': 'int',
> > +            'rounds': 'int',
> > +            'step': 'int' } }
> > 
> 
> Can/should any of the parameters be optional with a sane (documented)
> default?

I think last time Dan was arguing for it to be explicit, the only
default we could pick are the values we currently use, which I think are
only defendable as 'seem to have worked well so far'.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
