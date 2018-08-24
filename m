Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft48Y-0003C5-3E
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft48U-0004c0-1T
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:55:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft48T-0004b0-H1
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:55:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id h69-v6so3943082pfd.4
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:55:49 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c00fe9c-3c7a-0feb-faa3-59ec1ca219f2@linaro.org>
Date: Thu, 23 Aug 2018 21:55:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] hw/display/bcm2835_fb: Validate
 bcm2835_fb_mbox_push() config
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
> Refactor bcm2835_fb_mbox_push() to work by calling
> bcm2835_fb_validate_config() and bcm2835_fb_reconfigure(),
> so that config set this way is also validated.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/display/bcm2835_fb.c | 63 ++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
