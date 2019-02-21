Received: from eggs.gnu.org ([209.51.188.92]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gws50-0006Ts-V4
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gws4y-0003IL-UU
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:24:14 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:42447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gws4y-0003I1-Fg
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:24:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id s1so14480422plp.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:24:12 -0800 (PST)
References: <20190218183314.20157-1-svens@stackframe.org>
	<b1fa8a79-c7dc-0e30-b8e3-a11657667143@twiddle.net>
	<20190221142246.GA19123@t470p.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9bea166d-3e6a-bd7c-8233-56e20750f404@linaro.org>
Date: Thu, 21 Feb 2019 09:24:06 -0800
MIME-Version: 1.0
In-Reply-To: <20190221142246.GA19123@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/hppa/dino: mask out lower 2 bits of
 PCI config addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Cc: deller@gmx.de, qemu-devel@nongnu.org

On 2/21/19 6:22 AM, Sven Schnelle wrote:
> Hi Richard,
> 
> On Wed, Feb 20, 2019 at 10:57:50AM -0800, Richard Henderson wrote:
> 
>> Can you re-test with the following?
>>
>> If the stores are all aligned, then the reads to not need to re-align.
>> Also, partial writes to the config register don't make much sense.
>> Over in hw/pci/pci_host.c, we check addr == 0 && len == 4, which is a
>> very old fashioned way to do the .valid thing.
> 
> With your proposed change it works as well - should i send a v2 or will you
> take care of updating the patch?

I can squash this change.  Thanks for testing.


r~
