Received: from eggs.gnu.org ([2001:4830:134:3::10]:41069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1sN-0004rj-KR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX1sM-0001gL-Lg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX1sM-0001fr-DH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:59:34 -0400
Date: Mon, 17 Jul 2017 09:59:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717085927.GD3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170714101549.28665-1-berrange@redhat.com>
	<20170714101549.28665-2-berrange@redhat.com>
	<20170714170617.GJ6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714170617.GJ6020@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] docs: document support lifetime for
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jul 14, 2017 at 02:06:17PM -0300, Eduardo Habkost wrote:
> On Fri, Jul 14, 2017 at 11:15:48AM +0100, Daniel P. Berrange wrote:
> > There is currently no explicit guidance on the duration of support
> > for features such as versioned machine types, which have a finite
> > useful lifespan. Thus apps / users cannot predict how much time
> > they might be able to use a feature for, before it is removed (if
> > ever).
> > 
> > This adds a new appendix that lists items which have finite lifecycles,
> > such as machine types. For items which are generally expected to be
> > supported indefinitely, it sets out the policy around deprecation
> > and removal, should it be needed.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 48af5155c7..f067015d4b 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -38,6 +38,7 @@
> >  * QEMU Guest Agent::
> >  * QEMU User space emulator::
> >  * Implementation notes::
> > +* Support lifetime::
> >  * License::
> >  * Index::
> >  @end menu
> > @@ -3128,6 +3129,42 @@ Run the emulation in single step mode.
> >  
> >  @include qemu-tech.texi
> >  
> > +@node Support lifetime
> > +@appendix Support lifetime
> > +
> > +In general features are intended to be supported indefinitely once
> > +introduced into QEMU.
> > +
> > +In the event that a feature needs to be removed, it will be listed
> > +in the ``Deprecated features'' appendix of this document. The feature
> > +will remain functional for 2 major releases prior to actual removal.
> 
> Is a "major release" a x.0 release?  So if we decide to to
> deprecate a feature in QEMU 2.10, does this mean we will be able
> to remove it only on QEMU 4.0?
> 
> This doesn't sound like a predictable feature lifetime, if we
> don't have a predictable policy for major release numbering.

No, when I say "major" release there I meant non-bugfix releases.
eg 2.8, 2.9, 2.10, etc.  Lets remove the word "major" to avoid
such confusion



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
