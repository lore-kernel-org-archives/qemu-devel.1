Received: from eggs.gnu.org ([2001:4830:134:3::10]:55312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro3m-0003JI-Dl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fro3l-0007mH-Q1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:33:46 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fro3l-0007lg-LG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:33:45 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so27233761ois.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:33:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820171557.7734-4-laurent@vivier.eu>
References: <20180820171557.7734-1-laurent@vivier.eu>
	<20180820171557.7734-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 18:33:24 +0100
Message-ID: <CAFEAcA9_2ZjmSVC+kv_DRJ=MbjCvFiV0DcfJz3t5rPe4+0LPZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] linux-user: update netlink route
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 20 August 2018 at 18:15, Laurent Vivier <laurent@vivier.eu> wrote:
> Add RTA_PREF and RTA_CACHEINFO.
>
> Fix following errors when we start gedit:
>
>   Unknown host RTA type: 12
>   Unknown host RTA type: 20
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
