Received: from eggs.gnu.org ([2001:4830:134:3::10]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBzjQ-0002dM-Sv
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBzjM-0007mO-BZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:31:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBzjM-0007lq-7X
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:31:52 -0400
Date: Fri, 27 Apr 2018 17:31:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180427093135.GC13269@xz-mi>
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
	<a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

On Fri, Apr 27, 2018 at 11:15:37AM +0800, Xiao Guangrong wrote:
> 
> 
> On 04/26/2018 10:01 PM, Eric Blake wrote:
> > On 04/26/2018 04:15 AM, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > QEMU 2.13 enables strict check for compression & decompression to
> > > make the migration more robuster, that depends on the source to fix
> > 
> > s/robuster/robust/
> > 
> 
> Will fix, thank you for pointing it out.
> 
> > > the internal design which triggers the unexpected error conditions
> > 
> > 2.13 hasn't been released yet.  Why do we need a knob to explicitly turn
> > off strict checking?  Can we not instead make 2.13 automatically smart
> > enough to tell if the incoming stream is coming from an older qemu
> > (which might fail if the strict checks are enabled) vs. a newer qemu
> > (the sender gave us what we need to ensure the strict checks are
> > worthwhile)?
> > 
> 
> Really smart.
> 
> How about introduce a new command, MIG_CMD_DECOMPRESS_ERR_CHECK,
> the destination will do strict check if got this command (i.e, new
> QEMU is running on the source), otherwise, turn the check off.

Why not we just introduce a compat bit for that?  I mean something
like: 15c3850325 ("migration: move skip_section_footers",
2017-06-28).  Then we turn that check bit off for <=2.12.

Would that work?

(I would suspect that's what Eric mean too)

Regards,

-- 
Peter Xu
