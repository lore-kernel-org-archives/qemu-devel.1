Received: from eggs.gnu.org ([2001:4830:134:3::10]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYXPC-0001FL-Kt
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYXP9-0001Kb-Jt
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYXP9-0001Ju-DK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:56:11 -0400
Date: Thu, 28 Jun 2018 10:56:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180628135606.GD7451@localhost.localdomain>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530177956.22880.32.camel@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, wei.w.wang@intel.com

On Thu, Jun 28, 2018 at 05:25:56PM +0800, Robert Hoo wrote:
> On Wed, 2018-06-27 at 14:03 -0300, Eduardo Habkost wrote:
> > On Wed, Jun 27, 2018 at 07:27:20PM +0800, Robert Hoo wrote:
> > > IA32_PRED_CMD MSR gives software a way to issue commands that affect the state
> > > of indirect branch predictors. Enumerated by CPUID.(EAX=7H,ECX=0):EDX[26].
> > > IA32_ARCH_CAPABILITIES MSR enumerates architectural features of RDCL_NO and
> > > IBRS_ALL. Enumerated by CPUID.(EAX=07H, ECX=0):EDX[29].
> > > 
> > > https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf
> > > 
> > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > ---
> > >  target/i386/cpu.h |  4 ++++
> > >  target/i386/kvm.c | 27 ++++++++++++++++++++++++++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index 89c82be..734a73e 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > @@ -352,6 +352,8 @@ typedef enum X86Seg {
> > >  #define MSR_TSC_ADJUST                  0x0000003b
> > >  #define MSR_IA32_SPEC_CTRL              0x48
> > >  #define MSR_VIRT_SSBD                   0xc001011f
> > > +#define MSR_IA32_PRED_CMD               0x49
> > > +#define MSR_IA32_ARCH_CAPABILITIES      0x10a
> > >  #define MSR_IA32_TSCDEADLINE            0x6e0
> > >  
> > >  #define FEATURE_CONTROL_LOCKED                    (1<<0)
> > > @@ -1210,6 +1212,8 @@ typedef struct CPUX86State {
> > >  
> > >      uint64_t spec_ctrl;
> > >      uint64_t virt_ssbd;
> > > +    uint64_t pred_cmd;
> > > +    uint64_t arch_capabilities;
> > 
> > What's the purpose of those CPUX86State fields, if the migration
> > sections were removed in v2?
> > 
> Thanks Eduardo. Going to clean up in v3. Any more comments, regarding
> other patches?

The other patches look good, assuming that the bit offsets are
all correct.  Thanks!

-- 
Eduardo
