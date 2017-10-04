Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcPQ-0004M5-5I
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcPP-0002bp-B8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:39:52 -0400
Date: Wed, 4 Oct 2017 13:39:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171004053935.GB24018@lemon>
References: <150708336622.147.16727017734840064391@b58463cdfd5f>
	<7d6f852d-5186-e488-2f32-861ce5f69c79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6f852d-5186-e488-2f32-861ce5f69c79@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] block: Avoid copy-on-read assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Tue, 10/03 21:22, Eric Blake wrote:
> On 10/03/2017 09:16 PM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> > 
> 
> > 195         [not run] not suitable for this image format: raw
> > 197         - output mismatch (see 197.out.bad)
> > --- /tmp/qemu-test/src/tests/qemu-iotests/197.out	2017-10-04 01:52:59.000000000 +0000
> > +++ /tmp/qemu-test/build/tests/qemu-iotests/197.out.bad	2017-10-04 02:15:52.212004491 +0000
> > @@ -12,13 +12,18 @@
> >  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  read 0/0 bytes at offset 0
> >  0 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -read 2147483136/2147483136 bytes at offset 1024
> > -2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +
> > +(process:16284): GLib-ERROR **: gmem.c:100: failed to allocate 2147483136 bytes
> 
> Okay, a test that requires a nearly-2G read in one operation is fringe,
> and I can see it choking 32-bit platforms rather easily.  How do we
> modify the test to not be so mean to memory-starved systems?  And why
> didn't patchew complain about this on v1, which had the same ~2G read?

I don't know. The whole system (Fedora VM) is dedicated to patchew test and no
concurrent task should be running. Maybe 2G is just in between the memory
watermarks.

Fam
