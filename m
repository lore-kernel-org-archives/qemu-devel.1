Received: from eggs.gnu.org ([2001:4830:134:3::10]:51290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dhnT1-0007Pv-3J
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 21:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dhnSw-0003hL-54
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 21:49:55 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:21323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dhnSv-0003fu-QD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 21:49:50 -0400
Date: Tue, 15 Aug 2017 21:49:38 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170816014938.GC12928@localhost.localdomain>
References: <20170807085703.32267-1-lprosek@redhat.com>
	<20170809005053.GA26386@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809005053.GA26386@amt.cnet>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] i386/kvm: advertise Hyper-V
 frequency MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, david@redhat.com, rkrcmar@redhat.com

On Tue, Aug 08, 2017 at 09:50:53PM -0300, Marcelo Tosatti wrote:
> On Mon, Aug 07, 2017 at 10:56:59AM +0200, Ladi Prosek wrote:
> > This is the QEMU part of the changes required for nested Hyper-V to read
> > timestamps with RDTSC + TSC page. Without exposing the frequency MSRs,
> > Windows with the Hyper-V role enabled use the much slower
> > HV_X64_MSR_TIME_REF_COUNT (0x40000020) RDMSR to read timestamps.
> > 
> > The new registers are exposed only if the TSC frequency is stable across
> > migration and known, as suggested by Paolo.
> > 
> > v1->v2:
> > * deleted an extra empty line in patch 1
> > * added patch 3 introducing a helper function for the "TSC is stable and
> >   known" check (David)
> > 
> > Ladi Prosek (4):
> >   i386/kvm: use a switch statement for MSR detection
> >   i386/kvm: set tsc_khz before configuring Hyper-V CPUID
> >   i386/kvm: introduce tsc_is_stable_and_known()
> >   i386/kvm: advertise Hyper-V frequency MSRs
> > 
> >  target/i386/kvm.c | 138 ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 71 insertions(+), 67 deletions(-)
> > 
> > -- 
> > 2.9.3
> 
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Come again please?

> 
