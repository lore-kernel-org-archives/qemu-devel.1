Received: from eggs.gnu.org ([2001:4830:134:3::10]:37455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8kSm-0002ds-WC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8kSj-00011t-1z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d8kSi-00011o-SE
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:32:44 -0400
Date: Thu, 11 May 2017 10:32:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170511093240.GK8639@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170510111535.11190-1-berrange@redhat.com>
	<20170510163902.GG19962@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170510163902.GG19962@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] docs: document support lifetime and
 deprecation policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, May 10, 2017 at 12:39:02PM -0400, Stefan Hajnoczi wrote:
> On Wed, May 10, 2017 at 12:15:35PM +0100, Daniel P. Berrange wrote:
> > The deprecation of features in QEMU is totally adhoc currently,
> > with no way for the user to get a list of what is deprecated
> > in each release. There is also no guidance on the duration of
> > support for features such as versioned machine types, which
> > have a finite useful life.
> > 
> > This adds two new appendix entries to the main QEMU documentation.
> > The first appendix lists items which have finite lifecycles,
> > and sets out the policy that is used for deprecating & removing
> > features which have indefinite lifecycles. The second appendix
> > provides a list of all[1] currently deprecated features, along
> > with the release they were deprecated in.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > 
> > [1] This is a lie. I've only listed one deprecated feature. Once
> >     we agree on the general concept, we can fill out the doc
> >     with the rest of the currently deprecated features.
> > ---
> >  qemu-doc.texi | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> 
> Peter maydell is away in May.  He usually participates in discussions on
> this topic.  Unless there are urgent issues I suggest we wait until June
> to commit QEMU to new policies.

That's fine with me.

I just sent this because of the 'deprecate machine types' patch.

IMHO, we should decide on this general policy first, and only then
deprecate machine types in accordance with agreed policy, rather
than do an aribtrary deprecation of a bunch of machine types with
no clear idea of why we're picking them.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
