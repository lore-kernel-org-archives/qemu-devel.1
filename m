Received: from eggs.gnu.org ([2001:4830:134:3::10]:38740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO4Rh-0001UH-LQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO4Rg-0007LP-JO
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:55:01 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO4Rg-0007JY-BX
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:55:00 -0400
Received: by mail-wr0-x236.google.com with SMTP id k67so28924324wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 08:54:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 16:54:36 +0100
Message-ID: <CAFEAcA_kp1tVEd3km1+S7yCLtnVsRko6TQwPZL8xjqV3PVBu5w@mail.gmail.com>
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
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kamil Rytarowski <n54@gmx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, peter.maydell@redhat.com

On 5 June 2017 at 15:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 31.05.2017 15:00, Kamil Rytarowski wrote:
>> Currently ivshmem requires eventfd() which is Linux specific.
>> Do not and build it unconditionally on every Linux/BSD/Solaris.
>>
>> This patch indirectly fixes build failure on NetBSD, where these tools
>> additionally require -lrt for shm_open(3). In future there should be
>> added support for NetBSD and the linking addressed appropriately.
>
> Unfortunately this breaks static build.
>
> $ ../configure --disable-system --disable-linux-user --static
> $ make V=1
> ...

Why are you trying to build with both system emulation QEMU
and linux-user QEMU disabled anyway? That doesn't leave very
much left to build...

thanks
-- PMM
