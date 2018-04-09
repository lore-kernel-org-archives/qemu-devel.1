Received: from eggs.gnu.org ([2001:4830:134:3::10]:59708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5evO-000403-Kr
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5evN-00085x-Mr
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:06:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180409140714.26841-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3147e65b-b6ff-a49e-fc40-21396dcbea0c@twiddle.net>
Date: Tue, 10 Apr 2018 08:05:58 +1000
MIME-Version: 1.0
In-Reply-To: <20180409140714.26841-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Ensure
 AArch64 signal frame isn't too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henwood <richard.henwood@arm.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/10/2018 12:07 AM, Peter Maydell wrote:
> In particular the dash shell
> would segfault if the frame wasn't as big enough.

Ah, that was the critical difference in my failure to replicate -- the fedora
sysroot doesn't have dash.  As you say, the patch matches the kernel so,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

That said, what the hell is dash doing that relies on this?


r~
