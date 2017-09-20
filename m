Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dugZ0-0002ZC-Mh
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dugYv-0002ef-Pp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:05:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:63044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dugYv-0002dB-HO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:05:17 -0400
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
	<20170919230643.87425-2-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d8115e2d-7409-c6ea-3c8d-3aead5b5fa87@vivier.eu>
Date: Wed, 20 Sep 2017 10:39:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170919230643.87425-2-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: add SO_LINGER to setsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, riku.voipio@iki.fi, rth@twiddle.net

Le 20/09/2017 à 01:06, Carlo Marcelo Arenas Belón a écrit :
> Original implementation by Chen Gang; all bugs mine
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/syscall.c      | 15 +++++++++++++++
>  linux-user/syscall_defs.h |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..ad689dad50 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3071,6 +3071,21 @@ set_timeout:
>  		unlock_user (dev_ifname, optval_addr, 0);
>  		return ret;
>  	}
> +        case TARGET_SO_LINGER:
> +        {
> +                struct linger lg;
> +                struct target_linger *tlg;
> +

Why did you remove "optname = SO_LINGER" and "if (optlen !=
sizeof(struct target_linger))"?

Thanks,
Laurent
