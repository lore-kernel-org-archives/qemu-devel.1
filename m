Received: from eggs.gnu.org ([2001:4830:134:3::10]:41252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHu1P-0004mL-P5
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHu1O-0003E9-VF
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:06:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHu1O-0003DY-Pi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:06:38 -0500
References: <20171123092333.16085-1-peterx@redhat.com>
	<20171123092333.16085-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <039e8f8a-53e1-4208-7b4e-48a05d6faf5c@redhat.com>
Date: Thu, 23 Nov 2017 17:06:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171123092333.16085-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] cpu: refactor cpu_address_space_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On 23/11/2017 10:23, Peter Xu wrote:
> +                            const char *prefix, MemoryRegion *mr)
>  {
>      CPUAddressSpace *newas;
> +    AddressSpace *as = g_new0(AddressSpace, 1);
> +
> +    assert(mr);
> +    address_space_init(as, mr, prefix);
>  

Now that address_space_init_shareable doesn't exist anymore, the
AddressSpace could be placed directly in CPUAddressSpace instead of
having a pointer.  But the patches are already okay, that's a separate
change.

Paolo
