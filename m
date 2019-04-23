Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CD320645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIqpT-0003ey-Bm
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:31:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqm6-0000y0-NG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqm4-0007NI-Td
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqm4-0007Mk-KU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A087533024A;
	Tue, 23 Apr 2019 08:27:31 +0000 (UTC)
Received: from [10.36.117.135] (ovpn-117-135.ams2.redhat.com [10.36.117.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5C606092D;
	Tue, 23 Apr 2019 08:27:30 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-4-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
	dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
	QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
	XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
	Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
	PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
	WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
	UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
	jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
	B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
	ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
	BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
	8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
	xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
	jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
	s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
	m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
	MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
	z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
	dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
	UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
	7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
	uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
	0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
	2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
	xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
	8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
	hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
	u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
	gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
	rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
	BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
	KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
	NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
	YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
	lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
	qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
	C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
	W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
	TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
	+8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <983c65b8-047e-635f-f6a5-c0dbeffb39aa@redhat.com>
Date: Tue, 23 Apr 2019 10:27:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 23 Apr 2019 08:27:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/38] tcg: Return bool success from
 tcg_out_mov
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423082730.h57rnXR-EUid5ZYz6yAn7rbRj8SZoWxz9jxHKbQH1IE@z>

On 20.04.19 09:34, Richard Henderson wrote:
> This patch merely changes the interface, aborting on all failures,
> of which there are currently none.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c |  5 +++--
>  tcg/arm/tcg-target.inc.c     |  7 +++++--
>  tcg/i386/tcg-target.inc.c    |  5 +++--
>  tcg/mips/tcg-target.inc.c    |  3 ++-
>  tcg/ppc/tcg-target.inc.c     |  3 ++-
>  tcg/riscv/tcg-target.inc.c   |  5 +++--
>  tcg/s390/tcg-target.inc.c    |  3 ++-
>  tcg/sparc/tcg-target.inc.c   |  3 ++-
>  tcg/tcg.c                    | 14 ++++++++++----
>  tcg/tci/tcg-target.inc.c     |  3 ++-
>  10 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 8b93598bce..b2d3f9c0a5 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -938,10 +938,10 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
>      tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
>  }
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>  {
>      if (ret == arg) {
> -        return;
> +        return true;
>      }
>      switch (type) {
>      case TCG_TYPE_I32:
> @@ -970,6 +970,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>      default:
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>  
>  static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 6873b0cf95..34e6652142 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -2275,10 +2275,13 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
>      return false;
>  }
>  
> -static inline void tcg_out_mov(TCGContext *s, TCGType type,
> +static inline bool tcg_out_mov(TCGContext *s, TCGType type,
>                                 TCGReg ret, TCGReg arg)
>  {
> -    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
> +    if (ret != arg) {
> +        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
> +    }
> +    return true;
>  }
>  
>  static inline void tcg_out_movi(TCGContext *s, TCGType type,
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 1fa833840e..817a167767 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -809,12 +809,12 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
>      tcg_out_modrm(s, OPC_ARITH_GvEv + (subop << 3) + ext, dest, src);
>  }
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>  {
>      int rexw = 0;
>  
>      if (arg == ret) {
> -        return;
> +        return true;
>      }
>      switch (type) {
>      case TCG_TYPE_I64:
> @@ -852,6 +852,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>      default:
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>  
>  static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 8a92e916dd..f31ebb43bf 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -558,13 +558,14 @@ static inline void tcg_out_dsra(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
>      tcg_out_opc_sa64(s, OPC_DSRA, OPC_DSRA32, rd, rt, sa);
>  }
>  
> -static inline void tcg_out_mov(TCGContext *s, TCGType type,
> +static inline bool tcg_out_mov(TCGContext *s, TCGType type,
>                                 TCGReg ret, TCGReg arg)
>  {
>      /* Simple reg-reg move, optimising out the 'do nothing' case */
>      if (ret != arg) {
>          tcg_out_opc_reg(s, OPC_OR, ret, arg, TCG_REG_ZERO);
>      }
> +    return true;
>  }
>  
>  static void tcg_out_movi(TCGContext *s, TCGType type,
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 773690f1d9..ec8e336be8 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -566,12 +566,13 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>  static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
>                               TCGReg base, tcg_target_long offset);
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>  {
>      tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
>      if (ret != arg) {
>          tcg_out32(s, OR | SAB(arg, ret, arg));
>      }
> +    return true;
>  }
>  
>  static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index b785f4acb7..e2bf1c2c6e 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -515,10 +515,10 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>   * TCG intrinsics
>   */
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>  {
>      if (ret == arg) {
> -        return;
> +        return true;
>      }
>      switch (type) {
>      case TCG_TYPE_I32:
> @@ -528,6 +528,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>      default:
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>  
>  static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 7db90b3bae..eb22188d1d 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -548,7 +548,7 @@ static void tcg_out_sh32(TCGContext* s, S390Opcode op, TCGReg dest,
>      tcg_out_insn_RS(s, op, dest, sh_reg, 0, sh_imm);
>  }
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
>  {
>      if (src != dst) {
>          if (type == TCG_TYPE_I32) {
> @@ -557,6 +557,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
>              tcg_out_insn(s, RRE, LGR, dst, src);
>          }
>      }
> +    return true;
>  }
>  
>  static const S390Opcode lli_insns[4] = {
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index 7a61839dc1..83295955a7 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -407,12 +407,13 @@ static void tcg_out_arithc(TCGContext *s, TCGReg rd, TCGReg rs1,
>                | (val2const ? INSN_IMM13(val2) : INSN_RS2(val2)));
>  }
>  
> -static inline void tcg_out_mov(TCGContext *s, TCGType type,
> +static inline bool tcg_out_mov(TCGContext *s, TCGType type,
>                                 TCGReg ret, TCGReg arg)
>  {
>      if (ret != arg) {
>          tcg_out_arith(s, ret, arg, TCG_REG_G0, ARITH_OR);
>      }
> +    return true;
>  }
>  
>  static inline void tcg_out_sethi(TCGContext *s, TCGReg ret, uint32_t arg)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 4f77a957b0..b083faacd2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -102,7 +102,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
>                                             const char *ct_str, TCGType type);
>  static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
>                         intptr_t arg2);
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
>  static void tcg_out_movi(TCGContext *s, TCGType type,
>                           TCGReg ret, tcg_target_long arg);
>  static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
> @@ -3372,7 +3372,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>                                           allocated_regs, preferred_regs,
>                                           ots->indirect_base);
>              }
> -            tcg_out_mov(s, otype, ots->reg, ts->reg);
> +            if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
> +                abort();
> +            }
>          }
>          ots->val_type = TEMP_VAL_REG;
>          ots->mem_coherent = 0;
> @@ -3472,7 +3474,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>                        i_allocated_regs, 0);
>              reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
>                                  o_preferred_regs, ts->indirect_base);
> -            tcg_out_mov(s, ts->type, reg, ts->reg);
> +            if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> +                abort();
> +            }
>          }
>          new_args[i] = reg;
>          const_args[i] = 0;
> @@ -3629,7 +3633,9 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>              if (ts->val_type == TEMP_VAL_REG) {
>                  if (ts->reg != reg) {
>                      tcg_reg_free(s, reg, allocated_regs);
> -                    tcg_out_mov(s, ts->type, reg, ts->reg);
> +                    if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> +                        abort();
> +                    }
>                  }
>              } else {
>                  TCGRegSet arg_set = 0;
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 0015a98485..992d50cb1e 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -509,7 +509,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
>      old_code_ptr[1] = s->code_ptr - old_code_ptr;
>  }
>  
> -static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>  {
>      uint8_t *old_code_ptr = s->code_ptr;
>      tcg_debug_assert(ret != arg);
> @@ -521,6 +521,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>      tcg_out_r(s, ret);
>      tcg_out_r(s, arg);
>      old_code_ptr[1] = s->code_ptr - old_code_ptr;
> +    return true;
>  }
>  
>  static void tcg_out_movi(TCGContext *s, TCGType type,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

