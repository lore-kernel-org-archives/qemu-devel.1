Received: from eggs.gnu.org ([209.51.188.92]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmE5l-0000Gr-L2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmE5k-0001EU-T3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmE5k-0001Dd-MH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:41:00 -0500
Date: Wed, 23 Jan 2019 09:40:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123084054.thmakyhttshhzszv@sirius.home.kraxel.org>
References: <20190121141152.948-1-kraxel@redhat.com>
	<CAFEAcA93m=WproC2bpcT1WL7aDkDMVV4oPMV5B4CmsEAUw7pyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA93m=WproC2bpcT1WL7aDkDMVV4oPMV5B4CmsEAUw7pyQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190121 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

> >  delete mode 100644 pc-bios/qemu-icon.bmp
> 
> Doesn't this break the SDL UI? ui/sdl.c still looks for
> qemu-icon.bmp...

Well, a little bit, and SDL 1.2 only.  The icon is gone.  qemu runs fine
though.

SDL 1.2 is deprecated though, and I'm busy looking at the remaining
blockers for SDL 1.2 removal.  I expect it being removed before 4.0.

cheers,
  Gerd
