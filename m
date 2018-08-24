Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3pn-0001E1-2i
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3pi-0008OR-41
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:36:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:39393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3ph-0008Nz-Ug
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:36:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id j8-v6so3918877pff.6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:36:25 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <315f0ccb-2da2-3df9-4eec-5c591f29a708@linaro.org>
Date: Thu, 23 Aug 2018 21:36:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] hw/misc/bcm2835_property: Track fb
 settings using BCM2835FBConfig
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
> Refactor the fb property setting code so that rather than
> using a set of pointers to local variables to track
> whether a config value has been updated in the current
> mbox and if so what its new value is, we just copy
> all the current settings of the fb at the start, and
> then update that copy as we go along, before asking
> the fb to switch to it at the end.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  4 +-
>  hw/display/bcm2835_fb.c         | 27 ++---------
>  hw/misc/bcm2835_property.c      | 80 ++++++++++++++-------------------
>  3 files changed, 37 insertions(+), 74 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
