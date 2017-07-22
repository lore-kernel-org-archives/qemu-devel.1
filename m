Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYroh-0004kG-SK
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYroe-0001JG-Pe
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:39:23 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYroe-0001J2-H3
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:39:20 -0400
Received: by mail-pf0-x243.google.com with SMTP id d18so6641135pfe.4
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 03:39:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-8-rth@twiddle.net>
	<20170721213743.GE10809@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cccb194c-b885-25f2-3eb4-e56bf4b78f5a@twiddle.net>
Date: Sat, 22 Jul 2017 00:39:13 -1000
MIME-Version: 1.0
In-Reply-To: <20170721213743.GE10809@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 07/34] target/arm: Set is_jmp properly
 after single-stepping
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

On 07/21/2017 11:37 AM, Emilio G. Cota wrote:
>>                           gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
>> +                        dc->is_jmp = DISAS_NORETURN;
> 
> gen_exception_internal_insn already sets dc->is_jmp to DISAS_NORETURN,
> as per patch 04/34:
> @@ -304,7 +304,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
>   {
>       gen_a64_set_pc_im(s->pc - offset);
>       gen_exception_internal(excp);
> -    s->is_jmp = DISAS_EXC;
> +    s->is_jmp = DISAS_NORETURN;
>   }
> 
> This applies to both arm and a64.
> 
> Why do we need to set is_jmp again, then?

Because I confused gen_exception_internal, which does not.
I have dropped this patch.


r~
