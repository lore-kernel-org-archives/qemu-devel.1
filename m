Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRd8M-00086H-7k
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRd8J-0002A3-4D
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:34 -0500
Received: from mail-bgr052101128039.outbound.protection.outlook.com
	([52.101.128.39]:22575
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gRd8I-00027S-2o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:31 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue, 27 Nov 2018 13:10:14 +0000
Message-ID: <20181127131009.GB2288@rkaganb.sw.ru>
References: <20181126135958.20956-1-vkuznets@redhat.com>
In-Reply-To: <20181126135958.20956-1-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C315453A6AAA05448DF86A19C34D8A31@eurprd08.prod.outlook.com>
MIME-Version: 1.0
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, Nov 26, 2018 at 02:59:58PM +0100, Vitaly Kuznetsov wrote:
> It was found that QMP users of QEMU (e.g. libvirt) may need
> HV_CPUID_ENLIGHTMENT_INFO.EAX/HV_CPUID_NESTED_FEATURES.EAX information. In
> particular, 'hv_tlbflush' and 'hv_evmcs' enlightenments are only exposed in
> HV_CPUID_ENLIGHTMENT_INFO.EAX.
> 
> HV_CPUID_NESTED_FEATURES.EAX is exposed for two reasons: convenience
> (we don't need to export it from hyperv_handle_properties() and as
> future-proof for Enlightened MSR-Bitmap, PV EPT invalidation and
> direct virtual flush features.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c | 30 +++++++++++++++++
>  target/i386/cpu.h |  2 ++
>  target/i386/kvm.c | 85 +++++++++++++++++++++++++----------------------
>  3 files changed, 77 insertions(+), 40 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
