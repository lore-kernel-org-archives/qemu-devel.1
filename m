Received: from eggs.gnu.org ([2001:4830:134:3::10]:41782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g9rQq-0006ue-G1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g9rQn-0008E0-AA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:48:12 -0400
Received: from mail-bgr052101133029.outbound.protection.outlook.com
	([52.101.133.29]:29472
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1g9rQm-0008AZ-LS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:48:09 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue, 9 Oct 2018 12:47:56 +0000
Message-ID: <20181009124750.GD29982@rkaganb.sw.ru>
References: <20181008112726.16140-1-vkuznets@redhat.com>
	<20181008112726.16140-3-vkuznets@redhat.com>
In-Reply-To: <20181008112726.16140-3-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58BBB69F78A41242AFC58829779FAAFF@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] i386/kvm: add support for Hyper-V IPI
 send
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

On Mon, Oct 08, 2018 at 01:27:26PM +0200, Vitaly Kuznetsov wrote:
> Hyper-V PV IPI support is merged to KVM, enable the feature in Qemu. When
> enabled, this allows Windows guests to send IPIs to other vCPUs with a
> single hypercall even when there are >64 vCPUs in the request.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c          |  1 +
>  target/i386/cpu.h          |  1 +
>  target/i386/hyperv-proto.h |  1 +
>  target/i386/kvm.c          | 14 +++++++++++++-
>  4 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
