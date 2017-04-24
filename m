Received: from eggs.gnu.org ([2001:4830:134:3::10]:59507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2h1d-0001nk-Qf
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2h1a-0004zi-NW
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2h1a-0004zd-HR
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:39:42 -0400
Date: Mon, 24 Apr 2017 17:39:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424163936.GE7705@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
	<20170424135749.GR20809@redhat.com>
	<CAFEAcA8YyeQ3NOGQkr8xVZ9S5F7RmdeDwcRkLGSyNci3hf4OCw@mail.gmail.com>
	<20170424154117.GB7705@redhat.com>
	<CAFEAcA8noBf9VCZ+n24NMqVKGZC9D7KKMhLoacNyEA=WJ39uAg@mail.gmail.com>
	<20170424155255.GD7705@redhat.com>
	<f92490f5-a09c-0f11-4ea5-f09969f78870@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f92490f5-a09c-0f11-4ea5-f09969f78870@web.de>
Subject: Re: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 24, 2017 at 06:33:26PM +0200, Geert Martin Ijewski wrote:
> > We can have the existing qcrypto_init() call a qcrypto_random_init()
> > method to do the one-time initialization task, since that's already
> > required to run early in order to initialize gnutls when we use it.
> 
> Wouldn't it make sense to also move the unix initalization to that function?

Yep, we can do that.

> And what about deinitalization? Though because that handle needs to stay
> valid throughout the whole lifetime of QEMU anyway, that probably can be
> ignored and taken care of by the OS

Correct, there's no need for any de-init if we have a global handle, as it
is needed until QEMU exits.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
