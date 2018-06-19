Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVNTs-0003DN-67
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVNTp-000492-L2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:44:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVNTp-00048n-GK
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:43:57 -0400
Date: Tue, 19 Jun 2018 23:43:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180619233509-mutt-send-email-mst@kernel.org>
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Tue, Jun 19, 2018 at 05:17:45PM +0200, Paolo Bonzini wrote:
> On 16/06/2018 00:29, Michael S. Tsirkin wrote:
> >  
> > +static QemuOptsList qemu_dedicated_opts = {
> > +    .name = "dedicated",
> > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_dedicated_opts.head),
> > +    .desc = {
> > +        {
> > +            .name = "mem-lock",
> > +            .type = QEMU_OPT_BOOL,
> > +        },
> > +        {
> > +            .name = "cpu-pm",
> > +            .type = QEMU_OPT_BOOL,
> > +        },
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
> 
> Let the bikeshedding begin!
> 
> 1) Should we deprecate -realtime?

Can be a patch on top, by whoever cares.

> 2) Maybe -hostresource?
> 
> Paolo

Is ability to cause high latency for other threads really a resource?

The issues in question:
1. a malicious guest can cause high latency for others sharing the host cpu.
2. to host scheduler cpu looks busier than it really is.

All are avoided if you use a dedicated host cpu, and 2 will
help scheduler get closer to giving you one.


-- 
MST
