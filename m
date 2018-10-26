Received: from eggs.gnu.org ([2001:4830:134:3::10]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4XN-0002cG-6a
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4X5-0005CU-HJ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:00:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4X5-0005C6-81
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:00:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id y144-v6so1916070wmd.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:00:19 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-68-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a4917dce-43a2-d16b-0baf-bcf7ebfab283@linaro.org>
Date: Fri, 26 Oct 2018 17:00:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-68-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 68/71] cpu: add async_run_on_cpu_no_bql
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
> Some async jobs do not need the BQL.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 14 ++++++++++++++
>  cpus-common.c     | 39 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 48 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
