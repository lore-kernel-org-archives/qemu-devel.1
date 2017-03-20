Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpuqw-0001kK-It
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpuqr-000862-O4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:47:54 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpuqr-00085o-Gw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:47:49 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so59879703wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:47:49 -0700 (PDT)
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
	<1487616072-9226-2-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1487616072-9226-2-git-send-email-peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 10:48:12 +0000
Message-ID: <87r31sns0j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] arm: HVC and SMC encodings don't exist
 for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> M profile doesn't have the HVC or SMC encodings, so make them always
> UNDEF rather than generating calls to helper functions that assume
> A/R profile.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 9fded03..895b399 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10365,6 +10365,9 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>                      goto illegal_op;
>
>                  if (insn & (1 << 26)) {
> +                    if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +                        goto illegal_op;
> +                    }
>                      if (!(insn & (1 << 20))) {
>                          /* Hypervisor call (v7) */
>                          int imm16 = extract32(insn, 16, 4) << 12


--
Alex Bennée
