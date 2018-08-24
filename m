Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3lM-00074v-1x
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3lG-0004oZ-WB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:31:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3lG-0004o3-Hp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:31:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id d9-v6so540723plr.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:31:50 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b73437f7-bbf7-7175-69b3-65a2d1635447@linaro.org>
Date: Thu, 23 Aug 2018 21:31:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/misc/bcm2835_fb: Move config fields
 to their own struct
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
> The handling of framebuffer properties in the bcm2835_property code
> is a bit clumsy, because for each of the many fb related properties
> we try to track the value we're about to set and whether we're going
> to be setting a value, and then we hand all the new values off
> to the framebuffer via a function which takes them all as separate
> arguments. It would be simpler if the property code could easily
> copy all the framebuffer's current settings, update them with
> the new specified values and then ask the framebuffer to switch
> to the new set.
> 
> As the first part of this refactoring, pull all the fb config
> settings fields in BCM2835FBState out into their own struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  26 ++++++--
>  hw/display/bcm2835_fb.c         | 114 +++++++++++++++++---------------
>  hw/misc/bcm2835_property.c      |  28 ++++----
>  3 files changed, 94 insertions(+), 74 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
