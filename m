Received: from eggs.gnu.org ([2001:4830:134:3::10]:47944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft46c-0001Wr-Jd
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft46Y-0002vH-Ic
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:53:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft46Y-0002sS-Bx
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:53:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id j8-v6so3937655pff.6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:53:50 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6bbd929-5008-f72b-1a6c-67d5ea16d982@linaro.org>
Date: Thu, 23 Aug 2018 21:53:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] hw/display/bcm2835_fb: Validate config
 settings
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
> Validate the config settings that the guest tries to set.
> 
> The wiki page documentation is not really accurate here:
> generally rather than failing requests to set bad parameters,
> the hardware will just clip them to something sensible.
> 
> Validate the most important parameters: sizes and
> the viewport offsets. This prevents the framebuffer
> code from trying to read out-of-range memory.
> 
> In the property handling code, we validate the new parameters every
> time we encounter a tag that sets them. This means we validate the
> config multiple times if the request includes multiple config-setting
> tags, but the code would require significant restructuring to do a
> validation only once but still return the clipped settings for
> get-parameter tags and the buffer allocation tag.
> 
> Validation of settings made via the older bcm2835_fb_mbox_push()
> function will be done in the next commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  8 +++++
>  hw/display/bcm2835_fb.c         | 48 +++++++++++++++++++++++++++--
>  hw/misc/bcm2835_property.c      | 54 ++++++++++++++++-----------------
>  3 files changed, 81 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
