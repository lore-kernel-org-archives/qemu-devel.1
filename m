Received: from eggs.gnu.org ([2001:4830:134:3::10]:36040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cm2SI-0006hx-P5
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cm2SF-0000Bk-LK
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:06:26 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:34290)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cm2SF-0000BB-DX
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:06:23 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
	<20170308135751.GE4694@thinpad.lan.raisama.net>
	<aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
	<20170308184426.GG4694@thinpad.lan.raisama.net>
	<21562465-f6db-e36c-3578-27b43ea9928b@redhat.com>
	<20170309172722.GV4694@thinpad.lan.raisama.net>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <030d486f-b98e-03b8-dcfe-276d2b9b0000@kirschju.re>
Date: Thu, 9 Mar 2017 19:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170309172722.GV4694@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09.03.2017 18:27, Eduardo Habkost wrote:
> On Thu, Mar 09, 2017 at 05:32:08PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 08/03/2017 19:44, Eduardo Habkost wrote:
>>>>> If it's only supported by x86, I would just move the
>>>>> implementation to a x86-specific file, and add a stub for the
>>>>> other architectures. See qmp_query_gic_capabilities() for an
>>>>> example.
>>>>>
>>>>> Also, the command should be added to
>>>>> qmp_unregister_commands_hack() so we don't even report it as
>>>>> available on other architectures.
>>>>>
>>>> Awesome, thanks for your comments, I'll move the qmp commands to
>>>> target/i386/monitor.c and unregister them for architectures other than I386. Do
>>>> I have to explicitly take care of unregistering the hmp commands as well?
>>> For HMP commands, it looks like you can simply use #ifdefs inside
>>> hmp-commands.hx.
>>
>> Do we need the QMP commands?  There is no QMP version of info registers,
>> for example.
> 
> Good point. If we really want to expose additional CPU info
> through QMP, we already have qom_path on 'query-cpus', which
> allows QOM properties to be queried directly from the CPU object.
> 

Good catch. Will look into it.

-Julian
