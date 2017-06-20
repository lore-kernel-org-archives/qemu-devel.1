Received: from eggs.gnu.org ([2001:4830:134:3::10]:35073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dNHrp-00054r-QX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dNHrg-0004ns-E0
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:02:45 -0400
Date: Tue, 20 Jun 2017 13:02:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170620120206.GA23328@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-8-berrange@redhat.com>
	<w51d19y51e5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51d19y51e5.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v9 07/20] block: deprecate "encryption=on"
 in favor of "encrypt.format=aes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue, Jun 20, 2017 at 01:44:50PM +0200, Alberto Garcia wrote:
> On Mon 19 Jun 2017 07:34:42 PM CEST, Daniel P. Berrange wrote:
> > Historically the qcow & qcow2 image formats supported a property
> > "encryption=on" to enable their built-in AES encryption. We'll
> > soon be supporting LUKS for qcow2, so need a more general purpose
> > way to enable encryption, with a choice of formats.
> >
> > This introduces an "encrypt.format" option, which will later be
> > joined by a number of other "encrypt.XXX" options. The use of
> > a "encrypt." prefix instead of "encrypt-" is done to facilitate
> > mapping to a nested QAPI schema at later date.
> >
> > e.g. the preferred syntax is now
> >
> >   qemu-img create -f qcow2 -o encrypt.format=aes demo.qcow2
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > +    if (encryptfmt) {
> > +        buf = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT);
> > +        if (buf != NULL) {
> > +            g_free(buf);
> 
> If you use qemu_opt_get() instead then you don't need "buf" at all, do
> you?

IIRC, we needed to delete the option from opts, otherwise something
will later complain that there are opts that are not consumed.

> 
> > +    if (encryptfmt) {
> > +        buf = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT);
> > +        if (buf != NULL) {
> > +            g_free(buf);
> 
> Same here.
> 
> Everything else looks fine.
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
