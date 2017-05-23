Received: from eggs.gnu.org ([2001:4830:134:3::10]:49035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCxaI-0003wI-3E
	for qemu-devel@nongnu.org; Mon, 22 May 2017 20:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCxaH-0004OK-BB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 20:21:58 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-3-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3d09ab30-3c55-b3ae-d749-cd2f1055d6c4@twiddle.net>
Date: Mon, 22 May 2017 17:21:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: simplify and optimize
 aarch64 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/16/2017 04:01 PM, Aurelien Jarno wrote:
> Instead of byteswapping individual 16-bit words one by one, work on the
> whole register at the same time using shifts and mask. This is the same
> strategy than the aarch32 version of rev16 and is much more efficient
> in the case sf=1.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/arm/translate-a64.c | 24 ++++++------------------
>   1 file changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
