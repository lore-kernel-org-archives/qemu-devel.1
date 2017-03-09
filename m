Received: from eggs.gnu.org ([2001:4830:134:3::10]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm0zC-0000lE-4x
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm0z9-0005Gl-29
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:32:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm0z8-0005GO-Rz
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:32:14 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<20170308115909.GD10232@work-vm>
	<20170308135751.GE4694@thinpad.lan.raisama.net>
	<aa16a480-d3cd-e73c-00d4-947bc0b95deb@kirschju.re>
	<20170308184426.GG4694@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21562465-f6db-e36c-3578-27b43ea9928b@redhat.com>
Date: Thu, 9 Mar 2017 17:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170308184426.GG4694@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Julian Kirsch <git@kirschju.re>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 08/03/2017 19:44, Eduardo Habkost wrote:
>>> If it's only supported by x86, I would just move the
>>> implementation to a x86-specific file, and add a stub for the
>>> other architectures. See qmp_query_gic_capabilities() for an
>>> example.
>>>
>>> Also, the command should be added to
>>> qmp_unregister_commands_hack() so we don't even report it as
>>> available on other architectures.
>>>
>> Awesome, thanks for your comments, I'll move the qmp commands to
>> target/i386/monitor.c and unregister them for architectures other than I386. Do
>> I have to explicitly take care of unregistering the hmp commands as well?
> For HMP commands, it looks like you can simply use #ifdefs inside
> hmp-commands.hx.

Do we need the QMP commands?  There is no QMP version of info registers,
for example.

Paolo
