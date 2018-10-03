Received: from eggs.gnu.org ([2001:4830:134:3::10]:37157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7i9p-00074I-P4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7i9m-0004rV-F3
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:29:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7i9m-0004r5-8Q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:29:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so7806682wmf.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 07:29:42 -0700 (PDT)
References: <20181003132041.10075-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cf30eb2-8430-8507-d31e-370504287afd@redhat.com>
Date: Wed, 3 Oct 2018 16:29:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181003132041.10075-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 03/10/2018 15:20, Marc-André Lureau wrote:
> This should have been removed as part of commit
> 692fbdf9f4c6f6bafd0b3a4d4f94973effd3bbae.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/configure b/configure
> index a7368044cc..4f6d6e03b1 100755
> --- a/configure
> +++ b/configure
> @@ -3557,12 +3557,6 @@ if ! compile_prog "$CFLAGS" "$LIBS" ; then
>  	       "build target"
>  fi
>  
> -# g_test_trap_subprocess added in 2.38. Used by some tests.
> -glib_subprocess=yes
> -if ! $pkg_config --atleast-version=2.38 glib-2.0; then
> -    glib_subprocess=no
> -fi
> -
>  # Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage
>  cat > $TMPC << EOF
>  #include <glib.h>
> 
