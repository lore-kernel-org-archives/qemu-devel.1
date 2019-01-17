Received: from eggs.gnu.org ([209.51.188.92]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjy7l-00067i-Jj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjy7k-0001zU-Ke
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:13:45 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gjy7k-0001xL-2i
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:13:44 -0500
Received: by mail-pl1-x642.google.com with SMTP id z23so4032867plo.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 19:13:44 -0800 (PST)
References: <20190116041916.130523-1-aik@ozlabs.ru>
	<511a675b-fa61-1ef0-643f-9c568b5daaa8@linaro.org>
	<alpine.BSF.2.21.9999.1901161259260.16452@zero.eik.bme.hu>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1ab8c2ba-92c1-757a-5e19-7e4c8719179b@ozlabs.ru>
Date: Thu, 17 Jan 2019 14:13:38 +1100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901161259260.16452@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc]  [PATCH qemu] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 16/01/2019 23:01, BALATON Zoltan wrote:
> On Wed, 16 Jan 2019, Richard Henderson wrote:
>> On 1/16/19 3:19 PM, Alexey Kardashevskiy wrote:
>>> because TARGET_FMT_lx is defined as "%016"PRIx64.
>>>
>>> This uses simple "%lx" to suppress the warning. Since it is spapr which
>>> is always 64bit, we assume here that hwaddr is always "long".
>>
>> This file is not solely for kvm, i.e. ppc64 hosts.  Thus this
>> is a bad assumption and will fail for a 32-bit host.
>>
>> You may want to use PRIx64 and assume hwaddr == uint64_t, or
>> also include an explicit cast to uint64_t.
> 
> I don't know the context of this but there's HWADDR_PRIx as well so if
> you want to print a hwaddr that's probably the one to use.


Oh, thanks! I missed that :-/ I'll repost if otherwise the idea is
correct and nothing relies on leading zeroes (hi, David :) ).



-- 
Alexey
