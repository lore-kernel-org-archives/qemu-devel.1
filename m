Received: from eggs.gnu.org ([2001:4830:134:3::10]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3tM-0003KF-JQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3tL-0002tB-OW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:40:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3tL-0002sG-FW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:40:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id j8-v6so3922946pff.6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:40:11 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <123be298-4a05-773f-dbb3-cd36ed275d12@linaro.org>
Date: Thu, 23 Aug 2018 21:40:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] hw/display/bcm2835_fb: Abstract out
 calculation of pitch, size
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

On 08/14/2018 07:44 AM, Peter Maydell wrote:
> Abstract out the calculation of the pitch and size of the
> framebuffer into functions that operate on the BCM2835FBConfig
> struct -- these are about to get a little more complicated
> when we add support for virtual and physical sizes differing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h | 22 ++++++++++++++++++++++
>  hw/display/bcm2835_fb.c         |  6 +++---
>  hw/misc/bcm2835_property.c      |  4 ++--
>  3 files changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
