Received: from eggs.gnu.org ([2001:4830:134:3::10]:41154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJcPv-00064J-GV
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJcPs-0007H7-Ec
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:38:31 -0500
Message-ID: <1482309497.3732.30.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 21 Dec 2016 09:38:17 +0100
In-Reply-To: <20161221045245.GE13024@umbus.fritz.box>
References: <20161215061128.30792-1-david@gibson.dropbear.id.au>
	<1482160529.3732.2.camel@redhat.com>
	<20161219234717.GG23176@umbus.fritz.box>
	<1482225561.3732.12.camel@redhat.com>
	<20161221045245.GE13024@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 for-2.9 0/6] HPT resizing for
 pseries guests (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2016-12-21 at 15:52 +1100, David Gibson wrote:
> > > I'm not sure if we need a knob.=C2=A0=C2=A0I think in general enabl=
ing for
> > > pseries-2.9 and later machine types is correct.=C2=A0=C2=A0The diff=
iculty is
> > > that for HV guests, we can only enable it if the host kernel also h=
as
> > > support.=C2=A0=C2=A0Explicitly setting "resize-hpt=3Denable" means =
qemu will not
> > > start if the kernel doesn't support it.
> >=C2=A0
> > I thought that would be the case for resize-hpt=3Drequired,
> > not resized-hpt=3Denabled.
>=C2=A0
> resize-hpt=3Denabled requires the host to support resizing, but not the
> guest.=C2=A0=C2=A0resize-hpt=3Drequired requires both the host and the =
guest to
> support resizing.
>=C2=A0
> If you can think of a less ambiguous word for it, let me know.

The name makes sense, we just need to document the host
kernel requirement properly. The error message should of
course mention it as well.

> > Moreover, do you foresee any situation in which users
> > might reasonably want to turn the feature off even though
> > the entire stack (host kernel, QEMU, guest kernel)
> > understands it?
>=C2=A0
> Nothing clearly compelling.=C2=A0=C2=A0In the nearish term, being able =
to turn
> it off to isolate possible bugs could be useful of course.=C2=A0=C2=A0I=
t's also
> possible that you could have a VM where the latency of each resize
> could be too much downtime - although in that case I doubt you'd want
> to hotplug memory anyway.

It seems like the use case would be fairly narrow, if it
existed at all. Given that, I think we should avoid adding
yet another knob to libvirt until its value can be
unquestionably proven.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
