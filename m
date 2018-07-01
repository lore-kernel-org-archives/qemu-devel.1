Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZdCb-0000gT-9M
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZdCY-0002lQ-5D
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:45 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZdCX-0002ku-KV
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:42 -0400
Received: by mail-pg0-x244.google.com with SMTP id c9-v6so5978182pgf.5
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 07:19:41 -0700 (PDT)
References: <20180701051147.31649-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99a76cbb-c711-70f2-75db-a966259438ff@linaro.org>
Date: Sun, 1 Jul 2018 07:19:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180701051147.31649-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/openrisc: Fix delay slot exception
 flag to match spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, Richard Henderson <rth@twiddle.net>

On 06/30/2018 10:11 PM, Stafford Horne wrote:
> The delay slot exception flag is only set on the SR register during
> exception.  Previously it was being set on both the ESR and SR this
> caused QEMU to differ from the spec.  The was apparent as the linux
> kernel had a bug where it could boot on QEMU but not on real hardware.
> 
> The fixed logic now matches hardware.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/interrupt.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
