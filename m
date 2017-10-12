Received: from eggs.gnu.org ([2001:4830:134:3::10]:36575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2gyt-00048G-3K
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2gyo-00080E-1E
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:09:11 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:62162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e2gyn-0007ys-Nz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:09:05 -0400
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
	<b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
	<CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c9e56a17-3c75-cfcf-7709-ee27efc291af@vivier.eu>
Date: Thu, 12 Oct 2017 19:08:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, pgndev <pgnet.dev@gmail.com>

Le 12/10/2017 à 18:53, Peter Maydell a écrit :
> On 12 October 2017 at 17:49, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 12/10/2017 à 17:30, Peter Maydell a écrit :
>>> +#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
>>> +typedef abi_long target_kernel_daddr_t;
>>> +#else
>>> +typedef abi_int target_kernel_daddr_t;
>>> +#endif
>>
>> Perhaps you can add these ones into include/exec/user/abitypes.h ?
> 
> I don't think they belong there -- that file is for basic
> CPU ABI dependent types, not things which are just part of
> the kernel interface.

I agree

Laurent
