Received: from eggs.gnu.org ([2001:4830:134:3::10]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYL0-0004qk-Uu
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYKx-0005sZ-Tu
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:52:47 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:35733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diYKx-0005sN-OS
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:52:43 -0400
Received: by mail-pg0-x22c.google.com with SMTP id v189so55593874pgd.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 20:52:43 -0700 (PDT)
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b618834-f15a-846f-7c30-5e894e9a3ee4@linaro.org>
Date: Thu, 17 Aug 2017 20:52:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 02/10] target/s390x: move
 cpu_mmu_idx_to_asc() to excp_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 02:22 AM, David Hildenbrand wrote:
> Only used in that file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         | 14 --------------
>  target/s390x/excp_helper.c | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
