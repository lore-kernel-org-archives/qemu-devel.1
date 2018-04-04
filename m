Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3kul-0002eV-2P
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3kuh-0002GX-0V
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:05:35 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:52157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1f3kug-0002GK-Qj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:05:30 -0400
Received: by mail-it0-x22a.google.com with SMTP id b5-v6so18034079itj.1
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 09:05:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
Date: Wed, 4 Apr 2018 12:05:28 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C36CDC6-851D-41A3-BDA8-1D2712437117@gmail.com>
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
	<b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Apr 4, 2018, at 11:55 AM, Stefan Weil <sw@weilnetz.de> wrote:
>=20
> Am 04.04.2018 um 16:58 schrieb Daniel P. Berrang=C3=A9:
>> On Wed, Apr 04, 2018 at 04:45:48PM +0200, Paolo Bonzini wrote:
>>> On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
>>>> The source/quality of those binaries is completely opaque. We've no =
idea who
>>>> built them, nor what build options were used, nor what/where the =
corresponding
>>>> source is (required for GPL compliance), nor any checksum / =
signature to
>>>> validate the binary isn't compromised since build, etc, etc.
>>>>=20
>>>> Pointing users to those binaries makes it appear QEMU project is =
blessing
>>>> them, and so any issues with them directly reflect on QEMU's =
reputation.
>>>>=20
>>>> If we're going to link to binaries telling users to download them, =
we need
>>>> to be hosting them on qemu.org and have a clearly documented formal =
process
>>>> around building & distributing them.
>>>>=20
>>>> Since both Homebrew & Macports are providing formal bulds though, =
it looks
>>>> simpler to just entirely delegate the problem to them, as we do for =
Linux
>>>> where we delegate to distro vendors to build & distribute binaries.
>>>=20
>>> Note that, to some extent, the same issues do apply to Win32 =
binaries
>>> (in particular, they are distributed under http and there are no
>>> signatures).  However, the situation is better in that they are =
hosted
>>> on an identifiable person's website, and of course Windows doesn't =
have
>>> something akin to Homebrew and Macports so there is no alternative =
to
>>> volunteers building and hosting the binaries.
>>=20
>> It would be desirable & practical to address that for Win32, by =
building
>> the Win32 binaries at time of cutting the release, using the Mingw =
toolchain
>> via one of our formal Docker environments. Would need buy-in of our =
release
>> manager to accept the extra work for making releases though...
>>=20
>> Regards,
>> Daniel
>=20
> That would be one possible way. A more automated way could use CI =
builds
> (for example on GitHub) to generate executables for Windows.
>=20
> By the way: https://qemu.weilnetz.de provides https (maybe I should
> enforce it), it includes sha512, and I also sign the binaries with my
> key. You still have to trust me, Debian and Cygwin (which provides =
lots
> of libraries used for the build).
>=20
> Regards,
> Stefan

I guess there is just too much distrust to provide a QEMU binary for =
download.=
