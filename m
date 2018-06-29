Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYoo5-00025I-25
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYoo1-0003O3-8V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:31:05 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYoo1-0003NN-25
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:31:01 -0400
Received: by mail-ot0-x22b.google.com with SMTP id w22-v6so9113832otk.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:31:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-3-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:30:39 +0100
Message-ID: <CAFEAcA_7sR4ya3LO0HLJze8H8y4YeBb-AXETWYcK6MCvbE=zuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] target/arm: Fix SVE system register
 access checks
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

On 29 June 2018 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Leave ARM_CP_SVE, removing ARM_CP_FPU; the sve_access_check
> produced by the flag already includes fp_access_check.  If
> we also check ARM_CP_FPU the double fp_access_check asserts.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
