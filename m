Received: from eggs.gnu.org ([2001:4830:134:3::10]:56710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f6ERx-0001WL-UX
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f6ERs-0005PV-4u
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:02:06 -0400
Received: from mail-db5eur01hn0200.outbound.protection.outlook.com
	([104.47.2.200]:44426
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f6ERr-0005Ns-Fc
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:02:00 -0400
Date: Wed, 11 Apr 2018 15:01:43 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180411120142.GA2258@rkaganb.sw.ru>
References: <20180411115036.31832-1-vkuznets@redhat.com>
	<20180411115036.31832-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411115036.31832-2-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Wed, Apr 11, 2018 at 01:50:36PM +0200, Vitaly Kuznetsov wrote:
> KVM recently gained support for Hyper-V Reenlightenment MSRs which are
> required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
> when INVTSC is not passed to it (and it is not passed by default in Qemu
> as it effectively blocks migration).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v4:
> - Rebase on top of Roman's patches.
> ---
>  target/i386/cpu.c          |  4 +++-
>  target/i386/cpu.h          |  4 ++++
>  target/i386/hyperv-proto.h |  9 ++++++++-
>  target/i386/kvm.c          | 39 ++++++++++++++++++++++++++++++++++++++-
>  target/i386/machine.c      | 24 ++++++++++++++++++++++++
>  5 files changed, 77 insertions(+), 3 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
