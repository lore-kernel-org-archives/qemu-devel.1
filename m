Received: from eggs.gnu.org ([2001:4830:134:3::10]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHzj5-0003ux-KK
	for qemu-devel@nongnu.org; Sun, 13 May 2018 18:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHyIh-0001zA-S1
	for qemu-devel@nongnu.org; Sun, 13 May 2018 17:13:08 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHyIh-0001z1-NO
	for qemu-devel@nongnu.org; Sun, 13 May 2018 17:13:03 -0400
Received: by mail-qt0-x242.google.com with SMTP id f13-v6so13714378qtp.10
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 14:13:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180513085032.27773-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30a7172b-c972-fdf6-02f7-7967d8de258d@amsat.org>
Date: Sun, 13 May 2018 18:12:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180513085032.27773-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>

On 05/13/2018 05:50 AM, Stefan Weil wrote:
> This fixes cross builds for the (rare) case where cross binutils
> but no native binutils are installed.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 24c411e346..4f6ace1ed4 100755
> --- a/configure
> +++ b/configure
> @@ -517,6 +517,7 @@ objcopy="${OBJCOPY-${cross_prefix}objcopy}"
>  ld="${LD-${cross_prefix}ld}"
>  ranlib="${RANLIB-${cross_prefix}ranlib}"
>  nm="${NM-${cross_prefix}nm}"
> +strings="${STRINGS-${cross_prefix}strings}"
>  strip="${STRIP-${cross_prefix}strip}"
>  windres="${WINDRES-${cross_prefix}windres}"
>  pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
> @@ -1956,9 +1957,9 @@ int main(int argc, char *argv[]) {
>  EOF
>  
>  if compile_object ; then
> -    if strings -a $TMPO | grep -q BiGeNdIaN ; then
> +    if "$strings" -a $TMPO | grep -q BiGeNdIaN ; then
>          bigendian="yes"
> -    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
> +    elif "$strings" -a $TMPO | grep -q LiTtLeEnDiAn ; then
>          bigendian="no"
>      else
>          echo big/little test failed
> 
