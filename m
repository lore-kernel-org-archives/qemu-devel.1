Received: from eggs.gnu.org ([2001:4830:134:3::10]:41762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpxFb-0007gJ-Pi
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpxFS-0001KT-Az
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:53:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpxFS-0001Ji-4U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:53:38 -0400
Date: Thu, 7 Sep 2017 14:53:32 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907135332.GO30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906152111.16958-1-eblake@redhat.com>
	<CAFEAcA-1QOkSF+sG+0ymTv-Cx0WDEG4Ns4NydW-vz-box2Pi3Q@mail.gmail.com>
	<5ba61e49-3b84-46a4-2978-d42d3457f21b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ba61e49-3b84-46a4-2978-d42d3457f21b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/5] NBD patches for 2017-09-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 07, 2017 at 08:48:15AM -0500, Eric Blake wrote:
> On 09/07/2017 07:26 AM, Peter Maydell wrote:
> > On 6 September 2017 at 16:21, Eric Blake <eblake@redhat.com> wrote:
> >> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:
> >>
> >>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
> >>
> >> are available in the git repository at:
> >>
> >>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-09-06
> >>
> >> for you to fetch changes up to 030fa7f6f950f5c8963f1dee8e6bb7387ed86a99:
> >>
> >>   nbd: Use new qio_channel_*_all() functions (2017-09-06 10:11:54 -0500)
> >>
> 
> > I get an error in test-aio-multithread (clang, linux, x86-64):
> >   GTESTER tests/test-aio-multithread
> > **
> > ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-aio-multithread.c:368:test_multi_fair_mutex:
> > assertion failed (counter == atomic_counter): (532693 == 532694)
> > GTester: last random seed: R02Sa68ef1eb4822359eb869642ff26180df
> 
> I wonder if that is a rare but pre-existing bug, as I don't see any use
> of qio_channel in test-aio-multithread, and therefore no obvious way
> that this series would be the cause of the intermittent failure.

Agreed. Even if there was use of QIOChannel, there is certainly no use
of the qio_channel_read|write_all functions that are being changed
in this series, since they've only just been added to QEMU and are only
used in the test suite and your final NBD patch here. So I think this
must be a pre-existing race condition.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
