Received: from eggs.gnu.org ([209.51.188.92]:39373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2tTs-0005l7-St
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2tTs-0003n6-8d
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:06:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2tTr-0003ld-Ub
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:06:48 -0400
Date: Sun, 10 Mar 2019 10:06:36 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190310080635.GA4297@lap1>
References: <20190303203345.2472-1-yuval.shaia@oracle.com>
	<20190303203345.2472-5-yuval.shaia@oracle.com>
	<87r2bh9vae.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2bh9vae.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/9] {hmp,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

> 
> [...]
> > diff --git a/hw/rdma/rdma_hmp.c b/hw/rdma/rdma_hmp.c
> > new file mode 100644
> > index 0000000000..c5814473c5
> > --- /dev/null
> > +++ b/hw/rdma/rdma_hmp.c
> > @@ -0,0 +1,30 @@
> > +/*
> > + * RDMA device: Human Monitor interface
> 
> The file name and this comment are a bit akward.  Yes, you create
> TYPE_RDMA_STATS_PROVIDER for use in HMP info rdma, but there's
> absolutely nothing HMP-related in this file.  Same for rdma_hmp.h below.
> 
> Call them rdma_stats.c and rdma_stats.h?

Renamed to rdma.h and rdma.c, wo knows what other things might be added in
the future.

> 
> > + *
> > + * Copyright (C) 2018 Oracle
> > + * Copyright (C) 2018 Red Hat Inc
> > + *
> > + * Authors:
> > + *     Yuval Shaia <yuval.shaia@oracle.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/rdma/rdma_hmp.h"
> > +#include "qemu/module.h"
> > +
> > +static const TypeInfo rdma_hmp_info = {
> > +    .name = TYPE_RDMA_STATS_PROVIDER,
> > +    .parent = TYPE_INTERFACE,
> > +    .class_size = sizeof(RdmaStatsProviderClass),
> > +};
> > +
> > +static void rdma_hmp_register_types(void)
> > +{
> > +    type_register_static(&rdma_hmp_info);
> > +}
> > +
> > +type_init(rdma_hmp_register_types)
> 
> Also rename _hmp_ to _stats_.

Ditto.

> 
