Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKrDc-0007Pc-FJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKrDX-0003go-KO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:11:12 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dKrDX-0003gd-Ds
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:11:07 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v104so147968435wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 12:11:07 -0700 (PDT)
References: <20170610223135.1731-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170610223135.1731-1-f4bug@amsat.org>
Date: Tue, 13 Jun 2017 20:11:38 +0100
Message-ID: <87vanzitxx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> remove some copy/paste leftover, code seems sane.
>
> while running Alex Bennée's image aarch64-linux-3.15rc2-buildroot.img:
>
> Trace 0x7fa1904b0890 [0: ffffffc00036cd04]
> ----------------
> IN:
> 0xffffffc00036cd24:  5ac00694      rev16 w20, w20
>
> OP:
>  ---- ffffffc00036cd24 0000000000000000 0000000000000000
>  ext32u_i64 tmp3,x20
>  ext16u_i64 tmp2,tmp3
>  bswap16_i64 x20,tmp2
>  movi_i64 tmp4,$0x10
>  shr_i64 tmp2,tmp3,tmp4
>  ext16u_i64 tmp2,tmp2
>  bswap16_i64 tmp2,tmp2
>  deposit_i64 x20,x20,tmp2,$0x10,$0x10
>
> Linking TBs 0x7fa1904b0890 [ffffffc00036cd04] index 0 -> 0x7fa1904b0aa0 [ffffffc00036cd24]
> Trace 0x7fa1904b0aa0 [0: ffffffc00036cd24]
> TODO qemu/tci.c:1049: tcg_qemu_tb_exec()
> qemu/tci.c:1049: tcg fatal error
> Aborted
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Possibly the only person who has run tci recently ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>
> there is no entry in MAINTAINERS for this file, I think it should it go under:
> "Tiny Code Generator (TCG) / Common code"
>
>  tci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tci.c b/tci.c
> index 4bdc645f2a..f39bfb95c0 100644
> --- a/tci.c
> +++ b/tci.c
> @@ -1046,7 +1046,6 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
>              break;
>  #if TCG_TARGET_HAS_bswap16_i64
>          case INDEX_op_bswap16_i64:
> -            TODO();
>              t0 = *tb_ptr++;
>              t1 = tci_read_r16(&tb_ptr);
>              tci_write_reg64(t0, bswap16(t1));


--
Alex Bennée
