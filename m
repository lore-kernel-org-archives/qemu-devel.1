Received: from eggs.gnu.org ([2001:4830:134:3::10]:50397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOdZ-0000MW-Fs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOdW-0006x2-CI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:29:09 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOdW-0006wk-21
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:29:06 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-6-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a8315089-809f-a067-1f1c-1725186363e6@vivier.eu>
Date: Fri, 9 Mar 2018 21:28:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-6-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
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
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
