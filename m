Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1em1sI-0007Gc-EH
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1em1sH-00011y-HM
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:33:46 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:42150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1em1sH-00011g-CD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:33:45 -0500
Received: by mail-oi0-x22a.google.com with SMTP id u6so17227743oiv.9
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:33:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518629505-22480-1-git-send-email-thuth@redhat.com>
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Feb 2018 18:33:23 +0000
Message-ID: <CAFEAcA-R0aq7Sp6P2TYrMDE0p0ewwpuXPp6=RzF1bU11FQwJxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 14 February 2018 at 17:31, Thomas Huth <thuth@redhat.com> wrote:
> When running configure with --with-pkgversion=foo there is no
> space anymore between the version number and the parentheses:
>
> $ m68k-softmmu/qemu-system-m68k -version
> QEMU emulator version 2.11.50(foo)
>
> Fix it by moving the space from the configure script to the Makefile.
>
> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I see that in the bug report I wrote
"Also it looks like we return QEMU_PKGVERSION as part of the
QMP qmp_query_version() code, so we should check to see what
the expected behaviour there is regarding having the space
or not."

-- does this patch change the QMP reported string
unexpectedly?

thanks
-- PMM
