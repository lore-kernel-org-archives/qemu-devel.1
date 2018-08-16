Received: from eggs.gnu.org ([2001:4830:134:3::10]:48241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHtF-0002Nn-Kp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHtA-0000xL-3c
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:00:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHt9-0000wm-NN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:00:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so7773202oie.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 06:00:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806211806.29845-1-laurent@vivier.eu>
References: <20180806211806.29845-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:00:10 +0100
Message-ID: <CAFEAcA-gyw3Roc7RrsXBu1qVwvQKjegXwkALCvCRLTOvjPvUYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix recvmsg()/recvfrom() with
 netlink and MSG_TRUNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 6 August 2018 at 22:18, Laurent Vivier <laurent@vivier.eu> wrote:
> If recvmsg()/recvfrom() are used with the MSG_TRUNC flag, they return the
> real length even if it was longer than the passed buffer.
> So when we translate the buffer we must check we don't go beyond the
> end of the buffer.
>
> Bug: https://github.com/vivier/qemu-m68k/issues/33
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
