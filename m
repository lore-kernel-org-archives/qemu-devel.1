Received: from eggs.gnu.org ([209.51.188.92]:49435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJOU-0000Oy-R0
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJOT-0003Eq-R1
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:42493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJOT-0003Dv-Jw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id 13so5081422pfw.9
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:49:37 -0700 (PDT)
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-2-S.E.Harris@kent.ac.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <772cbab8-49a2-8969-ba3e-55f190c886ff@linaro.org>
Date: Sun, 5 May 2019 08:49:33 -0700
MIME-Version: 1.0
In-Reply-To: <20190504083638.13380-2-S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] target/avr: Add instruction decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, A.M.King@kent.ac.uk, E.J.C.Robbins@kent.ac.uk

On 5/4/19 1:36 AM, Sarah Harris wrote:
> This utility module builds a decision tree to decode instructions, starting from a human readable list of instruction bit patterns.
> Automatic tree generation will hopefully be more efficient and more maintainable than a hand-designed opcode parser.
> 
> Tree generation happens at startup because this seemed simpler to implement than adding a new build step.

We have such a thing in qemu already, as a separate build step.

See ./scripts/decodetree.py, and some of the uses in

  target/{arm,hppa,riscv}/*.decode

In addition to being able to select the instruction, it also
extracts arguments from the instruction, so there's less
repetition that you have for e.g.

 > +static inline uint32_t MOVW_Rr(uint32_t opcode)
> +{
> +    return extract32(opcode, 0, 4);
> +}
...
> +static inline uint32_t MULS_Rr(uint32_t opcode)
> +{
> +    return extract32(opcode, 0, 4);
> +}


r~
