Received: from eggs.gnu.org ([209.51.188.92]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqg2w-0002u5-5n
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqfqt-0002Bh-0X
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:08:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gqfqs-0002Ao-RF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:08:02 -0500
Date: Mon, 4 Feb 2019 15:07:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204150748.GP1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-16-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-16-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


No explanation of /why/ we want to build this by default ?

The source header calls it a demo application and it has no man
page.

Given this IMHO we should *not* be building & installing it by
default, as doing so defacto turns it into a user tool we have
to support.


On Mon, Feb 04, 2019 at 09:43:48AM -0500, Michael S. Tsirkin wrote:
> From: Changpeng Liu <changpeng.liu@intel.com>
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configure b/configure
> index 31cf6f584d..5c619d4e03 100755
> --- a/configure
> +++ b/configure
> @@ -5831,6 +5831,9 @@ if test "$want_tools" = "yes" ; then
>    if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
>      tools="elf2dmp $tools"
>    fi
> +  if [ "$linux" = "yes" ]; then
> +    tools="vhost-user-blk\$(EXESUF) $tools"
> +  fi
>  fi
>  if test "$softmmu" = yes ; then
>    if test "$linux" = yes; then
> -- 
> MST
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
