Received: from eggs.gnu.org ([2001:4830:134:3::10]:59238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG2wL-0007JS-Gg
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG2wH-0007hK-DV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:46:01 -0400
Date: Tue, 8 May 2018 15:45:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508154538.1b55f721.cohuck@redhat.com>
In-Reply-To: <bc3f13f6-56fd-058d-d717-508b7034d437@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-5-git-send-email-mst@redhat.com>
	<b3620ea6-0805-ccec-3bd5-11dc30bc2569@redhat.com>
	<20180508152349.15ad26d0.cohuck@redhat.com>
	<bc3f13f6-56fd-058d-d717-508b7034d437@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

On Tue, 8 May 2018 15:38:03 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 08.05.2018 15:23, Cornelia Huck wrote:
> > On Fri, 4 May 2018 02:24:12 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 03.05.2018 21:50, Michael S. Tsirkin wrote:  
> >>> we just need a struct name, let's add a forward
> >>> declaration instead of an include.
> >>>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>  include/hw/s390x/sclp.h | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> >>> index f9db243..6e65150 100644
> >>> --- a/include/hw/s390x/sclp.h
> >>> +++ b/include/hw/s390x/sclp.h
> >>> @@ -16,7 +16,8 @@
> >>>  
> >>>  #include "hw/sysbus.h"
> >>>  #include "hw/qdev.h"
> >>> -#include "target/s390x/cpu-qom.h"
> >>> +
> >>> +typedef struct CPUS390XState CPUS390XState;    
> >>
> >> IIRC you have to use include/qemu/typedefs.h instead to avoid trouble
> >> with older versions of GCC.  
> > 
> > Hm, I'm wondering why we do the typedef in cpu-qom.h, while other
> > architectures do it in their cpu.h.  
> 
> See:
> 
> commit ef2974cc270d51959ce90df6b4d4d41635d7a603
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Sep 13 15:24:02 2017 +0200
> 
>     target/s390x: move some s390x typedefs to cpu-qom.h
>     
>     This allows us to drop inclusion of cpu_models.h in cpu-qom.h, and
>     prepares for using cpu-qom.h as a s390 specific version of typedefs.h
>     
>     Signed-off-by: David Hildenbrand <david@redhat.com>
>     Message-Id: <20170913132417.24384-8-david@redhat.com>
>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>     Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> 
>  Thomas
> 
> 

Gargh, this is all very confusing...
