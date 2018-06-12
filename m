Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSrVl-000559-Oq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSrVi-0003E2-HG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:11:33 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fSrVi-0003Dd-AA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:11:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id z24-v6so248013pfe.7
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 15:11:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
	<20180611125633.32755-3-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f232941d-5dc6-7544-156b-23c614699052@twiddle.net>
Date: Tue, 12 Jun 2018 12:11:26 -1000
MIME-Version: 1.0
In-Reply-To: <20180611125633.32755-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] cputlb: Pass cpu_transaction_failed()
 the correct physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/11/2018 02:56 AM, Peter Maydell wrote:
> The API for cpu_transaction_failed() says that it takes the physical
> address for the failed transaction. However we were actually passing
> it the offset within the target MemoryRegion. We don't currently
> have any target CPU implementations of this hook that require the
> physical address; fix this bug so we don't get confused if we ever
> do add one.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/exec-all.h | 13 ++++++++++--
>  accel/tcg/cputlb.c      | 44 +++++++++++++++++++++++++++++------------
>  exec.c                  |  5 +++--
>  3 files changed, 45 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
