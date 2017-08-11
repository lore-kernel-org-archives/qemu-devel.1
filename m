Received: from eggs.gnu.org ([2001:4830:134:3::10]:38251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgG63-0002Zg-HN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgG60-0002Zh-BF
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:59:51 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:33001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgG60-0002ZG-3P
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:59:48 -0400
Received: by mail-pf0-x22f.google.com with SMTP id h68so19710483pfk.0
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 12:59:47 -0700 (PDT)
References: <cover.1502474835.git.alistair.francis@xilinx.com>
	<20b283f7eaf100783b291de3830dd226ec286b6a.1502474835.git.alistair.francis@xilinx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <202d07a5-b1a5-cd37-2a31-de45dc0690da@linaro.org>
Date: Fri, 11 Aug 2017 12:59:43 -0700
MIME-Version: 1.0
In-Reply-To: <20b283f7eaf100783b291de3830dd226ec286b6a.1502474835.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 1/3] target/arm: Update the memops for
 exclusive load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org, edgar.iglesias@gmail.com

On 08/11/2017 11:19 AM, Alistair Francis wrote:
> Acording to the ARM ARM exclusive loads require the same allignment as
> exclusive stores. Let's update the memops used for the load to match
> that of the store. This adds the alignment requirement to the memops.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
