Received: from eggs.gnu.org ([2001:4830:134:3::10]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGyzZ-0004qL-AR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eGyzV-0004M4-EE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:12:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:54210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eGyzV-0004KV-5k
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 22:12:53 -0500
Date: Tue, 21 Nov 2017 11:12:08 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171121031208.GA8063@yangzhon-Virtual>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
	<20171120142828.GB6828@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120142828.GB6828@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, anthony.xu@intel.com, stefanha@redhat.com, zhang.zhanghailiang@huawei.com, yang.zhong@intel.com

On Mon, Nov 20, 2017 at 10:28:28PM +0800, Fam Zheng wrote:
> On Fri, 11/17 14:23, Yang Zhong wrote:
> > diff --git a/util/rcu.c b/util/rcu.c
> > index ca5a63e..8d491a6 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -26,6 +26,7 @@
> >   * IBM's contributions to this file may be relicensed under LGPLv2 or later.
> >   */
> >  
> > +#include <malloc.h>
> 
> BTW, if you respin, the "qemu/osdep.h" header should always be included first as
> per HACKING file.

  Hello Fam,

  Thanks for your reminder!
  I ever thought the header file include in Qemu like linux kernel did, thanks again!

  Regards,

  Yang
