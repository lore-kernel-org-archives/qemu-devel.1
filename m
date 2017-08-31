Received: from eggs.gnu.org ([2001:4830:134:3::10]:39962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTWO-0003p0-6z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTWL-0002vj-36
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:44:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56948
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dnTWK-0002vb-U0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:44:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VHhthC130907
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 13:44:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpnaadbrv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 13:44:47 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 13:44:47 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <c79ab349-116d-10d5-9310-f3ff8a6b4b81@redhat.com>
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
	<CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
	<e24316e0-3b6f-ef1c-7c4b-66e7b302e5b4@linux.vnet.ibm.com>
	<97b35c4d-e897-c18a-525f-1fa1a7560776@de.ibm.com>
	<20170825092008.12484e6a.cohuck@redhat.com>
	<d3e9d032-fd2e-6126-1774-cb8a86a219f4@de.ibm.com>
	<20170825102950.736647be.cohuck@redhat.com>
	<2fdd5a70-6339-c4ec-c13c-d6f96d7abfc9@de.ibm.com>
	<c79ab349-116d-10d5-9310-f3ff8a6b4b81@redhat.com>
Date: Thu, 31 Aug 2017 12:44:32 -0500
Message-Id: <150420147254.3063.2667079729715778036@loki>
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

Quoting Thomas Huth (2017-08-29 04:35:22)
> On 28.08.2017 09:18, Christian Borntraeger wrote:
> > =

> > =

> > On 08/25/2017 10:29 AM, Cornelia Huck wrote:
> >> On Fri, 25 Aug 2017 10:21:58 +0200
> >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>
> >>> On 08/25/2017 09:20 AM, Cornelia Huck wrote:
> >>
> >>>> OK, to recap:
> >>>>
> >>>> - the current pre-built bios seems fine
> >>>> - rebuilding the bios may yield a version that fails on some systems
> >>>>   (different compiler?)
> >>>> - adding aligned(8) looks like the right thing to do
> >>>> - it seems to fix the problem, but on at least one system something
> >>>>   still seems off (under investigation)  =

> >>>
> >>> Yes. I am out of office today, so for any aligned(8) patch
> >>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>> even for 2.10.
> >>
> >> I fear the 2.10 train has already left the station, but any aligned(8)
> >> patch should be cc:stable.
> > =

> > I think this could be a topic for QEMU summit. Our process of not allow=
ing
> > fixes in rcx without requiring an rc(x+1) seems a bit odd. The Linux ke=
rnel
> > style (there are fixes between the last rc and release) seems more bala=
nced
> > as long as we establish some safety nets.
> =

> This sounds like a good idea to me, yes. And maybe we could also ease
> the situation a little bit by providing the first stable .1 release
> already two or three weeks after the .0 release [*] ? Then these "we are
> not 100% sure whether this is a severe blocker or not" patches could
> simply be provided to the public with that .1 release instead of
> blocking the QEMU master branch in freeze state...

I can give it a try for 2.10.1.

At least initially, I would prefer to not have there be a set expectation
that there will be a quick .1 release though, but rather anything tagged
for-2.10, for instance, that doesn't make it in, will then fall into
the "expedited 2.10.1" bucket, and for that to be the *only* way to get
into that bucket (we'd still do the normal round-up and pull in any
"Cc: qemu-stable@nongnu.org" patches at that point though).

This would help ensure we don't steal focus from the .0 releases and allow
those "is this a blocker?" discussions to happen in the proper context.

> =

>  Thomas
> =

> =

> [*] I know that means more additional work for Michael - sorry for that
> ... but at least we should talk about this, I think. Maybe someone else
> could also help with the releases if it's too much work for one person?
>=20
