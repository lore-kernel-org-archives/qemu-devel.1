Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f62gH-0005Gs-90
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f62gG-0003nq-JU
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:28:05 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:36502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f62gG-0003nb-C1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:28:04 -0400
Received: by mail-pf0-x234.google.com with SMTP id g14so9516845pfh.3
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 16:28:04 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-7-git-send-email-cota@braap.org>
	<a95ec4d4-72f7-486d-4123-a7bd4740cf03@linaro.org>
	<20180410142332.GA22989@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6a08977-5340-1aa3-9ae1-0656a5240507@linaro.org>
Date: Wed, 11 Apr 2018 09:27:57 +1000
MIME-Version: 1.0
In-Reply-To: <20180410142332.GA22989@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/17] target/mips: convert to
 DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/11/2018 12:23 AM, Emilio G. Cota wrote:
>          case DISAS_STOP:
> -            gen_goto_tb(&ctx, 0, ctx.pc);
> +            tcg_gen_lookup_and_goto_ptr();

You need to write ctx.pc back to the pc first, e.g.

    gen_save_pc(ctx.pc);
    tcg_gen_lookup_and_goto_ptr();


r~
