Received: from eggs.gnu.org ([2001:4830:134:3::10]:52026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe0o-0004Dz-FS
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe0n-0006Yv-Sd
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:48:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhe0n-0006YZ-Kb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:48:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id s7-v6so789471pgv.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:48:41 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-28-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6317e680-8b74-4790-0ee7-10ba6af63bda@linaro.org>
Date: Mon, 23 Jul 2018 09:48:37 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-28-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/40] target/mips: Adjust behavior of
 Config3's ISAOnExc bit for nanoMIPS
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
> -    if (env->insn_flags & ASE_MICROMIPS) {
> +    if ((env->insn_flags & ASE_MICROMIPS) &&
> +        !(env->insn_flags & ISA_NANOMIPS32)) {

Why is ASE_MICROMIPS ever set at the same time as ISA_NANOMIPS?
This change ought not be necessary, AFAIU.


r~
