Received: from eggs.gnu.org ([209.51.188.92]:52374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2dBq-0006Rm-EM
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2dBp-0005sC-As
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:43:06 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:39548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2dBp-0005rd-5t
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:43:05 -0500
Received: by mail-oi1-x22c.google.com with SMTP id b4so379150oif.6
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20190308123937.2346-1-kraxel@redhat.com>
In-Reply-To: <20190308123937.2346-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:42:52 +0000
Message-ID: <CAFEAcA-trb9TKzEtbbSXEJapBrqUpBvLFE5zFObMRqD9u6zeJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20190308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 8 Mar 2019 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190308-pull-request
>
> for you to fetch changes up to 61dbd9eaa1450f94886fb41366e4687d405c52c8:
>
>   virtio-gpu: make virtio_gpu_reset static (2019-03-08 09:36:23 +0100)
>
> ----------------------------------------------------------------
> vga: virtio reset fix, add ati emulation.
>
> ----------------------------------------------------------------

Hi -- I'm afraid this has conflicted with the Kconfig merge:

CONFLICT (modify/delete): default-configs/pci.mak deleted in HEAD and
modified in remotes/kraxel/tags/vga-20190308-pull-request.

Can you figure out what the Kconfig equivalent of the
pci.mak change is and resend, please?

thanks
-- PMM
