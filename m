Received: from eggs.gnu.org ([2001:4830:134:3::10]:41989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfTl-0004C8-1c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYfTh-0006GI-V1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:28:57 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYfTh-0006FP-MV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:28:53 -0400
Received: by mail-pf0-x242.google.com with SMTP id c23so5604757pfe.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:28:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <98208c73-d3fe-e484-657f-d1b648a8e0f3@twiddle.net>
Date: Fri, 21 Jul 2017 11:28:41 -1000
MIME-Version: 1.0
In-Reply-To: <1500616763-26560-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/20/2017 07:59 PM, Emilio G. Cota wrote:
> This will enable us to decouple code translation from the value
> of parallel_cpus at any given time. It will also help us minimize
> TB flushes when generating code via EXCP_ATOMIC.
> 
> Note that the declaration of parallel_cpus is brought to exec-all.h
> to be able to define there the "curr_cflags" inline.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/exec-all.h   | 20 +++++++++++++++++++-
>   include/exec/tb-hash-xx.h |  9 ++++++---
>   include/exec/tb-hash.h    |  4 ++--
>   include/exec/tb-lookup.h  |  6 +++---
>   tcg/tcg.h                 |  1 -
>   accel/tcg/cpu-exec.c      | 45 +++++++++++++++++++++++----------------------
>   accel/tcg/translate-all.c | 13 +++++++++----
>   exec.c                    |  2 +-
>   tcg/tcg-runtime.c         |  2 +-
>   tests/qht-bench.c         |  2 +-
>   10 files changed, 65 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
