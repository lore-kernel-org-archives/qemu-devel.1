Received: from eggs.gnu.org ([209.51.188.92]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gn1uX-0006Oo-DZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gn1oj-0001ql-P9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:46:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gn1oj-0001qO-JX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:46:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so6839294wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 05:46:45 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20190125124738.GB30730@rkaganb.sw.ru>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
Date: Fri, 25 Jan 2019 14:46:42 +0100
Message-ID: <87bm44onnh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jan 25, 2019 at 12:41:51PM +0100, Vitaly Kuznetsov wrote:
>> In many case we just want to give Windows guests all currently supported
>> Hyper-V enlightenments and that's where this new mode may come handy. We
>> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
>
> How is the compatibility ensured on migration between kernels reporting
> different feature sets?

AFAIU we don't change anything in this regard (or, my intention was to
not change anything): hv-all is converted to the individual hv-*
properties (hv_cpuid_check_and_set()) actually sets cpu->hyperv_* flags
according to what's supported by kernel so when we migrate we will
require all these features supported.

I'll look to see that my expectations actually match the reallity,
thanks for the reminder!

-- 
Vitaly
