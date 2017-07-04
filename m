Received: from eggs.gnu.org ([2001:4830:134:3::10]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSOFh-0001Q2-7P
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSOFd-00030u-8t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSOFc-0002zu-Vu
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:52:25 -0400
Date: Tue, 4 Jul 2017 14:52:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704135217.GA9211@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170704111404.28569-1-berrange@redhat.com>
	<20170704111404.28569-2-berrange@redhat.com>
	<33d0a009-766f-6c06-5968-d55ad19a0c27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33d0a009-766f-6c06-5968-d55ad19a0c27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] docs: document support lifetime for
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jul 04, 2017 at 02:43:29PM +0200, Thomas Huth wrote:
> On 04.07.2017 13:14, Daniel P. Berrange wrote:
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
> 
> Great, thanks for tackling this!
> 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 21079fd..27781e4 100644
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
> > @@ -3017,6 +3018,42 @@ Run the emulation in single step mode.
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
> Maybe say "at least for two major releases" instead? Sometimes we might
> forget to remove it in time, or we might decide to keep it alive a
> little bit longer in case it was once an important feature...

FWIW, I explicitly avoided saying "at least" when I wrote this. I
want to make deletion of deprecated features a clearly defined process
where we don't have to re-open the debate of whether its ok to now
delete it. 


> > +Deprecated features may also generate warnings on the console when
> > +QEMU starts up, or if activated via a monitor command, however,
> > +this is not a mandatory requirement.
> > +
> > +Certain features have an inherently finite lifetime, and thus
> > +will be removed on a fixed schedule, without following the normal
> > +deprecation process. Such features are listed in the sections
> > +that follow.
> > +
> > +@node Machine types
> > +@section Machine types
> > +
> > +For architectures which aim to support live migration compatibility
> > +across releases, each release will introduce a new versioned machine
> > +type. For example, the 2.8.0 release introduced machine types
> > +``pc-i440fx-2.8'' and ``pc-q35-2.8' 'for the x86_64/i686 architectures.
> 
> Space at wrong location --------------^

Opps.

> 
> > +To allow live migration of a guest running on a 2.8.0 release to a
> > +2.9.0, the QEMU 2.9.0 version must support the ``pc-i440fx-2.8'' and
> > +``pc-q35-2.8''.  To allow users live migrating VMs to skip multiple
> > +intermediate releases when upgrading, new releases of QEMU will
> > +support machine types from many previous versions.
> > +
> > +The supported lifetime for versioned machine types is 12 releases,
> 
> Maybe rather "The minimum supported lifetime ..." ? In case we decide to
> support it longer for any reasons...

Same point as above - I feel its important to set a clear fixed timeframe
to avoid re-opening debate each time we come to delete something.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
