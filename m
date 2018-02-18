Received: from eggs.gnu.org ([2001:4830:134:3::10]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUaF-0006XY-HP
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUaC-0005Uu-E3
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:11 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enUaC-0005Sm-64
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:08 -0500
Received: by mail-pf0-x241.google.com with SMTP id p5so1234495pff.3
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 11:25:07 -0800 (PST)
References: <1518736676-5994-1-git-send-email-cota@braap.org>
	<1518736676-5994-3-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a86c86b-ae88-e884-9d38-649319d3d6e8@linaro.org>
Date: Sun, 18 Feb 2018 11:25:02 -0800
MIME-Version: 1.0
In-Reply-To: <1518736676-5994-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/sparc: convert to
 DisasContextBase
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
> - The original meaning of ctx.singlestep is
>     cs->singlestep_enabled || singlestep
>   , which required a little extra work since base.singlestep_enabled
>   only gets its value from cs->singlestep_enabled.

These sort of inconsistencies should be fixed, not preserved.


r~
