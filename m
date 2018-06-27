Received: from eggs.gnu.org ([2001:4830:134:3::10]:44815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY6SP-0003Mm-Ka
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY6SM-0006Kb-ED
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:09:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fY6SM-0006Jb-8V
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:09:42 -0400
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
	<20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5d591d6c-ccc4-cc86-ebbc-3c66a6817c70@redhat.com>
Date: Wed, 27 Jun 2018 11:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 27.06.2018 10:52, Gerd Hoffmann wrote:
>   Hi,
>=20
>>> Is QEMU still useful on 32-bit hosts?  Honest question!
>>
>> I guess it depends on what 32-bit hosts you consider. If you look at o=
nly
>> x86 vs. x86_64 then probably x86 is not that important any more but fo=
r some
>> embedded systems/SoCs 32bit might still be common and QEMU useful for =
those
>> (also as host not only emulated).
>=20
> Well.  I've used kvm with an 32bit arm soc (cubietruck).  It's very
> slow.  And all the arm architecture improvements to support kvm better
> are for aarch64 only.
>=20
>> Another option might be to not support audio/hda on 32bit hosts. It's =
not
>> nice either but a lot nicer than dropping support for 32bit hosts
>> alltogether to fix a problem in device emulation.
>=20
> But it also is not useful and a waste of resources to maintain 32bit
> host compatibility if nobody actually uses that ...
>=20
> For me testbuilds are the only reason to compile qemu for 32bit hosts.
> Since years.

Well, while that's true for you, me and likely most of us developers,
you can not know whether this is also true for all users of qemu. Thus
this needs to be announced first for a couple of releases so that people
have a chance to speak up whether they still need this or not. As
mentioned earlier, embedded devices are often still 32-bit and I know
that there really are people who use QEMU on embedded devices.

But I think we could at least announce now already that we intend to
drop support for 32-bit hosts in the future (maybe not in 2 releases
already, but, let's say in 2020? 2020 is already the EOL of Python 2, so
that will rule out a bunch of other legacy hosts, too).

 Thomas
