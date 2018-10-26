Received: from eggs.gnu.org ([2001:4830:134:3::10]:55435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Wc-0001at-6a
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Wa-0004z9-UI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:59:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4WY-0004y8-QC
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:59:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g9-v6so1892306wrq.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:59:46 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-67-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <44983e65-6e10-9500-62a6-9b4891ca8dcd@linaro.org>
Date: Fri, 26 Oct 2018 16:59:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-67-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 67/71] cpus-common: release BQL earlier in
 run_on_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> After completing the conversion to per-CPU locks, there is no need
> to release the BQL after having called cpu_kick.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus-common.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
