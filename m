Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWSNB-0005IJ-Vi
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWSNB-0005xp-AP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:41:49 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWSN9-0005vc-C3
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:41:49 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so11807993otk.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 12:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20181210183836.20074-1-qwandor@google.com>
In-Reply-To: <20181210183836.20074-1-qwandor@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 20:41:32 +0000
Message-ID: <CAFEAcA9kXXeRkFamN73XREDp4QaokMs3E9TRLThKf4zYufapSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement VI/VF bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qwandor@google.com
Cc: qemu-arm <qemu-arm@nongnu.org>, wedsonaf@google.com, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 10 Dec 2018 at 18:38, Andrew Walbran <qwandor@google.com> wrote:
>
> From: Wedson Almeida Filho <wedsonaf@google.com>
>
> This lets hypervisors running at EL2 inject virtual interrupts into guest VMs.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Andrew Walbran <qwandor@google.com>

Hi; thanks for this patch. I'm a bit confused -- can you
explain what the patch provides that isn't already
implemented by commit 89430fc6f80a5aef1d4cb ?

thanks
-- PMM
