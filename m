Received: from eggs.gnu.org ([2001:4830:134:3::10]:54921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi3Ag-0006Jn-FT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi3Af-0002yh-I3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:40:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi35H-0007M4-LE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:35:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id y10-v6so1082729pfn.8
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:34:59 -0700 (PDT)
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532453527-22911-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85bdf4b0-d17d-fb79-f7f5-7053edb9a5f7@linaro.org>
Date: Tue, 24 Jul 2018 12:34:55 -0700
MIME-Version: 1.0
In-Reply-To: <1532453527-22911-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/55] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/24/2018 10:31 AM, Aleksandar Markovic wrote:
> +            case NM_SB16:
> +                {
> +                    int rt = decode_gpr_gpr3_src_store(
> +                                 NANOMIPS_EXTRACT_RD(ctx->opcode));

Shadowed variable.

> +            case NM_SH16:
> +                {
> +                    int rt = decode_gpr_gpr3_src_store(
> +                                 NANOMIPS_EXTRACT_RD(ctx->opcode));

Likewise.

>      case NM_LWSP16:
> +        {
> +            int rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);

Likewise.

>      case NM_LW4X4:
> +        {
> +            int rt = (extract32(ctx->opcode, 9, 1) << 3) |
> +                     extract32(ctx->opcode, 5, 3);
> +            int rs = (extract32(ctx->opcode, 4, 1) << 3) |
> +                     extract32(ctx->opcode, 0, 3);

Likewise.

>      case NM_SW4X4:
> +        {
> +            int rt = (extract32(ctx->opcode, 9, 1) << 3) |
> +                     extract32(ctx->opcode, 5, 3);
> +            int rs = (extract32(ctx->opcode, 4, 1) << 3) |
> +                     extract32(ctx->opcode, 0, 3);

Likewise.

>      case NM_SWSP16:
> +        {
> +            int rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);

Likewise.

>      case NM_SW16:
> +        {
> +            int rt = decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));

Likewise.

>      case NM_SWGP16:
> +        {
> +            int rt = decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));

Likewise.

It might be handy to temporarily add

target/mips/translate.o: QEMU_CFLAGS += -Wshadow=local

to target/mips/Makefile.objs, but I don't know how prevalent that situation is
within the existing code base...


r~
