Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dON5d-0007D2-VW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dON5b-0005yq-Pw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dON5b-0005yH-GD
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:49:27 -0400
Date: Fri, 23 Jun 2017 12:49:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170623114917.GG28635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170606110556.12922-1-berrange@redhat.com>
	<20170606110556.12922-2-berrange@redhat.com>
	<878tkjexn5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tkjexn5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] docs: document deprecated features
 in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jun 23, 2017 at 01:44:46PM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > The deprecation of features in QEMU is totally adhoc currently,
> > with no way for the user to get a list of what is deprecated
> > in each release. This adds an appendix to the doc that records
> > when each deprecation[1] was made and provides text explaining
> > what to use instead.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >
> > [1] This is a lie. I've only listed one deprecated feature. Once
> >     we agree on the general concept, we can fill out the doc
> >     with the rest of the currently deprecated features.
> 
> As written, this is PATCH RFC.  We can either collect the currently
> deprecated features before we commit (with the footnote dropped), or
> collect later (but then we should note the incompleteness in
> qemu-doc.texi, not just the commit message).

Assuming this patches continues to get favourable feedback, my
intention was/is to grep the source code for the word "deprecated"
to identify the "full" set, and then send a non-RFC version.


> > @@ -3016,6 +3017,19 @@ Run the emulation in single step mode.
> >  
> >  @include qemu-tech.texi
> >  
> > +@node Deprecations
> 
> Perhaps "Deprecated Features"?  Not a native speaker...

Yep, sounds better.

> 
> > +@appendix Deprecations
> > +
> > +The following is a list of features which have been marked as deprecated,
> > +pending removal in a future release:
> > +
> > +@section -drive boot=on|off (since v1.3.0)
> > +Since release 1.3.0, the ``boot=on|off'' parameter to ``-drive''
> 
> I wouldn't repeat "since v1.3.0".  It'll get old quickly when the list
> grows.

Agreed.

> 
> > +is no longer honoured. It is currently ignored, but a future verson
> > +will reject this parameter with an error. Applications should use
> > +the ``bootindex=N'' parameter to set an absolute ordering between
> > +devices instead.
> > +
> >  @node License
> >  @appendix License
> 
> I like it.
> 
> Of course, new deprecations need to be in release notes, too.  If the
> duplication bothers us, we could perhaps just point to release notes.
> We'd have to check and amend old release notes to make sure all
> currently deprecated features are covered.

Since the texi is fairly well structured, we could extract the list
of new deprecations from this doc in an automated manner, to populate
the per-release notes.  I'd like to keep the combined list as the
canonical location of the info, so app developers have a single
place to look to find the list, rather than searching multiple
release notes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
