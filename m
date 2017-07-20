Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHS2-0008PM-LM
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHRz-0005Nh-GP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:49:34 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-16-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <38211f3f-b5c5-003c-f568-eb9088c09f4e@twiddle.net>
Date: Thu, 20 Jul 2017 09:49:23 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 15/23]
 target/arm/translate-a64.c: AdvSIMD scalar 2 register misc decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> +    for (pass = 0; pass < elements; pass++) {
> +        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
> +        TCGv_i32 tcg_res = tcg_temp_new_i32();
> +
> +        read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
> +
> +        switch (fpopcode) {
> +        default:
> +            fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpopcode);
> +            unsupported_encoding(s, insn);
> +        }

Just noticing that we ought not issue N copies of the unsupported_encoding 
exception.  Return afterwards seems in order.  Is this a pattern that you 
copied that wants fixing elsewhere?


r~
