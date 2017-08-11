Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgG6l-0003DI-4G
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgG6i-0002wI-1H
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:00:35 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:33129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgG6h-0002vt-RK
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:00:31 -0400
Received: by mail-pf0-x22a.google.com with SMTP id h68so19717314pfk.0
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:00:31 -0700 (PDT)
References: <cover.1502474835.git.alistair.francis@xilinx.com>
	<a970dcb0e2778db6af5ecb62bef234d50c20be66.1502474835.git.alistair.francis@xilinx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e40aec2-10ed-589d-d380-a296402ae4bd@linaro.org>
Date: Fri, 11 Aug 2017 13:00:27 -0700
MIME-Version: 1.0
In-Reply-To: <a970dcb0e2778db6af5ecb62bef234d50c20be66.1502474835.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 2/3] tcg/tcg-op: Expose the tcg_gen_ext_i*
 functions
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
> Expose the tcg_gen_ext_i32() and tcg_gen_ext_i64() functions as we are
> going to use them later.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  tcg/tcg-op.c | 4 ++--
>  tcg/tcg-op.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

This is a good idea, since I'm certain we have several copies of this in
several of the target translators.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
