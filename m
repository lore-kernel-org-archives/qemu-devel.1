Received: from eggs.gnu.org ([2001:4830:134:3::10]:50653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn3Ep-0003N2-Hx
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn3Eo-0000G3-Pe
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:45:31 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn3Eo-0000Fp-KJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:45:30 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so28898120ois.1
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 07:45:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87600m2qb2.fsf@trasno.org>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-4-peter.maydell@linaro.org>
	<87600m2qb2.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 15:45:09 +0100
Message-ID: <CAFEAcA8O-SL4Bg4ar3QLLFCPcF8A7W7mRu4D8bbXvJkFUsXTKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 3/5] target/arm: Add dummy
 needed functions to M profile vmstate subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 7 August 2018 at 15:40, Juan Quintela <quintela@redhat.com> wrote:
> But having 3 subsections with the same needed function ... we could have
> a single subsection.

I wanted to keep the change small here since we're very
late in the release cycle, so I kept it to a change
that restores the intent of the code, ie "always transfer
the subsection".

thanks
-- PMM
