Received: from eggs.gnu.org ([2001:4830:134:3::10]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC2nh-0005cc-3b
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC2ng-0004Zx-BW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:20:49 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gC2ng-0004Ze-0B
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:20:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id e17-v6so15021570oib.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 06:20:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 14:20:25 +0100
Message-ID: <CAFEAcA_meKcp2pALQEKegYZOi-XVndRAd8+P7mOSNJFhm+-=RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 October 2018 at 09:46, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit a73549f99612f758dec0fdea6ae1c30b6c709a0b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-request' into staging (2018-10-12 16:45:51 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to a7ec0077c2db445d6bae421963188367d2695bd6:
>
>   qemu-options: Fix bad "macaddr" property in the documentation (2018-10-15 16:14:15 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi; there seems to be a format string issue in this pullreq:

In file included from hw/net/trace.c:4:0:
hw/net/trace.h: In function '_nocheck__trace_e1000_receiver_overrun':
hw/net/trace.h:2696:18: error: format '%lu' expects argument of type
'long unsigned int', but argument 5 has type 'size_t {aka long long
unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:e1000_receiver_overrun " "Receiver
overrun: dropped packet of %lu bytes, RDH=%u, RDT=%u" "\n",
                  ^

which means it won't compile on 32-bit hosts.

thanks
-- PMM
