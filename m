Received: from eggs.gnu.org ([2001:4830:134:3::10]:43719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e2Hm6-00046q-EV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e2Hm1-00042V-Gp
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:14:18 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-9-git-send-email-peter.maydell@linaro.org>
	<3bab968b-3476-55c2-ba7d-ffd2b902e532@linaro.org>
	<CAFEAcA8OzWu9KqA4MuTYst0o4K60wythCf0u7UuPHjp0q7NAxQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24680aa9-fa29-821f-30ad-0a03b901aa9d@twiddle.net>
Date: Wed, 11 Oct 2017 07:14:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OzWu9KqA4MuTYst0o4K60wythCf0u7UuPHjp0q7NAxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10/11/2017 02:57 AM, Peter Maydell wrote:
> On 11 October 2017 at 03:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 10/09/2017 06:48 AM, Peter Maydell wrote:
>>> -    if (dc->condexec_mask) {
>>> +    if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
>>>          uint32_t cond = dc->condexec_cond;
>>>
>>>          if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
>>
>> Don't you still need to advance the condexec_mask?
> 
> Yes -- that happens after we've called disas_thumb{,2}_insn()
> in thumb_tr_translate_insn().

Ah, mis-read the context of this hunk.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
