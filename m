Received: from eggs.gnu.org ([2001:4830:134:3::10]:41274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1emo1s-0000Vd-Ir
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1emo1r-0008M8-VV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:58:52 -0500
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:43244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1emo1r-0008M2-MV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:58:51 -0500
Date: Fri, 16 Feb 2018 13:58:48 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20180216215848.GB32655@bombadil.infradead.org>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
	<1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
	<CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
	<20180216183032.GA7439@bombadil.infradead.org>
	<CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v21 1/5] xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, david@redhat.com, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Fri, Feb 16, 2018 at 11:45:51PM +0200, Andy Shevchenko wrote:
> Now, the question about test case. Why do you heavily use BUG_ON?
> Isn't resulting statistics enough?

No.  If any of those tests fail, we want to stop dead.  They'll lead to
horrendous bugs throughout the kernel if they're wrong.  I think more of
the in-kernel test suite should stop dead instead of printing a warning.
Would you want to boot a machine which has a known bug in the page cache,
for example?
