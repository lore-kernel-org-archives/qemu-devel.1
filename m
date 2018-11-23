Received: from eggs.gnu.org ([2001:4830:134:3::10]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQEPn-00079H-RW
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gQEPk-0002Da-Ly
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gQEPk-0002C2-Du
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:34:44 -0500
References: <20181123090058.6931-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e5e461a-4e07-8175-4840-f375f758bd86@redhat.com>
Date: Fri, 23 Nov 2018 17:34:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181123090058.6931-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: fix elf2dmp check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

On 23/11/18 10:01, Roman Kagan wrote:
> elf2dmp is keyed on "$posix" = "yes", but "$posix" doesn't seem to be
> set anywhere.
> 
> The original intent was presumably to skip building it on Windows, so
> check for "$mingw32" = "no" instead.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 0a3c6a72c3..fc6ce0065d 100755
> --- a/configure
> +++ b/configure
> @@ -5722,7 +5722,7 @@ if test "$want_tools" = "yes" ; then
>    if [ "$ivshmem" = "yes" ]; then
>      tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
>    fi
> -  if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
> +  if [ "$mingw32" = "no" ] && [ "$curl" = "yes" ]; then
>      tools="elf2dmp $tools"
>    fi
>  fi
> 

Queued, thanks.

Paolo
