Received: from eggs.gnu.org ([209.51.188.92]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtdEa-0007u1-SU
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtdEY-00081n-U5
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:56:44 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtdEW-0007oS-Sc
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:56:42 -0500
Received: by mail-pf1-x441.google.com with SMTP id n22so1729949pfa.3
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:56:25 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <447f1f9f-b0e7-6328-9981-9c4d1989629c@linaro.org>
Date: Tue, 12 Feb 2019 10:56:22 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/15] s390x/tcg: Fix simulated-IEEE
 exceptions
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

On 2/12/19 3:03 AM, David Hildenbrand wrote:
> The trap is triggered based on priority of the enabled signaling flags.
> Only overflow and underflow allow a concurrent inexact exception.
> 
> z14 PoP, 9-33, Figure 9-21
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
