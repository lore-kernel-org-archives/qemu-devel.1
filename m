Received: from eggs.gnu.org ([2001:4830:134:3::10]:52474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9ywR-0002qW-MR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9ywQ-0005p8-OY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9ywQ-0005om-I7
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:49:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id f8-v6so1394142pgq.5
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 13:49:18 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0992254-5635-11bf-11f9-3637e71ee0be@linaro.org>
Date: Tue, 9 Oct 2018 13:49:14 -0700
MIME-Version: 1.0
In-Reply-To: <20181009174557.16125-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/6] target/unicore32: remove tlb_flush
 from uc32_init_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 10/9/18 10:45 AM, Emilio G. Cota wrote:
> As far as I can tell tlb_flush does not need to be called
> this early. tlb_flush is eventually called after the CPU
> has been realized.
> 
> This change paves the way to the introduction of tlb_init,
> which will be called from cpu_exec_realizefn.
> 
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/unicore32/cpu.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
