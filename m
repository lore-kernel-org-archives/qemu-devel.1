Received: from eggs.gnu.org ([2001:4830:134:3::10]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1ZD-0001Lf-MH
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1ZD-0004v1-3u
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:34:51 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:35324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpxps-0003rP-Fp
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:35:52 -0400
Received: by mail-oi0-x22c.google.com with SMTP id m11-v6so2647494oic.2
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 08:35:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 16:35:25 +0100
Message-ID: <CAFEAcA9FU7_PzzLgam6AC0P_F_N4zBC=fxCaNqZq0sR4kB1bFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 04:12, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
>
>   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)


>   tests/vm: Only use -cpu 'host' if KVM is available

Incidentally, why did you go with this one rather than just
using -cpu max all the time? The point of -cpu max is to work
everywhere, so you don't need to have special casing to decide
whether to use it or something else...

thanks
-- PMM
