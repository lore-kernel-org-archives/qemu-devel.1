Received: from eggs.gnu.org ([2001:4830:134:3::10]:56859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj3FN-0000V2-In
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj3FJ-0007gC-Sz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:20:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj3FJ-0007fq-Mq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:20:41 -0500
Date: Wed, 1 Mar 2017 12:20:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301122036.GB10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170228122901.24520-1-berrange@redhat.com>
	<20170301121934.GD29473@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170301121934.GD29473@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix stale 'trace-events-all' file in
 build dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Mar 01, 2017 at 12:19:34PM +0000, Stefan Hajnoczi wrote:
> On Tue, Feb 28, 2017 at 12:28:59PM +0000, Daniel P. Berrange wrote:
> > If systemtap support was disabled, the trace-events-all file was
> > only getting regenerated at time of 'make instal'. This is bad
> > because it leaves stale files in the build dir for developers.
> > 
> > Daniel P. Berrange (2):
> >   makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables
> >   makefile: generate trace-events-all upfront
> > 
> >  Makefile                   | 39 +++++++++++++++++++--------------------
> >  Makefile.target            |  6 +++---
> >  target/s390x/Makefile.objs |  2 +-
> >  tests/Makefile.include     |  2 +-
> >  4 files changed, 24 insertions(+), 25 deletions(-)
> > 
> > -- 
> > 2.9.3
> > 
> > 
> 
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

Could you apply the two typo fixes eric mentioned on the commit message

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
