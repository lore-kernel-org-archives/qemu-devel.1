Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96336C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFBF206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJqaiCGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFBF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1Cp-00069O-Ak
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 09:47:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hK1BP-00055N-34
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hK1BO-0000Xw-1P
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hK1BN-0000Xj-RR
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id b1so4575153wru.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=N9aBppMN8xa5U6yLncJ2KMPyEUkBKyO42x/Uynbu7kU=;
	b=rJqaiCGLTvwSoBoNhth6TgU/lUpGlKW9Rd4rM9pijh7keGa6eLGsxbGSAc8tvnG55O
	LidjQVfegmErcw9nQyTOFFLGjwGdJEYX6nKLIY/3+bMW2cGEbGPMG8VcG7Sw75epioDc
	KGFdkMrUPmnkPsrVuW0xf2KDQN8K6TqFxBMjG5hztKY3C+SopbCdvtfdSlQMZWh73553
	wXpvF8vrRdhFYiIHcUidPfk5Kg/GNwxG02pyJpnAcfmucX75tVzZFMJV0u0fRgdCTqLk
	fDI0CVDP7F65wcG8Jre4gJblRqrskzvDx7z7pt/rS9zQ/3aSfDhr+2bGY2tXl+JYpmkC
	jLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=N9aBppMN8xa5U6yLncJ2KMPyEUkBKyO42x/Uynbu7kU=;
	b=diDgwcLIU4toCbfvgg1skhAyimN+6K77EyN65CNvPAXp3/VxNHlWJAatPkuQuoSl04
	akCoLUMkeKNCYIQDKFOWiIl7OhtpQESiiR2wfKNUTe4jUXcDaBriFgu059hWdrfzJhJx
	1r+caPtNNyxoT6V9oRiU4+jGb1bsPSODlhgrKvAvC/Z9tNeMCa8VhX95o6n9bC4idu5r
	DPruH01hBhMxo3GvGbnwDjq5RKYKuAgm3J9UCis2+6iU7AC6C2d0NhTUSDbszWYvvmJe
	jOy2If2zHgUc/gaxRaa1SBwUSsaw21ohrYlNWMs5mNWk5AeqRDOTxd0Clv5Y7WFiN+li
	7jvg==
X-Gm-Message-State: APjAAAUwdHLSpxbFF4cDbmyMCLl+6adrTZP/PHE3fbCY2m+XpqKkCeul
	KiNKGXD6pepv9hQb8sZotqLrb5UfmgFQ1gix6Uw=
X-Google-Smtp-Source: APXvYqxTqjYYSY4ymVitkAJOXj4D8Fowz/z+rWyGmsKTeGaIszwc1i/b8VCZBbQbeZ283AUAqTS3oz6ron0Jcbw1+1w=
X-Received: by 2002:adf:b641:: with SMTP id i1mr30206806wre.288.1556286388601; 
	Fri, 26 Apr 2019 06:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-9-marcandre.lureau@redhat.com>
	<20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
In-Reply-To: <20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 15:46:16 +0200
Message-ID:
 <CAJ+F1CKR1z4eB+Pwm5jZ3GSCpqG0N3X-gRqCP_TpqXxfUymPgA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v6 08/11] contrib: add vhost-user-gpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426134616.hB7N3onGPUHTLP3bvBTRp8xgEHC4W1KwcS1j_gaRQ0U@z>

Hi

On Fri, Apr 26, 2019 at 10:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +#ifdef CONFIG_LIBDRM_INTEL
> > +static bool
> > +intel_alloc_bo(struct drm_buffer *buf)
> > +{
> > +    uint32_t tiling =3D I915_TILING_NONE;
> > +
> > +    buf->intel_bo =3D drm_intel_bo_alloc_tiled(buf->dev->bufmgr, "vhos=
t-user-gpu",
> > +                                             buf->width, buf->height,
> > +                                             (buf->bpp / 8), &tiling,
> > +                                             &buf->stride, 0);
>
> Why do you go for intel specific code here?
>

No idea, most likely some functions were lacking when I looked at it.
GBM is fine now.

> Can't you do the same with gbm_bo_create() or
> gbm_bo_create_with_modifiers() ?

It's not clear to me how to properly use
gbm_bo_create_with_modifiers(). I went with gbm_bo_create() for now,
it "works for me".

>
> > +static bool
> > +intel_map_bo(struct drm_buffer *buf)
> > +{
> > +    if (drm_intel_gem_bo_map_gtt(buf->intel_bo) !=3D 0) {
> > +        return false;
> > +    }
>
> gbm_bo_map()
>
> > +static bool
> > +intel_export_bo_to_prime(struct drm_buffer *buffer, int *fd)
> > +{
> > +    if (drm_intel_bo_gem_export_to_prime(buffer->intel_bo, fd) < 0) {
> > +        return false;
> > +    }
>
> gbm_bo_get_fd()
>
> > +get_pixman_format(uint32_t virtio_gpu_format)
> > +{
> > +    switch (virtio_gpu_format) {
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> > +        return PIXMAN_b8g8r8x8;
>
> Move that to a header for sharing?  Simliar to the bswap helpers?

ack

>
> > +static void
> > +virgl_cmd_create_resource_3d(VuGpu *g,
> > +                             struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    struct virtio_gpu_resource_create_3d c3d;
> > +    struct virgl_renderer_resource_create_args args;
> > +
> > +    VUGPU_FILL_CMD(c3d);
> > +
> > +    args.handle =3D c3d.resource_id;
> > +    args.target =3D c3d.target;
> > +    args.format =3D c3d.format;
> > +    args.bind =3D c3d.bind;
> > +    args.width =3D c3d.width;
> > +    args.height =3D c3d.height;
> > +    args.depth =3D c3d.depth;
> > +    args.array_size =3D c3d.array_size;
> > +    args.last_level =3D c3d.last_level;
> > +    args.nr_samples =3D c3d.nr_samples;
> > +    args.flags =3D c3d.flags;
> > +    virgl_renderer_resource_create(&args, NULL, 0);
> > +}
>
> The virtio_gpu_resource_create_3d -> virgl_renderer_resource_create_args
> mapping looks like an opportunity for code sharing too.
>
> Hmm, but virgl_renderer_resource_create seems to be the only call with
> an args struct, so maybe not worth the effort for this single case.

yeah, I will not bother for now

thanks!

--=20
Marc-Andr=C3=A9 Lureau

