Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1edi97-0002Ku-7j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1edi94-0007vr-4p
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1edi93-0007vO-Tx
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:52:42 -0500
Date: Mon, 22 Jan 2018 19:52:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180122195221.GC2628@work-vm>
References: <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
	<CAFEAcA-4HcQwWk2rEUuUc2PyGP8hnopbrL2zVOLiCayP3S7FrQ@mail.gmail.com>
	<016e04bd-3ee3-dffc-943f-394c8583c886@samsung.com>
	<CAFEAcA8wsQ7drfnyNbYHWcuNri4rn30BuE-4dXAnNFw_RZjxkw@mail.gmail.com>
	<96f66b1f-2248-04ed-aabb-0cac1342b0cc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f66b1f-2248-04ed-aabb-0cac1342b0cc@samsung.com>
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 01/22/2018 07:26 PM, Peter Maydell wrote:
> > On 22 January 2018 at 16:25, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> > > I want to keep 64bit atomic operations in migration.
> > Sorry, you can't -- some 32 bit CPUs simply do not provide these
> > operations. You need to rework your design to not require this.
> I would like to ask David,
> how do you think is it normal to use just one half of now_ms (int64_t), one
> half
> of 64 bit value should represent 1200 hours and probably it's enough to keep
> time
> difference.

Yes you could use an offset (start of migration?) - if the postcopy
phase is taking more than that long we're probably in trouble.
But remember your '0' value is special.

Dave

> > 
> > thanks
> > -- PMM
> > 
> > 
> > 
> 
> -- 
> Best regards,
> Alexey Perevalov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
