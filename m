Received: from eggs.gnu.org ([2001:4830:134:3::10]:44034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emN2X-0007XA-Mc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emN2T-0003J7-G8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:09:45 -0500
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:59822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1emN2T-0003Gb-8U
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:09:41 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8B16814E4A8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:09:39 +0100 (CET)
Date: Thu, 15 Feb 2018 18:09:32 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180215180932.67721e4f@bahia.lan>
In-Reply-To: <20180215165418.GA24818@redhat.com>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863726311.3003.8227524786940828598.stgit@bahia.lan>
	<20180215040818.GH5247@umbus.fritz.box>
	<20180215170831.39645199@bahia.lan>
	<20180215165418.GA24818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: drop DIV_ROUND_UP() from
 xics_max_server_number()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>

On Thu, 15 Feb 2018 16:54:18 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Feb 15, 2018 at 05:08:57PM +0100, Greg Kurz wrote:
> > On Thu, 15 Feb 2018 15:08:18 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Wed, Feb 14, 2018 at 08:41:03PM +0100, Greg Kurz wrote: =20
> >=20
> > <snip>
> >  =20
> > > >=20
> > > > It breaks migration of pre-2.7 machine types with unusual CPU topol=
ogies,
> > > > but I guess this is an acceptable trade-off.   =20
> > >=20
> > > No, not really.  Weird topologies are still allowed on old machine
> > > types for backwards compatibility, and we shouldn't break that.  I
> > > like the idea of consolidating this calculation, but we can't do it by
> > > just breaking the older machines (at least not until they're formally
> > > deprecated).
> > >  =20
> >=20
> > Heh, I had put this patch at the end because I was expecting you might
> > nack it :)
> >=20
> > Per curiosity, when/how do we decide that an older machine type may be
> > formally deprecated ? =20
>=20
> For versioned machine types we decided that we'd keep them around upstream
> for as long as they were needed by a downstream vendor, *provided* that
> downstream vendor is contributing to QEMU in order to mitigate the maint
> burden it would entail.=20
>=20

Indeed I now remember having heard something like that in the past. Thanks
for the details anyway. :)

And, this is probably a dumb question, but do we have an up-to-date list
of QEMU versions still needed by a contributing vendor ?

> Regards,
> Daniel
