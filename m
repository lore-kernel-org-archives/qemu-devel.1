Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnjSo-0008TW-64
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnjSk-0002NH-51
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cnjSj-0002Mj-Uz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:54 -0400
Date: Tue, 14 Mar 2017 11:13:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314101351.GC3952@noname.str.redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

Am 14.03.2017 um 10:24 hat Thomas Huth geschrieben:
> >   - in all areas our legacy code and back-compatibility requirements
> >     are threatening to choke forward progress if we don't make serious
> >     efforts to get on top of them
> 
> ... and don't forget all the code that is in "orphan" state since many
> years... it's often hard to get patches accepted that primarily touches
> files that nobody feels responsible for...
> 
> Maybe it's really time for a "spring-cleaning", break with some
> compatibility cruft and do a 3.0 release afterwards ;-)

If we decide that the situation is bad enough to do this, I'd vote for
breaking not just "some" compatibility for a usual release after three
months, but to take more time for it, completely break with the old
interfaces and declare this a new QEMU that libvirt should have a
separate driver for. And then throw out _all_ of the interfaces that
don't match the design any more that we have in mind, even if this means
a temporary regression in features.

This means one big cut rather than having every release just slightly
incompatible with the previous releases, which should actually make it
more managable, even though the change is more radical.

Kevin
