Received: from eggs.gnu.org ([2001:4830:134:3::10]:46340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLZs-0007MK-PT
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLZr-0007fn-85
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:15:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gaLZr-0007ew-0J
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:14:59 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20181220120544.GL19442@habkost.net>
References: <20181126135958.20956-1-vkuznets@redhat.com>
	<c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
	<878t1chzj8.fsf@vitty.brq.redhat.com>
	<20181130183608.GQ18284@habkost.net>
	<871s6yy9st.fsf@vitty.brq.redhat.com>
	<20181204180808.GC18284@habkost.net>
	<875zvpl98t.fsf@vitty.brq.redhat.com>
	<20181220120544.GL19442@habkost.net>
Date: Fri, 21 Dec 2018 15:14:55 +0100
Message-ID: <87y38j3r1c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Dec 19, 2018 at 06:25:06PM +0100, Vitaly Kuznetsov wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Mon, Dec 03, 2018 at 03:17:06PM +0100, Vitaly Kuznetsov wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> > [...]
>> >> > But note that we might still be able to move the existing
>> >> > "hyperv_*" features to feature_word_info[].feat_names.  We just
>> >> > need to keep the same semantics (e.g. enable
>> >> > HV_HYPERCALL_AVAILABLE automatically when some features are set).
>> >> >
>> >> > Maybe we can make some of the feature properties read-only.  This
>> >> > way we can give them meaningful names for debugging and error
>> >> > messages, even if we don't want to make them configurable
>> >> > directly.
>> >> 
>> >> I'd suggest (if there are no objections of course) we do this separately
>> >> from this patch. [...]
>> >
>> > Agreed.
>> >
>> 
>> Paolo, Eduardo,
>> 
>> in case there are no concerns here, could you please pick this patch up?
>> Thanks!
>
> Queued, thanks!
>
> Can you please send the comment you wrote about feat_names as a
> follow-up patch?

Oops, sorry, I just realized I promissed to send out v2 with it and
aparently never did. Will send out a follow-up patch shortly. Thanks!

-- 
Vitaly
