Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3Jj-00046i-Qn
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3Je-0006NS-57
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:10:09 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG3Je-0006NA-0U
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:10:06 -0400
Received: by mail-ot0-x235.google.com with SMTP id m11-v6so30026935otf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 07:10:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504224521.7801-1-richard.henderson@linaro.org>
References: <20180504183021.19318-1-richard.henderson@linaro.org>
	<20180504224521.7801-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 15:09:44 +0100
Message-ID: <CAFEAcA8U4sy2Kt+W4gcqiTePr5Po36SFww768nDDKhrtMB2Bhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/10] target/arm: Fill in
 disas_ldst_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 4 May 2018 at 23:45, Richard Henderson <richard.henderson@linaro.org> wrote:
> This implements all of the v8.1-Atomics instructions except
> for compare-and-swap, which is decoded elsewhere.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Do not zero-extend X[s] via the third parameter to read_cpu_reg.

Can you just resend the full series, please? Sending a single
patch rather than the whole thing means that 'patches' complains
about "series is either incomplete or improperly threaded",
and my eyeball for updated versions to add to my to-review
queue generally skips over patches which aren't cover letters
or single-patches...

thanks
-- PMM
