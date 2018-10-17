Received: from eggs.gnu.org ([2001:4830:134:3::10]:44437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCl2W-0001cK-T7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCl2V-0006Pa-1H
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCl2U-0006Nf-Qx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id o21so25941772otb.13
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016232201.16829-1-crosa@redhat.com>
References: <20181016232201.16829-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Oct 2018 13:34:41 +0100
Message-ID: <CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On 17 October 2018 at 00:22, Cleber Rosa <crosa@redhat.com> wrote:
> The host arch name is not always the target arch name, so it's
> necessary to have a mapping.
>
> The configure scripts contains what is the authoritative and failproof
> mapping, but, reusing it is not straightforward, so it's replicated in
> the acceptance tests supporting code.

So, why does the test code need to care? It's not clear
from the patch... My expectation would be that you'd
just test all the testable target architectures,
regardless of what the host architecture is.

thanks
-- PMM
