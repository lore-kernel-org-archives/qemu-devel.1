Received: from eggs.gnu.org ([209.51.188.92]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtdDB-00070D-As
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtdD7-0005pZ-O3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:55:15 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtdD3-0005eE-CT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:55:11 -0500
Received: by mail-pg1-x542.google.com with SMTP id i130so1409948pgd.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:55:07 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17c8caf2-e278-1153-3c59-e4420354872d@linaro.org>
Date: Tue, 12 Feb 2019 10:55:03 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/15] s390x/tcg: Refactor SET FPC AND
 SIGNAL handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/12/19 3:02 AM, David Hildenbrand wrote:
> We can directly work on the uint64_t value, no need for a temporary
> uint32_t value.
> 
> Also cleanup and shorten the comments.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
