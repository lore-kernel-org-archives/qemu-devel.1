Received: from eggs.gnu.org ([2001:4830:134:3::10]:42385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d961F-0002Fh-N3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d961A-0005JV-Nk
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:33:49 -0400
Message-ID: <1494578016.3994.13.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 12 May 2017 10:33:36 +0200
In-Reply-To: <20170512073313.GB15313@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<1493908379.4214.8.camel@redhat.com> <20170504212237.341bf8ef@bahia>
	<20170512073313.GB15313@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, armbru@redhat.com

On Fri, 2017-05-12 at 17:33 +1000, David Gibson wrote:
> > The goal of this series is indeed to switch from raw to architected b=
ut I
> > agree that it shouldn't affect existing machine types. This probably =
calls
> > for some compat prop.
>=C2=A0
> So, I have mixed feelings about this.
>=C2=A0
> 1. Yes, the series was intended to switch from preferring raw to
> preferring architected mode.
>=C2=A0
> 2. No, it shouldn't have affected older machine types - I didn't think
> that through.
>=C2=A0
> But, having made the mistake, I'm not sure it's worth correcting.=C2=A0=
=C2=A0I
> don't actually expect this to break guests, and fixing it now that
> it's already there will be messy, and raises the possibility of new
> behavioural change between older and newer subversions of 2.9.

I'm not sure how QEMU handles maintenance branches, but it
seems to me that it would be better to confine this issue
to a single buggy release rather than carrying it forward
forever.

Downstream releases can just backport the relevant commits
and pretend nothing ever happened :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
