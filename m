Received: from eggs.gnu.org ([2001:4830:134:3::10]:45581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3qx-0001mH-LP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ft3qw-0000iR-Ke
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:37:43 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ft3qw-0000hg-D8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 00:37:42 -0400
Received: by mail-pl1-x644.google.com with SMTP id e11-v6so546391plb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 21:37:42 -0700 (PDT)
References: <20180814144436.679-1-peter.maydell@linaro.org>
	<20180814144436.679-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <02db2056-e67d-f7d2-9766-8bf6d56b0d50@linaro.org>
Date: Thu, 23 Aug 2018 21:37:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180814144436.679-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] hw/display/bcm2835_fb: Drop unused
 size and pitch fields
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
> The BCM2835FBState struct has a 'pitch' field which is a
> cached copy of xres * (bpp >> 3), and a 'size' field which is
> a cached copy of pitch * yres. However we don't actually do
> anything with these fields; delete them. We retain the
> now-unused slots in the VMState struct for migration
> compatibility.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/display/bcm2835_fb.h |  4 ----
>  hw/display/bcm2835_fb.c         | 19 ++++++++-----------
>  2 files changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
