Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWCb-0000WL-8x
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWCa-0004jo-BU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:06:53 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYWCa-0004jU-62
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:06:52 -0500
Received: by mail-oi0-x244.google.com with SMTP id t16so1948793oif.10
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 04:06:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220212308.12614-1-michael.weiser@gmx.de>
References: <20171220212308.12614-1-michael.weiser@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 12:06:31 +0000
Message-ID: <CAFEAcA8A9=7onMxRLM6=L_uz3P4fZmVx=drDY2jv3wqsN7Akug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 20 December 2017 at 21:23, Michael Weiser <michael.weiser@gmx.de> wrote:
> Hello,
>
> below patches add support for big-endian aarch64 to linux-user. Almost
> everything is already in place. The patches just set up the CPU flags as
> required for big-endianness, add a distinction in uname and make sure the
> instructions for the signal trampoline end up in memory little-endian.
> Finally, configure is extended to allow building of a
> aarch64_be-linux-user target and scripts/qemu-binfmt-conf.sh to include
> the binfmt magic for aarch64_be ELF files.
>
> While at it, scripts/qemu-binfmt-conf.sh is changed again to separate
> arm/aarch64 targets of differing endianness into separate families so
> that the binfmt handler for the respective other endianness is indeed
> registered.  Also, while not strictly relevant to aarch64 support, armeb
> is actually added to the list of targets, binfmt handlers should
> registered for.
>
> With this I am able to run individual aarch64_be binaries as well as
> chroot into a full-blown aarch64_be userland using binfmt_misc, running
> and compiling things (Gentoo crossdev/native).
>
> v3:
> - drop changes to aarch64 host support from configure
> - add binfmt arm CPU family separation
> - add armeb to binfmt handler targets
>
> v2:
> - add binfmt magic to qemu-binfmt-conf.sh
> - fix style problems (tab indenting)

Thanks for this patchset -- I have applied it to target-arm.next.

-- PMM
