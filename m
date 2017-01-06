Received: from eggs.gnu.org ([2001:4830:134:3::10]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPYPI-0003LC-GL
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPYPH-0007Fx-Ml
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:34:24 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:33181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPYPH-0007Fg-Hy
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:34:23 -0500
Received: by mail-ua0-x231.google.com with SMTP id i68so307740239uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 09:34:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170106162116.12859-1-kirkseraph@gmail.com>
References: <20170106162116.12859-1-kirkseraph@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 17:34:00 +0000
Message-ID: <CAFEAcA_S-83pQVS-LJMWDzVu0Zk3+kpYZ2uZahkpDaeNAgaHCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCHv2] target-arm/abi32: check for segfault in
 do_kernel_trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seraphime Kirkovski <kirkseraph@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 6 January 2017 at 16:21, Seraphime Kirkovski <kirkseraph@gmail.com> wrote:
> Currently, the cmpxchg implementation tests whether the destination address
> is readable:
>   - if it is, we read the value and continue with the comparison
>   - if isn't, i.e. access to addr would segfault, we assume that src != dest
>     rather than queuing a SIGSEGV.
>
> The same problem exists in the case where src == dest: the code doesn't
> check whether put_user_u32 succeeds.
>
> This fixes both problems by sending a SIGSEGV when the destination address
> is inaccessible.
>
> Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> ---
>
> This accounts for Peter Maydell's remarks.
> The refactoring here extracts the cmpxchg code from do_kernel_trap in its own
> function.

As the patchew robot notes, our coding style wants braces on all
if() statements, even one-line ones. Other than that,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
