Received: from eggs.gnu.org ([209.51.188.92]:34853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw7OK-0007jT-Cw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw7OJ-0001Q0-8s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:33:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw7OH-0001Fq-BM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:33:03 -0500
Received: by mail-ot1-x341.google.com with SMTP id t7so18411606otk.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-3-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 15:32:41 +0000
Message-ID: <CAFEAcA-O57_LTcBHwWPQqGR0yvaipAvBF4HBdHbJcepRaQNRZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/arm: Split out vfp_helper.c
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move all of the fp helpers out of helper.c into a new file.
> This is code movement only.  Since helper.c has no copyright
> header, take the one from cpu.h for the new file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c      | 1062 -------------------------------------
>  target/arm/vfp_helper.c  | 1088 ++++++++++++++++++++++++++++++++++++++
>  target/arm/Makefile.objs |    2 +-
>  3 files changed, 1089 insertions(+), 1063 deletions(-)
>  create mode 100644 target/arm/vfp_helper.c
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(confirmed the code motion using git diff --color-moved)

thanks
-- PMM
