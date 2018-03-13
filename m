Received: from eggs.gnu.org ([2001:4830:134:3::10]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1evnZv-0003VV-N5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1evnZs-0003yz-90
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:19:11 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:56368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1evnZr-0003xX-Uy
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:19:08 -0400
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
Date: Tue, 13 Mar 2018 18:18:54 +0100
MIME-Version: 1.0
In-Reply-To: <87y3j1jn8z.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

On 03/09/2018 04:13 PM, Alex Bennée wrote:
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
[...]
>> I always saw it as a big plus that QEMU supports nearly any
>> architecture, no matter how obscure it is. So I'm a bit more hesitant on
>> dropping architectures quickly.
> All things being equal I agree, however there is a maintenance burden
> for the QEMU upstream, especially if the only active use if on
> out-of-tree branches or behind the closed doors of research groups.
>
> Looking at https://wiki.qemu.org/Documentation/Platforms/TileGX it
> doesn't give much of an idea of where I would get toolchains to build
> guest binaries or what guest user-space I could run.

I'm not saying, we shouldn't drop them. To me it felt like we brought 
just another target to the chop block while we were at it.

Maybe a good approach is to deprecate the target first, then ask if 
somebody else is willing to maintain it, and if this fails, drop it.

Cheers,
Bastian
