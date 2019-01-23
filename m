Received: from eggs.gnu.org ([209.51.188.92]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmPyA-00051g-LP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmPqE-0006E9-K0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:13:48 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmPqC-0006CW-KL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:13:46 -0500
Received: by mail-ot1-x342.google.com with SMTP id v23so3264758otk.9
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20190120143452.21683-1-stefanha@redhat.com>
	<20190120143452.21683-2-stefanha@redhat.com>
	<CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
	<20190123210725.GA13509@stefanha-x1.localdomain>
In-Reply-To: <20190123210725.GA13509@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 21:13:30 +0000
Message-ID: <CAFEAcA-be9piRLnh-BOL8PKDpSYwK_aQrWzCoPs3is06kER=DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] memory: add
 memory_region_flush_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>

On Wed, 23 Jan 2019 at 21:07, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Jan 22, 2019 at 04:36:36PM +0000, Peter Maydell wrote:
> > API and implementation make sense to me, but better that Paolo reviews
> > this I think. I guess we should add calls to this to the pflash device
> > models too...
>
> Okay, will cover pflash in the next revision.

We can do that as a separate patch, since it's not related to
the microbit work. For this lot we just need to make a decision
about whether to do this this way or have as Paolo suggested
"memory_region_invalidate_and_set_dirty()". I don't have a
strong opinion, and it sounded like Paolo didn't either, so
let's go with the code you have here.

I can take this patchset via target-arm.next.

thanks
-- PMM
