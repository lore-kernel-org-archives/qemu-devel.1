Received: from eggs.gnu.org ([209.51.188.92]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldEn-0008JM-2r
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldEl-0005KP-Rh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:19:53 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gldEg-0005G7-OG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:19:46 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so21164758otl.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20190116121350.23863-1-alex.bennee@linaro.org>
In-Reply-To: <20190116121350.23863-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 17:19:31 +0000
Message-ID: <CAFEAcA92xjp7-ed_ZPtzoY7O+bj_OGvNPPkpZAhrM7Ko01jtBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/block/xen: use proper format string for
 printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On Wed, 16 Jan 2019 at 12:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The %lu format string is different depending on the host architecture
> which causes builds like the debian-armhf-cross build to fail. Use the
> correct PRi64 format string.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/block/xen-block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index be28b63442..a636487b3e 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Erro=
r **errp)
>
>      xen_device_backend_printf(xendev, "sector-size", "%u",
>                                conf->logical_block_size);
> -    xen_device_backend_printf(xendev, "sectors", "%lu",
> +    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,
>                                blk_getlength(conf->blk) /
>                                conf->logical_block_size);
>

Applied to master as a build fix, thanks.

-- PMM
