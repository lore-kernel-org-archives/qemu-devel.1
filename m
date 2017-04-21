Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1UYg-0008W2-Fv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1UYf-0006y7-Gu
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:08:54 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1UYf-0006xR-9J
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:08:53 -0400
Received: by mail-wm0-x22e.google.com with SMTP id o81so10911365wmb.1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 02:08:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 10:08:31 +0100
Message-ID: <CAFEAcA-XcuXuK2yEG=tapO3ebbh+_RF1aXj2mv_G5YRF3qoj=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 31 January 2017 at 16:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> We already require gcc 4.1 or newer (for the atomic
> support), so the fallback codepaths for older gcc
> versions than that are now dead code and we can
> just delete them.
>
> NB: clang reports itself as gcc 4.2 (regardless of
> clang version), so clang won't be using the fallbacks
> either.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Applied to master, thanks.

-- PMM
