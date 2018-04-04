Received: from eggs.gnu.org ([2001:4830:134:3::10]:55081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3l0n-0008L5-Uy
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3l0j-0008Eq-SP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:11:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3l0j-0008E1-MF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:11:45 -0400
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
	<b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6171cf9f-6c76-33a7-9654-c6ed78dbe02f@redhat.com>
Date: Wed, 4 Apr 2018 18:11:42 +0200
MIME-Version: 1.0
In-Reply-To: <b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Weil <sw@weilnetz.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/04/2018 17:55, Stefan Weil wrote:
> Am 04.04.2018 um 16:58 schrieb Daniel P. Berrang=C3=A9:
>> On Wed, Apr 04, 2018 at 04:45:48PM +0200, Paolo Bonzini wrote:
>>> On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
>>>> The source/quality of those binaries is completely opaque. We've no =
idea who
>>>> built them, nor what build options were used, nor what/where the cor=
responding
>>>> source is (required for GPL compliance), nor any checksum / signatur=
e to
>>>> validate the binary isn't compromised since build, etc, etc.
>>>>
>>>> Pointing users to those binaries makes it appear QEMU project is ble=
ssing
>>>> them, and so any issues with them directly reflect on QEMU's reputat=
ion.
>>>>
>>>> If we're going to link to binaries telling users to download them, w=
e need
>>>> to be hosting them on qemu.org and have a clearly documented formal =
process
>>>> around building & distributing them.
>>>>
>>>> Since both Homebrew & Macports are providing formal bulds though, it=
 looks
>>>> simpler to just entirely delegate the problem to them, as we do for =
Linux
>>>> where we delegate to distro vendors to build & distribute binaries.
>>>
>>> Note that, to some extent, the same issues do apply to Win32 binaries
>>> (in particular, they are distributed under http and there are no
>>> signatures).  However, the situation is better in that they are hoste=
d
>>> on an identifiable person's website, and of course Windows doesn't ha=
ve
>>> something akin to Homebrew and Macports so there is no alternative to
>>> volunteers building and hosting the binaries.
>>
>> It would be desirable & practical to address that for Win32, by buildi=
ng
>> the Win32 binaries at time of cutting the release, using the Mingw too=
lchain
>> via one of our formal Docker environments. Would need buy-in of our re=
lease
>> manager to accept the extra work for making releases though...
>>
>> Regards,
>> Daniel
>=20
> That would be one possible way. A more automated way could use CI build=
s
> (for example on GitHub) to generate executables for Windows.
>=20
> By the way: https://qemu.weilnetz.de provides https (maybe I should
> enforce it), it includes sha512, and I also sign the binaries with my
> key. You still have to trust me, Debian and Cygwin (which provides lots
> of libraries used for the build).

Cool!  I had noticed sha512, but it is not very useful without https
(except to verify bitflips).  Good news that you support https, we
should change the website to use https links instead.

Regarding signing, there is no GPG signature.  That's okay, but we
should document how to verify the installer signature from either Linux
or Windows.

Thanks,

Paolo
