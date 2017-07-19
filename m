Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXl5p-0000f3-57
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXl5k-0001Lf-PN
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXl5k-0001L2-Iy
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:24 -0400
Date: Wed, 19 Jul 2017 11:16:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170719111617.708648c8@nial.brq.redhat.com>
In-Reply-To: <201707191648232246645@zte.com.cn>
References: <201707191648232246645@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, liu.yunh@zte.com.cn, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net, libvirt-users <libvirt-users@redhat.com>

On Wed, 19 Jul 2017 16:48:23 +0800 (CST)
<wang.yi59@zte.com.cn> wrote:

> >* wang.yi59@zte.com.cn (wang.yi59@zte.com.cn) wrote:  
> 
> 
> >> Hi Eduardo,  
> 
> >>   
> 
> >> Thank you for your reply!  
> 
> >>   
> 
> >> >On Mon, Jul 17, 2017 at 09:49:37PM -0400, Yi Wang wrote:  
> 
> >>   
> 
> >> >> Add [vcpu] index support for hmp command "info lapic", which is  
> 
> >>   
> 
> >> >> useful when debugging ipi and so on. Current behavior is not  
> 
> >>   
> 
> >> >> changed when the parameter isn't specified.  
> 
> >>   
> 
> >> >>   
> 
> >>   
> 
> >> >> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>  
> 
> >>   
> 
> >> >> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>  
> 
> >>   
> 
> >> >  
> 
> >>   
> 
> >> >We have 8 monitor commands (see below) that use the CPU set by  
> 
> >> >the "cpu" command (mon_get_cpu()) as input.  Why is "info lapic"  
> 
> >> >special?  
> 
> >>   
> 
> >> When we debugging a problem of ipi, we wanted to verify lapic info  
> 
> >> on each vCPU, but we found that we could only get vCPU 0's lapic  
> 
> >> through "info lapic", so we supposed this patch could help those  
> 
> >> who have the same problem as us.  
> 
> >  
> 
> >I think Eduardo's point is that you can already do:  
> 
> >    cpu 0  
> 
> >    info lapic  
> 
> >    cpu 1  
> 
> >    info lapic  
> 
> Yes, I get it, thank you.
> 
> The reason of the problem we met is that we use "virsh qemu-monitor-command",
> 
> so the 'cpu' command didn't work.
you can try to use qmp interface directly which supports specifying cpu for monitor commands:

qemu supports:

 -- Command: human-monitor-command

     Execute a command on the human monitor and return the output.

     Arguments:
     'command-line: string'
          the command to execute in the human monitor
     'cpu-index: int' (optional)
          The CPU to use for commands that require an implicit CPU

maybe "virsh qemu-monitor-command" can also do it, CCing libvirt list

> 
> 
> 
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
