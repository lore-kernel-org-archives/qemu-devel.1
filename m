Received: from eggs.gnu.org ([209.51.188.92]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hAyHO-0000y8-Nt
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hAyHN-0002ZG-Fl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:51:18 -0400
References: <20190401141222.30034-1-lvivier@redhat.com>
	<20190401141222.30034-4-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55732f44-defb-0dff-ad89-80bf099445a5@redhat.com>
Date: Mon, 1 Apr 2019 16:50:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190401141222.30034-4-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] configure: qemu-ga is only needed
 with softmmu targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 01/04/2019 16.12, Laurent Vivier wrote:
> Remove it from the list of tools if --disable-system
> and --disable-tools are used as we don't need it for
> linux-user targets.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> [lv: I also disable it with disable-tools, not only with disable-system]
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a70276a..b627efede6cf 100755
> --- a/configure
> +++ b/configure
> @@ -6083,7 +6083,9 @@ fi
>  # Probe for guest agent support/options
>  
>  if [ "$guest_agent" != "no" ]; then
> -  if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
> +  if [ "$softmmu" = no -a "$want_tools" = no ] ; then
> +      guest_agent=no
> +  elif [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
>        tools="qemu-ga $tools"
>        guest_agent=yes
>    elif [ "$guest_agent" != yes ]; then
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
