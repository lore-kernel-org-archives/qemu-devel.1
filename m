Received: from eggs.gnu.org ([2001:4830:134:3::10]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZioN-0003fH-Ro
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZioK-00046W-LR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:14:35 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-26-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a573b90a-def5-b3fb-d995-09a0c82ae7e3@vivier.eu>
Date: Mon, 24 Jul 2017 21:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-26-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 25/35] linux-user: extract
 is_error() out of syscall.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/qemu.h    | 5 +++++
>  linux-user/syscall.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4edd7d0c08..97b7cfdb63 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -614,6 +614,11 @@ static inline void *lock_user_string(abi_ulong guest_addr)
>  
>  #include <pthread.h>
>  
> +static inline int is_error(abi_long ret)
> +{
> +    return (abi_ulong)ret >= (abi_ulong)(-4096);
> +}
> +
>  /* Include target-specific struct and function definitions;
>   * they may need access to the target-independent structures
>   * above, so include them last.
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 003943b736..fcd20fa276 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -837,11 +837,6 @@ static inline abi_long get_errno(abi_long ret)
>          return ret;
>  }
>  
> -static inline int is_error(abi_long ret)
> -{
> -    return (abi_ulong)ret >= (abi_ulong)(-4096);
> -}
> -
>  const char *target_strerror(int err)
>  {
>      if (err == TARGET_ERESTARTSYS) {
> 
I think you should fold this one into the following one.

Laurent
