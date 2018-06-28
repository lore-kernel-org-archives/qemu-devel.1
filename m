Received: from eggs.gnu.org ([2001:4830:134:3::10]:48196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZjl-0006sM-Rj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZjl-0004b0-0b
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:25:37 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZjk-0004Zv-5c
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:25:36 -0400
Received: by mail-oi0-x244.google.com with SMTP id 21-v6so5743749oip.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:25:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-13-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-13-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:25:15 +0100
Message-ID: <CAFEAcA-dBq8vTB8sqxJ7_FjeHrteS58J-+2i_iYFH6iH6GWXMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 12/13] target/arm: Mark PMINTENSET
 accesses as possibly doing IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> This makes it match its AArch64 equivalent, PMINTENSET_EL1
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96667e6..38fb6a2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1763,7 +1763,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .writefn = pmuserenr_write, .raw_writefn = raw_write },
>      { .name = "PMINTENSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_tpm,
> -      .type = ARM_CP_ALIAS,
> +      .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pminten),
>        .resetvalue = 0,
>        .writefn = pmintenset_write, .raw_writefn = raw_write },

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Shouldn't PMINTENCLR and PMINTENCLR_EL1 also be ARM_CP_IO ?

thanks
-- PMM
