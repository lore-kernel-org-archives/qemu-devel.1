Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJPq-00022z-OF
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJPm-00080h-0L
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:56:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diJPl-00080U-SG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:56:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id d10so5968697qtb.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 04:56:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170328184959.5550-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5dac6dc9-dc22-997a-06b6-10de4b804d64@amsat.org>
Date: Thu, 17 Aug 2017 08:56:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170328184959.5550-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9?] configure: Remove unused code
 (found by shellcheck)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 03/28/2017 03:49 PM, Stefan Weil wrote:
> smartcard_cflags is no longer needed since commit
> 0b22ef0f57a8910d849602bef0940edcd0553d2c.

leftover from afd347ab387

> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> This is a very old patch which I just found in my patch queue.
> It's not mandatory for 2.9, but I also think that there is
> no risk to apply it.
> 
> Sorry for sending it so late.
> 
> Regards
> Stefan
> 
>   configure | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index d1ce33bc79..b65ea2931c 100755
> --- a/configure
> +++ b/configure
> @@ -4096,7 +4096,6 @@ EOF
>   fi
>   
>   # check for smartcard support
> -smartcard_cflags=""
>   if test "$smartcard" != "no"; then
>       if $pkg_config libcacard; then
>           libcacard_cflags=$($pkg_config --cflags libcacard)
> 
