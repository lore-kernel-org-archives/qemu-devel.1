Received: from eggs.gnu.org ([2001:4830:134:3::10]:57591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMpR-0002oo-SW
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMpQ-0005Wq-42
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:46:37 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWMpP-0005Vl-SG
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:46:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so10637467otk.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20181206175541.29508-1-richard.henderson@linaro.org>
	<20181206175541.29508-4-richard.henderson@linaro.org>
In-Reply-To: <20181206175541.29508-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 14:46:23 +0000
Message-ID: <CAFEAcA8XcFTayLj7GT+ff4jfhRt5SkHmam5h0bSrHBE8SNNOgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] target/arm: Implement the
 ARMv8.1-LOR extension
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

On Thu, 6 Dec 2018 at 17:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a trivial implementation with zero limited ordering regions,
> which causes the LDLAR and STLLR instructions to devolve into the
> LDAR and STLR instructions from the base ARMv8.0 instruction set.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2: Mark LORID_EL1 read-only.
>     Add TLOR access checks.
>     Conditionally unmask TLOR in hcr/scr_write.
> v3: Fix isar_feature_aa64_lor.
>     Split out access_lor_ns.
>     Defer all {E2H,TGE} vs TLOR testing to arm_hcr_el2_eff.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
