Received: from eggs.gnu.org ([2001:4830:134:3::10]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgtfI-0003T0-VW
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgtfF-0005IR-Sj
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:19:24 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgtfF-0005I8-Jq
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:19:21 -0400
Received: by mail-pl0-x244.google.com with SMTP id e11-v6so6415898plb.3
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 08:19:21 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-21-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b15a590d-5e2f-b6dd-d887-7d1823bd5e5c@linaro.org>
Date: Sat, 21 Jul 2018 08:19:16 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-21-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 20/40] target/mips: Implement MT ASE
 support for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +            tcg_temp_free(t0);
> +        }
> +    break;
> +    case NM_FORK:
> +        check_insn(ctx, ASE_MT);

Watch the indentation.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
