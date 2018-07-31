Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaY3-00085g-6n
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaY0-0001m3-17
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:43:11 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaXz-0001lS-Pr
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:43:07 -0400
Received: by mail-vk0-x241.google.com with SMTP id y9-v6so8112097vky.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:43:07 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ffbef1c-b6ff-b55a-35c2-994314156506@linaro.org>
Date: Tue, 31 Jul 2018 15:43:03 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/76] Add nanoMIPS support to QEMU
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

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> v4->v5:
> 
>   - merged series "Mips maintenance and misc fixes and improvements"
>     and this one for easier handling (there are build dependencies)
>   - eliminated shadow variables from translate.c
>   - replaced shift/mask combination with extract32()
>   - added new function gen_op_addr_addi()
>   - added "fall through" comments at appropriate places
>   - eliminated micromips flag from I7200 definition
>   - numerous other enhancements originating from reviewer's
>     comments
>   - some of the patches split into two or more for easier
>     handling and review
>   - rebased to the latest code

That concludes my review of this revision.
It's quite a bit better, but there is still a lot of work to do.


r~
