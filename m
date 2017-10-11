Received: from eggs.gnu.org ([2001:4830:134:3::10]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Dm8-0002ey-Pq
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Dm7-0002Ak-W9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:58:04 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:57055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2Dm7-00024m-PV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:58:03 -0400
Received: by mail-wr0-x232.google.com with SMTP id r79so841396wrb.13
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 02:58:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3bab968b-3476-55c2-ba7d-ffd2b902e532@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-9-git-send-email-peter.maydell@linaro.org>
	<3bab968b-3476-55c2-ba7d-ffd2b902e532@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 10:57:42 +0100
Message-ID: <CAFEAcA8OzWu9KqA4MuTYst0o4K60wythCf0u7UuPHjp0q7NAxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Support some Thumb insns
 being always unconditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 11 October 2017 at 03:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/09/2017 06:48 AM, Peter Maydell wrote:
>> -    if (dc->condexec_mask) {
>> +    if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
>>          uint32_t cond = dc->condexec_cond;
>>
>>          if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
>
> Don't you still need to advance the condexec_mask?

Yes -- that happens after we've called disas_thumb{,2}_insn()
in thumb_tr_translate_insn().

This patch just makes always-unconditional insns behave
as if the condition is AL.

thanks
-- PMM
