Received: from eggs.gnu.org ([2001:4830:134:3::10]:41630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg8FL-00064Z-5q
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg8FK-0002wk-BF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:41:27 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fg8FK-0002wI-50
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:41:26 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so15199039oib.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:41:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
References: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 13:41:04 +0100
Message-ID: <CAFEAcA_2t5z1JBWM9o7ygcOwxnQRba0qA8vVjcoZpcGfP9XUtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: downgrade
 error_report to warn_report in kvm_arm_its_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jia He <jia.he@hxt-semitech.com>

On 19 July 2018 at 04:11, Jia He <hejianet@gmail.com> wrote:
> In scripts/arch-run.bash of kvm-unit-tests, it will check the qemu
> output log with:
> if [ -z "$(echo "$errors" | grep -vi warning)" ]; then
>
> Thus without the warning prefix, all of the test fail.
>
> Since it is not unrecoverable error in kvm_arm_its_reset for
> current implementation, downgrading the report from error to
> warn makes sense.

I think the counterargument would be that this should report
an error, because you just asked the device to do something
that it doesn't support (ie to do a clean reset). Since the
device isn't going to behave correctly, the tests should fail,
and the way to make them pass is to upgrade to a kernel that
implements the device correctly (by implementing the necessary
feature).

But we could maybe move to warn_report() here -- I'm not
sure what our rules are for what counts as an error and
what counts as a warning.

thanks
-- PMM
