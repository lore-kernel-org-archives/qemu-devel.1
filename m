Received: from eggs.gnu.org ([209.51.188.92]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbLI-0004eh-UP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbLH-0004t2-4I
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:19:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gqbLG-0004m2-Rv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:19:06 -0500
Date: Mon, 4 Feb 2019 10:10:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204101005.GC1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190201185358.6972-1-ppandit@redhat.com>
	<20190204010904.GD2593@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204010904.GD2593@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>

On Mon, Feb 04, 2019 at 12:09:04PM +1100, David Gibson wrote:
> On Sat, Feb 02, 2019 at 12:23:58AM +0530, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >=20
> > On ppc hosts, hypervisor shares following system attributes
> >=20
> >   - /proc/device-tree/system-id
> >   - /proc/device-tree/model
> >=20
> > with a guest. This could lead to information leakage and misuse.[*]
> > Add machine attributes to control such system information exposure
> > to a guest.
> >=20
> > [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
> >=20
> > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Hm.  This seems like it might be overkill.  I mean, obviously we need
> to not leak that host information, but it's not clear we really need
> these properties at all.  They're not specified in PAPR (contrary to
> my previous guess) and it's not clear what actually uses them.
>=20
> I'm wondering if we can just ditch them entirely, or at least make
> them default to not present without regard to machine version.
>=20
> Yes, that's technically a compatibility breaking change, but it's hard
> to see anything that actually relied on these as not being broken
> already, so I think that's actually a fair trade off for the security
> improvement here.

We cannot assume that no one is using it.

In fact this issue came to light precisely because a person on IRC
was asking why x86 couldn't provide the same info as PPC, because
they found it useful on PPC.

So we will definitely break people if we remove this from existing
VMs.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
