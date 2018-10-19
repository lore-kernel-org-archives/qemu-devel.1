Received: from eggs.gnu.org ([2001:4830:134:3::10]:60690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDORf-0001Q4-1B
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDORa-0000jD-TV
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:39:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDORa-0000dq-A7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:39:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id 1-v6so15428307plv.7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:39:33 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-6-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dfe58d4-7f71-2afa-e781-038847c3524f@linaro.org>
Date: Thu, 18 Oct 2018 23:39:29 -0700
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-6-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 05/56] cpu: move run_on_cpu to cpus-common
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

On 10/18/18 6:05 PM, Emilio G. Cota wrote:
> We don't pass a pointer to qemu_global_mutex anymore.
> 
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 10 ----------
>  cpus-common.c     |  2 +-
>  cpus.c            |  5 -----
>  3 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
