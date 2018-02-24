Received: from eggs.gnu.org ([2001:4830:134:3::10]:40655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epRsm-0003FX-43
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epRsj-0008FY-1G
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:56:24 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epRsi-0008Eg-Lw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:56:20 -0500
Received: by mail-pf0-x242.google.com with SMTP id 17so4353287pfw.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 20:56:20 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e55c2d18-b3b9-520b-0e9d-69ba711543b8@linaro.org>
Date: Fri, 23 Feb 2018 20:56:16 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/19] hw/arm/boot: Honour CPU's address
 space for image loads
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Instead of loading kernels, device trees, and the like to
> the system address space, use the CPU's address space. This
> is important if we're trying to load the file to memory or
> via an alias memory region that is provided by an SoC
> object and thus not mapped into the system address space.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Function name changed to arm_boot_address_space()
> rather than arm_boot_addressspace(), following irc
> conversation...
> ---
>  hw/arm/boot.c | 119 +++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
