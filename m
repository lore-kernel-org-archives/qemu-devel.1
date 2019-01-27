Received: from eggs.gnu.org ([209.51.188.92]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpTC-0008Vo-Tj
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpTC-0006Py-2R
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:47:50 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnpTB-0006Pi-Rs
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:47:49 -0500
Received: by mail-pf1-x431.google.com with SMTP id b85so6990210pfc.3
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 10:47:49 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190126065211.3587-1-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <670acf7b-d0ce-63a0-a4e4-94b95cbab099@linaro.org>
Date: Sun, 27 Jan 2019 10:47:44 -0800
MIME-Version: 1.0
In-Reply-To: <20190126065211.3587-1-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 1/3] target/arm: fix AArch64 virtual
 address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 1/25/19 10:52 PM, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
> extension (yet), the VA address space is 48-bits plus a sign bit. User
> mode can only handle the positive half of the address space, so that
> makes a limit of 48 bits.
> 
> (With LVA, it would be 53 and 52 bits respectively.)
> 
> The incorrectly large address space conflicts with PAuth instructions,
> which bits 48-54 and 56-63 for the pointer authentication code. This
> also conflicts with (as yet unsupported by QEMU) data tagging and with
> the ARMv8.5-MTE extension.
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
