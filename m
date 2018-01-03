Received: from eggs.gnu.org ([2001:4830:134:3::10]:37733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eWrJG-00023Q-FV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eWrJF-0005gE-Oe
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:14:54 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eWrJF-0005fo-ID
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:14:53 -0500
Received: by mail-ot0-x22a.google.com with SMTP id x15so2488369ote.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:14:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jan 2018 22:14:32 +0000
Message-ID: <CAFEAcA_1+CWSb6Jc41n6UqvSqOLytgGi1idArXKe37iKyiv7mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On 3 January 2018 at 22:10, Alistair Francis <alistair23@gmail.com> wrote:
> Any chance any one has some insight into a way to externally set a
> vCPU as halted/un-halted?

PSCI (where one vCPU can power off another) does this by
calling arm_set_cpu_off(). Does that (or some variation
on it) work?

thanks
-- PMM
