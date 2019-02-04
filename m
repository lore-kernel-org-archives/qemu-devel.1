Received: from eggs.gnu.org ([209.51.188.92]:40646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gqfE3-0007Uh-MY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gqfE2-0004IT-Ov
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:27:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45206
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gqfE2-0003jZ-Id
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:27:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14EOknx138310
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 09:27:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qep5fkbur-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:27:22 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 4 Feb 2019 14:27:21 -0000
Date: Mon, 4 Feb 2019 12:27:12 -0200
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190130233605.22163-1-muriloo@linux.ibm.com>
	<20190204000805.GB2593@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204000805.GB2593@umbus.fritz.box>
Message-Id: <20190204142712.GA11061@kermit.br.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@linux.ibm.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-ppc@nongnu.org, mopsfelder@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Balamuruhan S <bala24@linux.vnet.ibm.com>

On Mon, Feb 04, 2019 at 11:08:05AM +1100, David Gibson wrote:
> On Wed, Jan 30, 2019 at 09:36:03PM -0200, Murilo Opsfelder Araujo wrote:
> > The first patch unfolds parts of qemu_ram_mmap() to make it clearer.
> > No changes in the function behaviour.
> >
> > The second one fixes the alignment of the length given to munmap().
> >
> > I am pretty sure there is room for improvement, so I would love to
> > hear your feedback.
> >
> > Thank you!
>
> Applied to ppc-for-4.0.

Thank you all for reviewing and testing it.

I did appreciate!

--
Murilo
