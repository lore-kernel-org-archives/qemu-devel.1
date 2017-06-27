Received: from eggs.gnu.org ([2001:4830:134:3::10]:60342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPn3x-0003wS-Ht
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPn3t-0004xo-K8
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPn3t-0004wY-Ej
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:45:33 -0400
Date: Tue, 27 Jun 2017 10:45:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170627094526.GA13634@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170616101246.1550-1-berrange@redhat.com>
	<20170616101246.1550-6-berrange@redhat.com>
	<a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
	<af6452ce-af71-1f92-e744-a370d35ac8dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af6452ce-af71-1f92-e744-a370d35ac8dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Mon, Jun 26, 2017 at 09:30:38PM -0500, Eric Blake wrote:
> On 06/26/2017 09:10 PM, Eric Blake wrote:
> > On 06/16/2017 05:12 AM, Daniel P. Berrange wrote:
> >> The semantics around handling ipv4=on|off & ipv6=on|off are quite
> >> subtle to understand in combination with the various hostname addresses
> >> and backend types. Introduce a massive test matrix that launches QEMU
> >> and validates the ability to connect a client on each protocol as
> >> appropriate.
> >>
> >> The test requires that the host has ability to bind to both :: and
> >> 0.0.0.0, on port 9000. If either protocol is not available, or if
> >> something is already listening on that port the test will skip.
> >>
> >> Although it isn't using the QTest APIs, it expects the
> >> QTEST_QEMU_BINARY env variable to be set.
> > 
> > I note that on failure, v3 created test-sockets-proto.pid in the current
> > working directory (the top level, if I ran 'make check-qtest') rather
> > than under the tests/ subdirectory or even better under a scratch
> > location that gets automatically cleaned up regardless of failure mode.
> > 
> > Since v3 failed for me, but v4 passes (and cleans up on success), I
> > can't say if that is still a problem in v4.
> 
> Scratch that - I just confirmed that 'test-sockets-proto.pid' is still
> created and now listed by 'git status' as a stray file after my in-tree
> build 'make check', even though the test passed.

Yep, I notice that I completely forgot to delete the pid file after
reading it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
