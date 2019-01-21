Received: from eggs.gnu.org ([209.51.188.92]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevC-000888-B0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleha-0003lg-CI
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:53:43 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleha-0003lI-8G
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:53:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id v23so21400874otk.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20190121181335.3326-1-philmd@redhat.com>
In-Reply-To: <20190121181335.3326-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:53:30 +0000
Message-ID: <CAFEAcA9DqR70kNLNr=ywLF3w_dQ2qiKUdp+NHP=Nw_ab2vsNmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

On Mon, 21 Jan 2019 at 18:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Fixes: 2974e916df8
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/virtio/virtio-net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index c7ec1a755f..756eee8af0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -94,7 +94,7 @@ typedef struct VirtioNetRscUnit {
>      uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
>  } VirtioNetRscUnit;
>
> -/* Coalesced segmant */
> +/* Coalesced segment */
>  typedef struct VirtioNetRscSeg {
>      QTAILQ_ENTRY(VirtioNetRscSeg) next;
>      void *buf;
> --
> 2.20.1
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
