Received: from eggs.gnu.org ([2001:4830:134:3::10]:52063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f8mTH-000281-63
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f8mTC-0003Yj-Ax
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:45:59 -0400
Date: Wed, 18 Apr 2018 14:45:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180418144538.4aa2f492.cohuck@redhat.com>
In-Reply-To: <20180418123838.3511-1-olaf@aepfle.de>
References: <20180418123838.3511-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 18 Apr 2018 14:38:37 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> Since usage of g_realloc_n was introduced, glib-2.22 can not be used anymore.
> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
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

Are we ready to give up support for whatever distro is still on 2.22?
(If yes, can we bump to an even newer glib version?) Or should we
rather solve this by adding a g_realloc_n implementation for that case?
