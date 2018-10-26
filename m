Received: from eggs.gnu.org ([2001:4830:134:3::10]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3I4-0004f1-De
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Hy-0005pS-PA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:40:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3Hs-0005nj-KN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:40:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id 189-v6so1763742wmw.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:40:32 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87aa6cc4-34cd-f364-30ce-d2459b3355ea@linaro.org>
Date: Fri, 26 Oct 2018 15:40:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 03/71] cpu: introduce cpu_mutex_lock/unlock
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

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> The few direct users of &cpu->lock will be converted soon.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h   | 33 +++++++++++++++++++++++++++++++
>  cpus.c              | 48 +++++++++++++++++++++++++++++++++++++++++++--
>  stubs/cpu-lock.c    | 20 +++++++++++++++++++
>  stubs/Makefile.objs |  1 +
>  4 files changed, 100 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/cpu-lock.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
