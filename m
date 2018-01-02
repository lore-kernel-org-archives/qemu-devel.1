Received: from eggs.gnu.org ([2001:4830:134:3::10]:51622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP5N-0007aP-TC
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP5N-0001Yt-05
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:06:41 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWP5M-0001XX-Qz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:06:40 -0500
Received: by mail-pg0-x244.google.com with SMTP id r2so9069198pgq.13
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:06:40 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <deab8ec5-4c76-b666-2f09-eb8faf9a35ff@linaro.org>
Date: Tue, 2 Jan 2018 08:06:37 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/17] linux-user,
 m68k: correctly manage SR in context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> Use cpu_m68k_get_ccr()/cpu_m68k_set_ccr() to setup and restore correctly
> the value of SR in the context structure. Fix target_rt_setup_ucontext().
> 
> Fixes: 3219de458c ("linux-user: correctly manage SR in ucontext")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
