Received: from eggs.gnu.org ([2001:4830:134:3::10]:47029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqfq-000072-2z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqfp-00039E-A8
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:49:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewqfp-000396-5K
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:49:37 -0400
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-3-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d1afa27-9653-75dc-ebfe-8633b93f1ce6@redhat.com>
Date: Fri, 16 Mar 2018 15:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180312151233.16565-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

On 12/03/2018 16:12, Vitaly Kuznetsov wrote:
>  
> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> +        if (has_msr_hv_frequencies && env->tsc_khz) {

Should this be

((env->tsc_khz && has_msr_hv_reenlightenment) ||
 tsc_is_stable_and_known(env))

so that you don't regress on older kernels?

Paolo

>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>          }
