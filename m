Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cmLER-0007BJ-W3
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cmLEP-0006RC-BQ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cmLEP-0006Qd-5K
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:09:21 -0500
Date: Fri, 10 Mar 2017 15:09:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170310150915.1c09d264@nial.brq.redhat.com>
In-Reply-To: <4684e745-3cf1-49e9-0a9d-13f86f1cc8f1@kirschju.re>
References: <20170308001637.9838-1-git@kirschju.re>
	<acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
	<4684e745-3cf1-49e9-0a9d-13f86f1cc8f1@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Julian Kirsch <git@kirschju.re>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Wed, 8 Mar 2017 09:26:58 +0100
Julian Kirsch <git@kirschju.re> wrote:

[...]
> >   
> >> +++ b/qapi-schema.json
> >> @@ -2365,6 +2365,55 @@
> >>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> >>  
> >>  ##
> >> +# @MsrInfo:
> >> +#
> >> +# Information about a MSR
> >> +#
> >> +# @cpu_idx: CPU index
we are trying no to use cpu_index in outside interfaces and
make it disappear from there. 
It's possible to use qom-path instead or more natural
CpuInstanceProperties to specify a CPU.

PS:
Comment applies to all QMP/monitor commands/structures introduced
in this patch.

> >> +# @msr_idx: MSR index
> >> +#
> >> +# @value: MSR value
> >> +#
> >> +# Since: 2.8.1  
> > 
> > You've missed 2.8 by a long shot; you've even missed soft freeze for
> > 2.9.  This should be 2.10.
> >   
> 
> Ops. thanks for pointing this out, will update it. I sticked to the latest
> version returned by "git tag".
> 
> >> +##
> >> +{ 'struct': 'MsrInfo',
> >> +  'data': {'cpu_idx': 'int', 'msr_idx': 'uint32', 'value': 'uint64'} }  
> > 
> > Please spell new members with '-' rather than '_', as in 'cpu-idx' (or
> > even spell it out as 'cpu-index') and 'msr-idx'.
> >   
> 
> Again, thank you, will take care of it.
> 
> >> +
> >> +##
> >> +# @msr-set:
> >> +#
> >> +# Set model specific registers (MSRs) on x86
> >> +#
> >> +# @cpu_idx: CPU holding the MSR that should be written
> >> +#
> >> +# @msr_idx: MSR index to write
> >> +#
> >> +# @value: Value to write
> >> +#
> >> +# Returns: Nothing on success  
> > 
> > Useless Returns: line.
> >   
> 
> Removed.
> 
> Best,
> Julian
> 
