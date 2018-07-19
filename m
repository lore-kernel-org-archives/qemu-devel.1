Received: from eggs.gnu.org ([2001:4830:134:3::10]:41371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fgBbl-0004Ww-14
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fgBbk-0007hl-9c
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:16:49 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180719154248.29669-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9d98177c-4bf1-1e2d-a2bb-b5c907e76705@twiddle.net>
Date: Thu, 19 Jul 2018 09:16:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180719154248.29669-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: limit mul_vec size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>

On 07/19/2018 08:42 AM, Alex Bennée wrote:
> In AdvSIMD we can only do 32x32 integer multiples although SVE is
> capable of larger 64 bit multiples. As a result we can end up
> generating invalid opcodes. Fix this by only reprting we can emit mul
> vector ops if the size is small enough.
> 
> Fixes a crash on:
> 
>   sve-all-short-v8.3+sve@vq3/insn_mul_z_zi___INC.risu.bin
> 
> When running on AArch64 hardware.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Queued.  Thanks,


r~
