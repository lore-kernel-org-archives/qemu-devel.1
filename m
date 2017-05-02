Received: from eggs.gnu.org ([2001:4830:134:3::10]:55512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5aYt-0003U0-Dh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5aYp-0001Ew-AG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:22:00 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5aYp-0001BL-5n
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:21:59 -0400
Received: by mail-qt0-x243.google.com with SMTP id c45so21008848qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:21:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170430145254.25616-1-aurelien@aurel32.net>
	<20170430145254.25616-2-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6a006ce5-303a-23cc-934f-6a1a71833b2e@twiddle.net>
Date: Tue, 2 May 2017 18:21:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170430145254.25616-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5++ 1/3] tcg/mips: implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

On 04/30/2017 04:52 PM, Aurelien Jarno wrote:
> +        /* jmp to the given host address (could be epilogue) */
> +        tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
> +        tcg_out_nop(s);

Any particular reason not to do the zeroing in the delay slot...

> +    s->code_gen_epilogue = s->code_ptr;
> +    tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);

... instead of here?


r~
