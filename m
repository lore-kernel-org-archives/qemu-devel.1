Received: from eggs.gnu.org ([2001:4830:134:3::10]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC5oS-0003g0-CH
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC5oR-0002Xn-9Y
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:33:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
Date: Mon, 15 Oct 2018 18:33:32 +0200
In-Reply-To: <20181015101309.GD10459@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 15 Oct 2018 12:13:09 +0200")
Message-ID: <87woqjw4o3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
>> On 15 October 2018 at 10:32, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> > On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
>> >> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> >> ---
>> >> I'd like to do this in QEMU 3.1.  I think it's time to drop
>> >> support for old systems that have only Python 2.
>> >>
>> >> We still have a few scripts that are not required for building
>> >> QEMU that still work only with Python 2 (iotests being the most
>> >> relevant set).  Requiring Python 3 for building QEMU won't
>> >> prevent people from using those scripts with Python 2 until they
>> >> are finally ported.
>> >
>> > I think it is premature & unecessary to do this. We just got QEMU buil=
ding
>> > with dual Python2/3 in 3.0 to give people leeway in the migration path=
 to
>> > a fully v3 future. The code to support building 2/3 in parallel is not
>> > imposing a unreasonable maint burden. Dropping py2 suport would have
>> > negligible impact on the code, as there's no v3-only features we have
>> > used. IOW, I don't think there's a compelling reason to rush into forc=
ing
>> > users onto v3.
>> >
>> > If we want to drop py2, we should give people a warning of such a plan=
ned
>> > change, especially since some of our targetted host OS[1] don't even
>> > include a py3 as standard without acquiring extra add-on repos. Devs in
>> > a typical corporate env will not have the freedom to install such extra
>> > repos on their machines.
>>=20
>> I agree. I also think that dropping python 2 support before we've
>> even converted all our python scripts to handle python 3 is the
>> wrong order to do things. People interested in moving forward with
>> the transition to python-3-only should start by making sure everything
>> we have works with python 3...
>
> It's easier to port stuff to Python 3 though than making them work with
> both. I think Eduardo's RFC is in part motivated by a patch from
> Philippe that converted something in iotests to work with Python 3,
> passed review and then turned out to break Python 2.

Seconded.  This is not about the cost of maintaining existing
compatibility gunk, it's about the extra effort to first get the
remainder to work with 2 and 3, only to throw away 2 a few months later.

I propose we permit ourselves to port stuff that isn't essential to
building QEMU straight to 3 instead.  This includes iotests.

> Having to test every iotests patch twice with different Python versions
> isn't something I would like to do for extended periods of time.

It's worth doing only if the benefits of doing it outweigh the costs.  I
don't think they do.
