Received: from eggs.gnu.org ([2001:4830:134:3::10]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGHgK-0007Qb-D9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGHgH-0006vz-3R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:25:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dGHgG-0006vn-Q1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:25:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v514NsYR066611
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 00:25:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at85qgjjr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 00:25:49 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 00:25:48 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170601040646.GB27525@in.ibm.com>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601040646.GB27525@in.ibm.com>
Date: Wed, 31 May 2017 23:25:41 -0500
Message-Id: <149629114184.3207.6757927820110284250@loki>
Subject: Re: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Quoting Bharata B Rao (2017-05-31 23:06:46)
> On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> > The code managing DRCs[0] has quite a few things that are more
> > complicated than they need to be.  In particular the object
> > representing a DRC has a bunch of method pointers, despite the fact
> > that there are currently no subclasses, and even if there were the
> > method implementations would be unlikely to differ.
> =

> So you are getting rid of a few methods. How about other methods ?
> Specially attach and detach which have incorporated all the logic needed
> to handle logical and physical DRs into their implementations ?

I would avoid any methods that incorporate special-casing for
physical vs. logical DRCs, since that seems like a good logical
starting point for moving to 'physical'/'logical' DRC
sub-classes to help simplify the increasingly complicated
state-tracking.

I also don't think we should expose DRC internal fields to
outside callers (which attach/detach would involve). This
series does that to some extent with the RTAS calls, but
since those are now moved to spapr_drc.c it makes more sense.

> =

> Guess these will be follow in subequent parts ? =

> =

> Regards,
> Bharata.
> =

>=20
