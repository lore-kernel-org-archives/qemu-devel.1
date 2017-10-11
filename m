Received: from eggs.gnu.org ([2001:4830:134:3::10]:50122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2Bww-0002js-NE
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2Bws-0005Bk-W7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:01:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e2Bws-0005B1-MW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:01:02 -0400
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c8ea06b3-0a7d-5349-9ee6-0c34ad039e58@vivier.eu>
Date: Wed, 11 Oct 2017 10:00:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170925231924.31303-2-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] linux-user: update hppa sockbits
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
> updated to match arch/parisc/include/uapi/asm/socket.h from linux 4.14
> include in socket.h changed to prefer a local path like all other qemu
> headers and for consistency and clarity when adding all other arch
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/hppa/sockbits.h | 148 +++++++++++++++++++++++----------------------
>  linux-user/socket.h        |   2 +-
>  2 files changed, 78 insertions(+), 72 deletions(-)

As I said for the RFC, I think it's better not to change indentation.

Thanks,
Laurent
