Received: from eggs.gnu.org ([2001:4830:134:3::10]:53129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8mVG-0003Hq-2y
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8mVC-0005ce-1y
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:48:02 -0400
Date: Wed, 18 Apr 2018 13:47:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418124753.GM27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418123838.3511-1-olaf@aepfle.de>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 18, 2018 at 02:38:37PM +0200, Olaf Hering wrote:
> Since usage of g_realloc_n was introduced, glib-2.22 can not be used anymore.
> Fixes commit 418026ca43 ("util: Introduce vfio helpers")

Normally we expect ./include/glib-compat.h to be changed in this scenario
to add compat for the missing symbol.

IIRC, one of Peters desired build targets required 2.22, but I guess we
missed this bug because that platform would not enable vfio functionality ?



> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 6e9b994f21..81760ef45a 100755
> --- a/configure
> +++ b/configure
> @@ -3369,7 +3369,7 @@ fi
>  if test "$mingw32" = yes; then
>      glib_req_ver=2.30
>  else
> -    glib_req_ver=2.22
> +    glib_req_ver=2.24
>  fi



>  glib_modules=gthread-2.0
>  if test "$modules" = yes; then
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
