Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3Qs-0000YG-RS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3Qn-0007c9-RC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:20:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3Qn-0007ZR-IS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:20:09 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-5-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <79b98fc1-922e-3517-bd3e-dee4c4ae1de2@vivier.eu>
Date: Mon, 2 Jul 2018 20:19:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/13] linux-user/strace: Add
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

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 311e63ef75..49bdee6d83 100644
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
> @@ -1184,6 +1185,26 @@ print_timeval(abi_ulong tv_addr, int last)
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
> +            print_pointer(tz, last);

print_pointer(tz_addr, last);

Thanks,
Laurent
