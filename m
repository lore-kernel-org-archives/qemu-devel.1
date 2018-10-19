Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDSAr-0001w2-Aw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDSAq-0008RD-KB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:38:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDSAq-0008PR-6p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:38:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id s69-v6so26408940oie.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:38:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 11:38:11 +0100
Message-ID: <CAFEAcA9BiW_7uCVjLHWN=upUvNTK9xuv-jbtkr+_zyZZ8SU4Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/8] target/arm: Rely on id regs instead
 of features
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

On 16 October 2018 at 23:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This edition moves some of the system registers into a substructure,
> which is then shared with "normal" runtime and the translators.
> This is seen as a better solution than letting the entire translator
> have access to the main ARMCPU structure.
>
> Also after rebasing on mainline, there was a new cortex-m33 failure
> caused by v8m implying v7ve implying arm_div.
>



Applied to target-arm.next, thanks.

-- PMM
