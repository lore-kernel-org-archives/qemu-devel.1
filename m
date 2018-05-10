Received: from eggs.gnu.org ([2001:4830:134:3::10]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGhzD-0008Lr-Aj
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGhzC-000287-DO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:35:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGhzC-00027o-8D
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:35:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id k17-v6so1215196oih.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:35:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510092935.29088-1-laurent@vivier.eu>
References: <20180510092935.29088-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 10:35:21 +0100
Message-ID: <CAFEAcA9xE=7ZRO4iivpFGkX1ELWpS=QcurrDMDPux_sK1+fQdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: move thunk.c to linux-user/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>

On 10 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
> thunk.c is part of linux-user and only used by it,
> so move it to the linux-user directory.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  Makefile.target               | 2 +-
>  linux-user/Makefile.objs      | 2 +-
>  thunk.c => linux-user/thunk.c | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename thunk.c => linux-user/thunk.c (100%)

bsd-user doesn't use it now, but I have a feeling maybe
the currently-out-of-tree improvements do?

thanks
-- PMM
