Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhFT-0001uE-IN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhFS-0001Xr-O3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:06:43 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:40698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhFS-0001XM-KW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:06:42 -0500
Received: by mail-ot0-x235.google.com with SMTP id d10so2840428oti.7
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:06:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218174552.18871-2-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:06:21 +0000
Message-ID: <CAFEAcA_zoqWwAhg5PhuUG=xkRuC3uwT0MF7D3NOvEFg0Z3yKMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/23] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> To be used to decode ARM SVE, but could be used for any 32-bit RISC.
> It would need additional work to extend to insn sizes other than 32-bit.

I guess we could make that extension without requiring all
existing pattern files to be updated, right?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 984 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 984 insertions(+)
>  create mode 100755 scripts/decodetree.py

This is rather large for a single patch...

> +# Pattern examples:
> +#
> +#   addl_r   010000 ..... ..... .... 0000000 ..... @opr
> +#   addl_i   010000 ..... ..... .... 0000000 ..... @opi
> +#

I think we should insist that a pattern defines all the
bits (either as constant values or as fields that get
passed to the decode function). That will help prevent
accidental under-decoding.

thanks
-- PMM
