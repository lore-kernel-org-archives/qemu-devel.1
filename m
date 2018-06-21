Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVsjG-0004wv-Bg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVsjD-0007Pt-3h
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:05:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVsjC-0007Pl-Ul
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29E31AD65
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 06:05:54 +0000 (UTC)
Date: Thu, 21 Jun 2018 08:05:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180621060551.fksdpt6lzjvbiun4@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-25-marcandre.lureau@redhat.com>
	<20180619064334.a2f6yv7yyiwlyqsk@sirius.home.kraxel.org>
	<CAMxuvaxmprDW2bEzEJB38cqV5eRT=jBaMav9EJnMG5e6SNr-Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaxmprDW2bEzEJB38cqV5eRT=jBaMav9EJnMG5e6SNr-Ow@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/26] virtio-gpu: split virtio-gpu,
 introduce virtio-gpu-base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>

On Wed, Jun 20, 2018 at 06:04:25PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Jun 19, 2018 at 8:43 AM, Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > On Mon, Jun 18, 2018 at 06:17:27PM +0200, Marc-Andr=E9 Lureau wrote:
> >> Add a base class that is common to virtio-gpu and vhost-user-gpu
> >> devices.
> >
> > More verbose commit message please.  What functionality is common and
> > handled by the new (abstract?) base class?  (same for patch #25).
>=20
> Would that level of details be enough?

> The VirtIOGPUBase base class provides common functionalities necessary
> for both virtio-gpu and vhost-user-gpu:
> - common configuration (max-outputs, initial resolution, flags)
> - virtio device initialization, including queue setup
> - device pre-conditions checks (iommu)
> - migration blocker
> - virtio device callbacks
> - hooking up to qemu display subsystem
> - a few common helper functions to reset the device, retrieve display
> informations
> - a class callback to unblock the rendering (for GL updates)
>=20
> What is left to the virtio-gpu subdevice to take care of, in short,
> are all the virtio queues handling, command processing and migration.

Looks good.

cheers,
  Gerd
