Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8T2G-0003GN-Ff
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8T2F-0006nh-Qr
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:33:04 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8T2F-0006nJ-DE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:33:03 -0400
Received: by mail-ot1-x331.google.com with SMTP id i12-v6so13323886otl.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:33:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538732546-2284-1-git-send-email-thuth@redhat.com>
References: <1538732546-2284-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 17:32:41 +0100
Message-ID: <CAFEAcA_W9ioV5qDFV6jNY6t-W3MfEkuUXZeZCAST8_tOe=k9wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Set a category for
 the generic-loader device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On 5 October 2018 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
> Each device that is instantiatable by the users should be marked with
> a category.

Presumably we could assert() this somewhere (at which
point we'd find that we have dozens of devices that
fail to set a category bit, I imagine) ?

thanks
-- PMM
