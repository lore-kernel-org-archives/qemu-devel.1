Received: from eggs.gnu.org ([2001:4830:134:3::10]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0jKH-00039J-9D
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0jKD-0001dT-Dv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:47:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0jKD-0001dB-9A
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:47:21 -0400
Date: Tue, 27 Mar 2018 15:47:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327074708.GL17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-5-xiaoguangrong@tencent.com>
	<20180315113759.GD3062@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315113759.GD3062@work-vm>
Subject: Re: [Qemu-devel] [PATCH 4/8] migration: introduce
 control_save_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: guangrong.xiao@gmail.com, quintela@redhat.com, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, Mar 15, 2018 at 11:37:59AM +0000, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > Abstract the common function control_save_page() to cleanup the code,
> > no logic is changed
> > 
> > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> It would be good to find a better name for control_save_page, but I
> can't think of one!).

Yeah.  I would prefer it's at least still prefixed with ram_*, however
I don't really hope we spend too much time on namings (always :).

Maybe we can just squash the changes into current
ram_control_save_page() directly.  But that's optional, current patch
is good to me already, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
