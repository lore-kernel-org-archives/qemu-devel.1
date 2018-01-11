Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZjC4-0006hD-EC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZjC3-0001Bj-EM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:11:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZjC3-0001B7-86
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:11:19 -0500
Date: Thu, 11 Jan 2018 20:11:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111201114.GA16343@work-vm>
References: <20171208173321.GR2403@work-vm>
	<20180109192802.17167-1-eblake@redhat.com>
	<20180111175934.GB13384@work-vm>
	<b198a35a-b69e-37f9-8024-bc98b2e80e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b198a35a-b69e-37f9-8024-bc98b2e80e3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2.5/6] hmp: Add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com

* Eric Blake (eblake@redhat.com) wrote:
> On 01/11/2018 11:59 AM, Dr. David Alan Gilbert wrote:
> > * Eric Blake (eblake@redhat.com) wrote:
> >> Extend the flexibility of the previous QMP patch to also work
> >> in HMP.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > Thanks, that looks good to me from the HMP side; let me
> > know which way you want to take it; I can take it via
> > HMP once the code that uses it is in; whichever is easiest.
> > 
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> I'll take it through the NBD tree, along with the rest of the series,
> once I get more answers on my open questions on the second half of the
> series.

Sure.

> > 
> >> ---
> >>
> >> In response to Dave's request.
> >> I could also squash this into Vladimir's 2/6 if desired.
> 
> At this point, I'm thinking it's better to leave it separate from
> Vladimir's QMP patch, since you've only reviewed this one.

Feel free to do either way.

Dave

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
