Received: from eggs.gnu.org ([2001:4830:134:3::10]:50173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP3S-00061V-6K
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP3R-00081H-AB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:04:42 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWP3R-00080S-4d
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:04:41 -0500
Received: by mail-pl0-x244.google.com with SMTP id bd8so28878319plb.9
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:04:41 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f937757-bcc8-57c3-4636-e47c576395f7@linaro.org>
Date: Tue, 2 Jan 2018 08:04:36 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/17] target/m68k: fix gen_get_ccr()
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
> As gen_helper_get_ccr() is able to compute CCR from cc_op and
> flags, we don't need to flush flags before to call it.
> flush_flags() and get_ccr() use COMPUTE_CCR() to compute
> flags. get_ccr() computes CCR value,
> whereas flush_flags update live cc_op and flags.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
