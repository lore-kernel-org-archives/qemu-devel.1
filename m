Received: from eggs.gnu.org ([2001:4830:134:3::10]:42118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0G2M-0006Ty-HZ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 19:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0G2H-0003eP-PS
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 19:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0G2H-0003dW-HA
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 19:26:21 -0400
Date: Mon, 17 Apr 2017 20:26:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170417232617.GB7078@thinpad.lan.raisama.net>
References: <20170329183017.14026-1-git@kirschju.re>
	<f3547873-feaa-0d77-abb7-79140bd74cdb@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3547873-feaa-0d77-abb7-79140bd74cdb@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Apr 04, 2017 at 11:33:33AM +0200, Julian Kirsch wrote:
> ping
> 
> I kindly request your comments.

Hi Julian,

Sorry for taking so long to reply.

I can't find the original series on either qemu-devel archives,
or on my own mail archive.

Searching for the Message-Id you were replying to, I can't find
any matches:
https://www.mail-archive.com/search?l=mid&q=20170329183017.14026-1-git%40kirschju.re

Can you resend?

> 
> On 29.03.2017 20:30, Julian Kirsch wrote:
> > Provide read/write access to x86 model specific registers (MSRs) by means of
> > two new HMP commands "msr_get" and "msr_set". The rationale behind this
> > is to improve introspection capabilities for system virtualization mode.
> > For instance, many modern x86-64 operating systems maintain access to internal
> > data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
> > introspection utilities (such as a remotely attached gdb via "monitor msr_get")
> > a way of accessing these registers improves analysis results drastically.
> > 
> > This iteration addresses Eduardo's comments of splitting the patch up into
> > movement, reordering and addition of new MSRs.
> > 
> > Changes v3 -> v4:
> > * Split up x86-related parts of the patch into three distinct patches performing
> >   movement, reordering and addition of new MSRs.
> > 
> > Changes v2 -> v3:
> > * Rename HMP commands to "msr_get" and "msr_set"
> > 
> > Changes v1 -> v2:
> > * Rename HMP commands to "msr-get" and "msr-set"
> > * HMP commands Operate on the current default CPU only
> >   (removes need for cpu_index argument)
> > * Remove QMP command alltogether
> > * Implement HMP command in target/i386/monitor.c
> > * Add #ifdef TARGET_I386 around msr-get/msr-set in hmp-commands.hx
> > 
> > Julian Kirsch (4):
> >   X86: Move rdmsr/wrmsr functionality to standalone functions
> >   X86: Reorder MSRs in rdmsr/wrmsr to follow the order used by KVM
> >   X86: Add MSRs supported by KVM to rdmsr/wrmsr
> >   HMP: Introduce msr_get and msr_set HMP commands
> > 
> >  hmp-commands.hx              |  38 ++++
> >  include/monitor/hmp-target.h |   2 +
> >  target/i386/cpu.h            |   3 +
> >  target/i386/helper.c         | 524 +++++++++++++++++++++++++++++++++++++++++++
> >  target/i386/misc_helper.c    | 297 +-----------------------
> >  target/i386/monitor.c        |  76 +++++++
> >  6 files changed, 654 insertions(+), 286 deletions(-)
> > 
> 
> 

-- 
Eduardo
