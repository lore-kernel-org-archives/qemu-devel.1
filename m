Received: from eggs.gnu.org ([2001:4830:134:3::10]:34912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM8LT-0006jq-Sh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM8LL-0004c4-Vh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:17:20 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM8LL-0004al-PK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:17:15 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so3638286ybj.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 01:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-12-f4bug@amsat.org>
	<c34eda41-8c27-6c61-a53f-eae06da63fd9@linaro.org>
In-Reply-To: <c34eda41-8c27-6c61-a53f-eae06da63fd9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 10:17:01 +0100
Message-ID: <CAAdtpL6Jrt5VN3bSLFLRfQAk6w+T4o-m9Wo90hkkgT8+n4kX7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] target/mips: Port MIPS64
 DCL[Z/O] to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Nov 12, 2018 at 10:15 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/12/18 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > +dclz            011100 ..... ..... ..... ..... 100100   @rs_rt_rd   ?c=
tx->insn_flags&ISA_MIPS64
> > +dclo            011100 ..... ..... ..... ..... 100101   @rs_rt_rd   ?c=
tx->insn_flags&ISA_MIPS64
>
> This syntax I do not like.  I preferred your other form,
>
>   >isa(ISA_MIPS64)
>
> which, with a change to return false as I suggested, would
> have the same effect.
>
> As an aside, you could do
>
> #define check_isa(ctx, which)  ((ctx)->insn_flags & ISA_##which)
>
> to reduce the decode markup to
>
>   >isa(MIPS64)

Very good idea! Thanks :)
