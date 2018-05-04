Received: from eggs.gnu.org ([2001:4830:134:3::10]:45027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEX24-0002T9-HJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEX21-0000nZ-Da
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:29:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEX21-0000mr-9D
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:29:37 -0400
Date: Fri, 4 May 2018 10:29:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180504092924.GE29999@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-28-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525376963-79623-28-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 27/67] replication: add include directory
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On Thu, May 03, 2018 at 10:51:05PM +0300, Michael S. Tsirkin wrote:
> This way it is easier to find using standard rules.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/replication.h | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 include/replication.h
> 
> diff --git a/include/replication.h b/include/replication.h
> new file mode 100644
> index 0000000..2f40e8e
> --- /dev/null
> +++ b/include/replication.h
> @@ -0,0 +1 @@
> +#include_next "../replication.h"

I think this is really crazy. If we want the headers to be accessible
via the include/ directory, lets move them to the include/ directory,
not create wrappers that point back to the source directory.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
