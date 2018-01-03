Received: from eggs.gnu.org ([2001:4830:134:3::10]:55598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eWgB9-0006vl-Md
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eWgB6-0005Sj-Gx
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:21:47 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:39845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eWgB6-0004R9-23
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:21:44 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>
	<5A3F5A4A.1070009@intel.com>
	<20180102132419.GB8222@bombadil.infradead.org>
	<201801031129.JFC18298.FJMHtOFLVSQOFO@I-love.SAKURA.ne.jp>
	<5A4C9BAC.3040808@intel.com>
In-Reply-To: <5A4C9BAC.3040808@intel.com>
Message-Id: <201801031918.GGJ69207.JOFSHQLMFtVOFO@I-love.SAKURA.ne.jp>
Date: Wed, 3 Jan 2018 19:19:00 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> On 01/03/2018 10:29 AM, Tetsuo Handa wrote:
> > Matthew Wilcox wrote:
> >> The radix tree convention is objectively awful, which is why I'm working
> >> to change it.  Specifying the GFP flags at radix tree initialisation time
> >> rather than allocation time leads to all kinds of confusion.  The preload
> >> API is a pretty awful workaround, and it will go away once the XArray
> >> is working correctly.  That said, there's no alternative to it without
> >> making XBitmap depend on XArray, and I don't want to hold you up there.
> >> So there's an xb_preload for the moment.
> > I'm ready to propose cvbmp shown below as an alternative to xbitmap (but
> > specialized for virtio-balloon case). Wei, can you do some benchmarking
> > between xbitmap and cvbmp?
> > ----------------------------------------
> > cvbmp: clustered values bitmap
> 
> I don't think we need to replace xbitmap, at least at this stage. The 
> new implementation doesn't look simpler at all, and virtio-balloon has 
> worked well with xbitmap.
> 
> I would suggest you to send out the new implementation for discussion 
> after this series ends, and justify with better performance results if 
> you could get.

I'm VMware Workstation Player user, and I don't have environment for doing
performance test using virtio-balloon. Thus, I need to ask you.

Also, please look at
http://lkml.kernel.org/r/1514904621-39186-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .
