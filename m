Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtv1b-0002mJ-19
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtv1a-0002OE-2j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:19:43 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:45882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtv1Z-0002Nm-Rw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:19:41 -0400
Received: by mail-wm0-x22c.google.com with SMTP id g206so2140723wme.0
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 05:19:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918111750.15965-1-kraxel@redhat.com>
References: <20170918111750.15965-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 13:19:20 +0100
Message-ID: <CAFEAcA-Ug8iqJK4u74iEp_yLaqhOtOEfLPjEjjhPDuUugeNjeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Audio 20170918 patches
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

On 18 September 2017 at 12:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit f75637badd76ae0f3bd51a128e1a2da0d2bb1d6b:
>
>   qemu.py: Fix syntax error (2017-09-18 11:32:22 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20170918-pull-request
>
> for you to fetch changes up to a6b0bdc8fb4ca57a4274205659bbe91d78c23f22:
>
>   audio: intel-hda: do not use old_mmio accesses (2017-09-18 13:13:32 +0200)
>
> ----------------------------------------------------------------
> audio: bugfixes for wm8750 and intel-hda.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   wm8750: add record buffer underrun check
>
> Matt Parker (1):
>   audio: intel-hda: do not use old_mmio accesses
>
>  hw/audio/intel-hda.c | 58 ++++++++++------------------------------------------
>  hw/audio/wm8750.c    |  6 +++++-
>  2 files changed, 16 insertions(+), 48 deletions(-)

Applied, thanks.

-- PMM
