Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dwinr-0000UF-E1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dwinq-0001Mc-Oe
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:53:07 -0400
References: <20170926041420.32673-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a0c73f93-14a7-1685-92bb-6f1a2c7f9dea@vivier.eu>
Date: Tue, 26 Sep 2017 07:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170926041420.32673-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove duplicate break in
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, qemu-trivial@nongnu.org

Le 26/09/2017 à 06:14, Carlo Marcelo Arenas Belón a écrit :
> likely introduced in 3532fa7402cda16f7b95261b0339c58630051f0b
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..3ef4d1c568 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3131,7 +3131,6 @@ set_timeout:
>          case TARGET_SO_RCVLOWAT:
>  		optname = SO_RCVLOWAT;
>  		break;
> -            break;
>          default:
>              goto unimplemented;
>          }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
