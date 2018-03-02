Received: from eggs.gnu.org ([2001:4830:134:3::10]:49144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbb-0007E3-0I
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbU-0005ur-RD
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:10 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkbU-0005u4-Ma
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:04 -0500
Received: by mail-ot0-x241.google.com with SMTP id 108so8664901otv.3
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:20:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-6-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-6-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:19:43 +0000
Message-ID: <CAFEAcA87gG+LCtp5AdjHgq9DbyyPrVdx-j6vw5aNuPkucyOKyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/10] linux-user: init_guest_space:
 Clarify page alignment logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> From: Luke Shumaker <lukeshu@parabola.nu>
>
> There are 3 parts to this change:
>  - Add a comment showing the relative sizes and positions of the blocks of
>    memory
>  - introduce and use new aligned_{start,size} instead of adjusting
>    real_{start_size}
>  - When we clean up (on failure), munmap(real_start, real_size) instead of
>    munmap(aligned_start, aligned_size).  It *shouldn't* make any
>    difference, but I will admit that this does mean we are making the
>    syscall with different values, so this isn't quite a no-op patch.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
