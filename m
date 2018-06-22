Received: from eggs.gnu.org ([2001:4830:134:3::10]:55963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWO0j-0007O4-7f
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWO0f-0006xt-Cm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:30:05 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWO0f-0006xd-65
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:30:01 -0400
Received: by mail-ot0-x244.google.com with SMTP id c15-v6so7935666otl.3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-2-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 16:29:40 +0100
Message-ID: <CAFEAcA84C7iU8eT2KK7DA68kjaKCcfyAfrQQhHZPCbk6Z_qqsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 01/35] target/arm: Implement SVE Memory
 Contiguous Load Group
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  35 +++++++++
>  target/arm/sve_helper.c    | 153 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 121 +++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  34 +++++++++
>  4 files changed, 343 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
