Received: from eggs.gnu.org ([2001:4830:134:3::10]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyBRp-0005UA-PQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyBRk-0002Qo-Ve
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:12:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eyBRk-0002Pw-SV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:12:36 -0400
Date: Tue, 20 Mar 2018 08:12:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180320081226.66d4b92e@redhat.com>
In-Reply-To: <c7354c76-afb6-e6f2-a0ca-86b6077228ea@linux.intel.com>
References: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
	<20180319170525.1016391d@igors-macbook-pro.local>
	<c7354c76-afb6-e6f2-a0ca-86b6077228ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: Properly handle IA32_APIC_BASE MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qin, Chao" <chao.qin@linux.intel.com>
Cc: qemu-devel@nongnu.org, yu.ning@linux.intel.com, Qin Chao <chao.qin@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 20 Mar 2018 13:29:24 +0800
"Qin, Chao" <chao.qin@linux.intel.com> wrote:

> On 3/20/2018 12:05 AM, Igor Mammedov wrote:
> > On Mon, 19 Mar 2018 17:04:49 +0800 chao.qin@linux.intel.com wrote:  > >> From: Qin Chao <chao.qin@intel.com>
/ something horribly wrong with mail client used for reply /

>> @@ 
> -933,6 +944,9 @@ static int hax_set_msrs(CPUArchState *env) >> 
> hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask); >> 
> hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, >> env->kernelgsbase); 
> #endif + hax_msr_entry_set(&msrs[n++], >> MSR_IA32_APICBASE, \ + >> 
> cpu_get_apic_base(x86_env_get_cpu(env)->apic_state)); + md.nr_msr = >> 
> n; md.done = 0; > Does it work for you if you drop everything except of 
> this chunk?
> Yes, it works just with this chunk.
Could you send v2 dropping unnecessary chunks pls?
(provided that Paolo would drop queued v1).
