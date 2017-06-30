Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mpe@ellerman.id.au>) id 1dQtHp-0003xx-7O
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mpe@ellerman.id.au>) id 1dQtHm-0002IN-4p
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:36:29 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <9aebd9c7-3d2d-7bd6-4010-8f8205f62f01@kaod.org>
References: <20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
	<20170630071402.GF13989@umbus.fritz.box>
	<9aebd9c7-3d2d-7bd6-4010-8f8205f62f01@kaod.org>
Date: Fri, 30 Jun 2017 20:36:19 +1000
Message-ID: <87wp7tpxss.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, sbobroff@redhat.com, mikey@neuling.org

C=C3=A9dric Le Goater <clg@kaod.org> writes:

>>>> According to https://patchwork.ozlabs.org/patch/776052/
>>>>
>>>> POWER9 DD2's PVR is expected to be 0x004e1200
>>=20
>> Uh.. I spoke to Michael Ellerman, and he said he expected 0x004e0200.
>> Though he did mention there might be several variants.  Can we please
>> get a definitive answer on this from IBM.
>
> Adding Michael Ellerman in cc: but I think Greg is correct.=20

I don't claim to be correct :)

AFAIK Mikey's patch (linked above) is the most definitive public
documentation we have on this.

Which says:
  The P9 PVR bits 12-15 don't indicate a revision but instead different
  chip configurations.  From BookIV we have:
     Bits      Configuration
      0 :    Scale out 12 cores
      1 :    Scale out 24 cores
      2 :    Scale up  12 cores
      3 :    Scale up  24 cores

His heading of "Bits" is somewhat confusing, I'm pretty sure he just
means "the decimal value of bits 12-15", not a bit number.

Which means there may be "POWER9 DD2" chips with PVRs of:
  - 0x004e02xx
  - 0x004e12xx
  - 0x004e22xx
  - 0x004e32xx
=20
So the question is just which of the scale out values to use. Neither
is technically correct, because Qemu won't necessarily be emulating a 12
or 24 core system.

Mikey did say "Linux will mostly use the "Scale out 24 core"
configuration", but AFAIK that's really just about the system designs
that are currently in plan.

Hope that makes it clear as mud :)

cheers
