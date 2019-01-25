Received: from eggs.gnu.org ([209.51.188.92]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gn0zt-0007Ns-El
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gn0tj-000832-3z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:47:51 -0500
Received: from mail-bgr052101133058.outbound.protection.outlook.com
	([52.101.133.58]:30025
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gn0ti-00081W-Hc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:47:51 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 25 Jan 2019 12:47:41 +0000
Message-ID: <20190125124738.GB30730@rkaganb.sw.ru>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-5-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19BE3E419E3C2F48A3A21B74CC391CD3@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
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

On Fri, Jan 25, 2019 at 12:41:51PM +0100, Vitaly Kuznetsov wrote:
> In many case we just want to give Windows guests all currently supported
> Hyper-V enlightenments and that's where this new mode may come handy. We
> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.

How is the compatibility ensured on migration between kernels reporting
different feature sets?

Roman.
