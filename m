Received: from eggs.gnu.org ([2001:4830:134:3::10]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fkBVA-0005K6-OU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fkBV8-0006yh-2D
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:58:32 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <b7bf6a3f-812f-78af-4f5f-832eb460fbf1@de.ibm.com>
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
	<b7bf6a3f-812f-78af-4f5f-832eb460fbf1@de.ibm.com>
Message-ID: <153296989359.10934.14853590010864246630@sif>
Date: Mon, 30 Jul 2018 11:58:13 -0500
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/sclp: fix maxram calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, qemu-stable@nongnu.org

Quoting Christian Borntraeger (2018-07-30 10:31:12)
> Are we still able to get things into 2.12.1 or are we too late?

Freeze is EOD today, but I can grab them if they hit master/rc3 tomorrow.

> =

> =

> On 07/30/2018 04:09 PM, Christian Borntraeger wrote:
> > We clamp down ram_size to match the sclp increment size. We do
> > not do the same for maxram_size, which means for large guests
> > with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
> > This can break other code (e.g. CMMA migration) which uses maxram_size
> > to calculate the number of pages and then throws some errors.
> > =

> > Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug supp=
ort")
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > CC: qemu-stable@nongnu.org
> > CC: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/s390x/sclp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index bd2a024..4510a80 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -320,6 +320,7 @@ static void sclp_memory_init(SCLPDevice *sclp)
> >      initial_mem =3D initial_mem >> increment_size << increment_size;
> >  =

> >      machine->ram_size =3D initial_mem;
> > +    machine->maxram_size =3D initial_mem;
> >      /* let's propagate the changed ram size into the global variable. =
*/
> >      ram_size =3D initial_mem;
> >  }
> > =

>=20
