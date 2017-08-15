Received: from eggs.gnu.org ([2001:4830:134:3::10]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhfSh-0002W5-3q
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhfSg-0007nR-5g
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:17:03 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhfSf-0007n0-Vr
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:17:02 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m85so13293598wma.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:17:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815145714.17635-1-richard.henderson@linaro.org>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 18:16:40 +0100
Message-ID: <CAFEAcA8g28owwY-Jsx-Zah773sHcjZGLT28BCuD-pqP4Ec-Rmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 0/3] Fixup logic for exclusive
 pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 15 August 2017 at 15:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
> In reviewing my previous patch, Peter pointed out that it is
> CONSTRAINED UNPREDICTABLE what happens when you mix the number
> of registers in a LDX[PR] + STX[RP] pair.  So most of the bug
> that I thought that I was fixing isn't a bug at all.
>
> That said, the patch does still fix a real bug wrt single-copy
> semantics, so patch 2 is largely unchanged; the commit message
> is re-worded.
>
> I also un-squashed Alistair's original patches and dropped the
> tcg/tcg-op.c change, to be revisited for 2.11.

Applied to master (with various reviewed-by etc tags, and
the typos in the commit message for 3/3 fixed).

thanks
-- PMM
