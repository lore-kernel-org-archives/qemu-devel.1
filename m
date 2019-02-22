Received: from eggs.gnu.org ([209.51.188.92]:55625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gxDzZ-0007ry-4F
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gxDzY-0005Ed-Ex
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:48:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gxDzW-0004cT-Cb
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:48:02 -0500
Date: Fri, 22 Feb 2019 16:47:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190222164713.GF2574@work-vm>
References: <VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190222163735.GB2616@work-vm>
	<1f3243df-1037-235f-838f-4651df476ee3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3243df-1037-235f-838f-4651df476ee3@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@outlook.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Natanael Copa <ncopa@alpinelinux.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 22/02/19 17:37, Dr. David Alan Gilbert wrote:
> > Why does vring_avail_idx use virtio_ld*u*w_phys_cached?
> > (similar for vring_avail_ring).
> > There's no generically safe way to do unaligned atomic loads - don't we know
> > in virtio that these are naturally aligned?
> 
> u is for unsigned. :)  We know that these are aligned and so they will
> be atomic.

Ah OK!

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
