Received: from eggs.gnu.org ([209.51.188.92]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwlBy-0004oA-Si
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwlBw-0003I7-7w
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:02:58 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:40930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gwlBr-0003CI-7T
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:02:52 -0500
Received: from player761.ha.ovh.net (unknown [10.109.146.20])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1B47D1B07F3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:02:38 +0100 (CET)
Date: Thu, 21 Feb 2019 11:02:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190221110229.117771c0@bahia.lan>
In-Reply-To: <20190221092546.GB17899@redhat.com>
References: <20190218181349.23885-1-ppandit@redhat.com>
	<20190219025500.GN9345@umbus.fritz.box>
	<20190221092546.GB17899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>

On Thu, 21 Feb 2019 09:25:46 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Feb 19, 2019 at 01:55:01PM +1100, David Gibson wrote:
> > On Mon, Feb 18, 2019 at 11:43:49PM +0530, P J P wrote: =20
> > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > >=20
> > > On ppc hosts, hypervisor shares following system attributes
> > >=20
> > >   - /proc/device-tree/system-id
> > >   - /proc/device-tree/model
> > >=20
> > > with a guest. This could lead to information leakage and misuse.[*]
> > > Add machine attributes to control such system information exposure
> > > to a guest.
> > >=20
> > > [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
> > >=20
> > > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org> =20
> >=20
> > Applied to ppc-for-4.0, thanks. =20
>=20
> Could you add the word  "CVE-2019-8934" to the commit message for this
> patch before sending a pulll request - either end of subject line, or
> just before the Reported-by line.
>=20

While here, please add my R-b tag as well:

Reviewed-by: Greg Kurz <groug@kaod.org>

> Regards,
> Daniel
