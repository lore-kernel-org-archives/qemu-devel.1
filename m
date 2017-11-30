Received: from eggs.gnu.org ([2001:4830:134:3::10]:37460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1eKIwm-0008Df-Rl
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1eKIwi-0002fI-KW
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:07:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1eKIwi-0002du-Dm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:07:44 -0500
Date: Thu, 30 Nov 2017 08:07:38 +0100
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20171130070738.qxtbudfdvkool6lo@dhcp22.suse.cz>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
	<20171130005817.GA14785@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130005817.GA14785@bombadil.infradead.org>
Subject: Re: [Qemu-devel] [PATCH v18 01/10] idr: add #include <linux/bug.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, Masahiro Yamada <yamada.masahiro@socionext.com>

On Wed 29-11-17 16:58:17, Matthew Wilcox wrote:
> On Wed, Nov 29, 2017 at 09:55:17PM +0800, Wei Wang wrote:
> > The <linux/bug.h> was removed from radix-tree.h by the following commit:
> > f5bba9d11a256ad2a1c2f8e7fc6aabe6416b7890.
> > 
> > Since that commit, tools/testing/radix-tree/ couldn't pass compilation
> > due to: tools/testing/radix-tree/idr.c:17: undefined reference to
> > WARN_ON_ONCE. This patch adds the bug.h header to idr.h to solve the
> > issue.
> 
> Thanks; I sent this same patch out yesterday.
> 
> Unfortunately, you didn't cc the author of this breakage, Masahiro Yamada.
> I want to highlight that these kinds of header cleanups are risky,
> and very low reward.  I really don't want to see patches going all over
> the tree randomly touching header files.  If we've got a real problem
> to solve, then sure.  But I want to see a strong justification for any
> more header file cleanups.

I agree. It usually requires unexpected combination of config options to
uncover some nasty include dependencies. So these patches might break
build while their additional value is quite questionable.
-- 
Michal Hocko
SUSE Labs
