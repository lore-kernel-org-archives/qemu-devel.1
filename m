Received: from eggs.gnu.org ([2001:4830:134:3::10]:48851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP0f-0003b0-7V
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP0e-0005xS-Fp
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:01:49 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWP0e-0005xM-8K
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:01:48 -0500
Received: by mail-pg0-x244.google.com with SMTP id b70so1123780pga.2
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:01:48 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <898a9d9a-2799-6024-d537-45051aa633dd@linaro.org>
Date: Tue, 2 Jan 2018 08:01:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/17] target-m68k: sync CC_OP before
 gen_jmp_tb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> And remove update_cc_op() from gen_exception() because there is
> one in gen_jmp_im().
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
