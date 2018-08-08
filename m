Received: from eggs.gnu.org ([2001:4830:134:3::10]:38647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnK7S-00016N-24
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnK7P-0001AO-0f
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:47:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnK7O-00019u-RG
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:46:58 -0400
Date: Wed, 8 Aug 2018 16:46:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808084647.GA5772@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-9-xiaoguangrong@tencent.com>
	<20180808050846.GG24415@xz-mi>
	<503d7733-e2e7-09c5-75a3-1e250f549065@gmail.com>
	<20180808065619.GK24415@xz-mi>
	<4c3ebdce-8c4e-8cb4-4dfe-384489224343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c3ebdce-8c4e-8cb4-4dfe-384489224343@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/10] migration: handle the error
 condition properly
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

On Wed, Aug 08, 2018 at 03:23:22PM +0800, Xiao Guangrong wrote:
> 
> 
> On 08/08/2018 02:56 PM, Peter Xu wrote:
> > On Wed, Aug 08, 2018 at 02:29:52PM +0800, Xiao Guangrong wrote:
> > > 
> > > 
> > > On 08/08/2018 01:08 PM, Peter Xu wrote:
> > > > On Tue, Aug 07, 2018 at 05:12:07PM +0800, guangrong.xiao@gmail.com wrote:
> > > > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > > > 
> > > > > ram_find_and_save_block() can return negative if any error hanppens,
> > > > > however, it is completely ignored in current code
> > > > 
> > > > Could you hint me where we'll return an error?
> > > > 
> > > 
> > > I think control_save_page() may return a error condition but i am not
> > > good at it ... Other places look safe _currently_. These functions were
> > > designed to have error returned anyway.
> > 
> > Ah, the RDMA codes...
> > 
> > Then I feel like this patch would be more suitable to be put into some
> > of the RDMA series - at least we'd better be clear about what errors
> > we're going to capture.  For non-RDMA, it seems a bit helpless after
> > all - AFAIU we're depending on the few qemu_file_get_error() calls to
> > detect output errors.
> 
> So, are you talking about to modify the semantic of these functions,
> ram_save_host_page(), ram_save_target_page(), etc, and make them
> be:
> "Returns the number of pages written where zero means no dirty pages,
> error conditions are indicated in the QEMUFile @rs->file if it
> happened."
> 
> If it's what you want, i will update the comments and make the
> implementation more clear to reflect this fact for these
> functions

Not really; I am just unclear about how this patch could help current
code, however I have no objection on the content.  Let's see whether
Dave or Juan would like it.

Thanks,

-- 
Peter Xu
