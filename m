Received: from eggs.gnu.org ([2001:4830:134:3::10]:35986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYNt-0006jH-Qb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYNq-0001AJ-Cz
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:45 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:38909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diYNq-00019P-3l
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:42 -0400
Received: by mail-pg0-x235.google.com with SMTP id t80so28169665pgb.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 20:55:41 -0700 (PDT)
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e2f5b7c-0291-e05f-34a7-c9e632118438@linaro.org>
Date: Thu, 17 Aug 2017 20:55:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 04/10] target/s390x: move
 s390_do_cpu_reset() to diag.c
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
> Only used in that file. Also drop the comment, not really needed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h  | 7 -------
>  target/s390x/diag.c | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
