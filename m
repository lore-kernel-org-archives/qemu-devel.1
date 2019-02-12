Received: from eggs.gnu.org ([209.51.188.92]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtec6-0000j2-1d
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtec5-0006IY-6W
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:25:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtec4-0006Gb-L7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:25:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id f90so1830301plb.10
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:25:04 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a4787fb-462e-8979-ca76-cdda4aa1cdb6@linaro.org>
Date: Tue, 12 Feb 2019 12:25:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/15] s390x/tcg: Implement rounding
 mode and XxC for LOAD ROUNDED
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
> With the floating-point extension facility, LOAD ROUNDED has
> a rounding mode specification and the inexact-exception control (XxC).
> 
> Handle them just like e.g. LOAD FP INTEGER.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Modulo the comments for patch 12,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
