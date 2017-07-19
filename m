Received: from eggs.gnu.org ([2001:4830:134:3::10]:51862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXnmy-00078Z-2a
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXnmu-0002qW-0x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXnmt-0002pu-Qz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:09:07 -0400
Date: Wed, 19 Jul 2017 03:16:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170719061651.GE2757@localhost.localdomain>
References: <201707191247531805742@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201707191247531805742@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yi59@zte.com.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, dgilbert@redhat.com, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

On Wed, Jul 19, 2017 at 12:47:53PM +0800, wang.yi59@zte.com.cn wrote:
> Hi Eduardo,
> 
> Thank you for your reply!
> 
> >On Mon, Jul 17, 2017 at 09:49:37PM -0400, Yi Wang wrote:
> >> Add [vcpu] index support for hmp command "info lapic", which is
> >> useful when debugging ipi and so on. Current behavior is not
> >> changed when the parameter isn't specified.
> >> 
> >> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> >> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> >
> 
> >We have 8 monitor commands (see below) that use the CPU set by
> >the "cpu" command (mon_get_cpu()) as input.  Why is "info lapic"
> >special?
> 
> When we debugging a problem of ipi, we wanted to verify lapic info
> on each vCPU, but we found that we could only get vCPU 0's lapic
> through "info lapic", so we supposed this patch could help those
> who have the same problem as us.

The "cpu" command is supposed to allow you to select the CPU for
those commands.  Doesn't it work?

-- 
Eduardo
