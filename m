Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5gu-0008Qj-L9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk5gt-0000nv-PV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:46:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk5gt-0000nh-Iv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:46:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so20327957oic.12
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 03:46:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <83728e91-de69-c376-a768-0aad501ff64e@twiddle.net>
References: <1527229488-49822-1-git-send-email-mjc@sifive.com>
	<83728e91-de69-c376-a768-0aad501ff64e@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 11:45:54 +0100
Message-ID: <CAFEAcA-hOTPOfW7ruRsSYt32Ahu707iMJtXdXkUREpLyHdFwJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Correct typo in RV32 perf counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Michael Clark <mjc@sifive.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 25 May 2018 at 14:17, Richard Henderson <rth@twiddle.net> wrote:
> On 05/24/2018 11:24 PM, Michael Clark wrote:
>> This patch enables mhpmcounter3h through mhpmcounter31h on RV32.
>> Previously the RV32 h versions (high 32-bits of 64-bit counters)
>> of these counters would trap with an illegal instruction instead
>> of returning 0 as intended.
>>
>> Reported-by: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
>>  target/riscv/op_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Fixes: Coverity CID 1390849
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ping -- Coverity is still complaining about this -- did this
patch get lost?

thanks
-- PMM
