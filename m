Received: from eggs.gnu.org ([2001:4830:134:3::10]:51360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDBD2-0002ZO-Lj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDBD1-000603-TH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:31:40 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDBD1-0005cp-K6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:31:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id s69-v6so24481905oie.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 09:31:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5bc854f3.1c69fb81.c9089.8940SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA97eSpOzU_xJZLFgFBZUCW1Z8mYDMzYsdpK99S5WiPf=A@mail.gmail.com>
	<5bc854f3.1c69fb81.c9089.8940SMTPIN_ADDED_BROKEN@mx.google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 17:31:01 +0100
Message-ID: <CAFEAcA-YkiqCfP9f2xxCEoNLsF3oem+wHzM=ROpXPzX-zZP5Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v11 0/2] add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "zhengxiang (A)" <zhengxiang9@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18 October 2018 at 10:38, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi peter,
>
>     Thanks very much for this comments and very sorry for my late response due to business trave.
>
>      Yes, the reason that tag the patchset to RFC is that it just  hasn't been tested on 32-bit. if someone else can test it on 32-bit platform, it will be great.
>
>     I do not have 32-bit environment, so only tested it on 64-bit.

OK, thanks. I gave it a quick 32-bit test, though I don't have
a mechanism for inserting SErrors.

Applied to target-arm.next, thanks.

-- PMM
