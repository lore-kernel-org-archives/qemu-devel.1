Received: from eggs.gnu.org ([2001:4830:134:3::10]:57760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHX6i-0004cf-4e
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHX6c-00055f-9q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:43:08 -0400
Date: Tue, 30 Oct 2018 16:42:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181030164255.GA7305@work-vm>
References: <1490056074976-474433.post@n7.nabble.com>
	<28d15bd5-1620-b39b-ed92-d8812d1549c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d15bd5-1620-b39b-ed92-d8812d1549c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc,
 secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> [adding qemu-trivial]
> 
> On 03/20/2017 07:27 PM, wangguang wrote:
> > Subject: [PATCH] Fix Colo doc secondeary should be secondary 
> 
> This line feels redundant compared to the overall mail's subject line.
> In turn, that subject could use a space after colon.
> 
> > This is an error in COLO-FT.txt. 
> > secondeary-disk0 should be secondary-disk0. 
> > 
> > Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
> > --- 
> >  docs/COLO-FT.txt | 2 +- 
> >  1 file changed, 1 insertion(+), 1 deletion(-) 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> As it is doc-only, it is safe for hard freeze, but also not the end of
> the world if it doesn't go in until 2.10.

Manually applied and queued for migration
(ahem a little late)

Dave

> > 
> > diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt 
> > index e289be2..bec7547 100644 
> > --- a/docs/COLO-FT.txt 
> > +++ b/docs/COLO-FT.txt 
> > @@ -139,7 +139,7 @@ Secondary: 
> >  { 'execute': 'nbd-server-start', 
> >    'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx',
> > 'port': '8889'} } } 
> >  } 
> > -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0',
> > 'writable': true } } 
> > +{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0',
> > 'writable': true } } 
> >   
> >  Note: 
> >    a. The qmp command nbd-server-start and nbd-server-add must be run 
> > 
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
