Received: from eggs.gnu.org ([2001:4830:134:3::10]:53652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dO3ZG-0004DM-QT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dO3ZC-0001Ja-Vq
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:58:46 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dO3ZC-0001Ia-RS
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:58:42 -0400
Received: by mail-qk0-x244.google.com with SMTP id p21so2506474qke.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 07:58:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
	<CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
Date: Thu, 22 Jun 2017 11:58:39 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/22/2017 11:09 AM, Peter Maydell wrote:
> On 21 June 2017 at 15:47, Alex Bennée <alex.bennee@linaro.org> wrote:
[...]>> We add the following cross-compile targets:
>>    - mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>>    - armeb-linux-user
>>
>> While I was rolling I discovered we could also back out a bunch of the
>> emdebian hacks as the newly released stretch handles cross compilers
>> as first class citizens. Unfortunately this also meant I had to drop
>> the powerpc support as that is no longer in Debian stable.
>>
> 
> Applied, thanks.

Yay! Shippable happily working again \o/

https://app.shippable.com/github/qemu/qemu/runs/238/summary/console

   Overall Status: Success
