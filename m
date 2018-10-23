Received: from eggs.gnu.org ([2001:4830:134:3::10]:41739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gEw9x-00030p-2l
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gEw9r-0006tJ-5I
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:51:44 -0400
Received: from mail-db5eur01on0096.outbound.protection.outlook.com
	([104.47.2.96]:60157
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gEw9q-0006r2-MI
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:51:39 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue, 23 Oct 2018 12:51:35 +0000
Message-ID: <20181023125131.GA14424@rkaganb>
References: <20181022165506.30332-1-vkuznets@redhat.com>
	<20181022165506.30332-3-vkuznets@redhat.com>
In-Reply-To: <20181022165506.30332-3-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F36B6FFB78BD44D9A1D213EF033E183@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] x86: hv_evmcs CPU flag support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, Oct 22, 2018 at 06:55:06PM +0200, Vitaly Kuznetsov wrote:
> Adds a new CPU flag to enable the Enlightened VMCS KVM feature.
> QEMU enables KVM_CAP_HYPERV_ENLIGHTENED_VMCS and gets back the
> version to be advertised in lower 16 bits of CPUID.0x4000000A:EAX.
> 
> Suggested-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
> - Throw away HV_CPUID_MIN_NESTED.
> - Create zeroed 0x40000006-0x40000009 CPUID leaves.
> ---
>  target/i386/cpu.c          |  1 +
>  target/i386/cpu.h          |  1 +
>  target/i386/hyperv-proto.h |  2 ++
>  target/i386/kvm.c          | 30 ++++++++++++++++++++++++++++--
>  4 files changed, 32 insertions(+), 2 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
