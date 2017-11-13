Received: from eggs.gnu.org ([2001:4830:134:3::10]:45850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEBvW-0003wt-9d
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEBvQ-0007aC-6T
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:25:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eEBvP-0007Zs-Vw
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:25:08 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1327ffaf-4153-a1d2-30c0-5fe8e884a126@redhat.com>
Date: Mon, 13 Nov 2017 11:25:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 13.11.2017 10:53, Peter Maydell wrote:
> On 13 November 2017 at 07:14, Thomas Huth <thuth@redhat.com> wrote:
>> By the way, before everybody now introduces "2.12" machine types ... i=
s
>> there already a consensus that the next version will be "2.12" ?
>>
>> A couple of months ago, we discussed that we could maybe do a 3.0 afte=
r
>> 2.11, e.g. here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>>
>> I'd still like to see that happen... Peter, any thoughts on this?
>=20
> I don't see the point in declaring a 3.0 unless we have some
> sweeping change that merits it. I don't think we should do a
> sweeping change unless we have a well laid out and agreed on
> plan for how the transition works.

Since we declared a lot of interfaces / features as deprecated in QEMU
2.10, we could finally remove them in the release after 2.11. Looking at
https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
that's quite a bit already. That's IMHO a good justification for a 3.0
already.
 > So I would want to see the
> plan discussed and agreed first, and then we can say "ok, and
> we think we can do this in this timescale and so the version
> at $DATE will be 3.0".

We could maybe also start a wiki page to collect ideas for what we want
to do with "3.0" ... but I guess a lot of the possible changes will just
be turned down again since somebody will cry "we need to stay compatible
with older versions! Forever!". So I somehow doubt that this is worth
the effort.

> Changing the version number should be
> the last part of this process, not the first, in my view.

Yeah, but you know how this works in QEMU-Land: Once the 2.12 is
established in the heads of various people, we'll have a hard time to
bump the version number again, since there's always somebody complaining.=
..

So I guess we'll likely end up doing it rather the Linux kernel way one
day - when we feel that the minor number got too big (three digits,
maybe?), we'll switch the major number without any further justification =
;-)

 Thomas
