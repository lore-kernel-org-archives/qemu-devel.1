Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXbsO-0002qG-IP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXbsL-0006FJ-D7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXbsL-0006Ap-6P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:25:57 -0400
Date: Tue, 18 Jul 2017 20:25:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170718232551.GE8345@localhost.localdomain>
References: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: pbonzini@redhat.com, rth@twiddle.net, dgilbert@redhat.com, qemu-devel@nongnu.org, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

On Mon, Jul 17, 2017 at 09:49:37PM -0400, Yi Wang wrote:
> Add [vcpu] index support for hmp command "info lapic", which is
> useful when debugging ipi and so on. Current behavior is not
> changed when the parameter isn't specified.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>

We have 8 monitor commands (see below) that use the CPU set by
the "cpu" command (mon_get_cpu()) as input.  Why is "info lapic"
special?

* info cpustats
* info lapic
* info mem
* info registers
* info tlb
* x
* memsave
* inject-nmi (QMP)

-- 
Eduardo
