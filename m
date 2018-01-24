Received: from eggs.gnu.org ([2001:4830:134:3::10]:56903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUlc-0005AM-DZ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUlb-00027b-JA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:47:44 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:42535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUlb-00026u-C7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:47:43 -0500
Received: by mail-pf0-x22e.google.com with SMTP id b25so4389698pfd.9
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:47:43 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
	<14dcf85d-a8e0-fc21-df46-b94fe48d1067@linaro.org>
	<CAFyWVabFUocnxebZxTYrVr71gbyd6PgLYfqxiAHAqSaw0=6VgA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75ba8c40-803f-4652-93d9-852c97334aad@linaro.org>
Date: Wed, 24 Jan 2018 15:47:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAFyWVabFUocnxebZxTYrVr71gbyd6PgLYfqxiAHAqSaw0=6VgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/24/2018 10:58 AM, Jim Wilson wrote:
> I think that qemu is correct here, and that you want to use float32_chs.

Ok.

> Although, looking at this again, I see another statement in a
> different place that says:
> 
> Except when otherwise stated, if the result of a floating-point operation is
> NaN, it is the canonical NaN. The canonical NaN has a positive sign and all
> significand bits clear except the MSB, a.k.a. the quiet bit. For
> single-precision floating-point, this corresponds to the pattern
> 0x7fc00000.
Yes, I had read this before as well.  I had assumed that your patch constituted
an intended change to this text.

> This could take a little time to sort out.
Ok.  I don't see this as a blocking issue for merging.


r~
