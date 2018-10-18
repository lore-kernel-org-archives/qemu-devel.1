Received: from eggs.gnu.org ([2001:4830:134:3::10]:38365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9Qh-0002oI-SF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD9Qh-0004RH-6R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD9Qh-0004PN-0e
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id c32so29974435otb.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:37:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018143051.48508-1-r.bolshakov@yadro.com>
References: <20181018143051.48508-1-r.bolshakov@yadro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 15:37:17 +0100
Message-ID: <CAFEAcA9FhW-R88biFv8gUjY0V91LM9XNhOeE=ziRFVcyVpc1Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i386: hvf: Remove hvf_disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 18 October 2018 at 15:30, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> accel_init_machine sets *(acc->allowed) to true if acc->init_machine(ms)
> succeeds. There's no need to have both hvf_allowed and hvf_disabled.
>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  include/sysemu/hvf.h  | 4 ++--
>  target/i386/hvf/hvf.c | 9 +--------
>  2 files changed, 3 insertions(+), 10 deletions(-)

This brings HVF into line with all the other accelerators,
which define the foo_enabled() function or macro to look at
a foo_allowed flag.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
