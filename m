Received: from eggs.gnu.org ([209.51.188.92]:59436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwq7u-0008Eo-TA
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwq7t-00034E-7Y
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:19:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwq7t-00033W-1W
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:19:05 -0500
Date: Thu, 21 Feb 2019 16:18:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221151856.4ypn2zxq5entu6aj@sirius.home.kraxel.org>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
	<CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
	<20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
	<CAJ+F1C+Kj5+J_-TXBmmGxzNOf_ehJ2xDzBAQoE8vjmUJJAChZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+Kj5+J_-TXBmmGxzNOf_ehJ2xDzBAQoE8vjmUJJAChZA@mail.gmail.com>
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

> > Too bad.  So broken for pretty much everyone I guess?
> 
> It should be easy to backport the patch for older virt-viewer.
> 
> But to get the "complete" experience, I would recommend you use the
> upcoming virt-viewer. Without it, you won't have the QMP monitor
> handling, VTE serial console, etc..
> 
> > I think we should have a fallback which exec's remote-viewer then, for
> > the next 2-3 years, until a fixed virt-viewer is in widespread use ...
> 
> I am not sure, I think it make sense to require the upcoming
> virt-viewer instead.
> 
> After all, if you use a bleeding edge qemu, you can use bleeding edge
> virt-viewer, no?

Fair enough, but please add a hint to the error message then so users
have a clue how to deal with it.

thanks,
  Gerd
