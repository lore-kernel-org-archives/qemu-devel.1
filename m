Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1cq0-0003cX-QW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1cpx-0005VQ-0Q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:59:20 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d1cpw-0005Uz-Pc
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 13:59:16 -0400
Received: by mail-wm0-x230.google.com with SMTP id m123so23164235wma.0
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 10:59:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_3fm+-6QaH0eb46wF7OS1qFnCEcEBa-q6UnGZD5HemPA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f1102288-a192-0ee2-3a35-08045926af59@twiddle.net>
Date: Fri, 21 Apr 2017 10:59:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3fm+-6QaH0eb46wF7OS1qFnCEcEBa-q6UnGZD5HemPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How expensive is an extra QEMU TLB MMU index ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/21/2017 10:23 AM, Peter Maydell wrote:
> Hi; I have a feature for the ARM M profile emulation which I think
> needs to be implemented by giving it a separate mmu index value.
> [The HFNMIENA control bit allows "privileged and execution priority
> is higher than 0" to run with the MPU effectively off even if normal
> privileged execution has enabled the MPU.]
>
> I could implement this by just bumping ARM's NB_MMU_MODES to 8
> and using the extra value for this. On the other hand, several
> of the current 7 index values are not needed for M profile CPUs,
> so in theory I could reuse one of those (so it would have different
> meanings if the CPU was M profile or not). But that feels like it would
> be pretty accident-prone, since so much of the code is shared.
>
> So, just how expensive is having an extra MMU mode which isn't
> actually used? Is it bad enough to be worth the reduced
> maintainability?

Once you get above 7 indicies, we will start to reduce the size of the TLB for 
various hosts.  See CPU_TLB_BITS in include/exec/cpu-defs.h.

That said, the size reduction doesn't happen for x86_64 host, and ought not 
actively fail for any host, so maybe you don't care.


r~
