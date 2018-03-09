Received: from eggs.gnu.org ([2001:4830:134:3::10]:43132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euJhz-0007UT-4X
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euJhu-0002iL-Tk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:13:23 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1euJhu-0002hu-L1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:13:18 -0500
Received: by mail-wr0-x236.google.com with SMTP id v65so9336026wrc.11
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:13:18 -0800 (PST)
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
Date: Fri, 09 Mar 2018 15:13:16 +0000
Message-ID: <87y3j1jn8z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> On 02/28/2018 07:11 AM, Thomas Huth wrote:
>> On 27.02.2018 12:51, Peter Maydell wrote:
>>> I propose that we deprecate and plan to remove the unicore32 code:
>> [...]
> [...]
>>
>> Sounds reasonable to me, but let's wait a week or two for feedback from
>> Guan Xuetao.
>
> Agreed.
>
>>
>>> Possibly there are other target architectures we could reasonably
>>> deprecate-and-remove (though none of the other ones Linux is dropping
>>> in this round are ones we support)...
>>
>> I'd vote for marking tilegx as deprecated, too, since we even do not
>> have an active maintainer for that CPU core (at least I did not spot one
>> in our MAINTAINERS file). Opinions?
>
> I always saw it as a big plus that QEMU supports nearly any
> architecture, no matter how obscure it is. So I'm a bit more hesitant on
> dropping architectures quickly.

All things being equal I agree, however there is a maintenance burden
for the QEMU upstream, especially if the only active use if on
out-of-tree branches or behind the closed doors of research groups.

Looking at https://wiki.qemu.org/Documentation/Platforms/TileGX it
doesn't give much of an idea of where I would get toolchains to build
guest binaries or what guest user-space I could run.

--
Alex Benn=C3=A9e
