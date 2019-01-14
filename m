Received: from eggs.gnu.org ([209.51.188.92]:58696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3Ph-00057k-Pp
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3Pg-0001RW-Rc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:40:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3Pg-0001R7-Lw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:40:28 -0500
Date: Mon, 14 Jan 2019 12:32:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114143239.GW4500@habkost.net>
References: <20181126135958.20956-1-vkuznets@redhat.com>
	<c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
	<878t1chzj8.fsf@vitty.brq.redhat.com>
	<20181130183608.GQ18284@habkost.net>
	<871s6yy9st.fsf@vitty.brq.redhat.com>
	<20181204180808.GC18284@habkost.net>
	<875zvpl98t.fsf@vitty.brq.redhat.com>
	<20181220120544.GL19442@habkost.net>
	<87y38j3r1c.fsf@vitty.brq.redhat.com>
	<87h8eb4ihl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8eb4ihl.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: expose
 HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX as feature
 words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jan 14, 2019 at 11:54:30AM +0100, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >
> >> On Wed, Dec 19, 2018 at 06:25:06PM +0100, Vitaly Kuznetsov wrote:
> >>> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>> 
> >>> > On Mon, Dec 03, 2018 at 03:17:06PM +0100, Vitaly Kuznetsov wrote:
> >>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>> > [...]
> >>> >> > But note that we might still be able to move the existing
> >>> >> > "hyperv_*" features to feature_word_info[].feat_names.  We just
> >>> >> > need to keep the same semantics (e.g. enable
> >>> >> > HV_HYPERCALL_AVAILABLE automatically when some features are set).
> >>> >> >
> >>> >> > Maybe we can make some of the feature properties read-only.  This
> >>> >> > way we can give them meaningful names for debugging and error
> >>> >> > messages, even if we don't want to make them configurable
> >>> >> > directly.
> >>> >> 
> >>> >> I'd suggest (if there are no objections of course) we do this separately
> >>> >> from this patch. [...]
> >>> >
> >>> > Agreed.
> >>> >
> >>> 
> >>> Paolo, Eduardo,
> >>> 
> >>> in case there are no concerns here, could you please pick this patch up?
> >>> Thanks!
> >>
> >> Queued, thanks!
> >>
> >> Can you please send the comment you wrote about feat_names as a
> >> follow-up patch?
> >
> > Oops, sorry, I just realized I promissed to send out v2 with it and
> > aparently never did. Will send out a follow-up patch shortly. Thanks!
> 
> Hey Eduardo,
> 
> any news about the fate of this patch?
> 
> (Correcting myself: there was v2 with the comment included:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00355.html
> 
> but as I sent the follow-up patch you requested separately too:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05463.html
> )

Patch was queued but I took too long to send a pull request,
sorry.  Pull request is being sent right now.

-- 
Eduardo
