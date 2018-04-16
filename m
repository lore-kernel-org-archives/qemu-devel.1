Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8741-000798-S9
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f873z-00023o-AE
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:33:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f873z-00023F-3L
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:33:07 -0400
Date: Mon, 16 Apr 2018 13:33:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180416163303.GI29865@localhost.localdomain>
References: <20180326170658.606-1-juterry@microsoft.com>
	<20180328175050.GH5046@localhost.localdomain>
	<DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
	<de10b07e-3ce7-e1e1-f437-792fe246d218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de10b07e-3ce7-e1e1-f437-792fe246d218@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Justin Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rth@twiddle.net" <rth@twiddle.net>

On Thu, Apr 05, 2018 at 05:50:20PM +0200, Paolo Bonzini wrote:
> On 28/03/2018 22:48, Justin Terry (VM) wrote:
[...]
> > If we use [2] to inject the answers at creation time WHPX needs access
> > to the CPUX86State at accel init which also doesn't seem to be possible
> > in QEMU today. WHPX could basically just call cpu_x86_cpuid() for each
> > CPUID QEMU cares about and plumb the answer before start. This has the
> > best performance as we avoid the additional exits but has an issue in
> > that the results must be known ahead of time.
> 
> The earliest where you have access to that is x86_cpu_initfn.

x86_cpu_initfn() is the earliest you have access to the CPU
object, but note that the final CPUID bits (based on -cpu
options, accel data, and possibly other input) are known only
when x86_cpu_realizefn() is called.

-- 
Eduardo
