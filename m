Received: from eggs.gnu.org ([2001:4830:134:3::10]:43363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWWF-0001Yn-Uk
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGWWC-0001nu-Ou
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:03 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGWWC-0001nY-Jt
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:21:00 -0400
Received: by mail-pl0-x242.google.com with SMTP id c11-v6so5034656plr.5
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 14:21:00 -0700 (PDT)
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
	<20180508173152.29327-36-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f648c0c-e012-25c7-4c78-ee7c98fac6e2@linaro.org>
Date: Wed, 9 May 2018 14:20:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180508173152.29327-36-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 35/36] target-microblaze: Convert
 env_btarget to i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 05/08/2018 10:31 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Convert env_btarget to i64.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.h       |  2 +-
>  target/microblaze/op_helper.c |  3 ++-
>  target/microblaze/translate.c | 35 ++++++++++++++++++++++-------------
>  3 files changed, 25 insertions(+), 15 deletions(-)

Merge with previous?  They seem to be indivisible.

Why do you want to do this for what appears to be a boolean?


r~
