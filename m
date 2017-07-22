Received: from eggs.gnu.org ([2001:4830:134:3::10]:51249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYs9U-0000WB-2J
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 07:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYs9O-00050G-LZ
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 07:00:52 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYs9O-0004ze-Gq
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 07:00:46 -0400
Received: by mail-pg0-x241.google.com with SMTP id s4so7384762pgr.5
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 04:00:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-34-rth@twiddle.net>
	<20170722003531.GB9909@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <78a94eac-6743-0ed9-2927-2bcaff11720e@twiddle.net>
Date: Sat, 22 Jul 2017 01:00:37 -1000
MIME-Version: 1.0
In-Reply-To: <20170722003531.GB9909@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 33/34] target/arm: Split out
 thumb_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On 07/21/2017 02:35 PM, Emilio G. Cota wrote:
>   static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
>   {
> +    if (dc->condjmp && !dc->base.is_jmp) {
> +        gen_set_label(dc->condlabel);
> +        dc->condjmp = 0;
> +    }
> +

Thanks for the catch.

I have merged the !dc->base.is_jmp check with the
following dc->base.is_jmp == DISAS_NEXT.

I hope that's clearer.


r~
