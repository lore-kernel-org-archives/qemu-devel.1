Received: from eggs.gnu.org ([2001:4830:134:3::10]:55710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2GzD-0000q1-9c
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2Gz8-0004ib-9z
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:23:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e2Gz8-0004hl-0V
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:23:42 -0400
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
	<20170925231924.31303-4-carenas@gmail.com>
	<20170925231924.31303-5-carenas@gmail.com>
	<20170925231924.31303-6-carenas@gmail.com>
	<20170925231924.31303-7-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5496192f-4fef-ef16-2769-81a9d31775d7@vivier.eu>
Date: Wed, 11 Oct 2017 15:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170925231924.31303-7-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] linux_user: consolidate sock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

Le 26/09/2017 à 01:19, Carlo Marcelo Arenas Belón a écrit :
> remove unnecessary sock_type enum and other unused surrounding code to
> allow for per arch sockbits to mirror better linux headers for maintenance
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/alpha/sockbits.h | 36 ----------------------------
>  linux-user/hppa/sockbits.h  | 30 -----------------------
>  linux-user/mips/sockbits.h  | 35 ---------------------------
>  linux-user/socket.h         | 58 ++++++++++++++++++++++-----------------------
>  linux-user/sparc/sockbits.h | 35 ---------------------------
>  5 files changed, 29 insertions(+), 165 deletions(-)

I think it's not a good idea to mix again what we have just unmixed.

Thanks,
Laurent
