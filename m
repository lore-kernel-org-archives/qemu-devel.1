Received: from eggs.gnu.org ([209.51.188.92]:53500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMll1-0005sF-2l
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMll0-0007Nu-37
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMlkz-0007Mv-Re
	for qemu-devel@nongnu.org; Fri, 03 May 2019 23:54:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so3890001pfk.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 20:54:36 -0700 (PDT)
References: <20190503171347.13747-1-peter.maydell@linaro.org>
	<20190503171347.13747-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <690764a2-4998-c6ae-9e2f-11a3bfdaa215@linaro.org>
Date: Fri, 3 May 2019 20:54:32 -0700
MIME-Version: 1.0
In-Reply-To: <20190503171347.13747-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/boot: Honour image size field
 in AArch64 Image format kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Mark Rutland <mark.rutland@arm.com>

On 5/3/19 10:13 AM, Peter Maydell wrote:
> Since Linux v3.17, the kernel's Image header includes a field image_size,
> which gives the total size of the kernel including unpopulated data
> sections such as the BSS). If this is present, then return it from
> load_aarch64_image() as the true size of the kernel rather than
> just using the size of the Image file itself. This allows the code
> which calculates where to put the initrd to avoid putting it in
> the kernel's BSS area.
> 
> This means that we should be able to reliably load kernel images
> which are larger than 128MB without accidentally putting the
> initrd or dtb in locations that clash with the kernel itself.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/boot.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
