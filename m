Received: from eggs.gnu.org ([2001:4830:134:3::10]:43350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnlfo-0005D8-T7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnlfl-0005RD-0A
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cnlfk-0005NF-OI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:35:28 -0400
Date: Tue, 14 Mar 2017 13:35:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314123525.GH3952@noname.str.redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
	<20170314101351.GC3952@noname.str.redhat.com>
	<87y3w89hit.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3w89hit.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>

Am 14.03.2017 um 13:20 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 14.03.2017 um 10:24 hat Thomas Huth geschrieben:
> >> >   - in all areas our legacy code and back-compatibility requirements
> >> >     are threatening to choke forward progress if we don't make serious
> >> >     efforts to get on top of them
> >> 
> >> ... and don't forget all the code that is in "orphan" state since many
> >> years... it's often hard to get patches accepted that primarily touches
> >> files that nobody feels responsible for...
> >> 
> >> Maybe it's really time for a "spring-cleaning", break with some
> >> compatibility cruft and do a 3.0 release afterwards ;-)
> >
> > If we decide that the situation is bad enough to do this, I'd vote for
> > breaking not just "some" compatibility for a usual release after three
> > months, but to take more time for it, completely break with the old
> > interfaces and declare this a new QEMU that libvirt should have a
> > separate driver for. And then throw out _all_ of the interfaces that
> > don't match the design any more that we have in mind, even if this means
> > a temporary regression in features.
> >
> > This means one big cut rather than having every release just slightly
> > incompatible with the previous releases, which should actually make it
> > more managable, even though the change is more radical.
> 
> Of course, "legacy code and back-compatibility requirements" will start
> to grow back the minute we release new interfaces.  Whether a big cut is
> worthwhile depends on the seriousness of the current situation and the
> rate of regrowth.  There's hope the weeds will grow more slowly around
> well-designed new interfaces.

There is no doubt that this would happen. But we've managed to keep
compatibility more or less for 10 years, so if we extrapolate from that,
it means that in another 10 years we need another cut. Doesn't sound too
bad.

I'm not completely sure whether our situation really requires it, but
it's true that we're (or at least I am) spending a lot of time for
keeping compatibility with old interfaces that nobody really likes and
that simply don't match any more how things really work.

There are more nice-to-have things like consistently spelt option names
and monitor commands that will never be important enough to be cleaned
up on their own.

So I'm not saying that we should do this big cut, but _if_ we say that
3.0 is to be considered incompatible, then I'd go for the radical
approach rather than making things incompatible in hundreds of details,
but not really attacking the big problems that slow down development.

Kevin
