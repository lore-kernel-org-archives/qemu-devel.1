Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTId-0006j0-1X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTIc-0002jp-5H
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:50:38 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDTIb-0002WM-LY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:50:38 -0400
Received: by mail-ot1-x331.google.com with SMTP id w67so32874215ota.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:50:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018190026.9494-1-laurent@vivier.eu>
References: <20181018190026.9494-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 12:50:07 +0100
Message-ID: <CAFEAcA_-CuQp_yaZM8Hx9b89MPEJ0XfbzTPBh6uqaMVk8LcwhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [2 0/2] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 18 October 2018 at 20:00, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to 6d5bb0b896f9954c98d85c8835a75bb3a041de41:
>
>   linux-user/sparc/signal.c: Remove unnecessary comment (2018-10-18 20:17:49 +0200)
>
> ----------------------------------------------------------------
> Add a workaround for clang bug and remove misleading comment (sparc)
>
> ----------------------------------------------------------------
>
> Peter Maydell (2):
>   linux-user: Suppress address-of-packed-member warnings in
>     __get/put_user_e
>   linux-user/sparc/signal.c: Remove unnecessary comment
>
>  linux-user/qemu.h         | 74 ++++++++++++++++++++++++++++-----------
>  linux-user/sparc/signal.c |  4 ---
>  2 files changed, 53 insertions(+), 25 deletions(-)

Applied, thanks.

-- PMM
