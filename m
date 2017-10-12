Received: from eggs.gnu.org ([2001:4830:134:3::10]:53147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2eyl-0001pX-Ma
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2eyg-0001q2-3u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:00:55 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2eyf-0001p4-TV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:00:50 -0400
Received: by mail-pf0-x233.google.com with SMTP id m63so5188843pfk.7
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 08:00:49 -0700 (PDT)
References: <1507650856-11718-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39cbdaa6-a900-bfd6-4bea-2eaf4b862b00@linaro.org>
Date: Thu, 12 Oct 2017 08:00:46 -0700
MIME-Version: 1.0
In-Reply-To: <1507650856-11718-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvic: Fix miscalculation of offsets into
 ITNS array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/10/2017 08:54 AM, Peter Maydell wrote:
> This calculation of the first exception vector in
> the ITNS<n> register being accessed:
>         int startvec = 32 * (offset - 0x380) + NVIC_FIRST_IRQ;
> 
> is incorrect, because offset is in bytes, so we only want
> to multiply by 8.
> 
> Spotted by Coverity (CID 1381484, CID 1381488), though it is
> not correct that it actually overflows the buffer, because
> we have a 'startvec + i < s->num_irq' guard.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Oops. I guess this is what Coverity is there to catch :-)
> 
>  hw/intc/armv7m_nvic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
