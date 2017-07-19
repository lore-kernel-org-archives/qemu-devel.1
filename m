Received: from eggs.gnu.org ([2001:4830:134:3::10]:51790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXk47-00019o-S7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXk44-0003Rk-DO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXk44-0003Rb-6N
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:10:36 -0400
Date: Wed, 19 Jul 2017 09:10:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170719081028.GA2103@work-vm>
References: <201707191247531805742@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201707191247531805742@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yi59@zte.com.cn
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

* wang.yi59@zte.com.cn (wang.yi59@zte.com.cn) wrote:
> Hi Eduardo,
> 
> Thank you for your reply!
> 
> >On Mon, Jul 17, 2017 at 09:49:37PM -0400, Yi Wang wrote:
> 
> >> Add [vcpu] index support for hmp command "info lapic", which is
> 
> >> useful when debugging ipi and so on. Current behavior is not
> 
> >> changed when the parameter isn't specified.
> 
> >> 
> 
> >> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> 
> >> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> 
> >
> 
> >We have 8 monitor commands (see below) that use the CPU set by
> >the "cpu" command (mon_get_cpu()) as input.  Why is "info lapic"
> >special?
> 
> When we debugging a problem of ipi, we wanted to verify lapic info
> on each vCPU, but we found that we could only get vCPU 0's lapic
> through "info lapic", so we supposed this patch could help those
> who have the same problem as us.

I think Eduardo's point is that you can already do:
    cpu 0
    info lapic
    cpu 1
    info lapic

Dave
> 
> 
> 
> 
> >
> 
> >* info cpustats
> 
> >* info lapic
> 
> >* info mem
> 
> >* info registers
> 
> >* info tlb
> 
> >* x
> 
> >* memsave
> 
> >* inject-nmi (QMP)
> 
> Monitor command "info registers" already have "-a" parameter to
> 
> show all vCPU's info. -)
> 
> May I send some new patches for the other monitor commands, which may
> 
> be helpful for analyzing multiple cpu problems?
> 
> 
> 
> 
> 
> ---
> 
> Best wishes
> 
> Yi Wang


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
