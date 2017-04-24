Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2eV4-0000uR-N0
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2eV0-0007Po-VC
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2eV0-0007Pb-Os
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:57:54 -0400
Date: Mon, 24 Apr 2017 14:57:49 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424135749.GR20809@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
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

On Mon, Apr 24, 2017 at 02:52:30PM +0100, Peter Maydell wrote:
> On 24 April 2017 at 14:36, Daniel P. Berrange <berrange@redhat.com> wrote:
> > FYI, both gnutls and openssl use these CryptAcquireContext/CryptGenRandom
> > methods, so I'd prefer to stick with that.
> 
> They probably need the full crypto API anyway, though...
> 
> > It seems we merely need to set CRYPT_SILENT in the flags to prevent any
> > chance of interactive prompts.
> >
> > https://msdn.microsoft.com/en-us/library/windows/desktop/aa379886(v=vs.85).aspx
> 
> How about CRYPT_VERIFYCONTEXT? The docs say "in most cases this flag
> should be set".
> 
> This kind of discussion puts me off the Crypt* APIs though -- they're
> a complicated API that can easily be misused. "Please just fill
> this buffer with randomness" is a simple API that's hard to call
> wrongly...

This is the extent of gnutls's code in this area

https://gitlab.com/gnutls/gnutls/blob/master/lib/nettle/sysrng-windows.c

Our API has the same usage scenario as this, hence my preference to mirror
what gnutls & other crypto libraries are using.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
