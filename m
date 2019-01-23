Received: from eggs.gnu.org ([209.51.188.92]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmIE3-0005PG-Ky
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmI0M-0003xE-T9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:51:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmI0M-0003uL-Mr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:51:42 -0500
Date: Wed, 23 Jan 2019 12:51:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123125111.GE5771@work-vm>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-2-xiaoguangrong@tencent.com>
	<fb4db77c-0cee-0f3b-d81a-0cc88d7f5406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4db77c-0cee-0f3b-d81a-0cc88d7f5406@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: introduce
 pages-per-second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 1/11/19 12:37 AM, guangrong.xiao@gmail.com wrote:
> > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > It introduces a new statistic, pages-per-second, as bandwidth or mbps is
> > not enough to measure the performance of posting pages out as we have
> > compression, xbzrle, which can significantly reduce the amount of the
> > data size, instead, pages-per-second is the one we want
> > 
> > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > ---
> >  hmp.c                 |  2 ++

I've queued this 1/3 and fixed these typos during the merge.

Dave

> 
> > +++ b/migration/migration.h
> > @@ -126,6 +126,12 @@ struct MigrationState
> >       */
> >      QemuSemaphore rate_limit_sem;
> >  
> > +    /* pages already send at the beggining of current interation */
> 
> beginning, iteration
> 
> > +    uint64_t iteration_initial_pages;
> > +
> > +    /* pages transferred per second */
> > +    double pages_per_second;
> > +
> >      /* bytes already send at the beggining of current interation */
> 
> although you copied the existing typos
> 
> > +++ b/qapi/migration.json
> > @@ -41,6 +41,9 @@
> >  #
> >  # @multifd-bytes: The number of bytes sent through multifd (since 3.0)
> >  #
> > +# @pages-per-second: the number of memory pages transferred per second
> > +#        (Since 3.2)
> > +#
> 
> 3.2 was last year; you'll need to update your series to use 4.0 on all
> new stuff
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
