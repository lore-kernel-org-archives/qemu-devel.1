Received: from eggs.gnu.org ([2001:4830:134:3::10]:45371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@waldemar-brodkorb.de>) id 1ex6ra-0001bc-Dt
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@waldemar-brodkorb.de>) id 1ex6rV-0002Py-KG
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:06:50 -0400
Received: from helium.openadk.org ([89.238.66.15]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@waldemar-brodkorb.de>)
	id 1ex6rV-0002O4-EF
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:06:45 -0400
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
In-Reply-To: <87y3j1jn8z.fsf@linaro.org>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8
Message-Id: <95596FAB-A168-46FE-9D74-DF6C7B885612@waldemar-brodkorb.de>
From: Waldemar Brodkorb <mail@waldemar-brodkorb.de>
Date: Sat, 17 Mar 2018 09:06:40 +0100
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

Hi,

> Am 09.03.2018 um 16:13 schrieb Alex Benn=C3=A9e <alex.bennee@linaro.org>:
>=20
>=20
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>=20
>>> On 02/28/2018 07:11 AM, Thomas Huth wrote:
>>>> On 27.02.2018 12:51, Peter Maydell wrote:
>>>> I propose that we deprecate and plan to remove the unicore32 code:
>>> [...]
>> [...]
>>>=20
>>> Sounds reasonable to me, but let's wait a week or two for feedback from
>>> Guan Xuetao.
>>=20
>> Agreed.
>>=20
>>>=20
>>>> Possibly there are other target architectures we could reasonably
>>>> deprecate-and-remove (though none of the other ones Linux is dropping
>>>> in this round are ones we support)...
>>>=20
>>> I'd vote for marking tilegx as deprecated, too, since we even do not
>>> have an active maintainer for that CPU core (at least I did not spot one=

>>> in our MAINTAINERS file). Opinions?
>>=20
>> I always saw it as a big plus that QEMU supports nearly any
>> architecture, no matter how obscure it is. So I'm a bit more hesitant on
>> dropping architectures quickly.
>=20
> All things being equal I agree, however there is a maintenance burden
> for the QEMU upstream, especially if the only active use if on
> out-of-tree branches or behind the closed doors of research groups.
>=20
> Looking at https://wiki.qemu.org/Documentation/Platforms/TileGX it
> doesn't give much of an idea of where I would get toolchains to build
> guest binaries or what guest user-space I could run.

Just from a user perspective, I like the different architecture support qemu=
 provides. I use it often for regression testing of uClibc-ng.
Regarding tilegx I used qemu to start with the port of tilegx from glibc to u=
Clibc-ng and it worked well for the binaries produced by OpenADK.

best regards
 Waldemar=
