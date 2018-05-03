Received: from eggs.gnu.org ([2001:4830:134:3::10]:36383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJLe-0000aw-Fh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEJLb-0000kV-8a
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:52:58 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEJLb-0000k0-0y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:52:55 -0400
Received: by mail-pf0-x241.google.com with SMTP id w129so10010781pfd.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:52:54 -0700 (PDT)
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-17-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87ae4b75-9a9b-456b-b010-e3043d120cff@linaro.org>
Date: Thu, 3 May 2018 11:52:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180503091922.28733-17-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 16/29] target-microblaze: Break out
 trap_illegal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Break out trap_illegal() to handle illegal operation traps.
> We now generally stop translation of the current insn if
> it's not valid.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 75 ++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
