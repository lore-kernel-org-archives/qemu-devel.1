Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHAx7-00027R-AT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHAx6-0004kf-Ej
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:45 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:41525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHAx6-0004bn-45
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:44 -0400
Received: by mail-ot1-x32c.google.com with SMTP id c32so8262677otb.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 10:03:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181029133722.12415-1-kraxel@redhat.com>
References: <20181029133722.12415-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 17:03:06 +0000
Message-ID: <CAFEAcA-mjgjC1DPTcArqoLDv+jgOrY_8v-qRhiwDpsFu-4cxUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Audio 20181029 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm <qemu-arm@nongnu.org>

On 29 October 2018 at 13:37, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 285278ca785f5fa9a570927e1c0958a2ca2b2150:
>
>   Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' into staging (2018-10-27 19:55:08 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20181029-pull-request
>
> for you to fetch changes up to d436d4e7a50a7c4fddc0569c2107fe5eaf0e1fbc:
>
>   audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string (2018-10-29 13:50:15 +0100)
>
> ----------------------------------------------------------------
> audio: qom cleanups.
>
> ----------------------------------------------------------------
>
> Li Qiang (1):
>   hw: AC97: make it more QOMconventional
>
> Mao Zhongyi (3):
>   audio: use TYPE_WM8750 instead of a hardcoded string
>   audio: use object link instead of qdev property to pass wm8750
>     reference
>   audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string
>
>  include/hw/audio/wm8750.h  |  1 +
>  hw/arm/musicpal.c          |  5 +++--
>  hw/audio/ac97.c            | 12 ++++++++----
>  hw/audio/marvell_88w8618.c | 14 ++++++--------
>  4 files changed, 18 insertions(+), 14 deletions(-)
>
Applied, thanks.

-- PMM
