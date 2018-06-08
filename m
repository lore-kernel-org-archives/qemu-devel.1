Received: from eggs.gnu.org ([2001:4830:134:3::10]:54935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIWZ-0004V7-5y
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIWW-00012u-3P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRIWV-00012Y-U8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:52 -0400
Date: Fri, 8 Jun 2018 15:37:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608143747.GR18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608143026.20167-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608143026.20167-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 08, 2018 at 11:30:26AM -0300, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.
> 
> Removing support for Python 2.6 will allow us to remove some
> compatibility modules we carry in the QEMU tree:
> 
> * scripts/argparse.py
> * scripts/ordereddict.py

Lets delete those in this patch then....

> 
> Python 2.6 is also not receiving bug fixes upstream and is not
> supported by pylint, which makes it harder to keep the code
> compatible with both Python 2 and Python 3.

Agreed, there's no compelling reason for 2.6 to stay around

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 14b11130a7..a8c4094c87 100755
> --- a/configure
> +++ b/configure
> @@ -1651,8 +1651,8 @@ fi
>  
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
> -  error_exit "Cannot use '$python', Python 2 >= 2.6 or Python 3 is required." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
> +  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
>        "Use --python=/path/to/python to specify a supported Python."
>  fi
>  
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
