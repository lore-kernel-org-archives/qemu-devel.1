Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ftE4E-0005VI-0h
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ftE48-0008WN-DY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:32:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ftE48-0008V0-2I
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:32:00 -0400
References: <20180824085601.6259-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <52cf0b55-7854-72b1-8258-92a13d94e342@vivier.eu>
Date: Fri, 24 Aug 2018 17:31:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180824085601.6259-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: add SO_LINGER to {g,
 s}etsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: schwab@suse.de, gang.chen.5i5j@gmail.com

Le 24/08/2018 à 10:56, Carlo Marcelo Arenas Belón a écrit :
> Original implementation for setsockopt by Chen Gang[1]; all bugs mine,
> including removing assignment for optname which hopefully makes the
> logic easier to follow and moving some variables to make the code
> more selfcontained.
> 
> [1] http://patchwork.ozlabs.org/patch/565659/
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Co-Authored-By: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  linux-user/syscall.c      | 52 ++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  5 ++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
