Received: from eggs.gnu.org ([2001:4830:134:3::10]:38439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUF7E-0007a8-VP
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUF7D-0006aY-UL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:08:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gUF7D-0006aB-NV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:08:11 -0500
Date: Tue, 4 Dec 2018 16:08:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204180808.GC18284@habkost.net>
References: <20181126135958.20956-1-vkuznets@redhat.com>
	<c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
	<878t1chzj8.fsf@vitty.brq.redhat.com>
	<20181130183608.GQ18284@habkost.net>
	<871s6yy9st.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s6yy9st.fsf@vitty.brq.redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On Mon, Dec 03, 2018 at 03:17:06PM +0100, Vitaly Kuznetsov wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
[...]
> > But note that we might still be able to move the existing
> > "hyperv_*" features to feature_word_info[].feat_names.  We just
> > need to keep the same semantics (e.g. enable
> > HV_HYPERCALL_AVAILABLE automatically when some features are set).
> >
> > Maybe we can make some of the feature properties read-only.  This
> > way we can give them meaningful names for debugging and error
> > messages, even if we don't want to make them configurable
> > directly.
> 
> I'd suggest (if there are no objections of course) we do this separately
> from this patch. [...]

Agreed.

>            [...] Some time ago when merging direct mode stimers for KVM
> Paolo suggested we stop adding capabilities to KVM for each individulat
> feature and replace them with something like KVM_GET_SUPPORTED_HV_CPUID
> ioctl returning all Hyper-V related feature words. When this is done we
> can reconsider how Qemu discoveres Hyper-V related KVM features and as
> part of this work we can take a closer look at feature words and
> feat_names.

Why a separate ioctl instead of extending GET_SUPPORTED_CPUID?

-- 
Eduardo
