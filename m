Received: from eggs.gnu.org ([209.51.188.92]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h29IM-00050k-GP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h29IL-00058a-Sq
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:47:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h29IL-00056C-LU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:47:49 -0500
Date: Fri, 8 Mar 2019 07:47:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

  Hi,

> > As an aside, it might be a nice idea to drop the in-srcdir
> > build altogether for QEMU anyway -- it's not really a very
> > good idea and it means our build system has to cope with two
> > different ways of working to no particularly useful end.
> 
> I was actually going to propose that, but I was afraid of throwing two
> bombs in the same day. :)

I stopped using in-tree builds years ago.  When test-building different
configurations using an build/$cfgname out-of-tree build directory is
the only sane approach.  And IIRC I've managed to break in-tree builds
because of that.

So, yes, please.

> CentOS 7 doesn't have "native" Python 3 (even the 3.4 version you have
> there is probably coming from Fedora) but it has software collections,
> where you have to do "scl enable rh-python35 './configure && make'".
> You can check if scl and the rh-python35 software collections are
> already installed.

Also:  epel offers a meson package.  It has python34 and python36
packages too.

cheers,
  Gerd
