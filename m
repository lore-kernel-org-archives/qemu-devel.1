Received: from eggs.gnu.org ([2001:4830:134:3::10]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MWC-0005W8-Bl
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MW8-0004zQ-Lz
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:03:16 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:46432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8MW8-0004xY-Gh
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:03:12 -0400
Received: by mail-ot0-x22b.google.com with SMTP id v64-v6so20575560otb.13
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 02:03:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417025328.25431-2-richard.henderson@linaro.org>
References: <20180417025328.25431-1-richard.henderson@linaro.org>
	<20180417025328.25431-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 10:02:51 +0100
Message-ID: <CAFEAcA--xC1j7Wd=uzFkM74K=AYfFxcHda=q=LpANV4o=E+Yyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] fpu: Check for inf/x before x/0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 17 April 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The re-factoring of div_floats changed the order of checking meaning
> an operation like -inf/0 erroneously raises the divbyzero flag.
> IEEE-754 (2008) specifies this should only occur for operations
> on finite operands.
>
> We fix this by moving the check on the dividend being Inf/0 to
> before the divisor is zero check.
>

I've applied Alex's fix to master for this, since it seems
more straightforward.

thanks
-- PMM
