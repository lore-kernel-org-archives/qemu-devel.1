Received: from eggs.gnu.org ([209.51.188.92]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJh1-0007ET-7G
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJgx-00037Z-0R
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJgS-0002y5-Rv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id 9so10018914pfj.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:43:16 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
	<50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
	<0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
	<b0567193-e353-d391-b438-e5b580d699a4@linaro.org>
	<0d400fda-85a7-6c5d-a693-1d0bfec63ce3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f632efd-37b9-5aaf-fe81-7c332ad51d7a@linaro.org>
Date: Mon, 15 Apr 2019 22:43:11 -1000
MIME-Version: 1.0
In-Reply-To: <0d400fda-85a7-6c5d-a693-1d0bfec63ce3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 4/15/19 10:33 PM, David Hildenbrand wrote:
>>>
>>> Indeed, I didn't really explore vector operations yet. This is more
>>> compact than I expected :)
>>
>> :-)
>>
>> That said, in implementing vector variable shifts today,
>> I've come up with a representational problem here.
>> You may want to hold off on these until I can address them.
> 
> I assume you mean vector helpers *in general* in this file. Yes, we can
> add them later.
> 
> What exact problem are you dealing with?

The .opc field lets you only specify one opcode which is optional in the
backend on which you depend.  In writing support for AArch64 USHL, I find that
I needed 3 optional opcodes.

I'm thinking of a mass change whereby .opc becomes a pointer to an array with
terminator.  But then, for debugging purposes, I think I need to validate that
array, so that it's not missing things that ought to be specified, but which
happen to be supported by the current host.


r~
