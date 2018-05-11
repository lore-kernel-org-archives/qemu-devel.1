Received: from eggs.gnu.org ([2001:4830:134:3::10]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fHBoC-0000wG-7p
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fHBo8-0005oT-8O
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:26:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fHBo8-0005oJ-2i
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:26:16 -0400
Date: Fri, 11 May 2018 18:26:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180511172611.GR22098@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-37-git-send-email-mst@redhat.com>
	<87o9hq8hcs.fsf@secure.laptop>
	<20180511202212-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511202212-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 36/67] migration: add include directory
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, May 11, 2018 at 08:23:22PM +0300, Michael S. Tsirkin wrote:
> On Tue, May 08, 2018 at 02:25:07PM +0200, Juan Quintela wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > This way they are easier to find using standard rules.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Nack.
> > 
> > This are _internal_ files, that shouldn't be used anywere elese.
> > 
> > Except .... that we need them to write tests.  We only have two scopes
> > on qemu:
> > - internal: only for the subsystem we are at in
> > - pubilc: they can be used everywhere
> > 
> > So, tests came in a strange class here, because they need internal
> > implementation, but they are not in the proper directory due to the way
> > we do tests.
> > I *think* that using complete paths is the only reasonable way of doing
> > this.
> > 
> > Thanks, Juan.
> 
> So how about tests include internal headers in a special way then?
> 
> #include "../migration/foo.h" works but makes it clear
> something unusual is going on.

I might suggest that the idea of having a single directory for all tests
is the real problem here. We have structured our source so that each
logically separate area of code has its own subdirectory, and then we
dump all unit tests in one big directory !

So how about moving unit tests into their respective directories, so
then any internal headers they need are just local includes.

Leave the global tests/ directory for qtests and iotests, etc which
don't need to poke at internal source.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
