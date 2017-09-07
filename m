Received: from eggs.gnu.org ([2001:4830:134:3::10]:50951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwaZ-0002Ry-Ig
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwaU-0004kr-Hu
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:11:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpwaU-0004jt-BG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:11:18 -0400
Date: Thu, 7 Sep 2017 15:11:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907151107.6959cd86.cohuck@redhat.com>
In-Reply-To: <4cb9db9c-7294-abde-92eb-8247ae354d86@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-2-david@redhat.com>
	<934be1e8-469e-6d54-bcc1-21e12da2e408@redhat.com>
	<4cb9db9c-7294-abde-92eb-8247ae354d86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/19] exec, dump, i386, ppc,
 s390x: don't include exec/cpu-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 7 Sep 2017 14:41:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 07.09.2017 07:46, Thomas Huth wrote:
> >>  #include "qemu/cutils.h"
> >>  #include "cpu.h"
> >> -#include "exec/exec-all.h"  
> > You should maybe mention exec-all.h in the patch description, too.
> > (I think it can be dropped here because it is included by
> > translate-all.h already).
> > 
> > If you tweak the patch description:
> > Reviewed-by: Thomas Huth <thuth@redhat.com>  
> 
> I'll just drop that hunk although it can also be removed.
> 
> Yes, this was not included on purpose - these similar names still
> confuse me :)
> 

Not only you :)

If we can do a sweep of exec-all.h as well, it should be a separate
patch.
