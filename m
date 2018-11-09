Received: from eggs.gnu.org ([2001:4830:134:3::10]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLC3C-0006sv-1A
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLC3B-0003S1-7F
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:02:37 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gLC3A-0003K2-Pq
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:02:37 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so2572570oth.7
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 11:02:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109141447.13101-1-kraxel@redhat.com>
References: <20181109141447.13101-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 19:02:13 +0000
Message-ID: <CAFEAcA89pAYe1ZQZDUHO33aP1jT7vfdsjJ4=aN7-c_fPSeYWgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 9 November 2018 at 14:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Broken (segfaultson first keypress) and appearently unused.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/bt.h     |   3 -
>  hw/bt/hid.c         | 554 ----------------------------------------------------
>  vl.c                |  34 +---
>  hw/bt/Makefile.objs |   3 +-
>  qemu-options.hx     |   9 -
>  5 files changed, 2 insertions(+), 601 deletions(-)
>  delete mode 100644 hw/bt/hid.c

Are we definitely happy that all the use cases for
this code segfault, not just the one you tested ?
Does it cost us much to mark this deprecated in 3.1
and drop it in 4.0 ?

thanks
-- PMM
