Received: from eggs.gnu.org ([2001:4830:134:3::10]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOi4N-0004vx-RM
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOi4K-0008V2-5c
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:45:51 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOi4K-0008UZ-0F
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:45:48 -0500
Received: by mail-ot0-x244.google.com with SMTP id d27so17392316ote.11
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 02:45:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A2F6F44.8050602@huawei.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<5A2F6F44.8050602@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 10:45:26 +0000
Message-ID: <CAFEAcA926yVWg6n+QE0mydU5v1DLBwtkfEM+Hs28H9bMVcgyMA@mail.gmail.com>
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
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <shannon.zhao@linaro.org>

On 12 December 2017 at 05:55, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> On 2017/12/8 23:02, Peter Maydell wrote:
>> Currently we only provide one non-secure UART on the virt
>> board. This is OK for most purposes, but there are some
>> use cases where having a second UART would be useful (like
>> bare-metal testing where you don't really want to have to
>> probe and set up a PCI device just to have a second comms
>> channel).

> I'm wondering if it need to provide a machine option for user to choose
> whether adding the second uart or not.

It seems harmless enough to me to provide it always.
It doesn't increase the attack surface for security
vulnerabilities because it's the same device as the
first UART the guest already has access to.

Do you have a scenario in mind where it would be bad
to provide the second uart?

thanks
-- PMM
