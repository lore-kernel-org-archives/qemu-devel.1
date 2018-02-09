Received: from eggs.gnu.org ([2001:4830:134:3::10]:33001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF3N-0007oj-PN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF3J-0007tf-Qb
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:13:49 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:55891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekF3J-0007tL-Ku
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:13:45 -0500
Received: by mail-it0-x22b.google.com with SMTP id b66so12417101itd.5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:13:45 -0800 (PST)
References: <20180209104546.29401-1-pbonzini@redhat.com>
	<20180209104546.29401-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5dfa5979-423f-eb71-8e24-b1030f6c1db6@linaro.org>
Date: Fri, 9 Feb 2018 12:13:41 -0800
MIME-Version: 1.0
In-Reply-To: <20180209104546.29401-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] memory: remove
 memory_region_test_and_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 02/09/2018 02:45 AM, Paolo Bonzini wrote:
> It is unused after g364fb has been converted to use DirtyBitmapSnapshot.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/exec/memory.h | 24 +++---------------------
>  memory.c              |  8 --------
>  2 files changed, 3 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
