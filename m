Received: from eggs.gnu.org ([208.118.235.92]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftcJO-0005ir-65
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftcI6-0004zj-0Z
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:24:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftcI5-0004zK-QM
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:24:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id h79-v6so5022971pfk.8
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 10:24:01 -0700 (PDT)
References: <cover.1535133088.git.jancraig@amazon.com>
	<20819a8ef4216527bccc346de4a50ce14386034c.1535133089.git.jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <979ec8a5-e0a9-5150-b132-5628fcbbc975@linaro.org>
Date: Sat, 25 Aug 2018 10:23:57 -0700
MIME-Version: 1.0
In-Reply-To: <20819a8ef4216527bccc346de4a50ce14386034c.1535133089.git.jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/mips: Add MXU instruction D16MUL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/24/2018 12:44 PM, Craig Janeczek via Qemu-devel wrote:
> +        gen_load_mxu_gpr(t1, opcode->D16MUL.xrb);
> +        tcg_gen_ext16s_tl(t0, t1);
> +        tcg_gen_shri_tl(t1, t1, 16);
> +        tcg_gen_ext16s_tl(t1, t1);

  tcg_gen_sextract_tl(t0, t1, 0, 16);
  tcg_gen_sextract_tl(t1, t1, 16, 16);


r~
