Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnuA-0005AS-8B
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnu8-00032T-VP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:40:06 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evnu8-00032A-Pe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:40:04 -0400
Received: by mail-oi0-x244.google.com with SMTP id e9so406055oii.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 10:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
	<08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 17:39:43 +0000
Message-ID: <CAFEAcA-JwWcB42CbL0rmZVYj06L+jT4BoK4tDaYmEprfcezNFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

On 13 March 2018 at 17:18, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> On 03/09/2018 04:13 PM, Alex Benn=C3=A9e wrote:
>>
>> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>
> [...]
>>>
>>> I always saw it as a big plus that QEMU supports nearly any
>>> architecture, no matter how obscure it is. So I'm a bit more hesitant o=
n
>>> dropping architectures quickly.
>>
>> All things being equal I agree, however there is a maintenance burden
>> for the QEMU upstream, especially if the only active use if on
>> out-of-tree branches or behind the closed doors of research groups.
>>
>> Looking at https://wiki.qemu.org/Documentation/Platforms/TileGX it
>> doesn't give much of an idea of where I would get toolchains to build
>> guest binaries or what guest user-space I could run.
>
>
> I'm not saying, we shouldn't drop them. To me it felt like we brought jus=
t
> another target to the chop block while we were at it.
>
> Maybe a good approach is to deprecate the target first, then ask if someb=
ody
> else is willing to maintain it, and if this fails, drop it.

Personally, I think it's useful to consider not merely "do we
have anybody actively maintaining this" (after all our x86 frontend
is not exactly very well-loved!) but also "are there users of QEMU
out there using it?" and "is this actually something that exists
in the real world as actual silicon in any quantity?". I think
unicore32 failed on both of those, but tilegx passes the latter
and possibly the former.

thanks
-- PMM
