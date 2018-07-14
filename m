Received: from eggs.gnu.org ([2001:4830:134:3::10]:46630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fe81k-0007Fn-RS
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 20:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fe81h-0007kg-N9
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 20:03:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:3267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fe81h-0007iu-Bp
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 20:03:05 -0400
Message-ID: <1531526579.78231.27.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 14 Jul 2018 08:02:59 +0800
In-Reply-To: <830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: konrad.wilk@oracle.com
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, 2018-07-13 at 10:11 -0400, konrad.wilk@oracle.com wrote:
> (Apologies if this comes out as HTML, using Thunderbird instead of mutt here)..
> 
> > +    uint64_t pred_cmd;
> > +    uint64_t arch_capabilities;
> 
> Could this be 'arch_cap' ?
> 
> >   
> >       /* End of state preserved by INIT (dummy marker).  */
> >       struct {} end_init_save;
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 2d174f3..3aab182 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -93,6 +93,8 @@ static bool has_msr_hv_reenlightenment;
> >   static bool has_msr_xss;
> >   static bool has_msr_spec_ctrl;
> >   static bool has_msr_virt_ssbd;
> > +static bool has_msr_pred_cmd;
> > +static bool has_msr_arch_capabilities;
> 
> Ditto here?
> 

Per Paolo and Eduardo's comments, the 2 fields/variables are gone in new
versions.
