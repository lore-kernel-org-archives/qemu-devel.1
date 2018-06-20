Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXRX-0008Og-Nw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXRS-0007Fw-PC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:22:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVXRS-0007Fi-JD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:22:10 -0400
Date: Wed, 20 Jun 2018 15:21:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180620072152.GH18985@xz-mi>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-5-peterx@redhat.com>
	<871sd2vpzg.fsf@dusky.pond.sub.org> <20180620030620.GC18985@xz-mi>
	<87y3faj5hi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3faj5hi.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/7] tests: iotests: drop some stderr
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jun 20, 2018 at 09:12:57AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jun 19, 2018 at 03:57:07PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > In my Out-Of-Band test, "check -qcow2 060" fail with this (the output is
> >> > manually changed due to line width requirement):
> >> >
> >> > 060 5s ... - output mismatch (see 060.out.bad)
> >> > --- /home/peterx/git/qemu/tests/qemu-iotests/060.out
> >> > +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad
> >> > @@ -427,8 +427,8 @@
> >> >  QMP_VERSION
> >> >  {"return": {}}
> >> >  qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1
> >> >   index: 0); further non-fatal corruption events will be suppressed
> >> > -{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
> >> > - "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2
> >> > - table offset 0x2a2a2a0
> >> > 0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
> >> >  read failed: Input/output error
> >> > +{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
> >> > + "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2
> >> > + table offset 0x2a2a2a0
> >> > 0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
> >> >  {"return": ""}
> >> >  {"return": {}}
> >> >  {"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
> >> >   "event": "SHUTDOWN", "data": {"guest": false}}
> >> 
> >> Please indent this diff; I'd expect git-am to choke on it.
> >
> > Do you mean something like pretty-JSON?
> 
> Instead of
> 
>     In my Out-Of-Band test, "check -qcow2 060" fail with this (the output is
>     manually changed due to line width requirement):
>     
>     060 5s ... - output mismatch (see 060.out.bad)
>     --- /home/peterx/git/qemu/tests/qemu-iotests/060.out
>     +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad
>     @@ -427,8 +427,8 @@
>      QMP_VERSION
>      {"return": {}}
> 
> write
> 
>     In my Out-Of-Band test, "check -qcow2 060" fail with this (the output is
>     manually changed due to line width requirement):
>     
>         060 5s ... - output mismatch (see 060.out.bad)
>         --- /home/peterx/git/qemu/tests/qemu-iotests/060.out
>         +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad
>         @@ -427,8 +427,8 @@
>          QMP_VERSION
>          {"return": {}}
> 
> The former confuses git-am.
> 
> In other words, quote diff output verbatim, but indent your quote.
>     
> > How about I remove this chunk too?  What do you prefer?
> 
> I rather like having the test failure details in the commit message.

Ah I see.  I'll keep them then.

Thanks,

-- 
Peter Xu
