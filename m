Received: from eggs.gnu.org ([2001:4830:134:3::10]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyx7N-0000tR-Uf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyx7K-0002PY-Qk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:06:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyx7K-0002P6-Mi
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:06:42 -0400
Date: Thu, 22 Mar 2018 18:06:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322100627.GI32362@xz-mi>
References: <CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
	<CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
	<84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
	<CABLmASFvQED-tsDGCgmw3LYx_CkLeKTGoQ_oU9qLHpGu=a=-hg@mail.gmail.com>
	<ed9c25bd-e5be-bde1-2447-775c3bfc93ad@redhat.com>
	<20180322051938.GG32362@xz-mi>
	<1b16d3da-cdd6-f18e-ed50-b5a0e25fbc59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b16d3da-cdd6-f18e-ed50-b5a0e25fbc59@redhat.com>
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>

On Thu, Mar 22, 2018 at 10:14:19AM +0100, Paolo Bonzini wrote:
> On 22/03/2018 06:19, Peter Xu wrote:
> > +#ifdef CONFIG_LINUX
> >  /* Benchmark results from 2016 on NVMe SSD drives show max polling times around
> >   * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
> >   * workloads.
> >   */
> >  #define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
> 
> POSIX, not Linux. :)   I'll fix it myself.

Oops... Thanks. :)

-- 
Peter Xu
