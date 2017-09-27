Received: from eggs.gnu.org ([2001:4830:134:3::10]:40180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxBKZ-0001sm-45
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxBKW-0003WA-M2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxBKW-0003Vr-FE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:20:44 -0400
References: <20170926183318.12995-1-david@redhat.com>
	<20170926183318.12995-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0257126a-f2a5-8029-f5e7-dbab0bc025ff@redhat.com>
Date: Wed, 27 Sep 2017 14:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170926183318.12995-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/6] s390x/tcg: add MMU for real
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>


> +/**
> + * Translate a real address into a physical (absolute) address.
> + * @param raddr  the real address
> + * @param rw     0 = read, 1 = write, 2 = code fetch
> + * @param addr  the translated address is stored to this pointer
----------------->^
Conny, if you want you can also insert one additional space here :)

> + * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
> + * @return       0 if the translation was successful, < 0 if a fault occurred
> + */
> +int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
> +                       target_ulong *addr, int *flags)
> +{
> +    /* TODO: low address protection once we flush the tlb on cr changes */
> +    *flags = PAGE_READ | PAGE_WRITE;
> +    *addr = mmu_real2abs(env, raddr);
> +
> +    /* TODO: storage key handling */
> +    return 0;
> +}
> 


-- 

Thanks,

David
