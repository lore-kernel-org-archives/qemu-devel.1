Received: from eggs.gnu.org ([2001:4830:134:3::10]:35477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clgan-0004Cz-9R
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clgai-0004lU-Co
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:45:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clgai-0004kA-7K
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:45:40 -0500
Date: Wed, 8 Mar 2017 15:44:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308184426.GG4694@thinpad.lan.raisama.net>
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
	<20170308135751.GE4694@thinpad.lan.raisama.net>
	<aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Mar 08, 2017 at 05:08:42PM +0100, Julian Kirsch wrote:
> On 08.03.2017 14:57, Eduardo Habkost wrote:
> 
> >>
> >> This should be abstracted some how so that we don't need
> >> x86 specifics in cpus.c; perhaps just an architecture call
> >> back on the CPU.
> > 
> > If it's only supported by x86, I would just move the
> > implementation to a x86-specific file, and add a stub for the
> > other architectures. See qmp_query_gic_capabilities() for an
> > example.
> > 
> > Also, the command should be added to
> > qmp_unregister_commands_hack() so we don't even report it as
> > available on other architectures.
> > 
> 
> Awesome, thanks for your comments, I'll move the qmp commands to
> target/i386/monitor.c and unregister them for architectures other than I386. Do
> I have to explicitly take care of unregistering the hmp commands as well?

For HMP commands, it looks like you can simply use #ifdefs inside
hmp-commands.hx.

-- 
Eduardo
