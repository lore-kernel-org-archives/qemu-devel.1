Received: from eggs.gnu.org ([2001:4830:134:3::10]:40789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRUpT-0002qE-Ms
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRUpP-0005vl-Om
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRUpP-0005vV-ID
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:13:55 -0500
Date: Wed, 20 Dec 2017 11:13:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171220031349.GD22308@xz-mi>
References: <20171124073417.4342-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171124073417.4342-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] cpu: suffix cpu address spaces with
 indexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Fri, Nov 24, 2017 at 03:34:14PM +0800, Peter Xu wrote:
> v2:
> - drop patch 1 since merged
> - add last patch as suggested by Paolo
> 
> Please review, thanks.

Ping for 2.12 dev window.

> 
> Peter Xu (3):
>   cpu: refactor cpu_address_space_init()
>   cpu: suffix cpu address spaces with cpu index
>   cpu: put AddressSpace into CPUAddressSpace
> 
>  cpus.c                  |  5 +----
>  exec.c                  | 41 ++++++++++++++++++++++++++---------------
>  include/exec/exec-all.h |  6 ++++--
>  target/arm/cpu.c        | 13 +++----------
>  target/i386/cpu.c       | 10 ++--------
>  5 files changed, 36 insertions(+), 39 deletions(-)
> 
> -- 
> 2.14.3
> 

-- 
Peter Xu
