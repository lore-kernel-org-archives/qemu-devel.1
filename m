Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gBzMv-0006lU-2U
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gBzMu-0005LY-BG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:40:56 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gBzMt-0005L3-Vb
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:40:56 -0400
Received: by mail-oi1-x229.google.com with SMTP id p125-v6so14550024oic.3
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 02:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39e2ed06-0e66-8030-fa4f-91b4c505da09@gmail.com>
References: <39e2ed06-0e66-8030-fa4f-91b4c505da09@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 10:40:34 +0100
Message-ID: <CAFEAcA-E3jWDeBk_TRGkkHen5HUD9wfmK6hjxQGdbrc6HsWRRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Assertion error when installing OpenBSD 6.3 in
 Linux 4.8.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hristo Mihaylov <za.hristomihaylov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 October 2018 at 17:50, Hristo Mihaylov
<za.hristomihaylov@gmail.com> wrote:
> Hello,
> I'm trying to install OpenBSD 6.3 on Arch Linux.

> This is the crash output:
>
> qemu-system-x86_64:
> /build/qemu/src/qemu-3.0.0/include/exec/memory_ldst_cached.inc.h:85:
> address_space_stw_le_cached: Assertion `addr < cache->len && 2 <=
> cache->len - addr' failed.

> Am I doing something wrong or is this a bug?

Hi; yes, this is a known bug (that affects OpenBSD guests
using virtio networking). It's fixed in QEMU git master
in commit db812c4073c77, and will be in the next (3.1)
release as well as the next 3.0.x release.

thanks
-- PMM
