Received: from eggs.gnu.org ([2001:4830:134:3::10]:52519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOFL-00045a-NZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDOFF-0003Ai-Tq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:26:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDOF6-0002Re-D5
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:26:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id 78-v6so13647910pfq.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:26:30 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-2-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c736dda2-fc3b-4fb3-91c3-350d39d05661@linaro.org>
Date: Thu, 18 Oct 2018 23:26:26 -0700
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 01/56] cpu: convert queued work to a
 QSIMPLEQ
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
> Instead of open-coding it.
> 
> While at it, make sure that all accesses to the list are
> performed while holding the list's lock.
> 
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  6 +++---
>  cpus-common.c     | 25 ++++++++-----------------
>  cpus.c            | 14 ++++++++++++--
>  qom/cpu.c         |  1 +
>  4 files changed, 24 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
