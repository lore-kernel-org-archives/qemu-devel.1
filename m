Received: from eggs.gnu.org ([2001:4830:134:3::10]:39453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEOWQ-0007Yu-5z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 20:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEOWN-0008U6-1B
	for qemu-devel@nongnu.org; Thu, 03 May 2018 20:24:26 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-5-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3620ea6-0805-ccec-3bd5-11dc30bc2569@redhat.com>
Date: Fri, 4 May 2018 02:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/67] s390x: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On 03.05.2018 21:50, Michael S. Tsirkin wrote:
> we just need a struct name, let's add a forward
> declaration instead of an include.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/s390x/sclp.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index f9db243..6e65150 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -16,7 +16,8 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/qdev.h"
> -#include "target/s390x/cpu-qom.h"
> +
> +typedef struct CPUS390XState CPUS390XState;

IIRC you have to use include/qemu/typedefs.h instead to avoid trouble
with older versions of GCC.

 Thomas
