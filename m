Received: from eggs.gnu.org ([2001:4830:134:3::10]:38374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eUFgO-0000iO-0k
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eUFgK-0004PG-Pm
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:39:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eUFgK-0004JS-FS
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:39:56 -0500
Date: Wed, 27 Dec 2017 15:39:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171227173951.GE24856@localhost.localdomain>
References: <1514383466-7257-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514383466-7257-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] i386/cpu/kvm: look at PMU's CPUID before
 setting MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org

On Wed, Dec 27, 2017 at 05:04:26PM +0300, Jan Dakinevich wrote:
> Certain PMU-related MSRs are not supported for CPUs with PMU
> architecture below version 2. KVM rejects any access to them (see
> intel_is_valid_msr_idx routine in KVM), and QEMU fails on the following
> assertion:
> 
>   kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> 
> QEMU also could fail if KVM exposes less fixed counters then 3. It could
> happen if host system run inside another hypervisor, which is tweaking
> PMU-related CPUID. To prevent possible fail, number of fixed counters now is
> obtained in the same way as number of GP counters.
> 
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
