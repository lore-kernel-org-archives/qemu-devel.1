Received: from eggs.gnu.org ([2001:4830:134:3::10]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2chX-0007qx-M3
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2chW-0002Zs-R4
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:34:59 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:53638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2chW-0002Y5-HE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:34:58 -0400
Received: by mail-wm0-x22e.google.com with SMTP id q132so12937520wmd.2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 05:34:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170928165414.7339-1-richard.henderson@linaro.org>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 13:34:36 +0100
Message-ID: <CAFEAcA9aLDDFoTHY+wHGV3S-squwtxs7kaaA6iiCivnOH3ACbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 September 2017 at 17:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since v3:
>   * Adjust how the submodule is detected and invoked.
>     - This should fix the reported patchew failure,
>     - Fixes e.g. -m32 "cross" compilation, or similar
>       abi-changing option sets.
>
>
> r~
>
>
> Richard Henderson (9):
>   target/i386: Convert to disas_set_info hook
>   target/ppc: Convert to disas_set_info hook
>   disas: Remove unused flags arguments
>   disas: Support the Capstone disassembler library
>   i386: Support Capstone in disas_set_info
>   arm: Support Capstone in disas_set_info
>   ppc: Support Capstone in disas_set_info
>   disas: Remove monitor_disas_is_physical
>   disas: Add capstone as submodule

I think the "add as submodule" patch might want to be
revised in the light of the changes to handling of
submodules that the current UI pull request is making,
but are the first 8 patches here more or less ready to
go in?

My other issue with patch 9 is that I think all our
submodules should be for git repos hosted on
git.qemu.org (ie mirrored from somewhere else). So
we should get capstone mirrored first and then use it.

thanks
-- PMM
