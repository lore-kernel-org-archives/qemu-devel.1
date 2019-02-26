Received: from eggs.gnu.org ([209.51.188.92]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gygSn-0001oL-Hp
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gygSm-0007rM-Pk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:24:17 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gygSk-0007pL-Gt
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:24:15 -0500
Received: by mail-ot1-x344.google.com with SMTP id b3so11764100otp.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20190219222952.22183-1-richard.henderson@linaro.org>
In-Reply-To: <20190219222952.22183-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 17:23:59 +0000
Message-ID: <CAFEAcA_BDFaTpAc_e7hRB9NM+oiyjXHLRDin6cFo0W83q5H32A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/5] target/arm: Implement ARMv8.2-FHM
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

On Tue, 19 Feb 2019 at 22:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v4:
>
> Fixed the FZ16 issue.
> Add the aa64 HWCAP bits for both JSConv and FHM.
>
>
> r~
>
>
> Richard Henderson (5):
>   target/arm: Add helpers for FMLAL
>   target/arm: Implement FMLAL and FMLSL for aarch64
>   target/arm: Implement VFMAL and VFMSL for aarch32
>   target/arm: Enable ARMv8.2-FHM for -cpu max
>   linux-user: Enable HWCAP_ASIMDFHM, HWCAP_JSCVT



Applied to target-arm.next, thanks.

-- PMM
