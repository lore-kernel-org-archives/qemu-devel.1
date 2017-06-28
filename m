Received: from eggs.gnu.org ([2001:4830:134:3::10]:47783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQ9Gn-0004zb-3z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQ9Gm-00054X-AP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:28:21 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQ9Gm-000549-3m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:28:20 -0400
Received: by mail-wm0-x231.google.com with SMTP id 62so47457389wmw.1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 02:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170628050003.1809-2-bobby.prani@gmail.com>
References: <20170628050003.1809-1-bobby.prani@gmail.com>
	<20170628050003.1809-2-bobby.prani@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Jun 2017 10:27:58 +0100
Message-ID: <CAFEAcA-9eHOtKcwjwvp3r9KtG0As0ZPz-Ui4QAH68caz--YcCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] [TEST] aarch64: Use pmuserenr_el0
 register for instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 28 June 2017 at 06:00, Pranith Kumar <bobby.prani@gmail.com> wrote:
> We need a way for the benchmark running in the guest to indicate us to
> start/stop our instrumentation. On x86, we could use the 'cpuid'
> instruction along with an appropriately populated 'eax'
> register. However, no such dummy instruction exists for aarch64. So
> we modify the permission bits for 'pmuserenr_el0' register and tap
> that to instrument the guest code.

Why not just define a QEMU-specific system register in the
reserved-for-implementation-defined-registers encoding range,
rather than modifying the behaviour of an architecturally
defined register?

(Though overall I feel we should be able to do better as
a mechanism.)

thanks
-- PMM
