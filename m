Received: from eggs.gnu.org ([2001:4830:134:3::10]:51061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtHtm-0001q6-BP
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtHtl-0000ai-Gc
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:33:02 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:55285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtHtl-0000aV-9I
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:33:01 -0400
Received: by mail-wr0-x233.google.com with SMTP id g29so3717191wrg.11
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 11:33:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914183516.19537-5-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<20170914183516.19537-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 19:32:39 +0100
Message-ID: <CAFEAcA_QTwDnqQsYKMMHYQmE9kJdPaRafDadGksM_QofPOmboQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/10] disas: Support the Capstone
 disassembler library
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

On 14 September 2017 at 19:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
> If configured, prefer this over our rather dated copy of the
> GPLv2-only binutils.  This will be especially apparent with
> the proposed vector extensions to TCG, as disas/i386.c does
> not handle AVX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/configure b/configure
> index fd7e3a5e81..a55a8eda8a 100755
> --- a/configure
> +++ b/configure
> @@ -366,6 +366,7 @@ opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt="no"
>  zlib="yes"
> +capstone=""
>  lzo=""
>  snappy=""
>  bzip2=""
> @@ -4381,6 +4382,18 @@ EOF
>  fi

We should have the usual --enable-capstone/--disable-capstone
option flags so distros can enforce that configure fails
if it can't find the dependency.

It's also tempting to suggesting making it into a submodule
so that we can dump the old binutils code entirely (or
just requiring capstone if you want the debug logging to
be any good).

thanks
-- PMM
