Received: from eggs.gnu.org ([209.51.188.92]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHRm-00047N-TF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHRk-0004Ab-QC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guHRk-00048z-Kz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:53:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id z19so10606246otm.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20190206052857.5077-1-richard.henderson@linaro.org>
	<20190206052857.5077-3-richard.henderson@linaro.org>
In-Reply-To: <20190206052857.5077-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 13:52:48 +0000
Message-ID: <CAFEAcA9kqwZfE5fr2ajoUqUbY1Dx7Hvrecd4ySTVev58TQs=Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/arm: Restructure
 disas_fp_int_conv
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

On Wed, 6 Feb 2019 at 05:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For opcodes 0-5, move some if conditions into the structure
> of a switch statement.  For opcodes 6 & 7, decode everything
> at once with a second switch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
