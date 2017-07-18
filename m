Received: from eggs.gnu.org ([2001:4830:134:3::10]:56682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dXNT6-0004Me-AX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dXNT1-00034R-GP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:02:56 -0400
Message-ID: <1500364961.11997.10.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 18 Jul 2017 10:02:41 +0200
In-Reply-To: <68cfb52b-d4cc-1980-e6f5-a454baf4e2e5@linux.vnet.ibm.com>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
	<1499856934.13989.38.camel@redhat.com>
	<68cfb52b-d4cc-1980-e6f5-a454baf4e2e5@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, libvir-list@redhat.com

On Wed, 2017-07-12 at 17:09 +0530, Shivaprasad G Bhat wrote:
> Setting numa_node for emulated devices is the benefit for now. On x86, =
I
> figured there is
> no way to set the numa_node for the root controller and the emulated
> devices sitting there
> all have numa_node set to -1. Only the devices on the pxb can have a
> sensible value specified.
> Does it mean, the emulated devices/drivers don't care about the
> numa_node they are on?
>=C2=A0
> Would it be fine on PPC to disallow setting the NUMA node for the
> default PHB because that is where
> all the emulated devices sit ?

I was not aware of that limitation for x86 guests.

If that's the case, then I would say it's perfectly okay to
just disallow setting the NUMA node for the default PHB, at
least for the time being.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
