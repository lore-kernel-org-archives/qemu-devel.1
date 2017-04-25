Received: from eggs.gnu.org ([2001:4830:134:3::10]:49574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d30vj-0002u1-OM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d30vg-0007jT-LY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d30vg-0007j3-FP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:54:56 -0400
Date: Tue, 25 Apr 2017 14:54:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425135452.GI21129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <faa27752-45a9-e6f3-d6fc-cad8254c4f31@web.de>
	<20170425134259.GH21129@redhat.com>
	<a7cc0ade-e37f-0c06-afdb-dbcf69a72e6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7cc0ade-e37f-0c06-afdb-dbcf69a72e6c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] crypto_gen_random() now also works on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Geert Martin Ijewski <gm.ijewski@web.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Tue, Apr 25, 2017 at 08:52:58AM -0500, Eric Blake wrote:
> On 04/25/2017 08:42 AM, Daniel P. Berrange wrote:
> > On Mon, Apr 24, 2017 at 07:51:49PM +0200, Geert Martin Ijewski wrote:
> >> If no crypto library is included in the build QEMU uses
> >> qcrypto_random_bytes() to generate random data. That function tried to open
> >> /dev/urandom or /dev/random and if openeing neither file worked it errored
> >> out.
> >>
> 
> >> +int qcrypto_random_init(Error **errp)
> >> +{
> >> +#ifdef _WIN32
> >> +    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
> >> +                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
> >> +        error_setg_errno(errp, GetLastError(),
> >> +                         "Unable to create cryptographic provider");
> > 
> > Unfortunately the return value of 'GetLastError()' isn't an errno
> > so we can't use error_setg_errno here.
> > 
> > Just use error_setg, and report the error value with a '(code=%u)'
> > substitution at the end of the error message.
> > 
> 
> Or, use error_setg_win32(), which is designed for this purpose.

Oh nice, didn't know that existed !

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
