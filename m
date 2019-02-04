Received: from eggs.gnu.org ([209.51.188.92]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqfcz-0008Dt-Hx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqfcy-0006ab-ES
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:53:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqfcy-0006Q3-1M
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:53:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id p6so169390wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:53:24 -0800 (PST)
References: <20190204132126.3255-1-richard.henderson@linaro.org>
	<20190204132126.3255-4-richard.henderson@linaro.org>
	<CAFEAcA84U00c=_q2Okkpd3vpwEC6O7KHMcz5NDTch+yOLLtd-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <709d3196-18c8-1823-b73d-a6fee441f043@linaro.org>
Date: Mon, 4 Feb 2019 14:53:19 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84U00c=_q2Okkpd3vpwEC6O7KHMcz5NDTch+yOLLtd-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] target/arm: Compute TB_FLAGS for
 TBI for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/4/19 2:45 PM, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 13:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Enables, but does not turn on, TBI for CONFIG_USER_ONLY.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> This patch turns out to break compilation of the linux-user
> targets with clang, which is stricter than gcc about warning about
> unused static functions.
> 
> I propose to squash in the following fixup patch:

Thanks, that works for me.


r~
