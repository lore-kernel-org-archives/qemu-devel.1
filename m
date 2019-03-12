Received: from eggs.gnu.org ([209.51.188.92]:58033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3VBP-0008T7-5T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3VBN-0006Do-IJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:22:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3VBN-0006DC-8b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:22:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id h1so458794pfo.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 17:22:12 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-7-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <894a7f77-a4b0-cadf-df82-9765f4ced37a@linaro.org>
Date: Mon, 11 Mar 2019 17:22:08 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-7-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/11] target/hppa: ignore DIAG opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> +static bool trans_diag(DisasContext *ctx, arg_diag *a)
> +{
> +    qemu_log_mask(LOG_UNIMP, "DIAG opcode ignored\n");
> +    return true;

This needs to free the nullify condition, as with trans_nop.
I've fixed this up while applying.


r~
