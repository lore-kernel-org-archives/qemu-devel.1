Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Mu-0008UY-PF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Mr-0008AK-JN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:45:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3Mh-0007yG-UC
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:45:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id 189-v6so1778347wmw.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:45:21 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec52ac9e-52c5-2e89-1315-fb10dbbd2103@linaro.org>
Date: Fri, 26 Oct 2018 15:45:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 04/71] cpu: make qemu_work_cond per-cpu
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
> This eliminates the need to use the BQL to queue CPU work.
> 
> While at it, give the per-cpu field a generic name ("cond") since
> it will soon be used for more than just queueing CPU work.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  6 ++--
>  cpus-common.c     | 72 ++++++++++++++++++++++++++++++++++++++---------
>  cpus.c            |  2 +-
>  qom/cpu.c         |  1 +
>  4 files changed, 63 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
