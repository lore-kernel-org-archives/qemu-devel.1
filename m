Received: from eggs.gnu.org ([2001:4830:134:3::10]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnbiq-0004FZ-S2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnbil-0006OM-No
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:34:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnbil-0006Ns-Im
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:34:43 -0400
Date: Thu, 9 Aug 2018 11:34:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180809033432.GA2539@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-11-xiaoguangrong@tencent.com>
	<20180808061230.GI24415@xz-mi>
	<40696b07-5663-5c6d-28a6-7d354f0e45cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40696b07-5663-5c6d-28a6-7d354f0e45cb@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/10] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Aug 09, 2018 at 11:13:17AM +0800, Xiao Guangrong wrote:
> 
> 
> On 08/08/2018 02:12 PM, Peter Xu wrote:
> > On Tue, Aug 07, 2018 at 05:12:09PM +0800, guangrong.xiao@gmail.com wrote:
> > 
> > [...]
> > 
> > > @@ -1602,6 +1614,26 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
> > >               rs->xbzrle_cache_miss_prev) / page_count;
> > >           rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> > >       }
> > > +
> > > +    if (migrate_use_compression()) {
> > > +        compression_counters.busy_rate = (double)(compression_counters.busy -
> > > +            rs->compress_thread_busy_prev) / page_count;
> > 
> > So this is related to the previous patch - I still doubt its
> > correctness if page_count is the host pages count rather than the
> > guest pages'.  Other than that the patch looks good to me.
> 
> I think i can treat it as your Reviewed-by boldly. :)

Yes, please do. :)

Regards,

-- 
Peter Xu
