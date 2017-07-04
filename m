Received: from eggs.gnu.org ([2001:4830:134:3::10]:55742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSWSR-0001Py-68
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSWSN-0004Rt-4r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:38:11 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:36481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSWSM-0004Rg-TV
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:38:07 -0400
Received: by mail-pf0-x22b.google.com with SMTP id q86so120155512pfl.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 15:38:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<CAK4993hiFSozkL-5B0gud-nPVFqcvP2mgBR1Rk1vQSmhts3fGQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7103e7ca-1504-58b0-1f32-aabba7f45792@twiddle.net>
Date: Tue, 4 Jul 2017 12:38:01 -1000
MIME-Version: 1.0
In-Reply-To: <CAK4993hiFSozkL-5B0gud-nPVFqcvP2mgBR1Rk1vQSmhts3fGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 00/13] QEMU AVR 8 bit cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Anichang <anichang@protonmail.ch>

On 06/21/2017 09:15 PM, Michael Rolnik wrote:
> Hi all,
> 
> are there any action items for me?

What kind of testing are you doing for this?

I just briefly browsed through the code again and happened to see that ROR has 
a critical typo.  Considering that ROR must be used for multi-byte shifts, I'm 
wondering how you wouldn't have found this via even cursory testing.

> +int avr_translate_ROR(CPUAVRState *env, DisasContext *ctx, uint32_t opcode)
> +{
> +    TCGv Rd = cpu_r[ROR_Rd(opcode)];
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    tcg_gen_shli_tl(t0, cpu_Cf, 7);
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 0);


r~
