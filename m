Received: from eggs.gnu.org ([2001:4830:134:3::10]:54660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRM2J-00023r-HQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRM2E-000408-J9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:55:11 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRM2E-000403-Ew
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:55:06 -0500
Date: Mon, 26 Nov 2018 13:55:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126185504.GB6688@flamenco>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181123110239.GC2373@work-vm>
	<e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60f648f-d475-a88b-b0c3-300f18a7d36d@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Nov 26, 2018 at 15:57:25 +0800, Xiao Guangrong wrote:
> 
> 
> On 11/23/18 7:02 PM, Dr. David Alan Gilbert wrote:
> 
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/bitmap.h"
> > > +#include "qemu/threaded-workqueue.h"
> > > +
> > > +#define SMP_CACHE_BYTES 64
> > 
> > That's architecture dependent isn't it?
> > 
> 
> Yes, it's arch dependent indeed.
> 
> I just used 64 for simplification and i think it is <= 64 on most CPU arch-es
> so that can work.
> 
> Should i introduce statically defined CACHE LINE SIZE for all arch-es? :(

No, at compile-time this is impossible to know.

We do query this info at run-time though (see util/cacheinfo.c),
but using that info here would complicate things too much.

You can just give it a different name, and perhaps add a comment.
See for instance what we do in qht.c with QHT_BUCKET_ALIGN.

Thanks,

		Emilio
