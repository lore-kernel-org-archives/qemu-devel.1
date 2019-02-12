Received: from eggs.gnu.org ([209.51.188.92]:34600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtcbj-0002Np-GH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtcRU-0006Q8-Tq
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:06:05 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtcRT-0006MN-BD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:06:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id r124so1613613pgr.3
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:05:55 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <925c8806-0a1a-c0d0-923c-167af4d548e4@linaro.org>
Date: Tue, 12 Feb 2019 10:05:51 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/15] s390x/tcg: Factor out conversion
 of softfloat exceptions
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
> We want to reuse that function in vector instruction context. While at it,
> cleanup the code, using defines for magic values and avoiding the
> handcrafted bit conversion.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 25 +++++++++++++------------
>  target/s390x/internal.h   |  7 +++++++
>  2 files changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
