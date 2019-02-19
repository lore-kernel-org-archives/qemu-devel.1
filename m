Received: from eggs.gnu.org ([209.51.188.92]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw7KT-0005HO-4y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw7KR-0005Tu-Aq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:04 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw7KQ-00052x-QD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:03 -0500
Received: by mail-ot1-x344.google.com with SMTP id c18so13201375otl.13
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-2-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 15:28:33 +0000
Message-ID: <CAFEAcA8+wxqG26CyeUdf4S_Hu=L2PmwZhKxF0DXcx5V-qsHa+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/8] target/arm: Restructure
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For opcodes 0-5, move some if conditions into the structure
> of a switch statement.  For opcodes 6 & 7, decode everything
> at once with a second switch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 94 ++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 45 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(this is identical to the JSConv v2 patchset patch 2 which I
reviewed, as far as I can tell.)

thanks
-- PMM
