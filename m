Received: from eggs.gnu.org ([2001:4830:134:3::10]:48292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dacSl-0004dt-7a
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dacSk-00011R-Af
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:39:59 -0400
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-13-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d95e5790-09c5-1075-0cd9-4f33daedd566@vivier.eu>
Date: Thu, 27 Jul 2017 08:39:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 12/20] syscall: fix dereference
 of undefined pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 27/07/2017 à 04:42, Philippe Mathieu-Daudé a écrit :
> linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer value
>     if (*host_rt_dev_ptr != 0) {
>         ^~~~~~~~~~~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 003943b736..71d45a9963 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5573,6 +5573,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>                                      field_types, THUNK_HOST);
>      }
>      unlock_user(argptr, arg, 0);
> +    assert(host_rt_dev_ptr);
>  
>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
>      if (*host_rt_dev_ptr != 0) {
> 
