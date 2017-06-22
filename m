Received: from eggs.gnu.org ([2001:4830:134:3::10]:56859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO3n6-0005hp-2i
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO3n2-0006cF-TJ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:13:04 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dO3n2-0006Xo-KT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:13:00 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 77so27575106wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 08:12:59 -0700 (PDT)
References: <20170621144814.15324-1-alex.bennee@linaro.org>
	<CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
	<6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
Date: Thu, 22 Jun 2017 16:13:42 +0100
Message-ID: <87wp84rr6h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/21] Docker and shippable updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On 06/22/2017 11:09 AM, Peter Maydell wrote:
>> On 21 June 2017 at 15:47, Alex Bennée <alex.bennee@linaro.org> wrote:
> [...]>> We add the following cross-compile targets:
>>>    - mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>>>    - armeb-linux-user
>>>
>>> While I was rolling I discovered we could also back out a bunch of the
>>> emdebian hacks as the newly released stretch handles cross compilers
>>> as first class citizens. Unfortunately this also meant I had to drop
>>> the powerpc support as that is no longer in Debian stable.
>>>
>>
>> Applied, thanks.
>
> Yay! Shippable happily working again \o/
>
> https://app.shippable.com/github/qemu/qemu/runs/238/summary/console
>
>   Overall Status: Success

Now we've been running shippable for a while is it worth turning on the
IRC notifications?

--
Alex Bennée
