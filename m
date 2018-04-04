Received: from eggs.gnu.org ([2001:4830:134:3::10]:57045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3l8J-0004YM-Mm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3l8G-0003Kf-DA
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:19:35 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1f3l8G-0003KR-6v
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:19:32 -0400
Received: by mail-io0-x235.google.com with SMTP id m83so27011754ioi.8
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 09:19:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <395f732f-dca2-a2e8-7c4c-0cbe79f3e8c5@redhat.com>
Date: Wed, 4 Apr 2018 12:19:29 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B844F19-6C50-475D-B33D-3A66620A2595@gmail.com>
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
	<b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
	<6C36CDC6-851D-41A3-BDA8-1D2712437117@gmail.com>
	<395f732f-dca2-a2e8-7c4c-0cbe79f3e8c5@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Apr 4, 2018, at 12:08 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 04/04/2018 18:05, Programmingkid wrote:
>>=20
>>> On Apr 4, 2018, at 11:55 AM, Stefan Weil <sw@weilnetz.de> wrote:
>>>=20
>>> Am 04.04.2018 um 16:58 schrieb Daniel P. Berrang=C3=A9:
>>>> On Wed, Apr 04, 2018 at 04:45:48PM +0200, Paolo Bonzini wrote:
>>>>> On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
>>>>>> The source/quality of those binaries is completely opaque. We've =
no idea who
>>>>>> built them, nor what build options were used, nor what/where the =
corresponding
>>>>>> source is (required for GPL compliance), nor any checksum / =
signature to
>>>>>> validate the binary isn't compromised since build, etc, etc.
>>>>>>=20
>>>>>> Pointing users to those binaries makes it appear QEMU project is =
blessing
>>>>>> them, and so any issues with them directly reflect on QEMU's =
reputation.
>>>>>>=20
>>>>>> If we're going to link to binaries telling users to download =
them, we need
>>>>>> to be hosting them on qemu.org and have a clearly documented =
formal process
>>>>>> around building & distributing them.
>>>>>>=20
>>>>>> Since both Homebrew & Macports are providing formal bulds though, =
it looks
>>>>>> simpler to just entirely delegate the problem to them, as we do =
for Linux
>>>>>> where we delegate to distro vendors to build & distribute =
binaries.
>>>>>=20
>>>>> Note that, to some extent, the same issues do apply to Win32 =
binaries
>>>>> (in particular, they are distributed under http and there are no
>>>>> signatures).  However, the situation is better in that they are =
hosted
>>>>> on an identifiable person's website, and of course Windows doesn't =
have
>>>>> something akin to Homebrew and Macports so there is no alternative =
to
>>>>> volunteers building and hosting the binaries.
>>>>=20
>>>> It would be desirable & practical to address that for Win32, by =
building
>>>> the Win32 binaries at time of cutting the release, using the Mingw =
toolchain
>>>> via one of our formal Docker environments. Would need buy-in of our =
release
>>>> manager to accept the extra work for making releases though...
>>>>=20
>>>> Regards,
>>>> Daniel
>>>=20
>>> That would be one possible way. A more automated way could use CI =
builds
>>> (for example on GitHub) to generate executables for Windows.
>>>=20
>>> By the way: https://qemu.weilnetz.de provides https (maybe I should
>>> enforce it), it includes sha512, and I also sign the binaries with =
my
>>> key. You still have to trust me, Debian and Cygwin (which provides =
lots
>>> of libraries used for the build).
>>>=20
>>> Regards,
>>> Stefan
>>=20
>> I guess there is just too much distrust to provide a QEMU binary for =
download.
>=20
> It's not distrust, it's responsibility.
>=20
> Paolo

So from what I learned, in order to provide a binary of QEMU, these =
things must be done:
- Some kind of checksum be provided for the binary (md5, SHA512, ...)
- A zip file that has the exact code used to build the binary be =
provided
- The complete environment use to build the binary be documented
-- Operating system name and version
-- name and version of various tools used to build the binary (GCC, =
make, ...)
-- name and version of libraries that are linked to QEMU (libc, pixman, =
...)
- The exact command-line options used to build the binary be provided
- The email address and identity of the person who made the binary be =
provided

If anything is missing please feel free to share.=20
