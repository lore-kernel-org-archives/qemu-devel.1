Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctdXD-000683-J0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctdX4-0001Td-Nk
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37132
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ctdX4-0001RY-HQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:06:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2UGwlD0114895
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:06:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29h4cnwr9j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:06:43 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 30 Mar 2017 11:06:41 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA8Yhm-vaf+AYfNTZG5jR6tVv1mtt_tGCiRD+SVBZ5mFJA@mail.gmail.com>
References: <CAFEAcA8EgBp8=xjyfR+nuYw5KvdptNC++o39nAJiwu-SWWM+yw@mail.gmail.com>
	<149029914932.3910.14105127854664571409@loki>
	<CAFEAcA8Yhm-vaf+AYfNTZG5jR6tVv1mtt_tGCiRD+SVBZ5mFJA@mail.gmail.com>
Date: Thu, 30 Mar 2017 12:05:29 -0500
Message-Id: <149089352985.3776.13525112292689981413@loki>
Subject: Re: [Qemu-devel] qga-test failure on Linux/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Quoting Peter Maydell (2017-03-30 10:13:17)
> On 23 March 2017 at 19:59, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > Quoting Peter Maydell (2017-03-23 10:13:13)
> >> Hi; I find that qga-test fails on Linux/sparc host:
> =

> > I think the code is assuming that it'll be the virtual block device
> > itself that's mounted, rather than a partition within it. This is
> > certainly a false assumption, so we shouldn't be making this a
> > fatal error.
> >
> > It does make me wonder if we *should* be looking at the parent to
> > get the slave/device information though, which in turn means we
> > might want logic to traverse up the whole tree for nested cases.
> > But the GuestDiskAddress field of GuestFilesystemInfo is documented
> > as possibly being empty for certain disk types, so I think for now
> > we can simply relax the error. Will send a patch for 2.9.
> =

> Did you find time to write a patch for this yet?
> It would be nice to be able to add the sparc machine to the
> build test set for 2.9.

Sorry, the patch was trivial, but I'd gotten distracted before I had a chan=
ce
to test. I think I've recreated the scenario with loopback devices though,
but you might want to give it a run just to double-check (I've cc'd you on
the patch). Either way, I will send a pull by EOD.

> =

> thanks
> -- PMM
>=20
