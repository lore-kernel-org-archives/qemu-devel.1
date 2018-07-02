Received: from eggs.gnu.org ([2001:4830:134:3::10]:47705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3Pv-0008Nf-Jv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3Pq-0006z5-L9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:19:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3Pq-0006xK-Ak
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:19:10 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0c70f743-6c0b-73c2-943e-74ed3caece2d@vivier.eu>
Date: Mon, 2 Jul 2018 20:18:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] linux-user/strace: Display
 invalid pointer in print_timeval()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index bd897a3f20..311e63ef75 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1173,8 +1173,10 @@ print_timeval(abi_ulong tv_addr, int last)
>          struct target_timeval *tv;
>  
>          tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
> -        if (!tv)
> +        if (!tv) {
> +            print_pointer(tv, last);

tv is NULL here. we want to print the value of tv_addr.

Thanks,
Laurent
