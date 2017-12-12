Received: from eggs.gnu.org ([2001:4830:134:3::10]:50817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOmqM-0001Sz-Bk
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOmqL-0005hN-JN
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:42 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOmqL-0005gm-EJ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:51:41 -0500
Received: by mail-oi0-x243.google.com with SMTP id u193so14300167oie.1
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 07:51:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212151605.v2eoestysaogzymm@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
	<CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
	<20171212151605.v2eoestysaogzymm@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 15:51:20 +0000
Message-ID: <CAFEAcA-t7XFxizUQMdo_JYTLet_a8ZL-Omg54gLOQC-=o+vjuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/virt: Add another UART to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>

On 12 December 2017 at 15:16, Andrew Jones <drjones@redhat.com> wrote:
> OK, so this patch is fine, but it kills my suggestion for AAVMF to
> only output debug messages to a debug port when the debug port is
> actually useful. Now it won't be able to tell the difference unless
> we can inform it some other way.

Yeah, and that might be a nice thing to do. I'm just a little
reluctant to have Arm start doing something that we don't
already do for x86, or plan to do on x86 in the same way
at the same time.

thanks
-- PMM
