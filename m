Received: from eggs.gnu.org ([2001:4830:134:3::10]:35820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HqK-0001DN-Ob
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HqJ-0001gz-Vg
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:23:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HqJ-0001PB-PV
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:23:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id 36-v6so1318933oth.11
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:23:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926192323.12659-7-richard.henderson@linaro.org>
References: <20180926192323.12659-1-richard.henderson@linaro.org>
	<20180926192323.12659-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:23:17 +0100
Message-ID: <CAFEAcA9Tx3PwbAPyOSPhfB84THtZGRY0Ma-=kKNVi1HVVNbrkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/15] target/arm: Clear unused
 predicate bits for LD1RQ
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

On 26 September 2018 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The 16-byte load only uses 16 predicate bits.  But while
> reusing the other load infrastructure, we find other bits
> that are set and trigger an assert.  To avoid this and
> retain the assert, zero-extend the predicate that we pass
> to the LD1 helper.
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
