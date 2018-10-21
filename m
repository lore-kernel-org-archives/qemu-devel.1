Received: from eggs.gnu.org ([2001:4830:134:3::10]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDbQ-0006rz-8x
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDbN-00076r-4G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:17:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDbM-00076e-Tg
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:17:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id w5-v6so41980719wrt.2
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:17:04 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-26-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6b30bac-9f43-70f7-4176-a8a3913980fe@linaro.org>
Date: Sun, 21 Oct 2018 14:17:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-26-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 25/56] exec: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> -    cpu->interrupt_request &= ~0x01;
> +    cpu_reset_interrupt(cpu, ~0x01);

cpu_reset_interrupt(cpu, 1);

Although this is during vmload, and I'm not sure what locks you really want to
play with here.  Perhaps it's ok...


r~
