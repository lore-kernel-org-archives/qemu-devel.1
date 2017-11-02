Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAH5t-0005eZ-LD
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAH5s-0005lo-Rb
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:07:45 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAH5s-0005jX-Lk
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:07:44 -0400
Received: by mail-wr0-x244.google.com with SMTP id z55so5339830wrz.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 08:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509519537-6964-1-git-send-email-thuth@redhat.com>
References: <1509519537-6964-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 15:07:23 +0000
Message-ID: <CAFEAcA9e7GAMmHjp9-nOy5AAiZL+CnW_OUbg89LpaT=3AoDnoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/arm: Mark the "fsl,
 imx" devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 1 November 2017 at 06:58, Thomas Huth <thuth@redhat.com> wrote:
> These devices can not be used by the user directly and cause QEMU
> to abort() if the user tried it anyway. So simply mark the devices
> with user_creatable = false to avoid that the users can run into
> this unpleasant situation.
>
> Thomas Huth (3):
>   hw/arm: Mark the "fsl,imx6" device with user_creatable = false
>   hw/arm: Mark the "fsl,imx25" device with user_creatable = false
>   hw/arm: Mark the "fsl,imx31" device with user_creatable = false
>
>  hw/arm/fsl-imx25.c | 6 +++++-
>  hw/arm/fsl-imx31.c | 6 +++++-
>  hw/arm/fsl-imx6.c  | 3 ++-
>  3 files changed, 12 insertions(+), 3 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
