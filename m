Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8pEu-0003UX-Lu
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8pEq-0005mu-Hd
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:43:20 -0400
References: <20180418145443.6332-1-olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <502db955-6c66-3255-0ea8-9a00876607e5@redhat.com>
Date: Wed, 18 Apr 2018 17:42:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180418145443.6332-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 18/04/2018 16:54, Olaf Hering wrote:
> Since usage of g_realloc_n was introduced, glib-2.22 can not be used
> anymore on Linux. Leave non-Linux unchanged because one developer system
> still uses it.
> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 6e9b994f21..ca19a66726 100755
> --- a/configure
> +++ b/configure
> @@ -3369,7 +3369,11 @@ fi
>  if test "$mingw32" = yes; then
>      glib_req_ver=2.30
>  else
> -    glib_req_ver=2.22
> +    if test "$targetos" = Linux; then
> +       glib_req_ver=2.24
> +    else
> +       glib_req_ver=2.22
> +    fi
>  fi
>  glib_modules=gthread-2.0
>  if test "$modules" = yes; then
> 

I think for 2.12 it's okay to just document this.  For 2.13 we should
raise the bar uniformly (and anyway remove g_realloc_n in favor of g_renew).

Paolo
