Received: from eggs.gnu.org ([2001:4830:134:3::10]:48799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOa3-0005fn-2n
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOa0-0005dq-02
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:31 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOZz-0005dO-Mh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:25:27 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-3-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <126db960-612f-7fcc-6a6a-2fc5980aecd1@vivier.eu>
Date: Fri, 9 Mar 2018 21:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-3-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/10] linux-user: Rename
 validate_guest_space => init_guest_commpage
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
> init_guest_commpage is a much more honest description of what the function
> does.  validate_guest_space not only suggests that the function has no
> side-effects, but also introduces confusion as to why it is only needed on
> 32-bit ARM targets.
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
