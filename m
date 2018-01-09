Received: from eggs.gnu.org ([2001:4830:134:3::10]:41793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYund-0000Cz-Cj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYunc-0007GZ-Cr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:22:45 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYunc-0007FA-8t
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:22:44 -0500
Received: by mail-ot0-x243.google.com with SMTP id h2so11448741oti.5
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:22:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52515faf-f889-93ee-c0d0-4a895cfb6b13@linaro.org>
References: <1513080506-17703-1-git-send-email-peter.maydell@linaro.org>
	<52515faf-f889-93ee-c0d0-4a895cfb6b13@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:22:23 +0000
Message-ID: <CAFEAcA-J4MwnyusPgB7V3LK2c4G-OCJx3ReVO27riM761mv9jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Make disas_thumb2_insn()
 generate its own UNDEF exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 12 December 2017 at 17:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 12/12/2017 04:08 AM, Peter Maydell wrote:
>> Refactor disas_thumb2_insn() so that it generates the code for raising
>> an UNDEF exception for invalid insns, rather than returning a flag
>> which the caller must check to see if it needs to generate the UNDEF
>> code. This brings the function in to line with the behaviour of
>> disas_thumb_insn() and disas_arm_insn().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This fixes the odd asymmetry of API that caused the bug fixed
>> in commit 7472e2efb...
>> ---
>>  target/arm/translate.c | 23 ++++++++++-------------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied to target-arm.next.

-- PMM
