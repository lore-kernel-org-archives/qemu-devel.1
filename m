Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dhxtK-0007mq-23
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dhxtE-0005Ml-60
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:57:46 -0400
References: <20170328184959.5550-1-sw@weilnetz.de>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <6a5b9248-312c-cb66-c189-9a3e1651013a@weilnetz.de>
Date: Wed, 16 Aug 2017 14:57:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170328184959.5550-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel@nongnu.org

It looks like this patch got lost somehow.

Stefan

See also https://patchwork.codeaurora.org/patch/210129/


Am 28.03.2017 um 20:49 schrieb Stefan Weil:
> smartcard_cflags is no longer needed since commit
> 0b22ef0f57a8910d849602bef0940edcd0553d2c.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
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
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index d1ce33bc79..b65ea2931c 100755
> --- a/configure
> +++ b/configure
> @@ -4096,7 +4096,6 @@ EOF
>  fi
>  
>  # check for smartcard support
> -smartcard_cflags=""
>  if test "$smartcard" != "no"; then
>      if $pkg_config libcacard; then
>          libcacard_cflags=$($pkg_config --cflags libcacard)
> 
