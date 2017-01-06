Received: from eggs.gnu.org ([2001:4830:134:3::10]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTJ9-0005XU-5l
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTJ8-0005SD-Ab
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:07:43 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPTJ8-0005S3-6u
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:07:42 -0500
Received: by mail-ua0-x232.google.com with SMTP id y9so73971348uae.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 04:07:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1482265908.git.alistair.francis@xilinx.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 12:07:21 +0000
Message-ID: <CAFEAcA9nCymOQCB1gmmnoVFCsW0vmke5FKHhs7JqF6BQ9xR-tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add the generic ARM timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alistair Francis <alistair23@gmail.com>

On 20 December 2016 at 22:41, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> These three patches and and connect the Generic ARM Timer. This includes
> support for dropping insecure writes and includes the ReadBase memory
> map.

Now reviewed. The really sticky bit I suspect is going to be
how we model the required connections between this and the
CPUs so that adjustments to the counter here update the
views the CPUs have of the counter value.

The other mandatory part of the system-level generic timer is
the CNTCTLBase frame (timer control), but I guess we can
leave that for later.

thanks
-- PMM
