Received: from eggs.gnu.org ([209.51.188.92]:49028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwpVi-00086q-B3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwpVg-0000l0-T0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:39:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwpVe-0000ez-HY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:39:35 -0500
Date: Thu, 21 Feb 2019 15:39:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
	<CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/11] display: add -display spice-app
 launching a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>

  Hi,

> > Hmm, not working on RHEL-7:
> >
> >   qemu-system-x86_64: Failed to launch spice+unix:///tmp/.QON7WZ/spice.sock URI: The specified location is not supported
> >
> > virt-viewer + remote-viewer are installed.
> >
> > any clue?
> 
> 5 months old patch, not event released yet :( but virt-viewer should
> have a release very soon hopefully
> 
> https://pagure.io/virt-viewer/c/c4f6142f15c4e51cbf427f5f1bf1fc6ac0e10d88?branch=master
> 
> thanks

Too bad.  So broken for pretty much everyone I guess?

I think we should have a fallback which exec's remote-viewer then, for
the next 2-3 years, until a fixed virt-viewer is in widespread use ...

cheers,
  Gerd
