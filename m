Received: from eggs.gnu.org ([209.51.188.92]:37434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkcJ-00056u-1O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkcH-0004Dh-N0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:26:06 -0500
Date: Thu, 21 Feb 2019 09:25:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190221092546.GB17899@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190218181349.23885-1-ppandit@redhat.com>
	<20190219025500.GN9345@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219025500.GN9345@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] ppc: add host-serial and host-model
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
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Feb 19, 2019 at 01:55:01PM +1100, David Gibson wrote:
> On Mon, Feb 18, 2019 at 11:43:49PM +0530, P J P wrote:
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
> Applied to ppc-for-4.0, thanks.

Could you add the word  "CVE-2019-8934" to the commit message for this
patch before sending a pulll request - either end of subject line, or
just before the Reported-by line.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
