Received: from eggs.gnu.org ([209.51.188.92]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Hua-0002eX-H1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2HuZ-0001g1-OA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:59:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2HuZ-0001fT-J5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:59:51 -0500
Received: by mail-ot1-x341.google.com with SMTP id c18so17743688otl.13
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 07:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20190307201244.8971-1-richard.henderson@linaro.org>
In-Reply-To: <20190307201244.8971-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 15:59:38 +0000
Message-ID: <CAFEAcA86PA-VOZ+o=PZ8b4ZM-zrLjp4gK1PiR5AEWzjPddCshw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: gdbstub system registers
 refinement
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

On Thu, 7 Mar 2019 at 20:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This was working toward fixing
>
>   https://bugs.linaro.org/show_bug.cgi?id=4274
>
> although I don't think I'm entirely successful.  I would argue,
> however, that gdb's behaviour in this is odd.  Why are registers
> that are clearly marked "system" being added to "general" simply
> because they have integer type?

Yeah, this does seem to me like it might be a bug on
gdb's end -- are you following up with them?

> In the meantime, we don't really need to present these registers
> to the user for CONFIG_USER_ONLY.

Reasonable enough, I guess, though a few sysregs are
visible to EL0.

thanks
-- PMM
