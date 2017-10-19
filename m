Received: from eggs.gnu.org ([2001:4830:134:3::10]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5DAJ-0001Uc-2o
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5DAH-0002Oz-OF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:55:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5DAH-0002NR-G5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:55:21 -0400
Received: by mail-wr0-x230.google.com with SMTP id z55so2764891wrz.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:55:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019155146.30434-1-richard.henderson@linaro.org>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:54:59 +0100
Message-ID: <CAFEAcA_cP-L8=DygAdvjr5Eaz=p5vX50-Gw6fm2_h8PpsFHsgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 19 October 2017 at 16:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since v5:
>   * Rearranged how we choose git submodule vs system installed library.
>     By default, the system library will be used, if present;
>     Followed by git submodule, if present;
>     Followed by not-git submodule, if for some reason a tarball contained it.

In general the tarball *should* contain it, because the tarball should
work for users to build from source, same as git.

thanks
-- PMM
