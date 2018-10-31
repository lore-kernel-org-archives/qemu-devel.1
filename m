Received: from eggs.gnu.org ([2001:4830:134:3::10]:49884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtUA-0001ug-Ba
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtU9-0006Qa-I6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtU9-0006QE-Ae
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id r10-v6so17236199wrv.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:36:49 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-45-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-45-cota@braap.org>
Date: Wed, 31 Oct 2018 16:36:46 +0000
Message-ID: <87h8h26pk1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 45/71] hppa: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/hppa/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..1ab4e62850 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -60,7 +60,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, =
TranslationBlock *tb)
>
>  static bool hppa_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
>  }
>
>  static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)


--
Alex Benn=C3=A9e
