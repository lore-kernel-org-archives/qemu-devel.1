Received: from eggs.gnu.org ([2001:4830:134:3::10]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e459F-0002Cq-1w
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e459B-00070p-Sd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:09:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e459B-0006zc-If
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:09:33 -0400
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
	<b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
	<CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
	<c9e56a17-3c75-cfcf-7709-ee27efc291af@vivier.eu>
	<20171016130616.GF1918@kos.to>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4d8c3811-62a9-2391-e962-736c333d45c6@vivier.eu>
Date: Mon, 16 Oct 2017 15:09:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171016130616.GF1918@kos.to>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, pgndev <pgnet.dev@gmail.com>

Le 16/10/2017 à 15:06, Riku Voipio a écrit :
> On Thu, Oct 12, 2017 at 07:08:55PM +0200, Laurent Vivier wrote:
>> Le 12/10/2017 à 18:53, Peter Maydell a écrit :
>>> On 12 October 2017 at 17:49, Laurent Vivier <laurent@vivier.eu> wrote:
>>>> Le 12/10/2017 à 17:30, Peter Maydell a écrit :
>>>>> +#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
>>>>> +typedef abi_long target_kernel_daddr_t;
>>>>> +#else
>>>>> +typedef abi_int target_kernel_daddr_t;
>>>>> +#endif
>>>>
>>>> Perhaps you can add these ones into include/exec/user/abitypes.h ?
>>>
>>> I don't think they belong there -- that file is for basic
>>> CPU ABI dependent types, not things which are just part of
>>> the kernel interface.
> 
>> I agree
> 
> So we should go with the patch as-is?

For this part, yes, but I think for the other comment, STRUCT(mtget,
...) needs to be updated.

Thanks,
Laurent
