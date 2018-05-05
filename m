Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEx9E-00027D-2x
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEx99-00037M-Bj
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:22:48 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEx99-000367-3b
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:22:43 -0400
Received: by mail-lf0-x243.google.com with SMTP id w8-v6so34677487lfe.3
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 06:22:43 -0700 (PDT)
Date: Sat, 5 May 2018 15:22:40 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180505132240.goq3tg673deoksaw@toto>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-21-edgar.iglesias@gmail.com>
	<448d1eaa-2ce9-6ce9-ea98-3d00e091f320@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448d1eaa-2ce9-6ce9-ea98-3d00e091f320@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 20/29] target-microblaze: Make special
 registers 64-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On Thu, May 03, 2018 at 12:03:19PM -0700, Richard Henderson wrote:
> On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Extend special registers to 64-bits. This is in preparation for
> > MFSE/MTSE, moves to and from extended special registers.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> > @@ -1124,13 +1125,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
> >      }
> >  }
> >  
> > -static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
> > +static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
> >  {
> >      TCGLabel *l1 = gen_new_label();
> >      /* Conditional jmp.  */
> > -    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_false);
> > +    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
> >      tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
> > -    tcg_gen_mov_i32(cpu_SR[SR_PC], pc_true);
> > +    tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
> >      gen_set_label(l1);
> >  }
> 
> For future cleanup, this should use tcg_gen_movcond_i32.

Thanks, I've added a follow-up patch in v2 that cleans this up.

Cheers,
Edgar
