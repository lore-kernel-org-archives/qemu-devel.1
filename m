Received: from eggs.gnu.org ([209.51.188.92]:43320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj0cb-00006z-1k
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj0ca-00051o-2h
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:41:37 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj0cZ-000515-JG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:41:35 -0500
Received: by mail-ot1-x32e.google.com with SMTP id v23so18978894otk.9
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20190111142702.25884-1-kraxel@redhat.com>
In-Reply-To: <20190111142702.25884-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 11:41:23 +0000
Message-ID: <CAFEAcA_C8vBxHc+52DBWikNWZyBGYjikPvj-CtquDrKnOZCnMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Input 20190111 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 11 Jan 2019 at 14:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit a311f891abf3833c1e4c5a62a6e5b0f1b81f22c3:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-01-10 17:49:54 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20190111-pull-request
>
> for you to fetch changes up to 7a1b46e09504419a3aa867dba3bcf23db5d6d956:
>
>   input: avoid malloc for mouse events (2019-01-11 11:57:17 +0100)
>
> ----------------------------------------------------------------
> input: avoid malloc for mouse events
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   input: avoid malloc for mouse events
>
>  include/ui/input.h |  3 ---
>  ui/input.c         | 68 +++++++++++++++++++++++++-----------------------------
>  2 files changed, 31 insertions(+), 40 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
