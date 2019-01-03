Received: from eggs.gnu.org ([208.118.235.92]:58085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf3dp-0001se-7k
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf3dl-0006j7-Vc
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:06:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf3dl-0006il-OM
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:06:29 -0500
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
	<a08068ab-88ae-4068-d4d6-3a3c4a968893@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5be74ec4-8a56-a479-85b0-49817a4aaf9c@redhat.com>
Date: Thu, 3 Jan 2019 15:06:23 +0100
MIME-Version: 1.0
In-Reply-To: <a08068ab-88ae-4068-d4d6-3a3c4a968893@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 2019-01-03 14:32, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/3/19 2:23 PM, Peter Maydell wrote:
>> On Mon, 31 Dec 2018 at 14:56, Aleksandar Markovic
>> <aleksandar.markovic@rt-rk.com> wrote:
>>> MIPS queue for December 2018 - v2
> [...]
>> Hi; I'm afraid this doesn't build on all my test hosts:
>>
>> target/mips/translate.c: In function =E2=80=98gen_mxu_Q8MAX_Q8MIN=E2=80=
=99:
>> target/mips/translate.c:25092:9: error: =E2=80=98for=E2=80=99 loop ini=
tial
>> declarations are only allowed in C99 mode
>>          for (int i =3D 2; i >=3D 0; i--) {
>>          ^
>> target/mips/translate.c:25092:9: note: use option -std=3Dc99 or
>> -std=3Dgnu99 to compile your code
>> target/mips/translate.c:25129:9: error: =E2=80=98for=E2=80=99 loop ini=
tial
>> declarations are only allowed in C99 mode
>>          for (int i =3D 2; i >=3D 0; i--) {
>>          ^
>>
>> (This probably only shows up on builds with older versions
>> of gcc which don't default to c99.)
>>
>> We don't use variable-declaration-in-for-loop.
>=20
> Hmmm I wonder if we shouldn't relax that now than all supported
> compilers do support C99.

Maybe we could / should enforce compiling with -std=3Dgnu11 now? That
would also fix the problem with the duplicated typedefs on older
compilers, see e.g.:

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

 Thomas
