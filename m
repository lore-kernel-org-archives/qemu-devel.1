Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dO4tp-0007up-Up
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dO4tp-00031A-46
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:24:05 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAFEAcA_kp1tVEd3km1+S7yCLtnVsRko6TQwPZL8xjqV3PVBu5w@mail.gmail.com>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<CAFEAcA_kp1tVEd3km1+S7yCLtnVsRko6TQwPZL8xjqV3PVBu5w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 13:24:00 -0300
Message-ID: <CAAdtpL72EXWFzd6cEgBk_WDdn2Ue=XVU3=2g=WUoPo6uum22fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Kamil Rytarowski <n54@gmx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, peter.maydell@redhat.com

On Thu, Jun 22, 2017 at 12:54 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 5 June 2017 at 15:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
[...]
>> $ ../configure --disable-system --disable-linux-user --static
>> $ make V=1
>> ...
>
> Why are you trying to build with both system emulation QEMU
> and linux-user QEMU disabled anyway? That doesn't leave very
> much left to build...

Hmm the only point would be to build libqemuutil.a...

Should the ./configure script return an error if $target_list is empty?
