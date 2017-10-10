Received: from eggs.gnu.org ([2001:4830:134:3::10]:55579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1vkW-0005kq-Qh
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1vkT-0002zn-GH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:43:12 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:46034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1vkT-0002zb-9k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:43:09 -0400
Received: by mail-pf0-x230.google.com with SMTP id d28so2733896pfe.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:43:09 -0700 (PDT)
References: <20171007155522.25436-1-sw@weilnetz.de>
	<bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
	<c01459d1-81f4-8af3-4e52-f7703ff389ea@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2025f3e-d54d-e5d0-d834-6e088a6f09ec@linaro.org>
Date: Tue, 10 Oct 2017 07:43:05 -0700
MIME-Version: 1.0
In-Reply-To: <c01459d1-81f4-8af3-4e52-f7703ff389ea@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/09/2017 10:39 PM, Stefan Weil wrote:
> Am 09.10.2017 um 23:58 schrieb Richard Henderson:
>> On 10/07/2017 08:55 AM, Stefan Weil wrote:
>>> +        char *addr = memset_args->addr;
>>> +        uint64_t numpages = memset_args->numpages;
>>> +        uint64_t hpagesize = memset_args->hpagesize;
>>> +        unsigned i;
>>
>> Match numpages properly while you're at it?
>>
>>
>> r~
> 
> Do you mean using uint64_t for the loop variable i?

Yes.

> Sure. I only hesitated to do that because it is so huge.
> A 64 bit loop variable looks strange, and the loop would
> take some time if it really uses that range. :-)

Why would we use a 64-bit variable for numpages if we don't expect such a
value?  What I see, from spot review only, is an apparent bug -- the iterator
type does not match the bound type.


r~
