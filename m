Received: from eggs.gnu.org ([209.51.188.92]:56575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hE6Ow-00059A-LG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hE6Ov-0002a6-Oy
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hE6Ov-0002Zo-Dv
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:08:01 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6df5f4b-d567-bab0-fb9d-78ca20154ec7@redhat.com>
Date: Wed, 10 Apr 2019 08:07:52 +0200
MIME-Version: 1.0
In-Reply-To: <a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 09/04/2019 21.46, Stefan Weil wrote:
> On 05.04.19 11:16, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/5/19 11:02 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>> Do the various crashes that you illustrate in that cover letter
>>> still exist today ? If so, 2 years of continued brokenness with no
>>> fixes would reinforce the the view that it is time to remove TCI
>>> from the codebase.
>>
>> Or find a maintainer and add tests...
>=20
> Thank you for CC'ing me. I could not spend much of my free time for QEM=
U
> last year and typically will miss important messages on the list unless
> my address is explicitly given. Nevertheless I still feel responsible
> for TCI, and I am also listed as maintainer in MAINTAINERS.

That's great, good to know that you're still interested in TCI! ... but
I think one of the main problems is still that we completely lack test
coverage for TCI - the code always is in danger to bit-rot if it is not
tested by default.

I could maybe have a try to add some test to our .gitlab-ci.yml file ...
if you or somebody else could add one to .travis.yml, that would be
great. Something like:

 - ./configure --enable-tcg-interpreter --target-list=3Dalpha-softmmu,ppc=
64-softmmu,i386-softmmu,sparc-softmmu,microblaze-softmmu,moxie-softmmu,ar=
m-softmmu,hppa-softmmu
 - make
 - make tests/boot-serial-test
 - QTEST_QEMU_BINARY=3D"alpha-softmmu/qemu-system-alpha"  ./tests/boot-se=
rial-test
 - QTEST_QEMU_BINARY=3D"ppc64-softmmu/qemu-system-ppc64"  ./tests/boot-se=
rial-test
 - ...

 Thomas
