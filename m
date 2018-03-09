Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOaD-0005nd-6d
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOaA-0005gK-2s
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:41 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOa9-0005fr-Pd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:38 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-4-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d50c4a3d-ce2f-4948-f640-7a223370a1ab@vivier.eu>
Date: Fri, 9 Mar 2018 21:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-4-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/10] linux-user: init_guest_space: Clean
 up if we can't initialize the commpage
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
> We'll just exit with an error anyway, so it doesn't really matter, but it
> is cleaned up in all of the other places were we error out.
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
