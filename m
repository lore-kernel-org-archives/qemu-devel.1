Received: from eggs.gnu.org ([2001:4830:134:3::10]:57821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7l0N-00025c-6w
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7l0J-0004ua-A5
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d7l0J-0004uS-3k
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:55:19 -0400
Date: Mon, 8 May 2017 16:55:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170508155511.GX18871@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, May 05, 2017 at 09:44:04AM +0200, Paolo Bonzini wrote:
> 
> 
> On 05/05/2017 05:23, Fam Zheng wrote:
> > A few tweaks to the docker images and running commands allow us to run
> > qemu-iotests in the fedora container. This will be added to the patchew test
> > cases later.
> > 
> > Fam Zheng (5):
> >   docker: Run tests with current user
> >   docker: Add bzip2 and hostname to fedora image
> >   docker: Use unconfined security profile
> >   docker: Add libaio to fedora image
> >   docker: Add test-block
> > 
> >  tests/docker/Makefile.include          |  3 ++-
> >  tests/docker/dockerfiles/fedora.docker |  4 ++--
> >  tests/docker/test-block                | 21 +++++++++++++++++++++
> >  3 files changed, 25 insertions(+), 3 deletions(-)
> >  create mode 100755 tests/docker/test-block
> > 
> 
> Patches 1-4:
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> For patch 5, I think we should revive the "quick" qemu-iotests group
> (maybe we can have support for skipping groups, and have a "slow" group
> with the very few tests that take >30 seconds?) and add the quick tests
> to "make check".

'quick' not only depends on the test case, but also the backend.
Most of the so called 'quick' tests are very slow with qcow v1 (over
your 30 sec mark), and can also be fairly slow with LUKS too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
