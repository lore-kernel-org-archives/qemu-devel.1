Received: from eggs.gnu.org ([2001:4830:134:3::10]:37155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8kQc-0001mm-PZ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8kQY-0008Pu-Rb
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d8kQY-0008ON-IJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:30:30 -0400
Date: Thu, 11 May 2017 10:30:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170511093022.GJ8639@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<20170510103153.GI31558@redhat.com>
	<ccb8fecd-e918-1cc0-28ef-af9865540fbc@redhat.com>
	<157a6609-d75a-5d40-e5b9-c70802e40950@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157a6609-d75a-5d40-e5b9-c70802e40950@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com

On Wed, May 10, 2017 at 06:15:39PM +0200, Paolo Bonzini wrote:
> 
> 
> On 10/05/2017 16:47, Thomas Huth wrote:
> >> So while we can delete pc-0.12, we can't delete associated features needed
> >> by pc-0.12, without complicating RHEL's ability to create its back-compat
> >> machine types. Downstream would have to un-delete the features.
> >
> > So I guess this is why Paolo said that pc-0.12 is still in "use" ... I
> > think removing pc-0.12, but not removing rombar=0 will cause confusion
> > in the upstream code base sooner or later,
> 
> I agree.
> 
> > so I guess we should rather
> > keep the pc-0.12 machine until we can get rid of it together with the
> > rombar code. We should still mark it as deprecated, of course.
> >
> >> I think tieing removal to major versions is a mistake, unless we're
> >> going to set a fixed timeframe for delivery of major versions. ie if
> >> we gaurantee that we'll ship a new major version every 18 months, that
> >> gives people a predictable lifetime.  If we carry on inventing reasons
> >> for major versions at arbitrary points in time, it makes it difficult
> >> to have any reasonable forward planning.  It is more users friendly if
> >> we can set a clear fixed timeframe for machine type lifecycle / eol
> >
> > IMHO we should have a new major release after we've reached a .9 minor
> > release, but so far it seems like I'm the only one with that wish...
> 
> I actually like that, but then you've pretty much guaranteed that you
> _cannot_ remove anything deprecated until 4.0.  You and Daniel aren't
> disagreeing as heavily as it seems, I think.

I don't think we should tie removal of features to version numbers. IMHO
we should just increment the first major digit on a fixed time scale,
either once a year, or whenever we get past .9.

For removal of features, IMHO, the only important thing is to give users
deprecation clear warning for 2-3  releases, and ensure feature detection
works well. As long as that is done, there shouldn't be any need to batch
them up for "major" releases. From libvirt POV, batching up removal to
major releases is not beneficial. Batching to major releases gives a very
inconsistent timeframe for removal too - somethign fdeprecated in .1
release may live on for years,  until the next $major.0, while something
deprecated in a .9 release can be killed in 4 months. I much prefer to
see a consistent deprecated for 2 releases / 8 months, then deleted
regardless of feature.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
