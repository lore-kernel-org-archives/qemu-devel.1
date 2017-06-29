Received: from eggs.gnu.org ([2001:4830:134:3::10]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQdiI-0002RN-Uv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQdiF-00078h-SL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:58:47 -0400
Received: from mail-eopbgr40127.outbound.protection.outlook.com
	([40.107.4.127]:52829
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dQdiF-00077U-FS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:58:43 -0400
Date: Thu, 29 Jun 2017 20:58:20 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170629175820.GC13435@rkaganb.sw.ru>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
	<20170629172030.224712ad@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629172030.224712ad@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/23] hyperv fixes and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>

On Thu, Jun 29, 2017 at 05:20:30PM +0200, Igor Mammedov wrote:
> On Wed, 21 Jun 2017 19:24:01 +0300
> Roman Kagan <rkagan@virtuozzo.com> wrote:
> 
> > This series applies miscellaneous fixes and enhancements to Hyper-V
> > emulation code in QEMU, and lays out the ground for VMBus devices.
> 
> Series is a big random mix of cleanup/refactoring/new features
> which is hard to review due to mixed content of above
> within patches as well inter them.
> 
> I suggest to split series in at least in 2
>  1: make cleanups/refactoring first
> and on top of this
>  2: add new features

Indeed, I started to realize this.  I'll try to re-split better when
respinning.

> * hyperv_find_vcpu() with expensive lookup and related renaming
>   might be not needed at all if local_apics[12/23] is used.
> 
> *pls add in cover letter a link to public git repo where
>  it would be possible to pull from for testing/review.

I'm in the process of setting it up, will include it next time.

> PS:
> if renaming, do it consistently.
> ex:
>  vcpu_id -> vp_index touches only hyperv.c
>  but leaves old naming in user of kvm_hv_sint_route_create(): hyperv_testdev.c

I strived for eventual consistency: no vcpu_id is left after the last
patch in the series.  But it's probably harder to review patch by patch.
So I'll redo the way you suggest.

Thanks,
Roman.
