Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo7R8-0008WG-Un
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo7R8-0004Cg-0F
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:26:38 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo7R7-0004Bz-I3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:26:37 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so15753189oiw.8
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 06:26:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180810132236.25908-1-kraxel@redhat.com>
References: <20180810132236.25908-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 14:26:16 +0100
Message-ID: <CAFEAcA9jAFM7gz4wOZuGMP-cumBf3Bh35P7XDAR7RQQvtMgpzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qxl: drop unused generation variable
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

On 10 August 2018 at 14:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/qxl.h | 1 -
>  hw/display/qxl.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 089696ef62..6eacba080d 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -43,7 +43,6 @@ typedef struct PCIQXLDevice {
>
>      enum qxl_mode      mode;
>      uint32_t           cmdflags;
> -    int                generation;
>      uint32_t           revision;
>
>      int32_t            num_memslots;
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 830c392c53..8e9135d9c6 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2057,7 +2057,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>
>      qemu_spice_display_init_common(&qxl->ssd);
>      qxl->mode = QXL_MODE_UNDEFINED;
> -    qxl->generation = 1;
>      qxl->num_memslots = NUM_MEMSLOTS;
>      qemu_mutex_init(&qxl->track_lock);
>      qemu_mutex_init(&qxl->async_lock);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
