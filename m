Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eydVR-0007ic-4D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eydVL-0005UU-GG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:10:17 -0400
Received: from mail-he1eur02hn0245.outbound.protection.outlook.com
	([104.47.5.245]:63857
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eydVK-0005Ta-AA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:10:11 -0400
Date: Wed, 21 Mar 2018 16:09:54 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321130954.GA31776@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-2-vkuznets@redhat.com>
	<20180320183227.GW3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320183227.GW3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 03:32:27PM -0300, Eduardo Habkost wrote:
> The difference between both approaches is that checking just
> has_msr_hv_* would let a non-cooperating guest prevent itself
> from being migrated to an older host by writing a non-zero value
> to a MSR, even if hyperv support was not enabled in the VM
> configuration at all.  I don't think we want that.

Thinking some more of what we do want in this regard, I wonder if we're
doing the right thing by not generating #GP on access to MSRs whose
support is present in KVM but disabled via cpu properties in QEMU?

Roman.
