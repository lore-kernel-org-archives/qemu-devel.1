Received: from eggs.gnu.org ([2001:4830:134:3::10]:40390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAjMU-0000Gx-7J
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAjMQ-0004gM-W2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAjMQ-0004g5-PC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id f8-v6so4899709plb.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 15:23:14 -0700 (PDT)
References: <20181009175129.17888-1-cota@braap.org>
	<20181009175129.17888-2-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <314ddde8-8f2d-e5c8-829c-96a76eb6dc10@linaro.org>
Date: Thu, 11 Oct 2018 15:23:10 -0700
MIME-Version: 1.0
In-Reply-To: <20181009175129.17888-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 1/5] tcg: Add tlb_index and tlb_entry
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/9/18 10:51 AM, Emilio G. Cota wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Isolate the computation of an index from an address into a
> helper before we change that function.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [ cota: convert tlb_vaddr_to_host; use atomic_read on addr_write ]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/softmmu_template.h     | 68 ++++++++++++++++----------------
>  include/exec/cpu_ldst.h          | 19 +++++++--
>  include/exec/cpu_ldst_template.h | 25 ++++++------
>  accel/tcg/cputlb.c               | 61 +++++++++++++---------------
>  4 files changed, 90 insertions(+), 83 deletions(-)

Queued.


r~
