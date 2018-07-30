Received: from eggs.gnu.org ([2001:4830:134:3::10]:60095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkErr-0000cY-R3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkErn-0007yc-Tj
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:34:11 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkErn-0007xy-KH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:34:07 -0400
Received: by mail-vk0-x242.google.com with SMTP id s17-v6so6398117vke.10
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:34:07 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-15-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a09d5aa0-9241-b2ba-23fd-db3b4fef5409@linaro.org>
Date: Mon, 30 Jul 2018 16:34:01 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-15-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 14/76] target/mips: Add
 gen_op_addr_addi()
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
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add gen_op_addr_addi(). This function will be used in emulation of
> some nanoMIPS instructions.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For your general mips to-do list, there are lots of places in
the existing code that can be cleaned up to make use of this
new function.


r~
