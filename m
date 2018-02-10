Received: from eggs.gnu.org ([2001:4830:134:3::10]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPXP-0006iq-Tf
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPXM-0001Fk-P4
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:31 -0500
References: <1954640316.20171226142913@mobile-stream.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <751c9675-7e93-a907-4b9e-998c50155e84@msgid.tls.msk.ru>
Date: Sat, 10 Feb 2018 10:25:27 +0300
MIME-Version: 1.0
In-Reply-To: <1954640316.20171226142913@mobile-stream.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] fix evsrwu and others for powerpcspe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: info@mobile-stream.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

26.12.2017 14:29, info@mobile-stream.com wrote:
> GEN_SPEOP_ARITH2 declares non-local temporaries then calls gen_op_evsrwu/evsrws/evslw which generates branch insn.

I'm Cc'ing qemu-devel@ for review, since I don't know much about how ppc works.

Thanks,

/mjt

> --- target/ppc/translate/spe-impl.inc.c.orig
> +++ target/ppc/translate/spe-impl.inc.c
> @@ -158,8 +158,8 @@
>          gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
>          return;                                                               \
>      }                                                                         \
> -    t0 = tcg_temp_new_i32();                                                  \
> -    t1 = tcg_temp_new_i32();                                                  \
> +    t0 = tcg_temp_local_new_i32();                                                  \
> +    t1 = tcg_temp_local_new_i32();                                                  \
>                                                                                \
>      tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                       \
>      tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
> 
> 
