Received: from eggs.gnu.org ([209.51.188.92]:42683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1h0vPT-0006Sd-A6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1h0vPS-0003fs-Hf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:46:07 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:42832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1h0vPS-0003d0-1y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:46:06 -0500
Received: by mail-pg1-x52a.google.com with SMTP id b2so4000395pgl.9
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 13:46:05 -0800 (PST)
Date: Mon, 04 Mar 2019 13:46:03 -0800 (PST)
In-Reply-To: <a652de39-fae2-9885-1197-fbb70b28b7cf@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-0bb53acf-0f1c-405f-8599-76941fe63e37@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Mon, 04 Mar 2019 11:30:21 PST (-0800), richard.henderson@linaro.org wrote:
> On 3/4/19 4:52 AM, Bastian Koppelmann wrote:
>> This looks like an unforeseen decodetree problem (CC' Richard). As these 16/32
>> instructions share the same trans_* function, we emit the same typedef once for
>> 16 bit and once for 32 bit. I don't see an easy fix in decodetree
>
> Use an argument set, and add !extern to the argument set definition for the
> "second" decoder.
>
> (Leastwise I don't think that feature is sitting on the branch...)
>

Thanks, I'll do another PR and keep the last 5 patches for later.
