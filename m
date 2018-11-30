Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfbI-00020a-SB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfb9-0003QS-F4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:00:44 -0500
Date: Fri, 30 Nov 2018 10:00:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130100000.GE8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <faeb4b80-e191-d670-d057-28eb4ac11d11@linux.ibm.com>
	<79b674dd-d5b5-ff7c-7497-6fce2cb31b8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79b674dd-d5b5-ff7c-7497-6fce2cb31b8a@redhat.com>
Subject: Re: [Qemu-devel] qemu-iotests 232 fails when running the test as
 root user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Thu, Nov 29, 2018 at 03:07:54PM -0600, Eric Blake wrote:
> On 11/29/18 3:03 PM, Farhan Ali wrote:
> > Hi,
> > 
> > I am seeing a failure of the qemu-iotest number 232 when running the
> > test as a root user. Is this the expected behavior?
> > 
> > Here is the output of the failure:
> > 
> 
> > -QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off:
> > Could not open 'TEST_DIR/t.IMGFMT': Permission denied
> > -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> > -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> > -
> > -QEMU_PROG: -drive
> > driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not
> > open 'TEST_DIR/t.IMGFMT': Permission denied
> > -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> > -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> > +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> 
> Not entirely unexpected (since root can read what are otherwise read-only
> files), but obviously unexpected by the test. The test should probably
> refuse to run as root.

I'd suggest that *all* our tests shoudl refuse to run as root as a matter
of principal. The risk of them doing damage is way too high and there is
no good reason why anyone should be building & testing QEMU as root
rather than an unprivileged user.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
