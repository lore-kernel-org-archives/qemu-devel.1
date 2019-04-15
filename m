Received: from eggs.gnu.org ([209.51.188.92]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFyMh-0004aR-ST
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFyMh-00075k-2C
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hFyMg-00075M-Pb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:27 -0400
Date: Mon, 15 Apr 2019 10:57:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190415095719.GB2852@work-vm>
References: <20190412152652.827-1-dgilbert@redhat.com>
	<20190415094552.GC29134@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415094552.GC29134@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] hmp: gva2gpa debug command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Fri, Apr 12, 2019 at 04:26:52PM +0100, Dr. David Alan Gilbert (git) wrote:
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index d3bad2fc27..ba4690b9ac 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -585,6 +585,21 @@ STEXI
> >  @findex gpa2hpa
> >  Print the host physical address at which the guest's physical address @var{addr}
> >  is mapped.
> > +ETEXI
> > +
> > +    {
> > +        .name       = "gva2gpa",
> > +        .args_type  = "addr:l",
> > +        .params     = "addr",
> > +        .help       = "print the guest physical address corresponding to a guest virtual address",
> > +        .cmd        = hmp_gva2gpa,
> > +    },
> > +
> > +STEXI
> > +@item gpa2hpa @var{addr}
> > +@findex gpa2hpa
> 
> s/gpa2hpa/gva2gpa/

Oops, thanks!

Dave

> Aside from this:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
