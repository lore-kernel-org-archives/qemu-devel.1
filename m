Received: from eggs.gnu.org ([209.51.188.92]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVFE-0007s7-3R
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVFD-0008Gy-71
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:01:16 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwVFC-0008GD-UO
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:01:15 -0500
Received: by mail-pf1-x441.google.com with SMTP id h1so12182324pfo.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:01:14 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-70-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2237ae5f-f8d7-9ed3-b279-e79ef437dc2f@linaro.org>
Date: Wed, 20 Feb 2019 09:01:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-70-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 69/73] cpu: rename all_cpu_threads_idle
 to qemu_tcg_rr_all_cpu_threads_idle
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

On 1/29/19 4:48 PM, Emilio G. Cota wrote:
> This function is only called from TCG rr mode, so add
> a prefix to mark this as well as an assertion.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
