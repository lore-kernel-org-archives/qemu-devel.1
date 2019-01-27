Received: from eggs.gnu.org ([209.51.188.92]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpTX-0000Oi-EG
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpTW-0006Yh-NW
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:48:11 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:34642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnpTW-0006XX-IH
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:48:10 -0500
Received: by mail-pf1-x42d.google.com with SMTP id h3so7002127pfg.1
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 10:48:08 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190126065211.3587-2-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dae91346-45e7-e86d-1354-facd74680f1f@linaro.org>
Date: Sun, 27 Jan 2019 10:48:04 -0800
MIME-Version: 1.0
In-Reply-To: <20190126065211.3587-2-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 2/3] target/arm: actually enable PAuth in
 user mode
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
> This always enables IA, IB, DA and DB keys in user mode on the maximum
> CPU, in a manner that is consistent with the other CPUs. That is to say
> redefining the reset value of SCTLR_ELx registers.
> 
> Without this patch, the PAC* and AUT* instructions have no effects
> (except PACGA of course).
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu64.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
