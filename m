Received: from eggs.gnu.org ([2001:4830:134:3::10]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fidt1-0000fN-8S
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fidsy-0002qX-B2
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:52:47 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fidsy-0002pr-4e
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:52:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id n21-v6so2142723oig.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 03:52:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180726104636.aua3pjsqkqnkvggk@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAHmQWvC44mLchhEFPU0T0gKWVcjjozp95ZumaKK9EkPwpeehTA@mail.gmail.com>
	<20180726104636.aua3pjsqkqnkvggk@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jul 2018 11:52:22 +0100
Message-ID: <CAFEAcA80549kHSO+8z334PYmoWshzz+EHJcPBxsmhBN_dk+0Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 26 July 2018 at 11:46, Andrew Jones <drjones@redhat.com> wrote:
> i440fx and q35 are specific machine types. 'sbsa' is a generic machine
> type that conforms to the SBSA specification. If you weren't trying to
> memory map AHCI and EHCI controllers, or if memory mapped AHCI and EHCI
> controllers were mandated in the SBSA spec, then there wouldn't be
> anything to discuss. But that's not the case. You're attempting to
> hard code one instance of a generic class of SBSA machines, but then
> just call it 'sbsa'.

Modelling a 'generic SBSA machine' is not the goal here (I'm
not sure that's even possible or useful), so let's just
stipulate that we'll call the machine type something else
and move on ?

thanks
-- PMM
