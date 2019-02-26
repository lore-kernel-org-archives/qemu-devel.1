Received: from eggs.gnu.org ([209.51.188.92]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfzK-00024U-0F
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfzJ-0004ny-25
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:53:49 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyfzI-0004nO-SP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:53:49 -0500
Received: by mail-oi1-x231.google.com with SMTP id a81so10854005oii.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
In-Reply-To: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 16:53:35 +0000
Message-ID: <CAFEAcA9dQ0NNp6XR5i4RAhEi4TPJAb+0H_9dFR7jC9rpAjha6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter, Alex,
> On 2/14/19 8:05 PM, Peter Maydell wrote:
> > Support this by making kvm_arch_put_registers() synchronize
> > CPU state back into the list. We sync only those registers
> > where the initial write succeeds, which should be sufficient.

> This commit introduces a regression when running with EDK2 FW:

I haven't found time to investigate this yet, so I propose
to just revert this commit for the moment.

thanks
-- PMM
