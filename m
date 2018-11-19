Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOkbL-00032q-9y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOkbF-0000Tv-78
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:32:35 -0500
Date: Mon, 19 Nov 2018 14:32:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119143219.GQ19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-6-berrange@redhat.com>
	<5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
	<20181119102732.GF19532@redhat.com>
	<5a677a31-ce10-cc2a-58b1-5589c20970da@redhat.com>
	<30b19e80-a7c5-8012-e9ff-86ae2025ca15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30b19e80-a7c5-8012-e9ff-86ae2025ca15@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: add iotests helpers for dealing
 with TLS certificates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, Nov 19, 2018 at 08:27:56AM -0600, Eric Blake wrote:
> On 11/19/18 5:04 AM, Max Reitz wrote:
> 
> > > > > +tls_dir="${TEST_DIR}/tls"
> > > > > +
> > > > > +function tls_x509_cleanup()
> > > > > +{
> > > > > +    rm -f ${tls_dir}/*.pem
> > > > > +    rm -f ${tls_dir}/*/*.pem
> > > > > +    rmdir ${tls_dir}/*
> > > > > +    rmdir ${tls_dir}
> > > > 
> > > > Why not just:
> > > > rm -rf $tls_dir
> > > 
> > > Yeah, I guess we could do that for simplicity
> > > 
> > > > Also, the quoting is a bit inconsistent. if ${TEST_DIR} can contain spaces,
> > > > then all uses of ${tls_dir} need to be in "".
> > > 
> > > Hmm, yes.
> > 
> > Which by the way is a very good reason *not* to blindly use "rm -r".
> 
> If we ever revive Jeff Cody's patches to let each test run with its own
> temporary directory, then we don't need this function at all.  With that in
> place, you either run the testsuite in debug mode (all temporary files
> preserved) or in normal mode (./check itself does rm -rf on the temporary
> directory).

That would be very nice - i'm often just commenting out the rm lines to
preserve temp files.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
