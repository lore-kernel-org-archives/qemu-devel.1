Received: from eggs.gnu.org ([2001:4830:134:3::10]:57538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpD7T-0003Rc-Lo
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpD7K-0007F3-4F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpD7J-0007Eo-UE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:38:10 -0400
Date: Tue, 5 Sep 2017 14:38:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905143801.1dc39cb1.cohuck@redhat.com>
In-Reply-To: <20170904154316.4148-9-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/19] s390x: move sclp_service_call()
 to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Mon,  4 Sep 2017 17:43:05 +0200
David Hildenbrand <david@redhat.com> wrote:

> Fix up includes and rename it to s390x_*.

I'm not quite sure whether that is the right direction: servc is just an
instruction that does something and then happens to also generate an
interrupt on conclusion. I'll think a bit more about it.

> cpu.h is now free of externally implemented functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/sclp.c            | 51 +---------------------------------------------
>  include/hw/s390x/sclp.h    |  1 +
>  target/s390x/cpu.h         |  5 +----
>  target/s390x/interrupt.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c         |  2 +-
>  target/s390x/misc_helper.c |  2 +-
>  6 files changed, 54 insertions(+), 56 deletions(-)
