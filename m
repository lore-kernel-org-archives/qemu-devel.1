Received: from eggs.gnu.org ([2001:4830:134:3::10]:60066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvIKF-0006na-1N
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvIKB-00040O-3c
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dvIKA-0003zw-Tc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:24:35 -0400
Date: Fri, 22 Sep 2017 09:24:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170922092426.53ca16ca.cohuck@redhat.com>
In-Reply-To: <31127d34-b117-59ec-ee8d-c4a7f8324173@de.ibm.com>
References: <20170921151446.40015-1-borntraeger@de.ibm.com>
	<20170921151446.40015-2-borntraeger@de.ibm.com>
	<20170921172142.1052a887.cohuck@redhat.com>
	<150601262807.14100.4805165453968988313@sif>
	<150602559136.14100.15716317748570889468@sif>
	<31127d34-b117-59ec-ee8d-c4a7f8324173@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/ais: for 2.10 stable: disable
 ais facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Sep 2017 08:47:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/21/2017 10:26 PM, Michael Roth wrote:
> > Quoting Michael Roth (2017-09-21 11:50:28)  
> >> Quoting Cornelia Huck (2017-09-21 10:21:42)  
> >>> On Thu, 21 Sep 2017 17:14:46 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>  
> >>>> The migration interface for ais was introduced with kernel 4.13
> >>>> but the capability itself had been active since 4.12. As migration
> >>>> support is considered necessary lets disable ais in the 2.10
> >>>> stable version. A proper fix and re-enablement will be done
> >>>> for qemu 2.11.  
> >>>
> >>> Also now with qemu-devel on cc:
> >>>
> >>> So, should I apply to s390-next? Or can this be applied just to stable?  
> >>
> >> Ideally we would get it in master or at least a branch that'll
> >> eventually get pulled so we can reference the upstream commit ID.
> >> It's not set in stone, but usually only patches specifically ported
> >> to stable are applied directly.  
> > 
> > Somehow I missed the "for 2.10 stable" in the subject line. I can apply
> > this directly if it comes to that, but it seems safer to apply this
> > upstream as well in the meantime, IMO. If the proper fix didn't make
> > 2.11 for whatever reason we'd still be okay with 2.10.1<->2.11, for
> > instance.
> >   
> 
> So what about the following. We will schedule this disable patch also for
> current master. Whenever we have a proper fix we can then revert/fixup the
> disable patch. This patch will then be backported to 2.10.1
> For 2.11 we then fixup the ais code and also add the "disable ais for compat
> machines" patch.

Sounds good. I'll queue this one and send a pull request, just to be on
the safe side.
