Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiTs-0004A4-1F
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiTo-0000mV-S2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:53:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRiTo-0000m3-LF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:53:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so23788337wrs.10
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:53:04 -0800 (PST)
References: <20181123090058.6931-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43c4a5d5-9437-57b1-e557-e82dfa6c3af1@redhat.com>
Date: Tue, 27 Nov 2018 19:50:54 +0100
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

Unfortunately this shows that elf2dmp is not portable to 32-bit systems,
nor to non-Linux.  Can this be fixed?

Paolo
