Received: from eggs.gnu.org ([2001:4830:134:3::10]:55804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coosb-0006Wg-LB
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coosY-0003gf-Cf
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coosY-0003gV-3V
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:13:02 -0400
Date: Fri, 17 Mar 2017 10:12:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170317101257.GB8050@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<0f504dd2-235b-7ada-98b2-e0ccbd376fa7@redhat.com>
	<7e86352b-add7-7b73-4e6b-08016b3e7a5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e86352b-add7-7b73-4e6b-08016b3e7a5d@redhat.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 17, 2017 at 10:09:51AM +0100, Thomas Huth wrote:
> On 16.03.2017 17:52, Paolo Bonzini wrote:
> > 
> > 
> > On 16/03/2017 16:55, Peter Maydell wrote:
> >>> IOW, I think there is a reasonable 3 tier set here
> >>>
> >>>  1. Stuff we actively test builds & thus guarantee will work for
> >>>     any QEMU release going forward.
> >>>
> >>>  2. Stuff we don't actively test, but generally assume is mostly
> >>>     working, and likely to be fixed if & when problems are found
> >>>
> >>>  3. Stuff we don't actively test,  assume is probably broken
> >>>     and unlikely to be fixed if reported
> >>>
> >>> Stuff in tier 3 should be candidate for deletion. Stuff in tier
> >>> 2 shouldn't be removed, but it might drop into tier 3 at some
> >>> point if people stop caring about fixing problems when found.
> >>> Conversely tier 2 might rise to tier 1 if CI turns up.
> >>
> >> I don't really want a tier 2. Either we support it enough
> >> to at least be able to run "make && make check" on some
> >> representative system, or we don't support it at all.
> >> Code which we have but are really reluctant to touch because
> >> we don't even test it builds (like bsd-user/) is really bad
> >> for preventing cleanups.
> > 
> > I think we should further differentiate between bsd-user/ and softmmu.
> > System emulation is just another program where we mostly compile to C
> > standard + POSIX or C standard + Win32.  There are certainly places
> > where we use Linux-specific extensions but it's not that special.
> > Neither BSD nor Solaris are particularly hard to support there.
> > 
> > On the other hand, bsd-user is extremely BSD specific, and ought to have
> > CI.  I think there should be a tier 2 for system emulation (which
> > doesn't mean that anything there shouldn't be moved to tier 3 and
> > eventually removed), but there shouldn't be a tier 2 for user-mode
> > emulation.
> > 
> > In particular, I believe that we should remove bsd-user from 2.10 unless
> > the downstream BSD port is merged back (and CI is provided).  There is
> > no point in keeping the current half-baked code without thread support.
> 
> I think you made a good point here.
> So "+1" from my side to remove "bsd-user" and "tcg/ia64" in QEMU 2.10
> or 2.11 (unless someone speaks up and provides maintainence, of course).

In the mail thread two months back Sean Bruno did suggest he might like
to just start over with bsd-user:

  https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00171.html

So perhaps someone should just ping him to see if he objects to us
deleting bsd-usr now (on off chance he's got patches nearly ready to
fix it)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
