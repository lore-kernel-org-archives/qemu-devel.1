Received: from eggs.gnu.org ([2001:4830:134:3::10]:39858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nM4-00011m-2U
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nLv-0005SZ-BW
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:02:41 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nLu-0005RX-Oz
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:02:34 -0400
Received: by mail-qk1-x744.google.com with SMTP id a85-v6so4293099qkg.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:02:34 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <328e9889-edaa-f57f-f2e3-b017a55cc496@linaro.org>
Date: Wed, 3 Oct 2018 15:02:28 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm: Add some comments in
 Thumb decode
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Add some comments to the Thumb decoder indicating what bits
> of the instruction have been decoded at various points in
> the code.
> 
> This is not an exhaustive set of comments; we're gradually
> adding comments as we work with particular bits of the code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Specifically, I figured these out as I was going through looking
> for the insns which write SP. These comments turn out not to
> be relevant to those instructions, but I don't want to throw
> them away.
> ---
>  target/arm/translate.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
