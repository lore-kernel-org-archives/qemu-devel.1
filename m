Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdV9q-0008LF-PV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdV9p-0003Rv-NH
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:32:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<CAFEAcA9J=Jmd=+9vEo4LLdk0LcL42fchHcAp3fp_+9q1tsCoNg@mail.gmail.com>
	<87tvp8or4u.fsf@dusky.pond.sub.org>
	<20180709130838.16f011a4.cohuck@redhat.com>
	<20180709111701.GF23731@redhat.com>
Date: Thu, 12 Jul 2018 08:32:45 +0200
In-Reply-To: <20180709111701.GF23731@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Mon, 9 Jul 2018 12:17:01 +0100")
Message-ID: <87601lge0i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jul 09, 2018 at 01:08:38PM +0200, Cornelia Huck wrote:
>> On Mon, 09 Jul 2018 08:33:05 +0200
>> Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >=20
>> > > On 6 July 2018 at 15:56, Kevin Wolf <kwolf@redhat.com> wrote:=20=20
>> > >> Am 06.07.2018 um 13:11 hat Cornelia Huck geschrieben:=20=20
>> > >>> That way, we can still easily remove old cruft (case (a)), but sti=
ll
>> > >>> accommodate cases like this (case (c)). The obvious drawback is th=
at
>> > >>> we'd need someone to curate the deprecation watchlist, to poke the
>> > >>> users we're waiting for, and probably remove anyway after some tim=
e if
>> > >>> they don't get their act together.=20=20
>> > >>
>> > >> The problem is that things are only starting to move after two rele=
ases
>> > >> have passed.=20=20
>> > >
>> > > Right, so clearly just "put a note in the documentation" isn't
>> > > sufficient advertisement/prodding of things going away.=20=20
>> >=20
>> > Yes.  Ideas on more forceful notification have been tossed around, we
>> > just have to act on them.
>> >=20
>> > >                                                         (Also, two
>> > > releases is pretty fast. Many of our users will be using distro
>> > > packaged versions of QEMU which will lag further behind than
>> > > bleeding-edge users. The system version of QEMU on my desktop
>> > > machine is 2.5...)=20=20
>> >=20
>> > If you consume QEMU in a way that's impacted by the changes the
>> > deprecation policy guards, you have two sane options:
>> >=20
>> > * Track upstream deprecation, either continuously, or at least right
>> >   after a QEMU release.  Since 2.10, they're collected in qemu-doc
>> >   appendix "Deprecated features".
>>=20
>> Can we draw more attention to this in any way? Point it out prominently
>> in the release notes? Send a list to known consumers (e.g. libvirt) on
>> release time?
>
> Yes, we should all newly deprecated stuff in the release notes.

No-brainer.

> For libvirt, I think whenever something is proposed for deprecation
> we could just CC libvir-list, or ask one of the libvirt people to
> confirm its not being used. If it is, then we should file BZ against
> libvirt.

Makes sense, but relying on developers getting their cc: right every
time is a setting us up for failure.

Our tool to help with getting cc: wrong less often is the MAINTAINERS
file.  Could one of the libvirt developers watch changes to qemu-doc
appendix "Deprecated features"?  Would putting the appendix in its own
.texi help with that?
