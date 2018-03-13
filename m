Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkXh-0007Tl-M1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evkXe-0002Qp-I5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evkXe-0002QC-8j
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:04:38 -0400
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-10-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <61e3ceb9-1da2-9957-182e-53ec3ca3f08d@vivier.eu>
Date: Tue, 13 Mar 2018 15:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-10-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/10] linux-user: init_guest_space: Add a
 comment about search strategy
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
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 1b7583d659..7736ea2c3a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1936,6 +1936,10 @@ unsigned long init_guest_space(unsigned long host_start,
>           * happen often.  Probably means we got unlucky and host
>           * address space randomization put a shared library somewhere
>           * inconvenient.
> +         *
> +         * This is probably a good strategy if host_start, but is
> +         * probably a bad strategy if not, which means we got here
> +         * because of trouble with ARM commpage setup.
>           */
>          munmap((void *)real_start, real_size);
>          current_start += qemu_host_page_size;
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
