Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUer-0000Pb-9J
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUeo-0007Ov-4P
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:29:57 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enUen-0007Og-So
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:29:54 -0500
Received: by mail-pl0-x241.google.com with SMTP id g18so4506702plo.7
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 11:29:53 -0800 (PST)
References: <1518736676-5994-1-git-send-email-cota@braap.org>
	<1518736676-5994-4-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f1a0b6f-d00b-24de-181b-a994e17647ae@linaro.org>
Date: Sun, 18 Feb 2018 11:29:49 -0800
MIME-Version: 1.0
In-Reply-To: <1518736676-5994-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/sparc: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 02/15/2018 03:17 PM, Emilio G. Cota wrote:
> +        (dc->pc - dc->base.pc_first) >= (TARGET_PAGE_SIZE - 32)) {

What is this, and why is it not a bug to be fixed via elimination?
Surely this condition is covered by the normal max_insns test.


r~
