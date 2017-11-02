Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAJJK-0003ux-R8
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAJJJ-0004tr-V2
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:29:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAJJJ-0004tX-OO
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:29:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id s66so434512wmf.5
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 10:29:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
References: <20171028194833.23858-1-n54@gmx.com>
	<CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
	<891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 17:29:24 +0000
Message-ID: <CAFEAcA-d3z-968piK2X0-8GBdGVqZjqrCnoKkvrjOxOu8PULXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2017 at 17:27, Kamil Rytarowski <n54@gmx.com> wrote:
> On 02.11.2017 17:55, Peter Maydell wrote:
>> It's a shame the BSDs can't agree on a single way to implement this :-(

> It's better to assume that there is no such entity as a shared BSD code
> in modern BSD Operating Systems. My opinion is to drop CONFIG_BSD
> entirely from qemu and treat __NetBSD__, __FreeBSD__ and __OpenBSD__ as
> diverse targets.

Mmm, that's probably the best way to do it. (Better still,
wherever possible check features rather than OS type).

It does mean that more minor BSD variants like DragonFly are
in a worse place, because nobody much is going to care about
supporting them, and they can't get automatic support by
being "like all of the others".

thanks
-- PMM
