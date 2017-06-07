Received: from eggs.gnu.org ([2001:4830:134:3::10]:43643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIbb2-0006hp-Ml
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIbb1-00011o-My
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:06:04 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:35625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dIbb1-00010W-6T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:06:03 -0400
Received: by mail-io0-x22d.google.com with SMTP id k93so7320710ioi.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:06:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496794624-4083-1-git-send-email-cota@braap.org>
References: <1496790745-314-2-git-send-email-cota@braap.org>
	<1496794624-4083-1-git-send-email-cota@braap.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 7 Jun 2017 10:05:30 -0400
Message-ID: <CAJhHMCALEfNuJaP_pfDR1+r-8CTh3ZSM2BX9gg1uJ=b3tVLEPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2 -- fixed] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Geert Martin Ijewski <gm.ijewski@web.de>

On Tue, Jun 6, 2017 at 8:17 PM, Emilio G. Cota <cota@braap.org> wrote:
> Add helpers to gather cache info from the host at init-time.
>
> For now, only export the host's I/D cache line sizes, which we
> will use to improve cache locality to avoid false sharing.
>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Suggested-by: Geert Martin Ijewski <gm.ijewski@web.de>
> Tested-by:    Geert Martin Ijewski <gm.ijewski@web.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

-- 
Pranith
