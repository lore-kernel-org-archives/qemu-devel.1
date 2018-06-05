Received: from eggs.gnu.org ([2001:4830:134:3::10]:50190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQBgS-0007U7-LL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQBgO-0007pr-AF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQBgO-0007ov-57
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:28 -0400
Received: by mail-oi0-x243.google.com with SMTP id l22-v6so1983993oib.4
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528231969-19584-2-git-send-email-gengdongjiu@huawei.com>
References: <1528231969-19584-1-git-send-email-gengdongjiu@huawei.com>
	<1528231969-19584-2-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 14:07:07 +0100
Message-ID: <CAFEAcA9N9J4r44nFkYEof6JfH3rT+y8Z3gnEfOHg4tcoeRoAfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] kvm: sync linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: James Morse <james.morse@arm.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>

On 5 June 2018 at 21:52, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> Import KVM_CAP_ARM_INJECT_SERROR_ESR and struct kvm_vcpu_events
> for arm64
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Was this produced with the update-headers script? If so,
the commit message should say so and also which upstream
kernel commit/tag the sync is against. (See QEMU commit
65a6d8dd3f32 for an example.) If not then this series should
be tagged as an RFC, since it shouldn't be applied until
the kernel API changes have gone into the kernel upstream.

thanks
-- PMM
