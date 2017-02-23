Received: from eggs.gnu.org ([2001:4830:134:3::10]:44200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1sS-0001Ps-UG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1sP-0003Cy-1D
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:28:44 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ch1sO-0003Cn-Qs
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:28:40 -0500
Received: by mail-qk0-x242.google.com with SMTP id n127so729167qkf.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:28:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170217154311.13920-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <234855b4-ebfd-1f38-8b63-495fe7774fcb@twiddle.net>
Date: Fri, 24 Feb 2017 09:28:33 +1100
MIME-Version: 1.0
In-Reply-To: <20170217154311.13920-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND] aarch64: Change ext type to TCGType
 to fix warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 02/18/2017 02:43 AM, Pranith Kumar wrote:
> To fix the following warnings:
>
> In file included from /users/pranith/qemu/tcg/tcg.c:255:
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:879:24: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
>       [-Wenum-conversion]
>         tcg_out_cmp(s, ext, a, b, b_const);
>         ~~~~~~~~~~~    ^~~
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:893:36: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
>       [-Wenum-conversion]
>         tcg_out_insn(s, 3201, CBZ, ext, a, offset);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:389:65: note: expanded from macro 'tcg_out_insn'
>     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
>                                                                 ^
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:895:37: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
>       [-Wenum-conversion]
>         tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:389:65: note: expanded from macro 'tcg_out_insn'
>     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
>                                                                 ^
> /users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:1610:27: warning: implicit conversion from enumeration type 'TCGType' (aka 'enum TCGType') to different enumeration type 'TCGMemOp' (aka 'enum TCGMemOp')
>       [-Wenum-conversion]
>         tcg_out_brcond(s, ext, a2, a0, a1, const_args[1], arg_label(args[3]));
>         ~~~~~~~~~~~~~~    ^~~
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tcg/aarch64/tcg-target.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I haven't seen this, but I've also just noticed that the gcc farm aarch64 
machine is using gcc 4.8.5, so that could be it.

Applied.


r~
