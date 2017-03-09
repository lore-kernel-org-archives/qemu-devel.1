Received: from eggs.gnu.org ([2001:4830:134:3::10]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm1qc-0003RA-SZ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm1qZ-0002eo-NG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:27:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm1qZ-0002eT-HG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:27:27 -0500
Date: Thu, 9 Mar 2017 14:27:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170309172722.GV4694@thinpad.lan.raisama.net>
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
	<20170308135751.GE4694@thinpad.lan.raisama.net>
	<aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
	<20170308184426.GG4694@thinpad.lan.raisama.net>
	<21562465-f6db-e36c-3578-27b43ea9928b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21562465-f6db-e36c-3578-27b43ea9928b@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Julian Kirsch <git@kirschju.re>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, Mar 09, 2017 at 05:32:08PM +0100, Paolo Bonzini wrote:
> 
> 
> On 08/03/2017 19:44, Eduardo Habkost wrote:
> >>> If it's only supported by x86, I would just move the
> >>> implementation to a x86-specific file, and add a stub for the
> >>> other architectures. See qmp_query_gic_capabilities() for an
> >>> example.
> >>>
> >>> Also, the command should be added to
> >>> qmp_unregister_commands_hack() so we don't even report it as
> >>> available on other architectures.
> >>>
> >> Awesome, thanks for your comments, I'll move the qmp commands to
> >> target/i386/monitor.c and unregister them for architectures other than I386. Do
> >> I have to explicitly take care of unregistering the hmp commands as well?
> > For HMP commands, it looks like you can simply use #ifdefs inside
> > hmp-commands.hx.
> 
> Do we need the QMP commands?  There is no QMP version of info registers,
> for example.

Good point. If we really want to expose additional CPU info
through QMP, we already have qom_path on 'query-cpus', which
allows QOM properties to be queried directly from the CPU object.

-- 
Eduardo
