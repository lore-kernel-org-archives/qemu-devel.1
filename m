Received: from eggs.gnu.org ([2001:4830:134:3::10]:41736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epS4k-0005JF-0k
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 00:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epS4f-0001xe-8q
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 00:08:45 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epS4f-0001xH-25
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 00:08:41 -0500
Received: by mail-pl0-x243.google.com with SMTP id ay8so6107196plb.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 21:08:40 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfe24538-86a6-bf56-6907-9444037e42ee@linaro.org>
Date: Fri, 23 Feb 2018 21:08:36 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/19] hw/arm/armv7m: Honour CPU's address
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
> Instead of loading guest images to the system address space, use the
> CPU's address space.  This is important if we're trying to load the
> file to memory or via an alias memory region that is provided by an
> SoC object and thus not mapped into the system address space.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/armv7m.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
