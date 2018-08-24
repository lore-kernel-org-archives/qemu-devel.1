Received: from eggs.gnu.org ([2001:4830:134:3::10]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3xI-0005cZ-2e
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3xD-0005mL-1B
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:44:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3xC-0005lh-OH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:44:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id m4-v6so3192957pgv.12
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:44:10 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <369b363b-0b90-fd78-d2f8-49f23510cb3e@linaro.org>
Date: Thu, 23 Aug 2018 21:44:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] hw/display/bcm2835_fb: Fix handling of
 virtual framebuffer
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
> The raspi framebuffir in bcm2835_fb supports the definition

framebuffer.

> of a virtual "viewport", which is smaller than the full
> physical framebuffer size and at an adjustable offset within
> it. Only the viewport area is sent to the screen. This allows
> the guest to do things like double buffering, or scrolling
> by adjusting the viewport origin. Currently QEMU doesn't
> implement this at all.
> 
> Add support for this feature:
>  * the property mailbox code needs to distinguish the
>    virtual width/height from the physical width/height
>  * the framebuffer code needs to do something with the
>    virtual width/height/origin information
> 
> Note that the wiki documentation on the semantics of the
> virtual and physical height and width has it the wrong way
> around -- the virtual size is the size of the allocated
> buffer, and the physical size is the size of the display,
> so the virtual size is always the same as or larger than
> the physical.
> 
> If the viewport size is set smaller than the physical
> screen size, we ignore the viewport settings completely
> and just display the physical screen area.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  6 ++++--
>  hw/display/bcm2835_fb.c         | 28 ++++++++++++++++++++++------
>  hw/misc/bcm2835_property.c      | 21 +++++++++++++++------
>  3 files changed, 41 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
