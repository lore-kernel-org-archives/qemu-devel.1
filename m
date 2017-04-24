Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2gIT-0000Vc-IV
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2gIQ-0006l4-Ii
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2gIQ-0006kU-CD
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:53:02 -0400
Date: Mon, 24 Apr 2017 16:52:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424155255.GD7705@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
	<20170424135749.GR20809@redhat.com>
	<CAFEAcA8YyeQ3NOGQkr8xVZ9S5F7RmdeDwcRkLGSyNci3hf4OCw@mail.gmail.com>
	<20170424154117.GB7705@redhat.com>
	<CAFEAcA8noBf9VCZ+n24NMqVKGZC9D7KKMhLoacNyEA=WJ39uAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8noBf9VCZ+n24NMqVKGZC9D7KKMhLoacNyEA=WJ39uAg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: GM.Ijewski@web.de, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 24, 2017 at 04:42:38PM +0100, Peter Maydell wrote:
> On 24 April 2017 at 16:41, Daniel P. Berrange <berrange@redhat.com> wrote:
> > We can have the existing qcrypto_init() call a qcrypto_random_init()
> > method to do the one-time initialization task, since that's already
> > required to run early in order to initialize gnutls when we use it.
> 
> Yep, that would work, or initialize-on-first-call.

I avoided suggesting that, to avoid having to worry about thread-safe
initialization :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
