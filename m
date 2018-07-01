Received: from eggs.gnu.org ([2001:4830:134:3::10]:42996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZiHO-0000ip-J5
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZiHK-0005pn-Nb
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:45:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fZiHK-0005o0-D4
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:44:58 -0400
References: <20180628034652.24152-1-f4bug@amsat.org>
	<20180628034652.24152-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ef46c1d4-c680-1f3c-58c2-23230b19dff8@vivier.eu>
Date: Sun, 1 Jul 2018 21:44:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180628034652.24152-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/12] linux-user/strace: Add
 print_timezone()
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

Le 28/06/2018 à 05:46, Philippe Mathieu-Daudé a écrit :
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index bd897a3f20..b43a21f48b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -63,6 +63,7 @@ UNUSED static void print_string(abi_long, int);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> +UNUSED static void print_timezone(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
>  UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
> @@ -1182,6 +1183,25 @@ print_timeval(abi_ulong tv_addr, int last)
>          gemu_log("NULL%s", get_comma(last));
>  }
>  
> +static void
> +print_timezone(abi_ulong tz_addr, int last)
> +{
> +    if (tz_addr) {
> +        struct target_timezone *tz;
> +
> +        tz = lock_user(VERIFY_READ, tz_addr, sizeof(*tz), 1);
> +        if (!tz) {

you should use print_pointer(tz_addr, last) instead of ignoring the value.

Thanks,
Laurent
