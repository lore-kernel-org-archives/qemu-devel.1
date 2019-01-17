Received: from eggs.gnu.org ([209.51.188.92]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkC4y-0005HF-PY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkC4y-0002zi-3V
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:07:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkC4x-0002y4-Uc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:07:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id m6so6864613oig.11
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:07:47 -0800 (PST)
MIME-Version: 1.0
References: <1547745248-1750-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547745248-1750-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 18:07:34 +0000
Message-ID: <CAFEAcA_TSSCUGXO-ze6QBfZsiddszywBCMgrX=kYjORwJsrdbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Add a proper check for
 openpty() in libutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, 17 Jan 2019 at 17:14, Thomas Huth <thuth@redhat.com> wrote:
>
> On Linux (and maybe some BSDs), we require libutil for the openpty()
> function. However, this library is not available on some other systems, so
> we currently use a fragile if-statement in the configure script to check
> whether we need the library or not. Unfortunately, we also hard-coded a
> "-lutil" in the tests/Makefile.include file, so this breaks the build on
> Solaris, for example (see buglink below). To fix the issue, add the "-lutil"
> to "libs_tools" in the configure script instead, then this gets properly
> propagated to the tests, too.

It also gets propagated to every tool binary we build even if
it doesn't use openpty(), but I guess that's not a big deal.

thanks
-- PMM
