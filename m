Received: from eggs.gnu.org ([2001:4830:134:3::10]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cle93-0003Qi-0l
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cle8w-0005Zk-TN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:08:56 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:54528)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cle8w-0005ZT-L6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:08:50 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
	<20170308135751.GE4694@thinpad.lan.raisama.net>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
Date: Wed, 8 Mar 2017 17:08:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170308135751.GE4694@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 08.03.2017 14:57, Eduardo Habkost wrote:

>>
>> This should be abstracted some how so that we don't need
>> x86 specifics in cpus.c; perhaps just an architecture call
>> back on the CPU.
> 
> If it's only supported by x86, I would just move the
> implementation to a x86-specific file, and add a stub for the
> other architectures. See qmp_query_gic_capabilities() for an
> example.
> 
> Also, the command should be added to
> qmp_unregister_commands_hack() so we don't even report it as
> available on other architectures.
> 

Awesome, thanks for your comments, I'll move the qmp commands to
target/i386/monitor.c and unregister them for architectures other than I386. Do
I have to explicitly take care of unregistering the hmp commands as well?

-Julian
