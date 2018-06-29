Received: from eggs.gnu.org ([2001:4830:134:3::10]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYwoL-0005yL-UM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYwoL-0005Wo-1g
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:03:53 -0400
Date: Fri, 29 Jun 2018 18:03:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629170343.GY27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628184624.5867-1-rjones@redhat.com>
	<20180628184624.5867-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628184624.5867-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org

On Thu, Jun 28, 2018 at 07:46:24PM +0100, Richard W.M. Jones wrote:
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 96a02deb69..50df64e0a9 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "crypto/tlssession.h"
>  #include "crypto/tlscredsanon.h"
> +#include "crypto/tlscredspsk.h"
>  #include "crypto/tlscredsx509.h"
>  #include "qapi/error.h"
>  #include "qemu/acl.h"
> @@ -88,6 +89,8 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
>      return session->readFunc(buf, len, session->opaque);
>  }
>  
> +#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
> +#define TLS_PRIORITY_ADDITIONAL_PSK  "+ECDHE-PSK:+DHE-PSK:+PSK"

Unfortunately in testing this I learn ECDHE-PSK is only supported when
using GNUTLS >= 3.0, so can you make this conditional based on 
GNUTLS_VERSION_MAJOR  >= 3


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
