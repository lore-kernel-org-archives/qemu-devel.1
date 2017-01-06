Received: from eggs.gnu.org ([2001:4830:134:3::10]:55362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ7h-0006SF-5C
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ7c-0000WM-6l
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:20:17 -0500
Received: from relay6-d.mail.gandi.net ([2001:4b98:c:538::198]:39117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPZ7c-0000Vh-0a
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:20:12 -0500
References: <20170103211705.27876-1-jcd@tribudubois.net>
	<CAFEAcA91iJ_8MeKmMp7_fDfdc+aKLHHs4--CyYh=0FQP+SmxLw@mail.gmail.com>
	<ea377760-4e9e-a5c7-2d2d-ccf8112b23c7@gmail.com>
	<6206996c-51ad-d561-f98a-f39702c3c826@tribudubois.net>
	<CAFEAcA9CT4iJHBLA1re6VabfwdFxfKcZQjx1JcTiu0mDvqHOcw@mail.gmail.com>
	<2efc8f93-4277-4d2b-11ff-8f2986776c19@tribudubois.net>
	<CAFEAcA9vD_hsgFw313t4GFthgc9aNxF+y4Ggdg-PyRgZGQe7zw@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <0b44fce7-6693-3e33-8b66-b4f084c5c25e@tribudubois.net>
Date: Fri, 6 Jan 2017 19:20:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vD_hsgFw313t4GFthgc9aNxF+y4Ggdg-PyRgZGQe7zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the
 internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "mar.krzeminski" <mar.krzeminski@gmail.com>

Le 06/01/2017 à 11:18, Peter Maydell a écrit :
> On 5 January 2017 at 21:39, Jean-Christophe DUBOIS <jcd@tribudubois.net> wrote:
>> So I think this behavior could be triggered either by buggy SPI controller
>> emulator or by buggy guest software. And it seems hard to determine where
>> the fault comes from from within Qemu. Obviously if the fault is in a Qemu
>> emulator we would not want to tag the error as a LOG_GUEST_ERROR. On the
>> other hand, it would be nice to warn the user if the guest if it is indeed
>> misbehaving so that he can fix his code.
> We should log it as a guest error. "warning might be wrong if there's
> a bug in QEMU" is true of pretty much any warning we emit...

OK, I'll do this.

JC

>
> thanks
> -- PMM
>
