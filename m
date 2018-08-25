Received: from eggs.gnu.org ([2001:4830:134:3::10]:45987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftbAA-00040q-1u
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftavX-0004Tn-1M
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 11:56:42 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftavW-0004SN-RL
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 11:56:38 -0400
Received: by mail-pg1-x542.google.com with SMTP id v66-v6so5577346pgb.10
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 08:56:38 -0700 (PDT)
References: <20180824170422.5783-1-peter.maydell@linaro.org>
	<20180824170422.5783-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0196b785-bc30-21f1-f829-e1bb2ca397f8@linaro.org>
Date: Sat, 25 Aug 2018 08:56:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180824170422.5783-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/nvram/fw_cfg: Use memberwise copy
 of MemoryRegionOps struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 08/24/2018 10:04 AM, Peter Maydell wrote:
> We've now removed the 'old_mmio' member from MemoryRegionOps,
> so we can perform the copy as a simple struct copy rather
> than having to do it via a memberwise copy.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/nvram/fw_cfg.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
