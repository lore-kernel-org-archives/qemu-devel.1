Received: from eggs.gnu.org ([209.51.188.92]:54849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gjjtL-0007nu-FK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gjjtF-0001ck-Sd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:01:55 -0500
Date: Wed, 16 Jan 2019 13:01:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <511a675b-fa61-1ef0-643f-9c568b5daaa8@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1901161259260.16452@zero.eik.bme.hu>
References: <20190116041916.130523-1-aik@ozlabs.ru>
	<511a675b-fa61-1ef0-643f-9c568b5daaa8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc]  [PATCH qemu] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 16 Jan 2019, Richard Henderson wrote:
> On 1/16/19 3:19 PM, Alexey Kardashevskiy wrote:
>> because TARGET_FMT_lx is defined as "%016"PRIx64.
>>
>> This uses simple "%lx" to suppress the warning. Since it is spapr which
>> is always 64bit, we assume here that hwaddr is always "long".
>
> This file is not solely for kvm, i.e. ppc64 hosts.  Thus this
> is a bad assumption and will fail for a 32-bit host.
>
> You may want to use PRIx64 and assume hwaddr == uint64_t, or
> also include an explicit cast to uint64_t.

I don't know the context of this but there's HWADDR_PRIx as well so if you 
want to print a hwaddr that's probably the one to use.

Regards,
BALATON Zoltan
