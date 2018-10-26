Received: from eggs.gnu.org ([2001:4830:134:3::10]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4R6-000471-TF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4R2-0000qT-SK
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4R2-0000pg-KF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id 189-v6so1989537wmw.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:54:04 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-61-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3577c63-b9da-e4e6-3922-e18d12733e14@linaro.org>
Date: Fri, 26 Oct 2018 16:54:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-61-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 61/71] mips: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
