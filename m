Received: from eggs.gnu.org ([2001:4830:134:3::10]:36493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5dcq-0006XZ-Fg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5dcp-0005LW-Nb
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:20 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5dcp-0005Kz-Hc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:19 -0400
Date: Tue, 2 May 2017 21:38:14 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170502193814.r7g62g3crckyvb4b@aurel32.net>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170430145254.25616-1-aurelien@aurel32.net>
	<20170430145254.25616-2-aurelien@aurel32.net>
	<6a006ce5-303a-23cc-934f-6a1a71833b2e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a006ce5-303a-23cc-934f-6a1a71833b2e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5++ 1/3] tcg/mips: implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>

On 2017-05-02 18:21, Richard Henderson wrote:
> On 04/30/2017 04:52 PM, Aurelien Jarno wrote:
> > +        /* jmp to the given host address (could be epilogue) */
> > +        tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
> > +        tcg_out_nop(s);
> 
> Any particular reason not to do the zeroing in the delay slot...
> 
> > +    s->code_gen_epilogue = s->code_ptr;
> > +    tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);
> 
> ... instead of here?

There is no particular reason in the current usage of goto_ptr. It's
just that in the future we might want to use code_gen_epilogue for
other reasons or use the tcg_out_opc_reg to do other things. It's
probably better to have a consistent behaviour across all TCG
targets.

That said if you prefer, I am find sending a v2 with the zeroing moved
to the delay slot.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
