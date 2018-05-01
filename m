Received: from eggs.gnu.org ([2001:4830:134:3::10]:46615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDalw-0000Z8-5R
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDalr-0001gR-AV
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDalr-0001gA-1q
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:17:03 -0400
Received: by mail-pf0-x243.google.com with SMTP id o76so9751329pfi.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 12:17:02 -0700 (PDT)
References: <20180427173611.10281-1-peter.maydell@linaro.org>
	<20180427173611.10281-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61fc82c2-2b86-db56-7029-608082b92a36@linaro.org>
Date: Tue, 1 May 2018 12:16:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180427173611.10281-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/usb/tusb6010: Convert away from
 old_mmio
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

On 04/27/2018 10:36 AM, Peter Maydell wrote:
> Convert the tusb6010 device away from using the old_mmio field
> of MemoryRegionOps. This device is used only in the n800 and n810
> boards.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/usb/tusb6010.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
