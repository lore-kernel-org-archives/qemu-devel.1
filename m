Received: from eggs.gnu.org ([2001:4830:134:3::10]:51949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTbd8-0007Ls-6S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTbd5-0005Pi-KK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:49:26 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTbd5-0005PJ-FH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:49:23 -0500
Received: by mail-pg0-x242.google.com with SMTP id 204so8931498pge.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 13:49:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-13-git-send-email-batuzovk@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4ade78ea-e9c2-f577-da2c-925bf4c0fdb0@twiddle.net>
Date: Tue, 17 Jan 2017 13:49:19 -0800
MIME-Version: 1.0
In-Reply-To: <1484644078-21312-13-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/18] tcg/i386: support remaining vector
 addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
>  #ifdef TCG_TARGET_HAS_REG128
> +    case INDEX_op_add_i8x16:
> +        tcg_out_modrm(s, OPC_PADDB, args[0], args[2]);
> +        break;
> +    case INDEX_op_add_i16x8:
> +        tcg_out_modrm(s, OPC_PADDW, args[0], args[2]);
> +        break;
>      case INDEX_op_add_i32x4:
>          tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
>          break;
> +    case INDEX_op_add_i64x2:
> +        tcg_out_modrm(s, OPC_PADDQ, args[0], args[2]);
> +        break;
> +#endif
> +
> +#ifdef TCG_TARGET_HAS_REGV64
> +    case INDEX_op_add_i8x8:
> +        tcg_out_modrm(s, OPC_PADDB, args[0], args[2]);
> +        break;
> +    case INDEX_op_add_i16x4:
> +        tcg_out_modrm(s, OPC_PADDW, args[0], args[2]);
> +        break;
> +    case INDEX_op_add_i32x2:
> +        tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
> +        break;
> +    case INDEX_op_add_i64x1:
> +        tcg_out_modrm(s, OPC_PADDQ, args[0], args[2]);
> +        break;
>  #endif

Once you drop the ifdefs, combine the cases.  Also: avx1 vpadd*.


r~
