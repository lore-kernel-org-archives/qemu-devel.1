Received: from eggs.gnu.org ([2001:4830:134:3::10]:39120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1er15e-0002RD-9p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1er15b-0006OV-6l
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:10 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:35294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1er15a-0006Nz-SB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:44:07 -0500
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
Date: Wed, 28 Feb 2018 13:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Chen Gang <chengang@emindsoft.com.cn>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

On 02/28/2018 07:11 AM, Thomas Huth wrote:
> On 27.02.2018 12:51, Peter Maydell wrote:
>> I propose that we deprecate and plan to remove the unicore32 code:
> [...]
[...]
> 
> Sounds reasonable to me, but let's wait a week or two for feedback from
> Guan Xuetao.

Agreed.

> 
>> Possibly there are other target architectures we could reasonably
>> deprecate-and-remove (though none of the other ones Linux is dropping
>> in this round are ones we support)...
> 
> I'd vote for marking tilegx as deprecated, too, since we even do not
> have an active maintainer for that CPU core (at least I did not spot one
> in our MAINTAINERS file). Opinions?

I always saw it as a big plus that QEMU supports nearly any
architecture, no matter how obscure it is. So I'm a bit more hesitant on
dropping architectures quickly.

Cheers,
Bastian
