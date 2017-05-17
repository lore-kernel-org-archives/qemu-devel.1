Received: from eggs.gnu.org ([2001:4830:134:3::10]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dAuh4-0003Wx-2n
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dAuh1-00076b-GD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:52:30 -0400
Message-ID: <1495011125.4663.5.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 17 May 2017 10:52:05 +0200
In-Reply-To: <20170517063547.23876-1-david@gibson.dropbear.id.au>
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] pseries: Correct behaviour change for
 older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, lvivier@redhat.com
Cc: mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-05-17 at 16:35 +1000, David Gibson wrote:
> 152ef80 "pseries: Rewrite CAS PVR compatibility logic" incorrectly
> introduced a guest-visible behaviour change into existing versioned
> machine type.=C2=A0=C2=A0Patch 2/2 corrects this change, while 1/2 is a
> preliminary clean up to make that easier.
>=C2=A0
> Unfortunately, this bug is already in the released qemu-2.9.0.=C2=A0=C2=
=A0Once
> this is ready to merge for master, I'll make a backport to apply for
> 2.9.1 as well.
>=C2=A0
> David Gibson (2):
>=C2=A0=C2=A0=C2=A0pseries: Split CAS PVR negotiation out into a separate=
 function
>=C2=A0=C2=A0=C2=A0pseries: Restore PVR negotiation logic for pre-2.9 mac=
hine types
>=C2=A0
>=C2=A0=C2=A0hw/ppc/spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A03 ++
>=C2=A0=C2=A0hw/ppc/spapr_hcall.c=C2=A0=C2=A0=C2=A0| 131 ++++++++++++++++=
+++++++++++++++++++++++++++------
>=C2=A0=C2=A0include/hw/ppc/spapr.h |=C2=A0=C2=A0=C2=A01 +
>=C2=A0=C2=A03 files changed, 119 insertions(+), 16 deletions(-)

I gave it a spin and I can no longer reproduce the issue,
so for the entire series:

Tested-by: Andrea Bolognani <abologna@redhat.com>

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
