Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gUvlL-0001Jo-7D
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gUvlH-0007h2-8b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:40:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gUvlG-0007b6-VU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:40:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so799136otk.3
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 07:40:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181205221126.16220-1-paul.burton@mips.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1479aed2-5a56-f818-57be-1f12db13c48a@twiddle.net>
Date: Thu, 6 Dec 2018 09:40:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181205221126.16220-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Set ATOMIC_REG_SIZE=8 for MIPS
 n32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Burton <paul.burton@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paul Burton <pburton@wavecomp.com>

On 12/5/18 4:11 PM, Paul Burton wrote:
> ATOMIC_REG_SIZE is currently defined as the default sizeof(void *) for
> all MIPS host builds, including those using the n32 ABI. n32 is the
> MIPS64 ILP32 ABI and as such tcg/mips/tcg-target.h defines
> TCG_TARGET_REG_BITS as 64 for n32 builds. If we attempt to build QEMU
> for an n32 host with support for a 64b target architecture then
> TCG_OVERSIZED_GUEST is 0 and accel/tcg/cputlb.c attempts to use atomic_*
> functions. This fails because ATOMIC_REG_SIZE is 4, causing the calls to
> QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE) in the various
> atomic_* functions to generate errors.
> 
> Fix this by defining ATOMIC_REG_SIZE as 8 for all MIPS64 builds, which
> will cover both n32 (ILP32) & n64 (LP64) ABIs in much the same was as we
> already do for x86_64/x32.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> ---
>  include/qemu/atomic.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
